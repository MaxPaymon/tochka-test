//
//  ViewController.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let searchBarHeight = 40
    private let cellIdentifier = "newsCell"
    
    private var searchBar : UISearchBar!
    
    private let cacheManager = CacheManager()
    
    private var isLoading = false
    private var blockOperations = [BlockOperation]()
    
    private var newsLoaded: NSObjectProtocol!
    
    private lazy var fetchedResultsController : NSFetchedResultsController<News> = {
        let fetchRequest : NSFetchRequest<News> = News.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: NewsKeys.date, ascending: false)]
        fetchRequest.fetchBatchSize = 20
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Couldn't init AppDelegate")
            return NSFetchedResultsController<News>()
        }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNotification()
        setSearchBar()
        collectionView?.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        fetchNews()
        cacheManager.loadNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayoutOptions()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let info = fetchedResultsController.object(at: indexPath)
        
        cell.titleView.text = info.title
        cell.descriptionView.text = info.descript
        cell.picture.setImage(from: info.pictureUrl ?? "")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = fetchedResultsController.sections?[0].numberOfObjects else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

        if (maximumOffset - contentOffset == 0) && !isLoading {
            isLoading = true
            cacheManager.page += 1
            cacheManager.loadNews()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        searchBar.frame = CGRect(x: 0, y: 0, width: size.width, height: CGFloat(searchBarHeight))
    }

    private func fetchNews() {
        do {
            try fetchedResultsController.performFetch()
            self.collectionView.reloadData()

        } catch let error {
            print("Error: perform fetched ", error)
        }
    }
    
    private func setLayoutOptions() {
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = .blue

        self.title = "Новости"
    }

    private func setSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .blackTranslucent
        searchBar.placeholder = "Поиск новостей"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setNotification() {
        newsLoaded = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "newsLoaded"), object: nil, queue: nil) { _ in
            
            self.isLoading = false
        }
    }

}

extension MainViewController : NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView.insertItems(at: [newIndexPath!])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            for operation in self.blockOperations {
                operation.start()
            }
        }, completion: nil)
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchBar.text ?? ""
        var predicate: NSPredicate?
        if searchText.count > 0 {
            predicate = NSPredicate(format: "title contains[cd] %@", searchText, searchText)
        } else {
            predicate = nil
        }
        
        fetchedResultsController.fetchRequest.predicate = predicate
        fetchNews()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        isLoading = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isLoading = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        fetchedResultsController.fetchRequest.predicate = nil
        fetchNews()
    }
}

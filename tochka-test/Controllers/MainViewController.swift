//
//  ViewController.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let searchBarHeight = 40
    private let cellIdentifier = "newsCell"

    private var newsLoaded: NSObjectProtocol!
    
    private let progress = UIActivityIndicatorView()
    private var searchBar : UISearchBar!
    
    private let cacheManager = CacheManager()
    
    private var news : [News] = []
    private var filteredNews : [News] = []
    
    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNotification()
        setSearchBar()
        setProgress()
        collectionView?.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayoutOptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cacheManager.fetchNews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let info = filteredNews[indexPath.row] as News? else {
            return UICollectionViewCell()
        }
        
        cell.titleView.text = info.title
        cell.descriptionView.text = info.descript
        cell.picture.setImage(from: info.pictureUrl ?? "")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if (maximumOffset - contentOffset == 0) && !isLoading {
            cacheManager.page += 1
            isLoading = true
            cacheManager.fetchNews()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNews = searchText.isEmpty ? news : news.filter { (item: News) -> Bool in
            return item.title!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredNews = news
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        searchBar.frame = CGRect(x: 0, y: 0, width: size.width, height: CGFloat(searchBarHeight))
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
            
            self.news = self.cacheManager.newsList
            self.filteredNews = self.news
            self.isLoading = false
            DispatchQueue.main.async {
                if !self.news.isEmpty {
                    self.stopProgress()
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setProgress() {
        progress.center = collectionView.center
        progress.hidesWhenStopped = true
        progress.color = .blue
        collectionView.addSubview(progress)
        DispatchQueue.main.async {
            self.progress.startAnimating()
        }
    }
    
    private func stopProgress() {
        DispatchQueue.main.async {
            self.progress.stopAnimating()
        }
    }
}


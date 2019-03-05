//
//  ViewController.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let searchBarHeight = 40
    private let cellIdentifier = "newsCell"
    
    private var searchBar : UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        collectionView?.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayoutOptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cache = CacheManager()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
//
//        let info = news.articles[indexPath.row]
//        cell.titleView.text = info.title
//        cell.descriptionView.text = info.description
//        cell.picture.setImage(from: info.urlToImage)
//
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: CGFloat(searchBarHeight))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        searchBar.frame = CGRect(x: 0, y: 0, width: size.width, height: 40)
    }

    func setLayoutOptions() {
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        navigationController?.navigationBar.barStyle = .black
        self.title = "Новости"
    }
    
    func setSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .blackTranslucent
        searchBar.placeholder = "Поиск новостей"
        collectionView.addSubview(searchBar)
    }
}


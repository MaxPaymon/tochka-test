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
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayoutOptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: CGFloat(searchBarHeight))
    }

    func setLayoutOptions() {
        collectionView.backgroundColor = UIColor.white
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


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
    
    private var searchBar : UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayoutOptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
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
        collectionView.addSubview(searchBar)
    }
}


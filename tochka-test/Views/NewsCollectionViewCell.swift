//
//  NewsCell.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class NewsCollectionViewCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    let cardView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleView : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleView : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    func setViews() {
        addSubview(cardView)
        setCardViewConstraints()
        
        cardView.addSubview(titleView)
        setTitleViewConstraints()
        
        cardView.addSubview(subTitleView)
        setSubTitleViewConstraints()
    }
    
    func setCardViewConstraints() {
        let cardViewLeading = NSLayoutConstraint(item: cardView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let cardViewTrailing = NSLayoutConstraint(item: cardView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let cardViewBottom = NSLayoutConstraint(item: cardView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 4)
        let cardViewTop = NSLayoutConstraint(item: cardView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 4)
        NSLayoutConstraint.activate([cardViewLeading, cardViewTrailing, cardViewBottom, cardViewTop])
    }
    
    func setTitleViewConstraints() {
        let titleViewLeading = NSLayoutConstraint(item: titleView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let titleViewTrailing = NSLayoutConstraint(item: titleView, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let titleViewTop = NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 4)
        NSLayoutConstraint.activate([titleViewLeading, titleViewTrailing, titleViewTop])
    }
    
    func setSubTitleViewConstraints() {
        let subTitleViewLeading = NSLayoutConstraint(item: subTitleView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let subTitleViewTrailing = NSLayoutConstraint(item: subTitleView, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let subTitleViewTop = NSLayoutConstraint(item: subTitleView, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1.0, constant: 4)
        NSLayoutConstraint.activate([subTitleViewLeading, subTitleViewTrailing, subTitleViewTop])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("couldn't init News Cell (init: coder)")
    }
}

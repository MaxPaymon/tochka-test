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
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let descriptionView : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let picture : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        image.layer.cornerRadius = 8
        return image
    }()
    
    func setViews() {
        addSubview(cardView)
        setCardViewConstraints()
        
        cardView.addSubview(picture)
        setPictureConstraints()
        
        cardView.addSubview(titleView)
        setTitleViewConstraints()
        
        cardView.addSubview(descriptionView)
        setDescriptionViewConstraints()
    }
    
    func setCardViewConstraints() {
        let leading = NSLayoutConstraint(item: cardView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: cardView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: cardView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 4)
        let top = NSLayoutConstraint(item: cardView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 4)
        NSLayoutConstraint.activate([leading, trailing, bottom, top])
    }
    
    func setTitleViewConstraints() {
        let leading = NSLayoutConstraint(item: titleView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: titleView, attribute: .trailing, relatedBy: .equal, toItem: picture, attribute: .leading, multiplier: 1.0, constant: -8)
        let top = NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 8)
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    func setDescriptionViewConstraints() {
        let leading = NSLayoutConstraint(item: descriptionView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: descriptionView, attribute: .trailing, relatedBy: .equal, toItem: picture, attribute: .leading, multiplier: 1.0, constant: -8)
        let top = NSLayoutConstraint(item: descriptionView, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1.0, constant: 4)
        let bottom = NSLayoutConstraint(item: descriptionView, attribute: .bottom, relatedBy: .equal, toItem: cardView, attribute: .bottomMargin, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
    func setPictureConstraints() {
        let trailing = NSLayoutConstraint(item: picture, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let height = NSLayoutConstraint(item: picture, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 80)
        let width = NSLayoutConstraint(item: picture, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 80)
        let vartical = NSLayoutConstraint(item: picture, attribute: .centerY, relatedBy: .equal, toItem: cardView, attribute: .centerY, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([trailing, height, width, vartical])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("couldn't init News Cell (init: coder)")
    }
}

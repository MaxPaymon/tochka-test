//
//  UIImageView.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.image = nil
            }
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error  in
                if let data = data {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: urlString as AnyObject)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}

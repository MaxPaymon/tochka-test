//
//  UIImageView.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

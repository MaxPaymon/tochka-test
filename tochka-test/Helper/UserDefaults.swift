//
//  UserDefaults.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 07/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class UserDefault {
    
    let key = "page"
    
    func getPage() -> Int {
        let page = UserDefaults.standard.integer(forKey: key)
        if page == 0 {
            return 1
        }
        return page
    }
    
    func savePage(page : Int) {
        UserDefaults.standard.set(page, forKey: key)
    }
    
}

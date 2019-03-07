//
//  Constants.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class NewsUrl {
    
    static let shared = NewsUrl()
    
    let apiKey = "78e1d3ac178d479eb0f9522feb82f508"
    
    func getNewsUrl(page : Int) -> String {
        let url = "https://newsapi.org/v2/everything?q=apple&from=2019-03-03&to=2019-03-06&sortBy=publishedAt&page=\(page)&pageSize=20&apiKey=\(apiKey)"
        return url
    }
}

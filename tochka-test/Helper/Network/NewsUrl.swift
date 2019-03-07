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
        let dateNow = getNowDate()
        let url = "https://newsapi.org/v2/everything?q=apple&from=2019-03-03&to=\(dateNow)&sortBy=publishedAt&page=\(page)&pageSize=20&apiKey=\(apiKey)"
        return url
    }
    
    func getNowDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

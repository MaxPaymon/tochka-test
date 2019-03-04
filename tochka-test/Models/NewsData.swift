//
//  NewsData.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 05/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class NewsData : Codable {
    var articles : NewsArticles!
}

class NewsArticles : Codable {
    var title : String!
    var description : String!
    var urlToImage : String!
}

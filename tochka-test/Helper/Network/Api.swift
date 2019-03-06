//
//  Api.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 04/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class Api {
    
    func getNews(page : Int, completionHandler: @escaping (NewsData) -> ()) {
        let urlString = NewsUrl.shared.getNewsUrl(page: page)
        
        guard let url = URL(string: urlString) else {
            print("Couldn't create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let getNews = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error api call ", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Error: couldn't get response")
                return
            }
            
            if response.statusCode == 200 {
                guard let responseData = data else {
                    print("Error: did not recieved data")
                    return
                }
                
                do {
                    let result : NewsData = try JSONDecoder().decode(NewsData.self, from: responseData)
                    completionHandler(result)
                } catch {
                    print("Error decode responseData")
                }
                
            } else {
                print("Error: status code is \(response.statusCode)")
                return
            }
        }
        
        getNews.resume()
    }
    
}

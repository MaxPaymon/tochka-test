//
//  CacheManager.swift
//  tochka-test
//
//  Created by Maxim Skorynin on 05/03/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import CoreData
import UIKit

struct NewsKeys {
    static let title = "title"
    static let description = "descript"
    static let pictureUrl = "pictureUrl"
    static let date = "date"
}

class CacheManager {
    
    private let entityNewsName = "News"
    private let api = Api()
    
    private let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
    
    private var managedContext : NSManagedObjectContext!
    
    var pageSize = 20
    
    var newsList : [News] = [] {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newsLoaded"), object: nil)
        }
    }
    
    init() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Couldn't init AppDelegate")
            return
        }
        
        managedContext = delegate.persistentContainer.viewContext
        
    }
    
    private func loadNews(pageSize: Int) {
        api.getNews(pageSize: pageSize) { news in
            self.saveNews(articles: news.articles)
        }
    }
    
    private func saveNews(articles : [NewsArticles]) {
        for article in articles {
            if let news = getExistNews(article: article) {
                updateNews(news: news, article: article)
            } else {
                createNews(article: article)
            }
        }
        
        fetchNews()
    }
    
    private func getExistNews(article : NewsArticles) -> News? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityNewsName)
        let date = getTimestampFromDate(dateString: article.publishedAt)
        fetchRequest.predicate = NSPredicate(format: "date = %d", date)
        
        do {
            let newsObjects = try managedContext.fetch(fetchRequest)
            guard let news = newsObjects.first as? News else {
                return nil
            }
            
            return news
        } catch {
            print("News doesn't exist")
            return nil
        }
        
    }
    
    private func createNews(article : NewsArticles) {
        let newsEntity = NSEntityDescription.entity(forEntityName: entityNewsName, in: managedContext)!
        let news = NSManagedObject(entity: newsEntity, insertInto: managedContext)
        updateNews(news: news, article: article)
    }
    
    private func updateNews(news : NSManagedObject, article : NewsArticles) {
        news.setValue(article.title, forKey: NewsKeys.title)
        news.setValue(article.description, forKey: NewsKeys.description)
        news.setValue(article.urlToImage, forKey: NewsKeys.pictureUrl)
        
        let timestamp = getTimestampFromDate(dateString: article.publishedAt)
        
        news.setValue(timestamp, forKey: NewsKeys.date)
        saveManagedContext()
        
    }
    
    func fetchNews() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityNewsName)
        fetchRequest.fetchLimit = pageSize
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: NewsKeys.date, ascending: false)]
        do {
            let result = try managedContext.fetch(fetchRequest) as! [News]
            if result.count == pageSize {
                newsList = result
            } else {
                loadNews(pageSize: pageSize)
            }
        } catch let error {
            print("Error fetch news: ", error)
        }
    }
    
    private func getTimestampFromDate(dateString : String) -> Int64 {
        if let date = dateFormatter.date(from: dateString) {
            return Int64(date.timeIntervalSince1970)
        } else {
            return Int64(Date().timeIntervalSinceNow)
        }
    }
    
    private func saveManagedContext() {
        do {
            try managedContext.save()
        } catch let error {
            print("Couldn't save news: ", error)
        }
    }
}

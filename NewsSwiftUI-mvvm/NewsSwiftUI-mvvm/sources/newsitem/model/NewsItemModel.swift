//
//  NewsItemModel.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class NewsItemModel: ObservableObject,IModel {
    
    var listener: IContainer?
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
    static let shared = NewsItemModel()
    
    @Published var newsItem: NewsItem = NewsItem()
    @Published var isFavorite: Bool = false
    
    
    var data:NewsItem {
        get {
            return newsItem
        }
    }
    
    func update(data: Any?) {
        if let data = data as? NewsItem {
            self.newsItem = data
        }
    }
    
    func setupData(item: NewsItem){
        self.newsItem = item
        self.isFavorite = item.favorite
    }
    
    func updateFavorite() {
        let favorite = newsItem.favorite
        newsItem.favorite = !favorite
        self.isFavorite = newsItem.favorite
        
        if (!favorite) {
            addToFavorite()
        } else {
            removeFromFavorite()
        }
    }
    
    private func addToFavorite() {
        newsService?.addToFavorite(newsItem: newsItem)
    }
    
    private func removeFromFavorite() {
        newsService?.removeFromFavorite(newsItem: newsItem)
    }
}

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
    private var item: NewsItem? = nil
    
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
        self.item = item
        self.isFavorite = item.favorite
    }
    
    func setupContent() {
        self.newsItem = item ?? NewsItem()
        self.isFavorite = item?.favorite ?? false 
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
        self.listener?.showLoading()
        newsService?.addToFavorite(newsItem: newsItem)
        self.listener?.hideLoading()
    }
    
    private func removeFromFavorite() {
        self.listener?.showLoading()
        newsService?.removeFromFavorite(newsItem: newsItem)
        self.listener?.hideLoading()
    }
}

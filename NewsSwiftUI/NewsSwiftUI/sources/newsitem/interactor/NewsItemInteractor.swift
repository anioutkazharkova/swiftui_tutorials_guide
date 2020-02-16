//
//  NewsItemInteractor.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

class NewsItemInteractor: INewsItemInteractor {
    private var newsItem: NewsItem? = nil
    
    var output:INewsItemPresenter?
    
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
    
    func setupData(item: NewsItem){
        self.newsItem = item
    }
    
    func setupContent() {
        if let item = newsItem {
            self.output?.setupResponse(response: .success(news: item))
        }
    }
    
    func updateFavorite() {
        let favorite = newsItem?.favorite ?? false
        newsItem?.favorite = !favorite
        
        if (!favorite) {
            addToFavorite()
        } else {
            removeFromFavorite()
        }
        self.output?.setupResponse(response: .success(news: newsItem!))
    }
    
    private func addToFavorite() {
        guard let item = newsItem else { return }
        newsService?.addToFavorite(newsItem: item)
    }
    
    private func removeFromFavorite() {
        guard let item = newsItem else { return }
        newsService?.removeFromFavorite(newsItem: item)
    }
}

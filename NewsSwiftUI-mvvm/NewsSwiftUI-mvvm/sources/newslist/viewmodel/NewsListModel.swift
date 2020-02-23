//
//  NewsListModel.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol INewsListLogic {
    func getNews(withRefresh: Bool)
    
    func updateFavorite(id: String)
}

class NewsListModel: ObservableObject,INewsListLogic  {
    static let shared = NewsListModel()
    var listener: IContainer?
    @Published var newsResult: [NewsItem] = [NewsItem]()
    @Published var error: String? = nil
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
    
    private let take: Int = 20
    private var page: Int = 0
    private var total: Int = 0
    
    private var news: [NewsItem] = [NewsItem]()
    
    var data:[NewsItem] {
        get {
            return newsResult
        }
    }
    
    func getNews(withRefresh: Bool) {
        if (withRefresh) {
            page = 0
            total = 0
            news = [NewsItem]()
        } else {
            guard news.count < total else {
                return
            }
        }
        self.listener?.showLoading()
        self.newsService?.getNewsList(page: page) { [weak self]
            response in
            guard let self = self else {return}
            self.listener?.hideLoading()
            if let error = response.error {
                self.error = error.message
                self.listener?.showError(error: error.message ?? "")
            } else {
                if let data = response.content {
                    self.total = data.total
                    
                    let loaded = data.articles ?? [NewsItem]()
                    if loaded.count > 0 {
                        self.page += 1
                        self.news.append(contentsOf: loaded)
                        
                    }
                    self.newsResult = self.news
                }
            }
        }
    }
    
    func synchronizeFavorite() {
        news = newsService?.syncWithFavorite(loadedNews: news) ?? [NewsItem]()
        self.newsResult = self.news
    }
    
    func updateFavorite(id: String){
        if let found = (news.filter{$0.uuid == id}).first {
            let index = news.firstIndex(of: found) ?? 0
            self.updateFavorite(index: index)
        }
    }
    
    func updateFavorite(index: Int) {
        let item = news[index]
        item.favorite = !item.favorite
        if (item.favorite) {
            addToFavorite(newsItem: item)
        } else {
            removeFromFavorite(newsItem: item)
        }
        DispatchQueue.main.async {
            self.newsResult = self.news
        }
    }
    
    private func addToFavorite(newsItem: NewsItem) {
        newsService?.addToFavorite(newsItem: newsItem)
    }
    
    private func removeFromFavorite(newsItem: NewsItem) {
        newsService?.removeFromFavorite(newsItem: newsItem)
    }
}


extension NewsListModel : IModel {
    func update(data: Any?) {
        if let data = data as? [NewsItem] {
            self.update(news: data)
        }
    }
    
    func update(news: [NewsItem])
    {
        self.newsResult = news
    }
}






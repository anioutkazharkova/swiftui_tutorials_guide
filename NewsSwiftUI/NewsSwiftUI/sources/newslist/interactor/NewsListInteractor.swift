//
//  NewsListInteractor.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

class NewsListInteractor :INewsListInteractor {
   var output: INewsListPresenter?
    
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
    
    private let take: Int = 20
    private var page: Int = 0
    private var total: Int = 0
    
    private var news: [NewsItem] = [NewsItem]()
    
    
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
        self.newsService?.getNewsList(page: page) { [weak self]
            response in
            guard let self = self else {return}
            
            if let error = response.error {
                self.output?.setupResponse(response: NewsListResponse.error(error: error.message ?? ""))
            } else {
                if let data = response.content {
                    self.total = data.total
                    
                    let loaded = data.articles ?? [NewsItem]()
                    if loaded.count > 0 {
                        self.page += 1
                        self.news.append(contentsOf: loaded)
                        self.output?.setupResponse(response: NewsListResponse.success(news: self.news))
                        // self?.view?.setupNews(news: self?.news ?? [NewsItem]())
                    }
                }
            }
        }
    }
    
    func synchronizeFavorite() {
        news = newsService?.syncWithFavorite(loadedNews: news) ?? [NewsItem]()
        //view?.setupNews(news: news)
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
        /*   DispatchQueue.main.async {
         self.view?.setupNews(news: self.news )
         }*/
    }
    
    private func addToFavorite(newsItem: NewsItem) {
        newsService?.addToFavorite(newsItem: newsItem)
    }
    
    private func removeFromFavorite(newsItem: NewsItem) {
        newsService?.removeFromFavorite(newsItem: newsItem)
    }
    
    func selectItem(index: Int) {
        let item = news[index]
        // router?.navigateTo(screen: .NewsItem, item)
    }
    
    func openFavorite() {
        // router?.navigateTo(screen: .Favorite)
    }
    func openSearch() {
        // router?.navigateTo(screen: .Search, news)
    }
}

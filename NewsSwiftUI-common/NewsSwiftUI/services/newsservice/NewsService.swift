//
//  NewsService.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class NewsService: INewsService {

    private let networkService: INetworkService
    private let favoriteDao: IFavoriteProvider
    private let searchDao: ISearchProvider

    init(networkService: INetworkService) {
        self.networkService = networkService
        self.favoriteDao = DI.dataContainer.favoriteDao
        self.searchDao = DI.dataContainer.searchDao
    }

    // MARK: News request
    func getNewsList(page: Int, completion: @escaping(ContentResponse<NewsList>) -> Void) {

     let parameters = ["page": "\(page)"]

      networkService.request(url: Requests.top.rawValue, parameters: parameters, method: Methods.get) {[weak self] (result: ContentResponse<NewsList>) in
                if let data = result.content?.articles {
                    let processed = self?.syncWithFavorite(loadedNews: data)
                    result.content?.articles = processed
                }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    // MARK: Sync received data with cached favorite
    func syncWithFavorite(loadedNews: [NewsItem]) -> [NewsItem] {
        let favorite = getFavorites()
        if favorite.count > 0 {
            for var n in loadedNews {
                if let _ = favorite.firstIndex(of: n) {
                    n.favorite = true
                }
            }
        }
        return loadedNews
    }

    // MARK: Favorite

    func getFavorites() -> [NewsItem] {
        return favoriteDao.getFavorites() ?? [NewsItem]()
    }

    func addToFavorite(newsItem: NewsItem) {
        favoriteDao.addFavorite(item: newsItem)
    }

    func removeFromFavorite(newsItem: NewsItem) {
        favoriteDao.removeFavorite(item: newsItem)
    }

    // MARK: Search

    func searchNews(query: String, page: Int = 0, completion: @escaping (ContentResponse<NewsList>) -> Void) {
        networkService.request(url: Requests.top.rawValue, parameters: ["q": "\(query)", "page": "\(page)"], method: Methods.get) {[weak self] (result: ContentResponse<NewsList>) in

            if let data = result.content?.articles {
                let processed = self?.syncWithFavorite(loadedNews: data)
                result.content?.articles = processed
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func getRecentRequests(completion: @escaping ([SearchItem]) -> Void) {
      let saved =  searchDao.getHistory()
        completion(saved)
    }

    func saveRecentRequests(items: [SearchItem]) {
        searchDao.saveHistory(item: items)
    }

}

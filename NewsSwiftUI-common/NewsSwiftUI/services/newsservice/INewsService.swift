//
//  INewsService.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INewsService: class {
    func getNewsList(page: Int, completion: @escaping(ContentResponse<NewsList>) -> Void)
    func searchNews(query: String, page: Int, completion: @escaping(ContentResponse<NewsList>) -> Void)
    func getRecentRequests(completion: @escaping([SearchItem]) -> Void)
    func saveRecentRequests(items: [SearchItem])
    func addToFavorite(newsItem: NewsItem)
    func getFavorites() -> [NewsItem]
    func removeFromFavorite(newsItem: NewsItem)
    func syncWithFavorite(loadedNews: [NewsItem]) -> [NewsItem]
}

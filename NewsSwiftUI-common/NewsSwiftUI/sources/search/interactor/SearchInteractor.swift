//
//  SearchInteractor.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

class SearchInteractor : ISearchInteractor {
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
    var output: ISearchPresenter?
    
    
    var retrievedData: [NewsItem] = [NewsItem]()
    var searchHistory: [SearchItem] = [SearchItem]()
    var foundResults: [NewsItem] = [NewsItem]()
    
    private var query = ""
    private let take: Int = 20
    private var page: Int = 0
    private var total: Int = 0
    
    
    func loadSearchHistory() {
        newsService?.getRecentRequests { [weak self] results in
            self?.searchHistory = results
            self?.output?.setupSavedResponse(response: SavedSearchResponse.success(news: results))
        }
    }
    
    func searchWithQuery(query: String) {
        if query.isEmpty {
           self.output?.setupSavedResponse(response: SavedSearchResponse.success(news: searchHistory))
            
        } else {
            searchHistory.insert(SearchItem(title: query), at: 0)
            newsService?.saveRecentRequests(items: searchHistory)
            if query.count > 2 {
                searchNews(query: query, withRefresh: true)
            } else {
                searchLocal(query: query)
            }
        }
    }
    
    func searchNews(query: String, withRefresh: Bool) {
        if (withRefresh) {
            self.query = query
            self.page = 0
            self.total = 0
        } else {
            guard foundResults.count < total else {
                return
            }
        }
        self.output?.showLoading()
        newsService?.searchNews(query: query, page: self.page) {[weak self]
            response in
            self?.output?.hideLoading()
            if let error = response.error {
                self?.output?.setupSearchResponse(response: SearchResultsResponse.error(error: error.message ?? ""))
            } else {
                if let data = response.content {
                    self?.total = data.articles?.count ?? 0
                    let results = data.articles ?? [NewsItem]()
                    if results.count > 0 {
                        self?.page += 1
                        
                    }
                    self?.foundResults.append(contentsOf: results)
                    self?.output?.setupSearchResponse(response: SearchResultsResponse.success(news: results))
                }
            }
        }
    }
    
    func getNextSearch() {
        if !self.query.isEmpty {
            self.searchNews(query: self.query, withRefresh: false)
        }
    }
    
    private func searchLocal(query: String) {
        foundResults = retrievedData.filter {($0.title ?? "").contains(query)}
          self.output?.setupSearchResponse(response: SearchResultsResponse.success(news: foundResults))
    }
    
    func searchSavedRequest(index: Int) {
        if let query = searchHistory[index].title {
            if (query.count > 2) {
                searchNews(query: query, withRefresh: true)
            } else {
                searchLocal(query: query)
            }
        }
    }
    
}

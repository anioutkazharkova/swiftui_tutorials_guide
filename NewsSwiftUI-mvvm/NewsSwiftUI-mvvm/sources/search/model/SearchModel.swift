//
//  SearchModel.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import Combine

class SearchModel : ObservableObject,IModel {
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
     var listener: IContainer?
       var retrievedData: [NewsItem] = [NewsItem]()
       var searchHistory: [SearchItem] = [SearchItem]()
       var foundResults: [NewsItem] = [NewsItem]()
       
       private var query = ""
       private let take: Int = 20
       private var page: Int = 0
       private var total: Int = 0
    
    @Published var text: String = ""
    @Published var items:[NewsItem] = [NewsItem]()
    @Published var search:[SearchItem] = [SearchItem]()
    
    static let shared = SearchModel()
    
    
    func loadSearchHistory() {
        newsService?.getRecentRequests { [weak self] results in
            guard let self = self else {return}
            self.searchHistory = results
            self.search = self.searchHistory
        }
    }
    
    func searchWithQuery(query: String) {
        if query.isEmpty {
             self.search = self.searchHistory
            
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
        newsService?.searchNews(query: query, page: self.page) {[weak self]
            response in
            guard let self = self else {return}
            if let error = response.error {
                //self?.output?.setupSearchResponse(response: SearchResultsResponse.error(error: error.message ?? ""))
            } else {
                if let data = response.content {
                    self.total = data.articles?.count ?? 0
                    let results = data.articles ?? [NewsItem]()
                    if results.count > 0 {
                        self.page += 1
                        
                    }
                    self.foundResults.append(contentsOf: results)
                    self.items = self.foundResults
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
         self.items = self.foundResults
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
    
    func update(data: Any?) {
        
    }
}

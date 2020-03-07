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
    @Published var text: String = ""
    @Published var items:[NewsItem] = [NewsItem]()
    @Published var search:[SearchItem] = [SearchItem]()
    
    var listener: IContainer?
    
    private weak var newsService: INewsService? = DI.serviceContainer.newsService
    
    private var query = ""
    private let take: Int = 20
    private var page: Int = 0
    private var total: Int = 0
    
    private var retrievedData: [NewsItem] = [NewsItem]()
    private var searchHistory: [SearchItem] = [SearchItem]()
    private var foundResults: [NewsItem] = [NewsItem]()
    
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
            let item = SearchItem(title: query)
            if searchHistory.contains(item) {
                if let index = searchHistory.firstIndex(of: item) {
                    searchHistory.remove(at: index)
                }
            }
            searchHistory.insert(item, at: 0)
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
        self.listener?.showLoading()
        newsService?.searchNews(query: query, page: self.page) {[weak self]
            response in
            guard let self = self else {return}
            self.listener?.hideLoading()
            if let error = response.error {
                self.listener?.showError(error: error.message ?? "")
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

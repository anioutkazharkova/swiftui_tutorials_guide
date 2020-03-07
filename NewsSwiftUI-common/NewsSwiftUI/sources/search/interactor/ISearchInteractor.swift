//
//  ISearchInteractor.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol ISearchInteractor : class {
    var output: ISearchPresenter? {get set}
    
    func loadSearchHistory()
    
    func searchWithQuery(query: String)
    
    func searchNews(query: String, withRefresh: Bool)
    
    func getNextSearch()
    
    func searchSavedRequest(index: Int)
}

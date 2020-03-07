//
//  SearchPresenter.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

class SearchPresenter: ISearchPresenter {
    var output: ISearchView?
    
    func setupSearchResponse(response:SearchResultsResponse) {
        switch response {
        case .success(let items):
            self.output?.updateModel(data: items)
        default:
            break
        }
    }
    
    func setupSavedResponse(response: SavedSearchResponse) {
        switch response {
        case .success(let items):
            self.output?.updateModel(data: items)
        case .error(let error):
            self.showError(error: error)
        default:
            break
        }
    }
    
    func showError(error: String) {
        self.output?.showError(error: error)
    }
    
    func showLoading() {
        self.output?.showLoading()
    }
    
    func hideLoading() {
        self.output?.hideLoading()
    }
}


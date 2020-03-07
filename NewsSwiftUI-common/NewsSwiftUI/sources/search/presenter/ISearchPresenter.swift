//
//  ISearchPresenter.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol ISearchPresenter: class,IPresenter {
    var output: ISearchView? {get set}
    
    func setupSearchResponse(response:SearchResultsResponse)
    
    func setupSavedResponse(response: SavedSearchResponse)
}

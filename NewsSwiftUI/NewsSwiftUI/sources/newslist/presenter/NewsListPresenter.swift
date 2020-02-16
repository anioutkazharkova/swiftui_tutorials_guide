//
//  NewsListPresenter.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

class NewsListPresenter:NSObject,INewsListPresenter {
    lazy var output: INewsListView? = nil
    
    func setupResponse(response: NewsListResponse) {
        switch  response {
        case .error(let error):
            self.showError(error: error)
        case .success(let data):
            output?.updateModel(data: data)
        }
    }
    
    func showError(error: String) {
        
    }
}

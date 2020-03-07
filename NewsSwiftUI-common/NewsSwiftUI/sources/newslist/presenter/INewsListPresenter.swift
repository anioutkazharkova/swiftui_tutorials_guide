//
//  INewsListPresenter.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol INewsListPresenter: class,IPresenter {
    var output:INewsListView? {get set}
    
    func setupResponse(response: NewsListResponse)
}

protocol IPresenter {
    func showError(error: String)
    
    func showLoading()
    
    func hideLoading()
}

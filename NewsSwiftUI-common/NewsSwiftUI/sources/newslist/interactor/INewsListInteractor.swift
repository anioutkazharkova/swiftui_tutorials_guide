//
//  INewsListInteractor.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol INewsListInteractor : class {
    var output:INewsListPresenter? {get set}
    
    func getNews(withRefresh: Bool)
    
    func updateFavorite(id: String)
}

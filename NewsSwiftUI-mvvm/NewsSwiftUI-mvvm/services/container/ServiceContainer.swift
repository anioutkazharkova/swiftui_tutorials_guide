//
//  ServiceContainer.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

// MARK: DI for services
protocol  IServiceContainer {
    var newsService: INewsService { get }
}

class  ServiceContainer: IServiceContainer {
    var _newsService: INewsService?
    
    var newsService: INewsService {
        get {
            if (_newsService == nil){
                _newsService = NewsService(networkService: DI.container.networkService)
            }
            return _newsService!
        }
    }
}

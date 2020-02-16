//
//  DataModel.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

enum NewsListResponse {
    case success(news: [NewsItem])
    
    case error(error: String)
}

enum NewsItemResponse {
    case success(news: NewsItem)
    
    case error(error: String)
}

enum SearchResultsResponse {
    case success(news: [NewsItem])
    
    case error(error: String)
}

enum SavedSearchResponse {
    case success(news: [SearchItem])
    
    case error(error: String)
}

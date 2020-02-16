//
//  NewsListModel.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NewsListModel: ObservableObject,IModel {
    static let shared = NewsListModel()
    
    @Published var news: [NewsItem] = [NewsItem]()
    
    var data:[NewsItem] {
        get {
            return news
        }
    }
    
    func update(data: Any?) {
        if let data = data as? [NewsItem] {
            self.update(news: data)
        }
    }
    
    func update(news: [NewsItem])
    {
        self.news = news
    }
    
}

protocol  IModel {
    func update(data: Any?)
}

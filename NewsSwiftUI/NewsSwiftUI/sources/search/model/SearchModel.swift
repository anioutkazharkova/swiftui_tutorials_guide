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
    
    static let shared = SearchModel()
    
    func update(data: Any?) {
        if let data = data as? [NewsItem] {
            self.items = data
        }
        if let data = data as? [SearchItem] {
            self.search = data
        }
    }
}

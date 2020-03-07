//
//  NewsItemModel.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class NewsItemModel: ObservableObject,IModel {
     var listener: IContainer?
    
    @Published var item: NewsItem = NewsItem()
    
    var data:NewsItem {
        get {
            return item
        }
    }
    
    func update(data: Any?) {
        if let data = data as? NewsItem {
            self.item = data
        }
    }
    
}

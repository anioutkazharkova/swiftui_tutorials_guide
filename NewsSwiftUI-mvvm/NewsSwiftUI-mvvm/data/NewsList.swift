//
//  NewsList.swift
//  MoviesSearch
//
//  Created by 1 on 17.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: Model for news list
class NewsList: Mappable,Identifiable {
    var status: String?
    var total: Int = 0
    var articles: [NewsItem]?

    required init?(map: Map) {}

     func mapping(map: Map) {
        status <- map["status"]
        total <- map["totalResults"]
        articles <- map["articles"]
    }

}

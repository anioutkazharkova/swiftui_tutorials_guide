//
//  NewsItem.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: model for news
class NewsItem: Mappable,Identifiable {
    
    let uuid = UUID().uuidString
    
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?
    var favorite: Bool = false
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        source <- map["source"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt = map.toDate(key: "publishedAt")
        content <- map["content"]
        favorite <- map["favorite"]
    }
}

extension NewsItem: Equatable {
    static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        return  lhs.url == rhs.url
    }
}

class Source: Mappable, Equatable {
    var id: String?
    var name: String?
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

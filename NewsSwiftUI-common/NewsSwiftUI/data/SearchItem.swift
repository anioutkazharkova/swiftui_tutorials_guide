//
//  SearchItem.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: Model for search history item
class SearchItem: Mappable,Identifiable {

    var title: String?

    required init?(map: Map) {}
    init() {}

    convenience init(title: String ) {
        self.init()
        self.title = title
    }

    func mapping(map: Map) {
        title <- map["title"]
    }

}

extension SearchItem: Equatable {
    static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
        return lhs.title == rhs.title
    }
}

//
//  CachedObject.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

// MARK: Data structure to store serialized data in storage
class CachedItem: Object {
    @objc dynamic var id = 0
    @objc dynamic var value = ""
    @objc dynamic var tableKey = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: Deserialization
extension CachedItem {
    static func create<T: Mappable>(item: T, key: String) -> CachedItem {
        let c = CachedItem()
        c.tableKey = key
        c.value = Mapper<T>().toJSONString(item, prettyPrint: false) ?? ""
        return c
    }

    func uncache<T: Mappable>() -> T? {
        return Mapper<T>().map(JSONString: self.value)
    }

    static func create<T: Mappable>(items: [T], key: String) -> CachedItem {
        let c = CachedItem()
        c.tableKey = key
        c.value = Mapper<T>().toJSONString(items, prettyPrint: false) ?? ""
        return c
    }

    func uncacheArray<T: Mappable>() -> [T]? {
        return Mapper<T>().mapArray(JSONString: self.value)
    }
}

// MARK: Deserialization in array
extension Array where Element: CachedItem {
    func uncacheAll<T: Mappable>() -> [T]? {
        var data: [T]? = [T]()
        for var r in self {
            data?.append(contentsOf: r.uncacheArray() ?? [T]())
        }
        return data
    }
}

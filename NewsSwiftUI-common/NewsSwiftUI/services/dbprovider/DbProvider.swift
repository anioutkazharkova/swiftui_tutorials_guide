//
//  DbProvider.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

// MARK: Tables types
enum TableType: String {
    case Favorite, SearchResult
}

// MARK: static db initializer
class RealmKeeper {
    static let database: Realm? = try? Realm()
}

// MARK: abstract db storage
class DbProvider<T: Mappable&Equatable> {

    private let database: Realm?

    init() {
        database = RealmKeeper.database
    }

    // MARK: Save data for type
    func saveAll(items: [T], key: TableType, withUpdate: Bool) {
      let id = getIdForType(key: key)
        guard let database = self.database else { return}
        do {
            try? database.write {
                let data = CachedItem.create(items: items, key: key.rawValue)
               data.id = id
                database.add(data, update: withUpdate)
            }
        }
    }

    // MARK: Get data for type
    func getAll(key: TableType) -> [T]? {
        guard let database = self.database else { return nil}
        let results: Results<CachedItem>? = database.objects(CachedItem.self).filter("tableKey == %@", key.rawValue)
        var data: [T]? = [T]()
        results?.forEach {
            data?.append(contentsOf: $0.uncacheArray() ?? [T]())
        }
        return data
    }

    // MARK: Add item
    func addItem(item: T, key: TableType) {
        var results =  self.getAll(key: key) ?? [T]()

        results.append(item)

        saveAll(items: results, key: key, withUpdate: true)

    }

    // MARK: Remove item
    func removeItem(item: T, key: TableType) {
        var results =  self.getAll(key: key) ?? [T]()
        if let index = results.firstIndex(of: item) {
            results.remove(at: index)
            saveAll(items: results, key: key, withUpdate: true)
        }
    }

    // MARK: clear db
    func removeAll(key: TableType) {
        guard let database = self.database else { return}
        do {
            try? database.write {
                database.deleteAll()
            }
        }
    }

    // MARK: Generate id for primary key
    private func getIdForType(key: TableType) -> Int {
        guard let database = self.database else { return 0}
        let results: Results<CachedItem>? = database.objects(CachedItem.self).filter("tableKey == %@", key.rawValue)
        return results?.first?.id ?? getId()
    }

    private func getId() -> Int {
        guard let database = self.database else { return 0}
        let results: Results<CachedItem>? = database.objects(CachedItem.self)
        return (results?.last?.id ?? 0) + 1
    }
}

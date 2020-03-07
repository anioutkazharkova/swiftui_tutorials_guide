//
//  SearchProvider.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: Impl of db provider to history
class SearchProvider: ISearchProvider {
       private let storage: DbProvider<SearchItem> = DbProvider<SearchItem>()

    func getHistory() -> [SearchItem] {
        return   storage.getAll(key: .SearchResult) ?? [SearchItem]()
    }

    func addHistoryItem(item: SearchItem) {
        storage.addItem(item: item, key: .SearchResult)
    }

    func saveHistory(item: [SearchItem]) {
        storage.saveAll(items: item, key: .SearchResult, withUpdate: true)
    }

}

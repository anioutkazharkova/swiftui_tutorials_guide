//
//  FavoriteProvider.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: Impl of db provider to favorite
class FavoriteProvider: IFavoriteProvider {

   private let storage: DbProvider<NewsItem> = DbProvider<NewsItem>()

    func addFavorite(item: NewsItem) {
        storage.addItem(item: item, key: .Favorite)
    }

    func removeFavorite(item: NewsItem) {
        storage.removeItem(item: item, key: .Favorite)
    }

    func getFavorites() -> [NewsItem]? {
        return storage.getAll(key: .Favorite)
    }

}

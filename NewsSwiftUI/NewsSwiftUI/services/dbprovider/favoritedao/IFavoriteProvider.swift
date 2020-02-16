//
//  IFavoriteProvider.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol IFavoriteProvider: class {
    func addFavorite(item: NewsItem)
    func removeFavorite(item: NewsItem)
    func getFavorites() -> [NewsItem]?
}

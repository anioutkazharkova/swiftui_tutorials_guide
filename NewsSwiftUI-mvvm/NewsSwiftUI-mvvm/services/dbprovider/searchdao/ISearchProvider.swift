//
//  ISearchProvider.swift
//  TestNewsSearch
//
//  Created by 1 on 22.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol ISearchProvider: class {
    func getHistory() -> [SearchItem]
    func addHistoryItem(item: SearchItem)
    func saveHistory(item: [SearchItem])
}

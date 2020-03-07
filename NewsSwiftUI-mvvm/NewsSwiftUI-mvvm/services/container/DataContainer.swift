//
//  DataContainer.swift
//  TestNewsSearch
//
//  Created by 1 on 21.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: DI for dao
protocol IDataContainer {
    var favoriteDao: FavoriteProvider {get}
    var searchDao: SearchProvider { get }
}

class DataContainer: IDataContainer {
    var _favoriteDao: FavoriteProvider?
    var _searchDao: SearchProvider?
    
    var favoriteDao: FavoriteProvider {
        get {
            if (_favoriteDao == nil){
                _favoriteDao = FavoriteProvider()
            }
            return _favoriteDao!
        }
    }
    
    var searchDao: SearchProvider {
        get {
            if (_searchDao == nil){
                _searchDao = SearchProvider()
            }
            return _searchDao!
        }
    }
}

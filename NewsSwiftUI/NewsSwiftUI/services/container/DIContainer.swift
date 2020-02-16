//
//  DIContainer.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

protocol IDIContainer {
    var networkService: INetworkService { get }
    var networkConfiguration: INetworkConfiguration { get }
}

class DIContainer: IDIContainer {
    private var _networkService: INetworkService?
    private var _networkConfig: INetworkConfiguration?
    
    var networkService: INetworkService {
        if (_networkService == nil) {
            _networkService = NetworkService(networkConfiguration: DI.container.networkConfiguration)
        }
        return _networkService!
    }
    
    var networkConfiguration: INetworkConfiguration {
        if (_networkConfig == nil ) {
            _networkConfig = NetworkConfiguration()
        }
        return _networkConfig!
    }
}

//
//  DI.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: simple di 
class DI {

private static let shared = DI()
    private let container: IDIContainer
    private let serviceContainer: IServiceContainer
    private let dataContainer: IDataContainer

    static var container: IDIContainer {
        return shared.container
    }
    static var dataContainer: IDataContainer {
        return shared.dataContainer
    }
    static var serviceContainer: IServiceContainer {
        return shared.serviceContainer
    }

init() {
    container = DIContainer()
    serviceContainer = ServiceContainer()
    dataContainer = DataContainer()
}

}

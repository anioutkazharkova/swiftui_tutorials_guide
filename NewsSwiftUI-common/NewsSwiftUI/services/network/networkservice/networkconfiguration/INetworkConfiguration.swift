//
//  INetworkConfiguration.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INetworkConfiguration {
    func getHeaders() -> [String: String]
    func getBaseUrl() -> String
}

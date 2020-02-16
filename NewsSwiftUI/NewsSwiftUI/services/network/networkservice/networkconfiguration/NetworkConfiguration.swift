//
//  NetworkConfiguration.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

// MARK: base network configuration
class NetworkConfiguration: INetworkConfiguration {

    private let apiUrl = "https://newsapi.org/v2/"
    private let apiKey = "5b86b7593caa4f009fea285cc74129e2"

    func getHeaders() -> [String: String] {
        return ["X-Api-Key":apiKey]
    }

    func getBaseUrl() -> String {
        return apiUrl
    }

}

//
//  INetworkService.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol INetworkService: class {
    func request<T>(url: String,
    parameters: [String: String],
    method: Methods,
    completion: @escaping (ContentResponse<T>) -> Void)
}

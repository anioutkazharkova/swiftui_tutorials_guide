//
//  ContentResponse.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: Error types
enum ErrorType {
    case network, other
}

// MARK: generic type for network response
class ContentResponse<T: Mappable> {
    var content: T?
    var error: ErrorResponse?
    var code: Int = 0

    init() {}

  convenience init(response: HTTPURLResponse, json: Any) {
        self.init()
        code = response.statusCode
        guard let result = Mapper<T>().map(JSONObject: json) else {
             error = Mapper<ErrorResponse>().map(JSONObject: json)
            return
        }
        content = result
    }

    convenience init(error: ErrorResponse) {
        self.init()
        self.error = error
    }
}

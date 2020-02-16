//
//  NetworkService.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

// MARK: Method wrapper to prevent including Alamofire in presenters
enum Methods {
    case get, post, patch, delete

    func toMehtod() -> HTTPMethod {
        switch (self) {
        case .get:
            return .get
        case .post:
            return .post
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
}

// MARK: Network service
class NetworkService: INetworkService {

private var requestSessionManager: SessionManager
private var networkConfiguration: INetworkConfiguration

    init(networkConfiguration: INetworkConfiguration) {
        self.networkConfiguration = networkConfiguration
        requestSessionManager = SessionManager.default
    }

    // MARK: Generic request method
    public func request<T>(url: String,
                           parameters: [String: String] = [:],
                           method: Methods,
                           completion: @escaping (ContentResponse<T>) -> Void) {
        DispatchQueue.global().async {

            let urlEncoding = URLEncoding(boolEncoding: .literal)
            let requestURL = "\(self.networkConfiguration.getBaseUrl())\(url)"

             Alamofire.request(requestURL, method: method.toMehtod(), parameters: parameters, encoding: urlEncoding, headers: self.networkConfiguration.getHeaders())
                .responseJSON { response in

                    if let _ = response.error {
                        let errorResult = ContentResponse<T>(error: ErrorResponse(type: .network))
                        completion(errorResult)
                        return
                    }

                 guard let urlResponse = response.response, let json = response.value else {
                    let errorResult = ContentResponse<T>(error: ErrorResponse(type: .network))
                    completion(errorResult)
                    return
                  }
                 let result = ContentResponse<T>(response: urlResponse, json: json)
print("\(json)")
                 completion(result)
            }
        }
    }
}

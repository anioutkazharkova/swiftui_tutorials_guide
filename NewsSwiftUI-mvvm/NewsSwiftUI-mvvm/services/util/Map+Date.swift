//
//  Map+Date.swift
//  MoviesSearch
//
//  Created by 1 on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import ObjectMapper

extension Map {
    var formats:[String]{
        return [ "yyyy-MM-dd'T'hh:mm:ss",
                 "yyyy-MM-dd'T'hh:mm:ssz",
                 "yyyy-MM-dd'T'hh:mm:ssZ"]
    }
    
    func toDate (key: String, _ format: String = "yyyy-MM-dd'T'hh:mm:ss") -> Date? {
        var dateString: String? = nil
        dateString <- self[key]
        
        
        guard let date = dateString else {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        var returnedDate: Date? = nil
        
        for f in formats {
            dateFormatter.dateFormat = f
            let d = dateFormatter.date(from: date)
            if d != nil {
                returnedDate = d
                break
            }
        }
        return returnedDate
    }
}

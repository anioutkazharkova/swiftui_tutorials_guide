//
//  BaseModel.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 22.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import Combine

class BaseModel:ObservableObject,IModel {
   
    var hasError: Bool {
        return !(error ?? "").isEmpty
    }
    var didChangeError = PassthroughSubject<String?, Never>()
    var error: String? = nil {
           didSet {
               didChangeError.send(error)
           }
       }
    
    @objc func showError(error: String){
        self.error = error
    }
    
    @objc  func errorShown() {
        self.error = nil
    }
    
    @objc func update(data: Any?) {
        
    }
    
}

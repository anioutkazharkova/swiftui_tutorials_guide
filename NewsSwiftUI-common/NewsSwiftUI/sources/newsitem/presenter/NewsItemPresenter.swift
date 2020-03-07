//
//  NewsItemPresenter.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

class NewsItemPresenter: INewsItemPresenter {
    var output:INewsItemView?
    
    func setupResponse(response: NewsItemResponse) {
        switch response {
        case .success(let item):
            self.output?.updateModel(data: item)
        case .error(let error):
            self.showError(error: error)
        }
    }
    
     
     func showError(error: String) {
              self.output?.showError(error: error)
              }
           
           func showLoading() {
                self.output?.showLoading()
              }
              
              func hideLoading() {
                  self.output?.hideLoading()
              }
}

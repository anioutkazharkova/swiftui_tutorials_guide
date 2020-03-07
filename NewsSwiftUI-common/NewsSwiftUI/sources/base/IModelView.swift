//
//  IModelView.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 22.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol IModelView {
    var viewModel: IModel? {get}
    
    func showError(error: String)
    
    func showLoading()
    
    func hideLoading()
}


extension IModelView {
    func showError(error: String) {
        self.viewModel?.listener?.showError(error: error)
    }
       
    func showLoading() {
        self.viewModel?.listener?.showLoading()
    }
       
    func hideLoading() {
        self.viewModel?.listener?.hideLoading()
    }
}

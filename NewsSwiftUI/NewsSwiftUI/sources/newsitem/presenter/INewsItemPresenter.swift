//
//  INewsItemPresenter.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol INewsItemPresenter: class,IPresenter {
    var output:INewsItemView? {get set}
    
    func setupResponse(response: NewsItemResponse)
}

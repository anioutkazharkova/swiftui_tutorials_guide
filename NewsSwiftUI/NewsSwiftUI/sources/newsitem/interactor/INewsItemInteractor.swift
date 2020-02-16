//
//  INewsItemInteractor.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol INewsItemInteractor : class {
     var output:INewsItemPresenter? {get set}
    
    func updateFavorite()
    
    func setupContent()
    
    func setupData(item: NewsItem)
}

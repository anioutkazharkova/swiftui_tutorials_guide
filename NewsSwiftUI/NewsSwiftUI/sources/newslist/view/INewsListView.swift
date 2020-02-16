//
//  INewsListView.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol INewsListView: IInputView {
    var output: INewsListInteractor? {get set}
    
}

protocol IInputView {
    func updateModel(data: Any?)
}

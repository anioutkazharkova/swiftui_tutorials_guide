//
//  ISearchView.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation

protocol ISearchView : IInputView {
    var output: ISearchInteractor? {get set}
}

//
//  SearchConfigurator.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SearchConfigurator : IConfugator {
    static let shared = SearchConfigurator()
    
    func createScreen(_ data: Any?) -> UIViewController {
        var view = SearchView()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        view.output = interactor
        interactor.output = presenter
        presenter.output = view
        return UIHostingController<ContainerView<SearchView>>(rootView: ContainerView(content: view))
    }
}

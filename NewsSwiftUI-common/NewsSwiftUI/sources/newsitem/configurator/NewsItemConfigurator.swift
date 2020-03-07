//
//  NewsItemConfigurator.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class NewsItemConfigurator:IConfugator {
    static let shared = NewsItemConfigurator()
    private init(){}
    
    func createScreen(_ data: Any?) -> UIViewController {
        let data = data as? NewsItem
        
        var view = NewsItemView()
        let interactor = NewsItemInteractor()
        let presenter = NewsItemPresenter()
        interactor.setupData(item: data ?? NewsItem())
        interactor.output = presenter
        presenter.output = view
        view.output = interactor
        
        let vc = UIHostingController<ContainerView<NewsItemView>>(rootView: ContainerView(content: view))
        return vc
    }
    
    
}

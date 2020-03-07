//
//  NewsListConfigurator.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class NewsListConfigurator: IConfugator {
    static let shared = NewsListConfigurator()
    
    func createScreen(_ data: Any?) -> UIViewController {
      
        
        var view = NewsListView()
        let presenter = NewsListPresenter()
         let interactor = NewsListInteractor()
        
        interactor.output = presenter
        presenter.output = view
        view.output = interactor
        
        let vc = UIHostingController<ContainerView<NewsListView>>(rootView: ContainerView(content: view))
        //view.setupParent(parent: vc)
        return vc
    }
}

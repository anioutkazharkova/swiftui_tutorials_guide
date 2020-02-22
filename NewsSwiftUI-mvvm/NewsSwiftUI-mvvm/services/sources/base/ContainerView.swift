//
//  ContainerView.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 22.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import SwiftUI

import Foundation
import SwiftUI
import Combine

struct ContainerView<Content>: IContainer, View where Content: View&IModelView {
    @ObservedObject var containerModel = ContainerModel()
    private let content: Content

    public init(content: Content) {
        self.content = content
        content.viewModel?.listener = self
        //self.common = content.viewModel as! BaseModel
    }

    var body : some View {
        ZStack {
            content
        }.alert(isPresented: $containerModel.hasError){
            Alert(title: Text(""), message: Text(containerModel.errorText), dismissButton: .default(Text("OK")){
                self.containerModel.hasError = false
                self.containerModel.errorText = ""
                })
        }
    }
    
    func showError(error: String) {
        self.containerModel.errorText = error
        if (!error.isEmpty) {
            self.containerModel.hasError = true
        }
    }
}

class ContainerModel:ObservableObject {
    @Published var hasError: Bool = false
    @Published   var errorText: String = ""
}

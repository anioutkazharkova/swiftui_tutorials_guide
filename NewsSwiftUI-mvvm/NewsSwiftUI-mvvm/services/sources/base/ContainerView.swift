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

struct ContainerView<Content>: View where Content: View {
  
    private let content: Content

    public init(content: Content) {
        self.content = content
        //self.common = content.viewModel as! BaseModel
    }

    var body : some View {
        ZStack {
            content
        }/*.onReceive(common.didChangeError, perform: { (error) in
            self.hasError = !(error ?? "").isEmpty
        }) .alert(isPresented:$hasError) { () -> Alert in
            Alert(title: Text(""), message: Text(common.error ?? ""), dismissButton: .default(Text("OK"), action: {
                self.common.errorShown()
            }))*/
        //}
    }
}

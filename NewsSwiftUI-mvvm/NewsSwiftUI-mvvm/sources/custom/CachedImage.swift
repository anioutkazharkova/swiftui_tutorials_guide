//
//  CachedImage.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 13.04.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI


struct CachedImage : View {
    @ObservedObject var model:CachedImageModel
    
    init(withURL url:String) {
        model = CachedImageModel(urlString:url)
    }
    
    var body: some View {
        Image(uiImage: self.model.image).resizable().scaledToFit().onAppear{
            self.model.loadImage()
        }
    }
    
}

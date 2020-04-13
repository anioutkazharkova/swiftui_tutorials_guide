//
//  WrappedCachedImage.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 13.04.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI

struct WrappedCachedImage : UIViewRepresentable {
    let height: CGFloat
    @State var imageUrl: String
    
    func makeUIView(context: Context) -> CachedImageView {
        let frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.size.width - 40, height: height)
        return CachedImageView(frame: frame)
    }
    
    func updateUIView(_ uiView: CachedImageView, context: Context) {
        uiView.imageUrl = imageUrl
        uiView.contentMode = .scaleToFill
    }
}

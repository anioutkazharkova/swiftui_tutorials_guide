//
//  ImageLoader.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    var data = UIImage() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        ImageManager.sharedInstance.receiveImage(forKey: urlString) { [weak self] (im) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.data = im
            }
        }
    }
}

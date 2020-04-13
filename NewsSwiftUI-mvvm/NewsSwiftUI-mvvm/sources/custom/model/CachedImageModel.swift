//
//  CachedImageLoader.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 13.04.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI

class CachedImageModel : ObservableObject {
    @Published var image: UIImage = UIImage()
    
    private var urlString: String = ""
    
    init(urlString:String) {
        self.urlString = urlString
    }
    
    func loadImage() {
        ImageManager.sharedInstance.receiveImage(forKey: urlString) {[weak self] (im) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.image = im
            }
        }
    }
    
}

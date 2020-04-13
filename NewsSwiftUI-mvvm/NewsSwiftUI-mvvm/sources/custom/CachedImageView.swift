//
//  CachedImageView.swift
//  NewsSwiftUI-mvvm
//
//  Created by 1 on 13.04.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import UIKit

class CachedImageView : UIImageView {
    private var _imageUrl: String?
    var imageUrl: String?  {
        get {
            return _imageUrl
        }
        set {
            self._imageUrl = newValue
            if let url = newValue, !url.isEmpty {
                self.setup(by: url)
            }
        }
    }
    
    func setup(by key: String) {
        ImageManager.sharedInstance.setImage(toImageView: self, forKey: key)
    }
}

//
//  UIImageView+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/12.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import FLAnimatedImage

public extension UIImageView {
    public typealias ExternalCOmpletionBlock = (UIImage?, Error?) -> ()
    public func renderRemoteImage(with url : URL?, placeholderImage : UIImage?, _ completion: ExternalCOmpletionBlock? = nil) {
        let options : SDWebImageOptions = completion == nil ? .retryFailed : [.retryFailed, .avoidAutoSetImage]
        sd_setImage(with: url,
                    placeholderImage: placeholderImage,
                    options: options) { (image, error, _, _) in
            completion?(image, error)
        }
    }
}

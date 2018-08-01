//
//  UIImage+Addition.swift
//  Foo
//
//  Created by huangmin on 30/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    static func imageWithColor(_ color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    static func roundRectImageWithColor(_ color:UIColor, _ rect : CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        context?.addPath(bezierPath.cgPath)
        context!.setFillColor(color.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    static func compressImage(_ image : UIImage?, _ compressionQuality : CGFloat? = nil)-> Data? {
        if let image = image {
            if let imageData = UIImageJPEGRepresentation(image, compressionQuality != nil ? compressionQuality! : 1) {
                while (imageData.count > 1024 * 1024 * 3) {
                    return compressImage(UIImage(data: imageData), 0.9)
                }
                return imageData
            }
        }
        return nil
    }
}

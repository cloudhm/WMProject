//
//  UIImage+Addition.swift
//  Foo
//
//  Created by huangmin on 30/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UIImage {
    public static func imageWithColor(_ color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    public static func roundRectImageWithColor(_ color:UIColor, _ rect : CGRect) -> UIImage {
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
    // MARK: compress image, image quantity and image size
    // https://www.cnblogs.com/silence-cnblogs/p/6346729.html
    public static func compressImage(_ image: UIImage, toByte maxLength: Int? = 1024 * 1024 * 3) -> Data? {
        var compression: CGFloat = 1
        guard var data = UIImageJPEGRepresentation(image, compression), let maxLength = maxLength,
            data.count > maxLength else { return UIImageJPEGRepresentation(image, compression) }
        
        // Compress by size
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = UIImageJPEGRepresentation(image, compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLength { return data }
        
        // Compress by size
        var lastDataLength: Int = 0
        while data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = UIImageJPEGRepresentation(resultImage, compression)!
        }
        return data
    }
}

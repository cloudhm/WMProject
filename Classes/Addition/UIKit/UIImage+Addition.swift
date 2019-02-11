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
        guard var data = image.jpegData(compressionQuality: compression), let maxLength = maxLength,
            data.count > maxLength else { return image.jpegData(compressionQuality: compression) }
        
        // Compress by size
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = image.jpegData(compressionQuality: compression)!
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
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return data
    }
}
/**
 * MAKR: crop image
 * 图片截取
 */
public extension UIImage {
    /**
     * cropped image direction
     * 截图方向
     */
    public enum ImageCropDirection {
        case top
        case left
        case bottom
        case right
    }
    /**
     * crop image
     * 在无法通过系统方法得到满足的情况下，采用此方法
     * direction 截取方向，默认从上往下
     * ratio 宽高比默认为1
     */
    public func croppedImage(direction : ImageCropDirection? = nil, targetRatio : CGFloat? = nil) -> UIImage {
        let cropDirection : ImageCropDirection =  direction ?? .top
        let widthHeightRatio : CGFloat = targetRatio ?? 1.0
        var x : CGFloat = 0
        var y : CGFloat = 0
        var width : CGFloat = size.width
        var height : CGFloat = size.height
        switch cropDirection {
        case .top:
            height = min(size.width / widthHeightRatio, height)
        case .left:
            width = min(size.height * widthHeightRatio, width)
        case .bottom:
            height = min(size.width / widthHeightRatio, height)
            y = size.height - height
        case .right:
            width = min(size.height * widthHeightRatio, width)
            x = size.width - width
        }
        let croppedImage = cgImage?.cropping(to: CGRect(x: x,
                                                        y: y,
                                                        width: width,
                                                        height: height))
        return UIImage(cgImage: croppedImage!)
    }
}

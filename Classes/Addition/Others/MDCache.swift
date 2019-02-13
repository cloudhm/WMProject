//
//  MDCache.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import SDWebImage
public class MDCache {
    public static func clearMemory() {
        SDImageCache.shared().clearMemory()
    }
    public static func cacheSize() -> UInt {
        let size = SDImageCache.shared().getSize()
        return size
    }
    public static func imageForKey(_ key: String?) -> UIImage? {
        return SDImageCache.shared().imageFromCache(forKey: key)
    }
    public static func setImage(_ image: UIImage?, forKey key: String?) {
        SDImageCache.shared().store(image, forKey: key, completion: nil)
    }
    public static func removeImageForKey(_ key: String?) {
        SDImageCache.shared().removeImage(forKey: key, withCompletion: nil)
    }
    public static func clearDisk(_ completion : (()->())? = nil) {
        SDImageCache.shared().clearDisk {
            completion?()
        }
    }
}

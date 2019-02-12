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
}

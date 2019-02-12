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

public class MDImagePrefetcher {
    private static let ignoreNetwork = true
    private static let shared = MDImagePrefetcher()
    private lazy var manager : SDWebImageManager = {
        let m = SDWebImageManager()
        m.imageDownloader?.maxConcurrentDownloads = 3
        return m
    }()
    public static func prefetchImageURL(_ imageURL : URL?) {
        let isReachableOnEthernetOrWiFi = MDNetworkMonitor.shared.isReachableOnEthernetOrWiFi
        if isReachableOnEthernetOrWiFi || ignoreNetwork {
            MDImagePrefetcher.shared.manager.loadImage(with: imageURL,
                                                       options: .lowPriority,
                                                       progress: nil) { (_, _, _, _, _, _) in}
        }
    }
    public static func prefetchImageURLs(_ imageURLs : [URL]?) {
        for imageURL in imageURLs ?? [] {
            prefetchImageURL(imageURL)
        }
    }
}

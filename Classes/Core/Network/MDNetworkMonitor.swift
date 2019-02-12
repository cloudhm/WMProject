//
//  MDNetworkMonitor.swift
//  WMProject
//
//  Created by cloud on 2019/2/12.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import Alamofire
public extension Notification.Name {
    public static let NetworkDidChange = Notification.Name("MDNetworkMonitor.NetworkDidChange")
}
public class MDNetworkMonitor {
    public static let shared : MDNetworkMonitor = MDNetworkMonitor()
    private var networkReachabilityManager : NetworkReachabilityManager?
    public var isReachableOnEthernetOrWiFi : Bool {
        get {
            return networkReachabilityManager?.isReachableOnEthernetOrWiFi ?? false
        }
    }
    public func startListening(host : String) {
        stopListening()
        networkReachabilityManager = NetworkReachabilityManager(host: host)
        networkReachabilityManager?.listener = { status in
            switch status {
            case .reachable(.wwan), .reachable(.ethernetOrWiFi):
                NotificationCenter.default.post(name: NSNotification.Name.NetworkDidChange,
                                                object: true)
            default:
                NotificationCenter.default.post(name: NSNotification.Name.NetworkDidChange,
                                                object: false)
            }
        }
        networkReachabilityManager?.startListening()
    }
    public func stopListening() {
        networkReachabilityManager?.stopListening()
    }
}

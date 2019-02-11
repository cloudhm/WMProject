//
//  WMNetworkStatus.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import HandyJSON
/**
 * Network status parse
 * 解析返回的状态，
 */
private let defaultErrCode = -1
public class WMNetworkStatus : HandyJSON {
    public var code : String!
    public var message : String?
    
    public required init() {}
    
    public static let `default` = WMNetworkStatus.deserialize(from: ["code": "\(defaultErrCode)"])
    // MARK: convert to error type
    public func asErr() -> Error {
        let domain = String(describing: WMNetworkStatus.self)
        let errCode = Int(code) ?? defaultErrCode
        if code == WMNetworkStatus.ERROR_CODE_ACCESS_TOKEN_EXPIRED.name {
            NotificationCenter.default.post(name: .LogoutAndShouldLoginAgain, object: nil)
        }
        var userInfo : [String : String] = [:]
        userInfo[NSLocalizedDescriptionKey] = message
        return NSError(domain: domain,
                       code: errCode,
                       userInfo: userInfo) as Error
    }
    
    public class Name : Equatable {
        var name : String
        init(rawValue : String) {
            name = rawValue
        }
        func toInt() -> Int? {
            return Int(name)
        }
        public static func == (lhs: Name, rhs: Name) -> Bool {
            return lhs.name == rhs.name
        }
    }
}
/**
 * 网络状态
 * 预置的服务端API返回状态码
 */
public extension WMNetworkStatus {
    public static let NO_ERROR = WMNetworkStatus.Name(rawValue: "1")
    public static let ERROR_CODE_ACCESS_TOKEN_EXPIRED = WMNetworkStatus.Name(rawValue: "100007")
    public static let ERROR_CODE_INSTAGRAM_USER_USED = WMNetworkStatus.Name(rawValue: "10024")
    public static let ERROR_CODE_INSTAGRAM_URL_INVALIDED = WMNetworkStatus.Name(rawValue: "10025")
    public static let ERROR_CODE_PRODUCT_OFF_SHELF = WMNetworkStatus.Name(rawValue: "200011")
}

public extension Notification.Name {
    public static let LogoutAndShouldLoginAgain = Notification.Name(rawValue: "\(String(describing: WMNetworkStatus.self)).ERROR_CODE_ACCESS_TOKEN_EXPIRED")
}

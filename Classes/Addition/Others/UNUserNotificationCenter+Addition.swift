//
//  UNUserNotificationCenter+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import UserNotifications
@available(iOS 10.0, *)
public extension UNUserNotificationCenter {
    /**
     * remote notification status
     */
    public static func remoteNotificationStatus(completion: @escaping(Bool) -> Void){
        // use UserNotifications -- iOS 10.0+
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus != .authorized {
                completion(false)
            } else {
                completion((settings.alertSetting == .enabled ||
                    settings.soundSetting == .enabled ||
                    settings.badgeSetting == .enabled))
            }
        })
    }
}

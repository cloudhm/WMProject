//
//  OneSignal+Addition.swift
//  OneSignalAddition
//
//  Created by cloud on 2018/7/31.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//

import Foundation
import UIKit
import OneSignal
public extension Notification.Name {
    static let OneSignalDeeplink = Notification.Name("OneSignal.Extension.Deeplink")
}
public extension OneSignal {
    static func configureOneSignal(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?, appId: String) {
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            guard let additionalData = result?.notification.payload.additionalData as? [String : Any],
                let deeplink = additionalData["deeplink"] as? String,
                let url = URL(string: deeplink) else {
                    return
            }
            // default handle
            NotificationCenter.default.post(name: NSNotification.Name.OneSignalDeeplink,
                                            object: url)
        }
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true]
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: appId,
                                        handleNotificationAction: notificationOpenedBlock,
                                        settings: onesignalInitSettings)
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
}

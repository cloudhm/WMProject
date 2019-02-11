//
//  UIApplication+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import UIKit
public extension UIApplication {
    public static func safeBottomPadding() -> CGFloat {
        var bottomPadding : CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return bottomPadding
    }
}

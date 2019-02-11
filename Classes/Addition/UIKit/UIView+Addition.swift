//
//  UIView+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import UIKit
public extension UIView {
    // MARK: remove current view's subviews
    public func removeChildren() {
        subviews.forEach{$0.removeFromSuperview()}
    }
}

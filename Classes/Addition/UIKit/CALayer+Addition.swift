//
//  CALayer+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
import UIKit
public extension CALayer {
    public func configureLayer(inputCornerRadius : CGFloat, inputBorderColor : UIColor? = .clear) {
        cornerRadius = inputCornerRadius
        borderColor = inputBorderColor?.cgColor
        borderWidth = 1
        masksToBounds = true
    }
}

//
//  Int+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
public extension Int {
    public func accountPointConvert() -> String? {
        let pointDecimal = Decimal(self).dividing(by: 100)
        return "\(pointDecimal)".priceFormat()
    }
}

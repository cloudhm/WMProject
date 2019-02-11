//
//  Decimal+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
public extension Decimal {
    /**
     * multiplying decimal
     */
    public func multiplying(by rhs: Decimal) -> Decimal {
        var (lhs, rhs) = (self, rhs)
        var result = Decimal()
        NSDecimalMultiply(&result, &lhs, &rhs, NSDecimalNumber.RoundingMode.up)
        return result
    }
    /**
     * dividing decimal
     */
    public func dividing(by rhs: Decimal) -> Decimal {
        var (lhs, rhs) = (self, rhs)
        var result = Decimal()
        NSDecimalDivide(&result, &lhs, &rhs, NSDecimalNumber.RoundingMode.up)
        return result
    }
    /**
     Add a `NSDecimal` to the receiver.
     - parameter other: another `NSDecimal`.
     - returns: a `NSDecimal`.
     */
    public func adding(_ rhs: Decimal) -> Decimal {
        var (lhs, rhs) = (self, rhs)
        var result = Decimal()
        NSDecimalAdd(&result, &lhs, &rhs, NSDecimalNumber.RoundingMode.up)
        return result
    }
    /**
     Subtract a `NSDecimal` from the receiver.
     - parameter other: another `NSDecimal`.
     - returns: a `NSDecimal`.
     */
    public func subtracting(_ rhs: Decimal) -> Decimal {
        var (lhs, rhs) = (self, rhs)
        var result = Decimal()
        NSDecimalSubtract(&result, &lhs, &rhs, NSDecimalNumber.RoundingMode.up)
        return result
    }
}

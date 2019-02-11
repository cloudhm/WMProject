//
//  Array+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
public extension Array where Element == String {
    public func getMaxLengthString() -> String? {
        var str : String?
        for el in self {
            if el.count > (str?.count ?? 0) {
                str = el
            }
        }
        return str
    }
}

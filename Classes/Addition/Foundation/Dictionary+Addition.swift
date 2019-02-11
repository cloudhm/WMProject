//
//  Dictionary+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
// MARK: Dictionary Extension, key string type, value optional any type
public extension Dictionary where Key == String, Value == Any? {
    public func asHTTPHeaderFields(fields : [String : String]) -> [String : String] {
        var header : [String : String] = [:]
        let keys = fields.keys
        for (key, value) in self {
            if keys.contains(key), let alais = fields[key] {
                header[alais] = value as? String
            } else {
                header[key] = value as? String
            }
        }
        return header
    }
}

//
//  Dictionary+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import Foundation
// MARK: Dictionary Extension, key string type, value optional any type
extension Dictionary where Key == String, Value == Any? {
    func asHTTPHeaderFileds(fileds : [String : String]) -> [String : String] {
        var header : [String : String] = [:]
        let keys = fileds.keys
        for (key, value) in self {
            if keys.contains(key), let alais = fileds[key] {
                header[alais] = value as? String
            }
        }
        return header
    }
}

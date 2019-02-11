//
//  UITableView+Addition.swift
//  Foo
//
//  Created by huangmin on 30/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UITableView {
    /**
     * register nibs for tableView
     */
    public func registerNibs(_ classes : [AnyClass]){
        for aClass in classes {
            register(UINib(nibName: String(describing: aClass), bundle: nil), forCellReuseIdentifier: String(describing: aClass))
        }
    }
    /**
     * register classes for tableView headerFooterView
     */
    public func registerHeaderFooterClasses(_ classes : [AnyClass]) {
        for aClass in classes {
            register(aClass, forHeaderFooterViewReuseIdentifier: String(describing: aClass))
        }
    }
}

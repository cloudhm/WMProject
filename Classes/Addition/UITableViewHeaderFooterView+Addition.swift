//
//  UITableViewHeaderFooterView+Addition.swift
//  Foo
//
//  Created by huangmin on 02/01/2018.
//  Copyright © 2018 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UITableViewHeaderFooterView {
    /**
     * dequeue reuseable header view for tableView
     */
    public static func dequeueReusableHeaderFooterView(_ tableView : UITableView) -> UITableViewHeaderFooterView {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: self)) else {
            return self.init(reuseIdentifier: String(describing: self))
        }
        return cell
    }
}

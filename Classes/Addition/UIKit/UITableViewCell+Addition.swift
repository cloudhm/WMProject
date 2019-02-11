//
//  UITableViewCell+Addition.swift
//  Foo
//
//  Created by huangmin on 30/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UITableViewCell {
    /**
     * dequeue reuseable cell for collectionView
     */
    public static func dequeueReusableCell(_ tableView : UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) else {
            return self.init(style: .default, reuseIdentifier: String(describing: self))
        }
        return cell
    }
}

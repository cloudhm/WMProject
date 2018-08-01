//
//  UICollectionViewCell+Addition.swift
//  Foo
//
//  Created by huangmin on 30/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UICollectionViewCell {
    /**
     * dequeue reuseable cell for collectionView
     */
    public static func dequeueReusableCell(_ collectionView : UICollectionView, indexPath : IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath)
    }
}

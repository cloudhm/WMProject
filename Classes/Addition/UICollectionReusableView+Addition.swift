//
//  UICollectionReusableView+Addition.swift
//  Foo
//
//  Created by huangmin on 01/12/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UICollectionReusableView {
    public static func dequeueReusableSupplementaryView(_ collectionView : UICollectionView, ofKind : String, for indexPath : IndexPath) -> UICollectionReusableView{
        return collectionView.dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: String(describing: self), for: indexPath)
    }
}

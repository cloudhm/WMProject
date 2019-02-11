//
//  UICollectionView+Addition.swift
//  Foo
//
//  Created by huangmin on 30/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public extension UICollectionView {
    /**
     * register nibs for collectionView (normal cell)
     */
    public func registerNibs(_ classes : [AnyClass]) {
        for aClass in classes {
            register(UINib(nibName: String(describing: aClass), bundle: nil), forCellWithReuseIdentifier: String(describing: aClass))
        }
    }
    /**
     * register classes for collectionView (normal cell)
     */
    public func registerClasses(_ classes : [AnyClass]) {
        for aClass in classes {
            register(aClass, forCellWithReuseIdentifier: String(describing: aClass))
        }
    }
    /**
     * register nibs for collectionView (reusable cell)
     */
    public func registerReusableNibs(_ classDicts : [String : [AnyClass]]){
        for (kind, classes) in classDicts {
            for aClass in classes{
                register(UINib(nibName: String(describing: aClass), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: aClass))
            }
        }
    }
    /**
     * register classes for collectionView (reusable cell)
     */
    public func registerReusableClasses(_ classes : [AnyClass]) {
        for aClass in classes {
            register(aClass, forCellWithReuseIdentifier: String(describing: aClass))
        }
    }
}

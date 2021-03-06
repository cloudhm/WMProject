//
//  BaseCollectionView.swift
//  Foo
//
//  Created by huangmin on 04/12/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import UIKit

open class BaseCollectionView: UICollectionView {
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCollectionView()
    }
    private func configureCollectionView(){
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
    }
}

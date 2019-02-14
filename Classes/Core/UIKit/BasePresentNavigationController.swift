//
//  BaseNavigationController.swift
//  WMProject
//
//  Created by cloud on 2019/2/14.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    private let presentedAnimatedTransitioningDelegate = PresentedAnimatedTransitioningDelegate()
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    private func setup(){
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .custom
        transitioningDelegate = presentedAnimatedTransitioningDelegate
    }
    

}

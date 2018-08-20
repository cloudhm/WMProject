//
//  PresentedAnimatedTransition.swift
//  Foo
//
//  Created by huangmin on 26/12/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public class PresentedAnimatedTransitioningDelegate : NSObject, UIViewControllerTransitioningDelegate {
    /**
     * UIViewControllerTransitioningDelegate
     */
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentedAnimatedTransitioning()
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentedAnimatedTransitioning()
    }
}

//
//  UIWindow+Addition.swift
//  myshop
//
//  Created by cloud on 2018/6/14.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//

import Foundation
import UIKit
public extension UIWindow {
    public func switchRootViewController(_ viewController: UIViewController?,
                                  animated: Bool = true,
                                  duration: TimeInterval = 0.5,
                                  options: UIView.AnimationOptions = .transitionFlipFromRight,
                                  completion: (() -> Void)? = nil) {
        let oldViewController = rootViewController
        guard animated else {
            rootViewController = viewController
            removeOldViewController(oldViewController)
            return
        }
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) {[weak self] _ in
            self?.removeOldViewController(oldViewController)
            completion?()
        }
    }
    private func removeOldViewController(_ oldViewController : UIViewController?) {
        /**
         * MARK: remove all oldViewController subviews from superView, then dealloc all old viewController
         * https://stackoverflow.com/questions/17632024/changing-the-rootviewcontroller-of-a-uiwindow
         */
        if let presentedViewController = oldViewController?.presentedViewController {
            presentedViewController.dismiss(animated: false, completion: {[weak self] in
                self?.removeOldViewController(oldViewController)
            })
        } else {
            oldViewController?.view.removeFromSuperview()
        }
    }
}

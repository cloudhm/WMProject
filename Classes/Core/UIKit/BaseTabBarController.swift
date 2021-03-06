//
//  BaseTabBarController.swift
//  Foo
//
//  Created by huangmin on 16/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import UIKit
public protocol BaseTabBarControllerConfiguration {
    var canAnimated : Bool { get }
}
extension BaseTabBarControllerConfiguration where Self: UITabBarController {
    public var canAnimated: Bool {
        get {
            return false
        }
    }
}
open class BaseTabBarController: UITabBarController, UITabBarControllerDelegate, BaseTabBarControllerConfiguration {
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    open func setupUI() {
        for item in tabBar.items ?? [] {
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            let defaultFont = UIFont.systemFont(ofSize: 9, weight: .regular)
            item.setTitleTextAttributes([.font : defaultFont, .foregroundColor : #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1)], for: .normal)
            item.setTitleTextAttributes([.font : defaultFont, .foregroundColor : #colorLiteral(red: 0.9254901961, green: 0.2392156863, blue: 0.262745098, alpha: 1)], for: .selected)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        }
        tabBar.tintColor = .white
        tabBar.itemSpacing = 0
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage.imageWithColor(.clear)
        tabBar.shadowImage = UIImage.imageWithColor(#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1))
        delegate = self
    }

    // MARK: UITabBarControllerDelegate
    open func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if !canAnimated { return nil }
        guard let fromIndex = tabBarController.viewControllers?.index(of: fromVC) else { return nil }
        guard let toIndex = tabBarController.viewControllers?.index(of: toVC) else { return nil }
        /**
         * tabbarController's viewControllers trainsitioning animation
         */
        if UIView.userInterfaceLayoutDirection(for: UIView.appearance().semanticContentAttribute) == .leftToRight {
            return AAPLSlideTransitionAnimator(fromIndex < toIndex ? .left : .right)
        } else {
            return AAPLSlideTransitionAnimator(fromIndex < toIndex ? .right : .left)
        }
    }
    open func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


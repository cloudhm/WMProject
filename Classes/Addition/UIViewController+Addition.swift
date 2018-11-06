//
//  UIViewController+Addition.swift
//  WMProject
//
//  Created by cloud on 2018/11/6.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//

import Foundation
import UIKit
// optimize iOS 11.0 +
// https://forums.developer.apple.com/thread/80075
fileprivate enum BarButtonViewPosition {
    case left
    case right
}
fileprivate class BarButtonView: UIView {
    public var applied : Bool = false
    public var position : BarButtonViewPosition = .left
    public override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {
            if applied {
                return
            }
            // Find the _UIButtonBarStackView containing this view, which is a UIStackView, up to the UINavigationBar
            var view : UIView? = self
            while !(view?.isKind(of: UINavigationBar.self) ?? true) {
                view = view?.superview
                if (view?.isKind(of: UIStackView.self) ?? false) && view?.superview != nil {
                    (view as? UIStackView)?.spacing = 0.0
                    if position == .left {
                        view?.superview?.addConstraint(NSLayoutConstraint(item: view as Any,
                                                                          attribute: .leading,
                                                                          relatedBy: .equal,
                                                                          toItem: view?.superview,
                                                                          attribute: .leading,
                                                                          multiplier: 1.0,
                                                                          constant: 15))
                        applied = true
                    } else if position == .right {
                        view?.superview?.addConstraint(NSLayoutConstraint.init(item: view as Any,
                                                                               attribute: .trailing,
                                                                               relatedBy: .equal,
                                                                               toItem: view?.superview,
                                                                               attribute: .trailing,
                                                                               multiplier: 1.0,
                                                                               constant: -15))
                        applied = true
                    }
                    break;
                }
            }
        }
    }
}
public extension UIViewController {
    /**
     * set right button items
     */
    public func setRightBarButtonViews(_ views : [UIView]) {
        if views.isEmpty { return }
        var barButtonItems : [UIBarButtonItem] = []
        for view in views {
            if #available(iOS 11.0, *) {
                let barBtnView : BarButtonView = BarButtonView(frame: view.frame)
                barBtnView.position = .right
                barBtnView.addSubview(view)
                barButtonItems.append(UIBarButtonItem(customView: barBtnView))
            } else {
                barButtonItems.append(UIBarButtonItem(customView: view))
            }
        }
        navigationItem.setRightBarButtonItems(barButtonItems, animated: true)
    }
    /**
     * set left button items
     */
    public func setLeftBarButtonViews(_ views : [UIView]) {
        if views.isEmpty { return }
        var barButtonItems : [UIBarButtonItem] = []
        for view in views {
            if #available(iOS 11.0, *) {
                let barBtnView : BarButtonView = BarButtonView(frame: view.frame)
                barBtnView.position = .left
                barBtnView.addSubview(view)
                barButtonItems.append(UIBarButtonItem(customView: barBtnView))
            } else {
                barButtonItems.append(UIBarButtonItem(customView: view))
            }
        }
        navigationItem.setLeftBarButtonItems(barButtonItems, animated: true)
    }
}

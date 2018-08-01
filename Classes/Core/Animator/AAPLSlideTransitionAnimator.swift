//
//  AAPLSlideTransitionAnimator.swift
//  Foo
//
//  Created by huangmin on 18/01/2018.
//  Copyright © 2018 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
class AAPLSlideTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    var targetEdge : UIRectEdge!
    init(_ targetEdge : UIRectEdge) {
        super.init()
        self.targetEdge = targetEdge
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC : UIViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC : UIViewController = transitionContext.viewController(forKey: .to) else { return }
        let fromView : UIView = fromVC.view
        let toView : UIView = toVC.view
        let fromFrame = transitionContext.initialFrame(for: fromVC)
        // configure vector
        let offset : CGVector = targetEdge == .left ? CGVector(dx: -1, dy: 0) : CGVector(dx: 1, dy: 0)
        containerView.addSubview(toView)
        fromView.frame = fromFrame
        // reset toView frame
        toView.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx * -1,
                                          dy: fromFrame.size.height * offset.dy * -1)
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx,
                                                dy: fromFrame.size.height * offset.dy)
            toView.frame = fromFrame
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

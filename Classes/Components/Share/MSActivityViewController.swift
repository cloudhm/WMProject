//
//  MSActivityViewController.swift
//  myshop
//
//  Created by cloud on 2018/6/25.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//

import UIKit
import FBSDKShareKit
public final class MSActivityViewController: UIActivityViewController {
    public static func showActivityViewController(shareUrl url : URL, from controller : UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: [url as AnyObject], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view
        activityViewController.completionWithItemsHandler = {[weak controller] (activityType, finished, items, error) in
            if activityType == UIActivity.ActivityType.postToFacebook && (!finished) {
                // https://developers.facebook.com/docs/apps/review/prefill
                let shareLinkContent : FBSDKShareLinkContent = FBSDKShareLinkContent()
                shareLinkContent.contentURL = url
                let shareDialog = FBSDKShareDialog()
                shareDialog.fromViewController = controller
                shareDialog.shareContent = shareLinkContent
                if shareDialog.canShow() {
                    shareDialog.show()
                }
            }
        }
        controller.present(activityViewController, animated: true, completion: nil)
    }
}

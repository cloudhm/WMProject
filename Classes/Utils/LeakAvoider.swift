//
//  LeakAvoider.swift
//  WMProject
//
//  Created by cloud on 2018/9/6.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//

import Foundation
import WebKit
/**
 * controller cannot be released to lead memory leak
 * https://stackoverflow.com/questions/26383031/wkwebview-causes-my-view-controller-to-leak
 */
public class LeakAvoider : NSObject, WKScriptMessageHandler {
    weak var delegate : WKScriptMessageHandler?
    public init(_ delegate:WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }
    public func userContentController(_ userContentController: WKUserContentController,
                                      didReceive message: WKScriptMessage) {
        self.delegate?.userContentController(userContentController,
                                             didReceive: message)
    }
    deinit {
        #if DEBUG
            print("deinit LeakAvoider")
        #endif
    }
}

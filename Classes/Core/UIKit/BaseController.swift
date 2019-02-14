//
//  BaseController.swift
//  Foo
//
//  Created by huangmin on 08/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import UIKit

public extension Notification.Name {
    static let WMProjectControllerViewDidAppear = Notification.Name("WMProject.BaseController.ViewDidAppear")
}
open class BaseController: UIViewController, UIGestureRecognizerDelegate {
    open var canRefresh : Bool = true
    open var canSideBack : Bool = false
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    public init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    public var tasks : [URLSessionTask?] = []
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .init(rawValue: 0)
        extendedLayoutIncludesOpaqueBars = true;
        if  #available(iOS 11.0, *) {
            // null configure
        }
        else {
            automaticallyAdjustsScrollViewInsets = false
        }
        configureNavigationItem()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name.WMProjectControllerViewDidAppear,
                                        object: nil)
    }
    open func configureNavigationItem () {
        
    }
    open func configureNavigationBar () {
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .semibold),.foregroundColor: #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)]
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        /**
         * fixed bug: page transition block
         * website: http://www.jianshu.com/p/cbb9ee30e4d0
         */
        let index = navigationController?.viewControllers.index(of: self)
        if let index = index {
            canSideBack = index > 0
        }
        configureCustomizedNavigationBar()
    }
    private func setup() {
        self.hidesBottomBarWhenPushed = true
    }
    open func configureCustomizedNavigationBar(){
        
    }
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        MDCache.clearMemory()
    }
    // MARK: UIGestureRecognizerDelegate
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.canSideBack
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        for task in tasks {
            task?.cancel()
        }
    }
}

//
//  DatePickerViewController.swift
//  WhatsMode
//
//  Created by cloud on 2018/8/20.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//

import UIKit
public class DatePickerController: UIViewController {
    public var cancelBtnTitle : String?
    public var okBtnTitle : String?
    public var actionBlock : ((_ datePickerController : DatePickerController) -> Void)?
    public lazy var datePicker : UIDatePicker = {
        var view = UIDatePicker()
        view.datePickerMode = .date
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        return view
    }()
    // MARK: declare variables
    lazy var backView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.alpha = 0
        return view
    }()
    lazy var tapGr: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(dismissCurrentController))
    }()
    lazy var contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let contentViewHeight : CGFloat = 260
    let presentedAnimatedTransitioningDelegate : PresentedAnimatedTransitioningDelegate = PresentedAnimatedTransitioningDelegate()
    lazy var cancelBtn : UIButton = {
        var btn : UIButton = UIButton()
        btn.setTitle(cancelBtnTitle ?? "Cancel", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return btn
    }()
    lazy var confirmBtn : UIButton = {
        var btn : UIButton = UIButton()
        btn.setTitle(okBtnTitle ?? "OK", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return btn
    }()
    private var originDate : Date?
    // MARK: initialization
    public init(_ originDate : Date?) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .custom
        transitioningDelegate = presentedAnimatedTransitioningDelegate
        self.originDate = originDate
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(self.contentViewHeight)
        }
        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(44)
        }
        contentView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        contentView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        if let originDate = originDate {
            datePicker.setDate(originDate, animated: false)
        }
        contentView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: contentViewHeight)
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        show()
    }
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        backView.removeGestureRecognizer(tapGr)
        UIView.animate(withDuration: 0.25, animations: {
            self.backView.alpha = 0
            self.contentView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.contentViewHeight)
        }) { (finished) in
            super.dismiss(animated: flag, completion: completion)
        }
    }
}
extension DatePickerController {
    func show(){
        UIView.animate(withDuration: 0.25, animations: {
            self.backView.alpha = 1
            self.contentView.transform = .identity
        }) { (finished) in
            self.backView.addGestureRecognizer(self.tapGr)
        }
    }
    @objc func dismissCurrentController(){
        dismiss(animated: true, completion: nil)
    }
    @objc func tapAction(_ sender : UIButton){
        if sender == confirmBtn {
            actionBlock?(self)
        } else {
            dismiss(animated: true)
        }
    }
}


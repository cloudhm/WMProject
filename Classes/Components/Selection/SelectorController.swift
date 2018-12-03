//
//  SelectorController.swift
//  Foo
//
//  Created by huangmin on 20/11/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import UIKit
import SnapKit
public class SelectorController: UIViewController {
    public var cancelBtnTitle : String?
    public var okBtnTitle : String?
    public var selectorBeans : [SelectorBean] = []
    public var selectedIndexs : [Int] = []
    public var actionBlock : ((_ selectorController : SelectorController) -> Void)?
    public lazy var pickerView : UIPickerView = {
        var view = UIPickerView()
        view.dataSource = self
        view.delegate = self
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

    // MARK: initialization
    public init(_ selectorBeans : [SelectorBean], _ selectedIndexs : [Int]) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .custom
        transitioningDelegate = presentedAnimatedTransitioningDelegate
        self.selectorBeans = selectorBeans
        self.selectedIndexs = selectedIndexs
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
            make.leading.bottom.trailing.equalTo(0)
            make.height.equalTo(self.contentViewHeight)
        }
        contentView.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(0)
            make.top.equalTo(44)
        }
        contentView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        contentView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.top.equalTo(0)
            make.height.equalTo(44)
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
extension SelectorController {
    func show(){
        for (component, row) in selectedIndexs.enumerated() {
            if row != -1 {
                pickerView.selectRow(row, inComponent: component, animated: false)
            }
            pickerView.reloadAllComponents()
        }
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
extension SelectorController : UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return SelectorBean.analyticsSelectorBeansLayer(selectorBeans)
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SelectorBean.rowsInPickerView(selectorBeans, pickerView, component)
    }
}
extension SelectorController : UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let label = view as? UILabel else {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.text = SelectorBean.pickerView(selectorBeans, pickerView, titleForRow: row, component)
            return label
        }
        label.text = SelectorBean.pickerView(selectorBeans, pickerView, titleForRow: row, component)
        return label
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let columns = SelectorBean.analyticsSelectorBeansLayer(selectorBeans)
        for column in component ..< columns {
            pickerView.reloadComponent(column)
        }
    }
}

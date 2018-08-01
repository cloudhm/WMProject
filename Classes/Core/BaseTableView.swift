//
//  BaseTableView.swift
//  Foo
//
//  Created by huangmin on 20/12/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import UIKit

public class BaseTableView: UITableView {
    /**
     * MARK: initialization
     * @params: hideNullCell, default value is true, if true then hide other cell 
     * @params: useCustomizedSeperator, default value is false, if true, then hide all
     */
    init(_ useCustomizedSeperator : Bool? = true, _ hideNullCell : Bool? = true) {
        super.init(frame: .zero, style: .plain)
        configureTableView()
        if let useCustomizedSeperator = useCustomizedSeperator {
            separatorStyle = useCustomizedSeperator ? .none : .singleLine
        }
        if let hideNullCell = hideNullCell {
            if hideNullCell {
                let nullView = UIView()
                tableHeaderView = nullView
                tableFooterView = nullView
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureTableView()
    }
    private func configureTableView(){
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        showsVerticalScrollIndicator = false
        rowHeight = UITableViewAutomaticDimension
    }
}

//
//  SelectorBean.swift
//  Foo
//
//  Created by huangmin on 26/12/2017.
//  Copyright © 2017 YedaoDev. All rights reserved.
//

import Foundation
import UIKit
public class SelectorBean : Equatable {
    // MARK: declare variables
    public var category : String?
    public var name : String?
    public var markText : String?
    public var subSelectorBeans : [SelectorBean] = []
    
    // MARK: initialize method
    public init(_ category : String?, _ name : String?, _ markText : String? = nil) {
        self.category = category
        self.name = name
        self.markText = markText
    }
    // MARK: Equatable
    public static func ==(lhs: SelectorBean, rhs: SelectorBean) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: UIPickerView
public extension SelectorBean {
    // MARK:  calculate how many componnents
    public static func analyticsSelectorBeansLayer(_ selectorBeans : [SelectorBean]) -> Int {
        return analyticsSelectorBeansLayer(selectorBeans, 1)
    }
    private static func analyticsSelectorBeansLayer(_ selectorBeans : [SelectorBean], _ currentLayer : Int) -> Int {
        var maxSubLayer = 0
        for selectorBean in selectorBeans {
            if selectorBean.subSelectorBeans.count > 0 {
                // has next node
                let layer = analyticsSelectorBeansLayer(selectorBean.subSelectorBeans, currentLayer + 1)
                if layer > maxSubLayer {
                    maxSubLayer = layer
                }
            }
        }
        if maxSubLayer > 0 {
            return maxSubLayer
        }
        return currentLayer
    }
    // MARK: calculate how many rows in assigned component
    public static func rowsInPickerView(_ selectorBeans : [SelectorBean] , _ pickerView : UIPickerView, _ inComponent : Int) -> Int {
        return rowsInPickerView(selectorBeans, pickerView, inComponent, 0).count
    }
    private static func rowsInPickerView(_ selectorBeans : [SelectorBean] , _ pickerView : UIPickerView, _ inComponent : Int, _ currentComponent : Int) -> [SelectorBean] {
        if (currentComponent < inComponent) {
            let selectedRow = pickerView.selectedRow(inComponent: currentComponent)
            if selectedRow == -1 {
                return []
            } else {
                let selectorBean = selectorBeans[selectedRow]
                return rowsInPickerView(selectorBean.subSelectorBeans, pickerView, inComponent, currentComponent+1)
            }
        } else if (currentComponent == inComponent){
            return selectorBeans
        } else {
            return []
        }
    }
    // MARK:  fetch assigned component's row display content
    public static func pickerView(_ selectorBeans : [SelectorBean] , _ pickerView: UIPickerView, titleForRow row: Int, _ inComponent : Int) -> String? {
        let res : [SelectorBean] = rowsInPickerView(selectorBeans, pickerView, inComponent, 0)
        if row < res.count {
            let selectorBean : SelectorBean? = res[row]
            return selectorBean?.name
        } else {
            return nil
        }
    }
    // MARK: fetch pickerView selected option
    public static func selectedOptionInPickerView(_ selectorBeans : [SelectorBean], _ pickerView : UIPickerView) -> [SelectorBean?] {
        return selectedOptionInPickerView(selectorBeans, pickerView, (analyticsSelectorBeansLayer(selectorBeans) - 1), 0, [])
    }
    private static func selectedOptionInPickerView(_ selectorBeans : [SelectorBean], _ pickerView : UIPickerView, _ inComponent : Int, _ currentComponent : Int, _ list : [SelectorBean?]) -> [SelectorBean?] {
        if currentComponent <= inComponent {
            let selectedRow = pickerView.selectedRow(inComponent: currentComponent)
            if selectedRow < selectorBeans.count {
                let selectorBean = selectorBeans[selectedRow]
                return selectedOptionInPickerView(selectorBean.subSelectorBeans, pickerView, inComponent, currentComponent+1, list + [selectorBean])
            } else {
                return list + [nil]
            }
        } else {
            return list
        }
    }
    // MARK: fetch selectorBeans by [String?]
    public static func fetchSelectorBeans(_ selectorBeans : [SelectorBean], _ titles : [String?]?) -> [Int] {
        let columns = analyticsSelectorBeansLayer(selectorBeans)
        var indexs : [Int] = Array<Int>(repeating: -1, count: columns)
        guard let beanNames = titles else {
            return indexs
        }
        var beans : [SelectorBean] = selectorBeans
        var allTitles : [String?] = beanNames
        var currentIndex = 0
        while beans.count > 0 {
            guard let title = allTitles.first else {
                break
            }
            var objectAtIndex = -1
            var subBeans : [SelectorBean] = []
            for (index, bean) in beans.enumerated() {
                if bean.markText == title {
                    objectAtIndex = index
                    subBeans = bean.subSelectorBeans
                    break
                }
            }
            if objectAtIndex != -1 {
                indexs[currentIndex] = objectAtIndex
                allTitles.remove(at: 0)
                beans = subBeans
                currentIndex += 1
            } else {
                break
            }
        }
        return indexs
    }
}

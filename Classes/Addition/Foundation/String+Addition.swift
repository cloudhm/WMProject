//
//  String+Addition.swift
//  WMProject
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//
import Foundation

/**
 * MARK: validate string
 * 根据正则表达式判断合法性
 */
public extension String {
    /**
     * validate only alphabet and number
     * 判断字母和数字
     */
    public func validateNumberAndAlphabet() -> Bool {
        return matches(by: "[0-9a-zA-Z]+")
    }
    /**
     * validate only alphabet
     * 判断仅字母
     */
    public func validateAlphabet() -> Bool {
        return matches(by: "[a-zA-Z]+")
    }
    /**
     * validate only alphabet, number, '_', '-'
     * 判断instagram 用户名输入正确性
     */
    public func validateIGNameInput() -> Bool {
        return matches(by: "([0-9a-zA-Z_.]+){1,30}")
    }
    /**
     * validate IDFA
     * 判断IDFA是否有效
     */
    public func validateIDFA() -> Bool {
        return matches(by: "[a-zA-Z1-9]+")
    }
    /**
     * validate host
     * 判断域名
     */
    public func validateHost(mainHost : String) -> Bool {
        return matches(by: "[a-zA-Z]*\\.?(\(mainHost))")
    }
    
    // Validate AE, SA phone number
    public func phoneNumberValidateComplete() -> Bool {
        return matches(by: "^5(\\d{8})")
    }
    // Validate AE, SA phone number imcomplete
    public func phoneNumberValidateImcomplete() -> Bool {
        return matches(by: "^5(\\d{0,7})")
    }
    // Validate number input
    public func phoneNumberInputValidate() -> Bool {
        return matches(by: "^\\d{1}$")
    }
    /**
     * validate string by regular expression
     * 根据正则表达式判断字符串是否符合规则
     */
    public func matches(by regularExpression : String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
}

/**
 * MARK: filter string
 * 去除字符串中不合法的字符
 */
public extension String {
    /**
     * fliter non-number
     * 去除非0-9的字符
     */
    public func filterNonNumber() -> String {
        return filter(by: "[^0-9]")
    }
    /**
     * filter by regular expression
     * 过滤掉不符合规则的字符
     */
    public func filter(by regularExpression : String, replaceText : String? = nil) -> String {
        let template = replaceText ?? ""
        let regular = try! NSRegularExpression(pattern: regularExpression,
                                               options: .caseInsensitive)
        let result = NSMutableString(string: self)
        _ = regular.replaceMatches(in: result,
                                   options: .reportProgress,
                                   range: NSMakeRange(0, count),
                                   withTemplate: template)
        return result as String
    }
}

/**
 * MARK: substring accroding to regular expression
 * 截取字符串根据正则表达式
 */
public extension String {
    /**
     * get price from current string
     * 根据正则表达式获取字符串中的价格
     */
    public func getPrice() -> String {
        return substring(by: "[\\d,. ]+")
    }
    /**
     * get substring from current string accroding to regular expression
     * if not found, then return origin string
     * 截取字符串根据正则表达式
     */
    public func substring(by regularExpression : String) -> String {
        let regularExpression = try! NSRegularExpression.init(pattern: regularExpression,
                                                              options: .caseInsensitive)
        let result = regularExpression.matches(in: self,
                                               options: .reportProgress,
                                               range: NSRange(location: 0, length: count))
        if let range = result.first?.range {
            return NSString(string: self).substring(with: range)
        }
        return self
    }
}

/**
 * MARK: timestamp/date convert
 * 时间戳/日期转换
 */
public extension String {
    /**
     * format time
     * 时间戳格式化，默认毫秒单位
     */
    public func formatTimeInterval(format : String? = "MM/dd/YYYY", mills : Bool? = true) -> String? {
        if let millSeconds = TimeInterval(self) {
            var seconds = millSeconds
            if mills ?? true {
                seconds = seconds / 1000.0
            }
            let date = Date(timeIntervalSince1970: seconds)
            let df = DateFormatter()
            df.dateFormat = format ?? "MM/dd/YYYY"
            return df.string(from: date)
        }
        return nil
    }
}
/**
 * MARK: price format
 * 价格格式化
 */
public extension String {
    /**
     * cent convert to float
     * 转换价格显示
     */
    public func accountPointConvert() -> String? {
        if let point = Int(self) {
            let pointDecimal = Decimal(point).dividing(by: 100)
            return "\(pointDecimal)".priceFormat()
        }
        return nil
    }
    /**
     * group number
     * 对整数进行分组显示
     */
    public func groupingSeperator() -> String {
        return priceFormat(groupingSeparator: ",",
                           minimumIntegerDigits: 1,
                           maximumFractionDigits: 0,
                           numberStyle: .decimal) ?? "0"
    }
    /**
     * price format
     * 可自定义分隔符，显示最大/小位数
     */
    public func priceFormat(decimalSeparator : String? = nil,
                            groupingSeparator : String? = nil,
                            minimumIntegerDigits : Int? = nil,
                            maximumFractionDigits : Int? = nil,
                            minimumFractionDigits : Int? = nil,
                            numberStyle : NumberFormatter.Style? = nil) -> String? {
        let number = NSDecimalNumber(string: self)
        let formatter = NumberFormatter()
        formatter.decimalSeparator = decimalSeparator ?? "."
        formatter.groupingSeparator = groupingSeparator ?? ","
        formatter.minimumIntegerDigits = minimumIntegerDigits ?? 1
        formatter.maximumFractionDigits = maximumFractionDigits ?? 2
        formatter.minimumFractionDigits = minimumFractionDigits ?? 2
        formatter.numberStyle = numberStyle ?? .none
        return formatter.string(from: number)
    }
}

/**
 * MARK: Range/NSRange convert
 * oc/swift range转换
 */
public extension String {
    /**
     * swift range convert to oc range
     * swift range转换成OC range
     */
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    /**
     * search string, get swift ranges from this string
     * 搜索字符串，获得swift ranges
     */
    public func ranges(of searchString: String, options mask: NSString.CompareOptions = [], locale: Locale? = nil) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        while let range = range(of: searchString, options: mask, range: (ranges.last?.upperBound ?? startIndex)..<endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
    /**
     * search string, get oc ranges from this string
     * 搜索字符串，获得oc ranges
     */
    public func nsRanges(of searchString: String, options mask: NSString.CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
        let ranges = self.ranges(of: searchString, options: mask, locale: locale)
        return ranges.map { nsRange(from: $0) }
    }
}

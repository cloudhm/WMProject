//
//  Counter.swift
//  Counter
//
//  Created by cloud on 2018/6/25.
//  Copyright © 2018 Yedao Inc. All rights reserved.
//


// Reference : https://github.com/jkpang/PPCounter
import Foundation
import UIKit
public enum CounterAnimation {
    typealias CounterAnimationResult = (progress : CGFloat, currentValue : CGFloat)
    case linear
    case easeInOut
    case easeIn
    case easeOut
    func progressValue(lastTimeInterval : TimeInterval,
                       totalTimeInterval : TimeInterval,
                       originNum : CGFloat,
                       targetNum : CGFloat) -> CounterAnimationResult {
        let timePercent = lastTimeInterval / totalTimeInterval
        var currentValue : CGFloat = 0.0
        var progress : CGFloat = 0.0
        switch self {
        case .linear:
            progress = CGFloat(timePercent)
        case .easeInOut:
            if(timePercent < 0.5) {
                progress = CGFloat(0.5 * pow(2, (20 * timePercent) - 10))
            } else {
                progress = CGFloat(-0.5 * pow(2, (-20 * timePercent) + 10) + 1)
            }
        case .easeIn:
            progress = CGFloat(pow(2, 10 * (timePercent - 1)))
        case .easeOut:
            progress = CGFloat(1 - pow(2, -10 * timePercent))
        }
        currentValue = progress * (targetNum - originNum)
        return (progress, currentValue)
    }
}
public class Counter {
    public typealias CounterCallback = ((CGFloat, CGFloat)->Void)
    var timeInterval : TimeInterval = 1.5
    public var animation : CounterAnimation = .linear
    public var originNum : CGFloat = 0.0
    public var targetNum : CGFloat = 0.0
    private var lastTimeInterval : TimeInterval = 0.0
    private var timer : Timer? {
        didSet {
            oldValue?.invalidate()
        }
    }
    /**
     * result is a block function
     * first arg is UIControl
     * second arg is progress (0.0 ~> 1.0)
     * third arg is current value
     */
    public var counterCallback : CounterCallback?
    public var isRunning : Bool {
        get {
            return timer != nil
        }
    }
    public static func bindView(originNum : CGFloat,
                                targetNum : CGFloat,
                                timeInterval : TimeInterval,
                                animation : CounterAnimation,
                                counterCallback : CounterCallback? = nil) -> Counter {
        verify(timeInterval: timeInterval)
        let counter = Counter()
        counter.originNum = originNum
        counter.targetNum = targetNum
        counter.timeInterval = timeInterval
        counter.lastTimeInterval = 0.0
        counter.animation = animation
        counter.counterCallback = counterCallback
        counter.start()
        return counter
    }
    static func verify(timeInterval : TimeInterval) {
        if timeInterval < 0.5 {
            fatalError("timeInterval is too short, we recommend the value is greater than 1.0s")
        }
    }
    public func pause() {
        timer = nil
    }
    public func resume() {
        lastTimeInterval = 0.0
        start()
    }
    public func stop() {
        lastTimeInterval = 0.0
        timer = nil
    }
    public func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.02,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: false)
    }
    @objc func update(t : Timer) {
        if originNum == targetNum {
            counterCallback?(1.0, targetNum)
            timer = nil
            return
        }
        lastTimeInterval += 0.02
        if lastTimeInterval >= timeInterval {
            counterCallback?(1.0, targetNum)
            timer = nil
        } else {
            let progressValue = animation.progressValue(lastTimeInterval: lastTimeInterval,
                                                        totalTimeInterval: timeInterval,
                                                        originNum: originNum,
                                                        targetNum: targetNum)
            counterCallback?(progressValue.progress, progressValue.currentValue)
            start()
        }
    }
    deinit {
        timer = nil
    }
}

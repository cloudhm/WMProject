//
//  HandySwiftTests.swift
//  WMProjectTests
//
//  Created by cloud on 2019/2/11.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import XCTest
import HandyJSON
class HandySwiftTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        var status = WMNetworkStatus.deserialize(from: ["code": "-1", "message" : NSNull()])
        XCTAssertNotNil(status)
        status = WMNetworkStatus.deserialize(from: ["code": "0", "message" : NSNull()])
        XCTAssertNotNil(status)
        status = WMNetworkStatus.deserialize(from: ["code": NSNull(), "message" : NSNull()])
        XCTAssertNotNil(status)
        status = WMNetworkStatus.deserialize(from: ["message" : NSNull()])
        XCTAssertNotNil(status)
        status = WMNetworkStatus.deserialize(from: ["code": NSNull()])
        XCTAssertNotNil(status)
        let status1 = WMNetworkStatus.deserialize(from: [] as? [String : Any])
        XCTAssertNil(status1)
        let status2 = WMNetworkStatus.deserialize(from: [:])
        XCTAssertNotNil(status2)
    }

}

//
//  JsonableTests.swift
//  JsonableTests
//
//  Created by Drew Pitchford on 3/31/17.
//  Copyright © 2017 Drew Pitchford. All rights reserved.
//

import XCTest
@testable import Jsonable

class JsonableTests: XCTestCase {
    
    private let optionalPropertyString = "optionalProperty"
    private let nonOptionalPropertyString = "nonOptionalProperty"
    private let optionalMockParentNameString = "Test Optional Parent name"
    private let nonOptionalMockParentNameString = "Test Non-optional Parent name"
    private let optionalMockParentAddressString = "Test Optional Parent Address"
    private let nonOptionalMockParentAddressString = "Test Non-optional parent address"

    func testJsonAllParams() {
        
        let optionalParent = MockParent(name: optionalMockParentNameString, address: optionalMockParentAddressString)
        let nonOptionalParent = MockParent(name: nonOptionalMockParentNameString, address: nonOptionalMockParentAddressString)
        
        let user = MockUser(optionalProperty: optionalPropertyString, nonOptionalProperty: nonOptionalPropertyString, optionalParent: optionalParent, nonOptionalParent: nonOptionalParent)
        let userJson = user.json()
        
        // test user
        XCTAssertEqual(userJson["optionalProperty"] as? String, optionalPropertyString)
        XCTAssertEqual(userJson["nonOptionalProperty"] as? String, nonOptionalPropertyString)
        
        // test optional parent
        guard let optionalParentJson = userJson["optionalParent"] as? [String: Any] else {
            
            XCTFail("Failed to get parent json")
            return
        }
        
        XCTAssertEqual(optionalParentJson["name"] as? String, optionalMockParentNameString)
        XCTAssertEqual(optionalParentJson["address"] as? String, optionalMockParentAddressString)
        
        // test non-optional parent
        guard let nonOptionalParentJson = userJson["nonOptionalParent"] as? [String: Any] else {
         
            XCTFail("Failed to get nonOptionalParent")
            return
        }
        
        XCTAssertEqual(nonOptionalParentJson["name"] as? String, nonOptionalMockParentNameString)
        XCTAssertEqual(nonOptionalParentJson["address"] as? String, nonOptionalMockParentAddressString)
        
        print("****All params: \(userJson)****")
    }
    
    func testJsonNils() {
        
        let nonOptionalParent = MockParent(name: nonOptionalMockParentNameString, address: nonOptionalMockParentAddressString)
        
        let user = MockUser(optionalProperty: nil, nonOptionalProperty: nonOptionalPropertyString, optionalParent: nil, nonOptionalParent: nonOptionalParent)
        let userJson = user.json()
        
        XCTAssertNil(userJson["optionalProperty"])
        XCTAssertNotNil(userJson["nonOptionalProperty"])
        XCTAssertNil(userJson["optionalParent"])
        XCTAssertNotNil(userJson["nonOptionalParent"])
        
        print("****Nils: \(userJson)****")
    }
}

class MockUser: Jsonable {
    
    var optionalProperty: String?
    var nonOptionalProperty: String
    var optionalParent: MockParent?
    var nonOptionalParent: MockParent
    
    init(optionalProperty: String?, nonOptionalProperty: String, optionalParent: MockParent?, nonOptionalParent: MockParent) {
        
        self.optionalProperty = optionalProperty
        self.nonOptionalProperty = nonOptionalProperty
        self.optionalParent = optionalParent
        self.nonOptionalParent = nonOptionalParent
    }
}

class MockParent: Jsonable {
    
    var name: String
    var address: String?
    
    init(name: String, address: String?) {
        
        self.name = name
        self.address = address
    }
}

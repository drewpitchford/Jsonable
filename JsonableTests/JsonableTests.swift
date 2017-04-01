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
        XCTAssertEqual(userJson["optional_property"] as? String, optionalPropertyString)
        XCTAssertEqual(userJson["non_optional_property"] as? String, nonOptionalPropertyString)
        
        // test optional parent
        guard let optionalParentJson = userJson["optional_parent"] as? [String: Any] else {
            
            XCTFail("Failed to get parent json")
            return
        }
        
        XCTAssertEqual(optionalParentJson["name"] as? String, optionalMockParentNameString)
        XCTAssertEqual(optionalParentJson["address"] as? String, optionalMockParentAddressString)
        
        // test non-optional parent
        guard let nonOptionalParentJson = userJson["non_optional_parent"] as? [String: Any] else {
         
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
        
        XCTAssertNil(userJson["optional_property"])
        XCTAssertNotNil(userJson["non_optional_property"])
        XCTAssertNil(userJson["optional_parent"])
        XCTAssertNotNil(userJson["non_optional_parent"])
        
        print("****Nils: \(userJson)****")
    }
    
    func testParse() {
        
        struct MockJsonable: Jsonable {
            
            let value = "Jsonable Value"
             
        }
        
        let name: String? = "Optional"
        let value = MockJsonable().parse(value: name) as? String
        XCTAssertEqual(value, "Optional")
        
        let jsonableOptional: MockJsonable? = MockJsonable()
        let jsonableDict = MockJsonable().parse(value: jsonableOptional) as? [String: Any]
        XCTAssertEqual(jsonableDict?["value"] as? String, "Jsonable Value")
    }
    
    func testConvertingCamelCaseToUnderscores() {
        
        struct CamelCase: Jsonable {
        
        }
        
        let camelCase = CamelCase()
        let camelCaseConverted = camelCase.insertUnderscores(into: "aCamelCaseString")
        XCTAssertEqual(camelCaseConverted, "a_camel_case_string")
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

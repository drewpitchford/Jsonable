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

    func testJson() {
        
        let user = MockUser(opt: "Hello", nonOpt: "There")
        
        
        let userJson = user.json()
        
        XCTAssertEqual(userJson["optionalProperty"] as? String, "Hello")
        XCTAssertEqual(userJson["nonOptionalProperty"] as? String, "There")
    }
}

class MockUser: Jsonable {
    
    var optionalProperty: String?
    var nonOptionalProperty: String
    
    init(opt: String, nonOpt: String) {
        
        optionalProperty = opt
        nonOptionalProperty = nonOpt
    }
}

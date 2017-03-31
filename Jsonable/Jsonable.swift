//
//  Jsonable.swift
//  Jsonable
//
//  Created by Drew Pitchford on 3/31/17.
//  Copyright © 2017 Drew Pitchford. All rights reserved.
//

import Foundation

public protocol Jsonable {}

extension Jsonable {
    
    func json() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            
            guard let key = child.label else { continue }
            
            if let value = child.value as? OptionalType {
                
                dict[key] = value.unwrap()
            }
            else {
                
                dict[key] = child.value
            }
        }
        
        return dict
    }
}

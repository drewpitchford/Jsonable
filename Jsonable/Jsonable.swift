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
    
    public func json() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            
            guard let key = child.label else { continue }
            
            if let value = child.value as? Jsonable {
                
                dict[key] = value.json()
            }
            else if let value = child.value as? OptionalType {
                
                if value.containsValue() {
                 
                    dict[key] = parse(value: value)
                }
            }
            else {
                
                dict[key] = child.value
            }
        }
        
        return dict
    }
    
    // MARK: - Helper
    func parse(value: OptionalType) -> Any {
        
        guard let jsonableValue = value.unwrap() as? Jsonable else {
            
            return value.unwrap()
        }
        
        return jsonableValue.json()
    }
}

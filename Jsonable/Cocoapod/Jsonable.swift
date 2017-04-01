//
//  Jsonable.swift
//  Jsonable
//
//  Created by Drew Pitchford on 3/31/17.
//  Copyright © 2017 Drew Pitchford. All rights reserved.
//

import Foundation

/*
 Jsonable converts your objects into a [String: Any] which can be sent to a server.
 Jsonable assumes normal Ruby convention in json key naming. 
 Ex. firstName = "first_name"
*/
public protocol Jsonable {}

extension Jsonable {
    
    /*
        Calling this method will return a [String: Any] using your object's property names as the keys and property values as the values.
    */
    public func json() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            
            guard var key = child.label else { continue }
            key = insertUnderscores(into: key)
            
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
    
    // MARK: - Helpers
    func parse(value: OptionalType) -> Any {
        
        guard let jsonableValue = value.unwrap() as? Jsonable else {
            
            return value.unwrap()
        }
        
        return jsonableValue.json()
    }
    
    func insertUnderscores(into aString: String) -> String {
        
        var newString = ""
        
        for character in aString.characters {
            
            if "A"..."Z" ~= character {
                
                newString.append("_")
            }
            
            newString.append(character)
        }
        
        return newString.lowercased()
    }
}

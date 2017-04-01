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
 
 @property shouldUnderscore - set to true if your json key names need to follow standard Ruby var name syntax. 
                              set to false if your json key names need to be camel cased.
*/
public protocol Jsonable {

    var shouldUnderscore: Bool { get set }
}

extension Jsonable {
    
    /*
        Calling this method will return a [String: Any] using your object's property names as the keys and property values as the values. @property shouldUnderscore will affect the casing of your key names.
    */
    public func json() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            
            guard var key = child.label else { continue }
            
            if shouldUnderscore {
                
                key = insertUnderscores(into: key)
            }
            
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

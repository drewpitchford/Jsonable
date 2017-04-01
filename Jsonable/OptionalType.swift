//
//  OptionalType.swift
//  Jsonable
//
//  Created by Drew Pitchford on 3/31/17.
//  Copyright © 2017 Drew Pitchford. All rights reserved.
//

import Foundation

/*
    OptionalType provides a way to handle optional Any type objects. This allows Jsonable to determine if an optional contains an Any object.
 */
public protocol OptionalType {

    func containsValue() -> Bool
    func unwrap() -> Any
}

extension Optional: OptionalType {
    
    /*
        Returns whether or not the OptionalType contains a value
    */
    public func containsValue() -> Bool {
        
        switch self {
            
        case .none: return false
            
        case .some: return true
            
        }
    }
    
    /*
        Unwraps an OptionalType's optional value
    */
    public func unwrap() -> Any {
        
        switch self {
            
        case .some(let unwrapped):
            return unwrapped
            
        case .none:
            fatalError("Nil unwrap")
        }
    }
}

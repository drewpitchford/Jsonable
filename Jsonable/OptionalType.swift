//
//  OptionalType.swift
//  Jsonable
//
//  Created by Drew Pitchford on 3/31/17.
//  Copyright © 2017 Drew Pitchford. All rights reserved.
//

import Foundation

public protocol OptionalType {
    
    func containsValue() -> Bool
    func unwrap() -> Any
}

extension Optional: OptionalType {
    
    public func containsValue() -> Bool {
        
        switch self {
            
        case .none: return false
            
        case .some: return true
            
        }
    }
    
    public func unwrap() -> Any {
        
        switch self {
            
        case .some(let unwrapped):
            return unwrapped
            
        case .none:
            fatalError("Nil unwrap")
        }
    }
}

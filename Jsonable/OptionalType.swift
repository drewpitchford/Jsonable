//
//  OptionalType.swift
//  Jsonable
//
//  Created by Drew Pitchford on 3/31/17.
//  Copyright © 2017 Drew Pitchford. All rights reserved.
//

import Foundation

public protocol OptionalType {
    
    func isNil() -> Bool
    func unwrap() -> Any
}

extension Optional: OptionalType {
    
    public func isNil() -> Bool {
        
        switch self {
            
        case .none: return true
            
        case .some: return false
            
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

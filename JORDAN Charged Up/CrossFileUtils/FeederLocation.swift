//
//  FeederLocation.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

enum FeedLocation: Int {
    case Nowhere = -1
    case Floor   = 0
    case Portal  = 1
    case Both    = 2
}

extension FeedLocation {
    func JSONValue() -> String {
        switch self {
        case .Nowhere:
             return "Nowhere"
            
        case .Floor:
            return "Floor"
        
        case .Portal:
            return "Portal"
            
        case .Both:
            return "Both"
        
        }
    }
}

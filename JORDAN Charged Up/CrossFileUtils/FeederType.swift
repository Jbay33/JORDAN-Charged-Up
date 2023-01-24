//
//  FeederType.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

enum FeederType: Int {
    case None = -1
    case Cone = 0
    case Cube = 1
    case Both = 2
}

extension FeederType {
    func JSONValue() -> String {
        switch self {
        case .None:
            return "None"
            
        case .Cone:
            return "Cone"
            
        case .Cube:
            return "Cube"
            
        case .Both:
            return "Both"
        }
    }
}

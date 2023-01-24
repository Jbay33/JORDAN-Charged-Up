//
//  GamePiece.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

enum GamePeice {
    case Empty
    case Cone(auto: Bool)
    case Cube(auto: Bool)
}

extension GamePeice {
    func JSONValue() -> String {
        switch self {
        case .Empty:
            return "Empty"
        case .Cone(let auto):
            return auto ? "ConeAuto" : "ConeTeleop"
        case .Cube(let auto):
            return auto ? "CubeAuto" : "CubeTeleop"
        }
    }
}

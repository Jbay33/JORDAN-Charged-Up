//
//  ChargeStationStatus.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

enum ChargeStationStatus: Int {
    case None
    case InCommunity
    case OnUnbalanced
    case OnBalanced
}

extension ChargeStationStatus {
    func JSONValue() -> String {
        switch self {
        case .None:
            return "None"
        case .InCommunity:
            return "InCommunity"
        case .OnUnbalanced:
            return "DockedUnengaged"
        case .OnBalanced:
            return "DockedEngaged"
        }
    }
}

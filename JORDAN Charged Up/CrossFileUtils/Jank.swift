//
//  Jank.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

class Jank: Codable {
    public var teamNumber: Int
    public var scouter: String
    public var scouterId: Int
    public var defensive: Bool
    public var notes: String
    public var gamePieces: [String]
    public var endGameStatus: String
    public var matchNumber: Int
    public var endAutoStatus: String
    public var feedLocation: String
    public var feederType: String
    public var fileVersion: Int
}

extension Jank {
    
    func asDict() throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        guard let dict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            throw NSError()
        }
        return dict
    }
    
    func makeGamePeiceList() -> [GamePeice] {
        var ls: [GamePeice] = [ ]
        for i in self.gamePieces {
            ls.append({
                switch i {
                case "Empty":
                    return .Empty
                    
                case "CubeTeleop":
                    return .Cube(auto: false)
                    
                case "CubeAuto":
                    return .Cube(auto: true)
                    
                case "ConeTeleop":
                    return .Cone(auto: false)
                    
                case "ConeAuto":
                    return .Cone(auto: true)
                    
                default:
                    print(i)
                    return GamePeice.Empty
                }
            }())
        }
        return ls
    }
    func getFeedLocation() -> FeedLocation {
        switch self.feedLocation {
        case "Nowhere":
            return .Nowhere
        case "Floor":
            return .Floor
        case "Portal":
            return .Portal
        case "Both":
            return .Both
        default:
            print(self.feedLocation)
            return .Nowhere
        }
    }
    func getFeederType() -> FeederType {
        switch self.feederType {
        case "None":
            return .None
        case "Cone":
            return .Cone
        case "Cube":
            return .Cube
        case "Both":
            return .Both
        default:
            print(self.feederType)
            return .None
        }
    }
    func getChargeStationStatus(auto: Bool) -> ChargeStationStatus {
        switch (auto) ? self.endAutoStatus : self.endGameStatus {
        case "None":
            return .None
        case "InCommunity":
            return .InCommunity
        case "DockedUnengaged":
            return .OnUnbalanced
        case "DockedEngaged":
            return .OnBalanced
        default:
            print((auto) ? self.endAutoStatus : self.endGameStatus)
            return .None
        }
    }
    
}

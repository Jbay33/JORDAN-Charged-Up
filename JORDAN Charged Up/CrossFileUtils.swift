//
//  CrossFileUtils.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/17/23.
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

class Flow {
    public static var waterfall = false
}

class GameData {
    public static var teamId: UInt = 0
    
    public static var playingDefense: Bool = false
    
    public static var notes: String = ""
    
    public static var feeder: FeederType = .Cone
    
    public static var feedLocation: FeedLocation = .Floor
    
    public static var endgameStatus: ChargeStationStatus = .None
    
    public static var endAutoStatus: ChargeStationStatus = .None
    
    public static var gamePeices: [GamePeice] = [
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty,
        .Empty, .Empty, .Empty
    ]
    
    static func finalize() {
        let finString = Self.ToJSON()
        
        GameDataArchive.updateList(newItem: finString)
        
        Self.clear()
    }
    
    static func clear() {
        Self.teamId = 0
        Self.playingDefense = false
        Self.notes = ""
        Self.endgameStatus = .None
        Self.endAutoStatus = .None
        Self.gamePeices = [
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty,
            .Empty, .Empty, .Empty
        ]
        Self.feeder = .Cone
        Self.feedLocation = .Floor
    }
    
    //kinda disgusting but oh well
    static func ToJSON() -> String {
        return """
        {
            "teamId": \(GameData.teamId),
            "defensive": \(GameData.playingDefense),
            "notes": "\(GameData.notes)",
            "gamePeices":
        [\({
            var finalString = ""
            
            for i in 0..<GameData.gamePeices.count {
                if i + 1 == GameData.gamePeices.count {
                    finalString += "\"\(GameData.gamePeices[i].JSONValue())\" "
                } else {
                    finalString += "\"\(GameData.gamePeices[i].JSONValue())\", "
                }
            }
        
            return finalString
        }())],
            "endgameStatus": "\(GameData.endgameStatus.JSONValue())",
            "endAutoStatus": "\(GameData.endAutoStatus.JSONValue())",
            "feedLocation": "\(Self.feedLocation.JSONValue())",
            "feederType": "\(Self.feeder.JSONValue())",
            "fileVersion": 1
        }
        """
    }
}


class GameDataArchive {
    public static var gameList: [String] = [ ]

    //TODO: more userdefaults aaaAAAaaaAAA
    static func clearArchive() {
        
        gameList = [ ]
    }
    
    //TODO: make it work with userdefaults AAAAaaaAAAAAAAaaaa
    static func updateList(newItem: String) {
        Self.gameList.append(newItem)
    }
    
    //TODO: parse json back into data i dont feel like doing right now aaaaaa
    static func loadItem(index: Int) {
        //first cast: [String; Any], second cast: [String; [String]] (for game piece list)
    }
    
    //TODO: upload code and i find http library aaaaaa
    static func uploadItems() {
        for i in Self.gameList {
            print(i)
        }
    }
}

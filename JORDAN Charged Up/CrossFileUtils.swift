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

class GameData {
    public static var teamId: UInt = 0
    
    public static var playingDefense: Bool = false
    
    public static var notes: String = ""
    
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
            
            for i in GameData.gamePeices {
                if i.JSONValue() != GameData.gamePeices.last!.JSONValue() {
                    finalString += "\"\(i.JSONValue()), \""
                } else {
                    finalString += "\"\(i.JSONValue()) \""
                }
            }
        
            return finalString
        }())],
            "endgameStatus": "\(GameData.endgameStatus.JSONValue())",
            "endAutoStatus": "\(GameData.endAutoStatus.JSONValue())"
        }
        """
    }
}


class GameDataArchive {
    public static var gameList: [String] = [ ]
    
    static func loadList() {
        
    }
    
    static func updateList(newItem: String) {
        Self.gameList.append(newItem)
    }
    
    //TODO: parse code i dont feel like doing right now aaaaaa
    static func loadItem(index: Int) {
        if index <= GameDataArchive.gameList.count {
            
        }
    }
    
    //TODO: upload code and i find http library aaaaaa
    static func uploadItems() {
        for i in Self.gameList {
            print(i)
        }
    }
}

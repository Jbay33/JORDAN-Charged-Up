//
//  GameData.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

class GameData {
    public static var teamId: UInt = 0
    
    public static var matchNumber: UInt = 0
    
    public static var scouter: String = "YOUR NAME"
    
    public static var playingDefense: Bool = false
    
    public static var notes: String = ""
    
    public static var feeder: FeederType = .Cone
    
    public static var feedLocation: FeedLocation = .Floor
    
    public static var endGameStatus: ChargeStationStatus = .None
    
    public static var endAutoStatus: ChargeStationStatus = .None
    
    public static var gamePieces: [GamePeice] = [
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
        //doesnt change scouter by default
        Self.teamId = 0
        Self.playingDefense = false
        Self.notes = ""
        Self.matchNumber += 1
        Self.endGameStatus = .None
        Self.endAutoStatus = .None
        Self.gamePieces = [
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
            "teamNumber": \(GameData.teamId),
            "defensive": \(GameData.playingDefense),
            "notes": "\(GameData.notes)",
            "scouter": "\(Self.scouter)",
            "matchNumber": \(Self.matchNumber),
            "gamePieces":
        [\({
            var finalString = ""
            
            for i in 0..<GameData.gamePieces.count {
                if i + 1 == GameData.gamePieces.count {
                    finalString += "\"\(GameData.gamePieces[i].JSONValue())\" "
                } else {
                    finalString += "\"\(GameData.gamePieces[i].JSONValue())\", "
                }
            }
        
        print(finalString)
        
            return finalString
        }())],
            "endGameStatus": "\(GameData.endGameStatus.JSONValue())",
            "endAutoStatus": "\(GameData.endAutoStatus.JSONValue())",
            "feedLocation": "\(Self.feedLocation.JSONValue())",
            "feederType": "\(Self.feeder.JSONValue())",
            "scouterId": 0,
            "fileVersion": 1
        }
        """
    }
}

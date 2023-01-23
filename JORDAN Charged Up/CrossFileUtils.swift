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

class MatchCompressed: Hashable, Identifiable {
    static func == (lhs: MatchCompressed, rhs: MatchCompressed) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
    }
    
    let id = UUID()
    
    var a: Int
    var b: Int
    
    init(val: (Int, Int) ) {
        a = val.0
        b = val.1
    }
}

class Jank: Codable {
    public var teamId: Int
    public var defensive: Bool
    public var notes: String
    public var gamePeices: [String]
    public var endgameStatus: String
    public var endAutoStatus: String
    public var feedLocation: String
    public var feederType: String
    public var fileVersion: Int
}

extension Jank {
    func makeGamePeiceList() -> [GamePeice] {
        var ls: [GamePeice] = [ ]
        for i in self.gamePeices {
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
        switch (auto) ? self.endAutoStatus : self.endgameStatus {
        case "None":
            return .None
        case "InCommunity":
            return .InCommunity
        case "DockedUnengaged":
            return .OnUnbalanced
        case "DockedEngaged":
            return .OnBalanced
        default:
            print((auto) ? self.endAutoStatus : self.endgameStatus)
            return .None
        }
    }
    
}

class GameDataArchive {
    public static var gameList: [String] = [ ]
    
    static func clearArchive() {
        gameList = [ ]
        deleteUserDefaults()
    }
    
    static func getListOfMatches() -> [MatchCompressed] {
        var list: [MatchCompressed] = [ ]
        
        for i in 0..<Self.gameList.count {
            do {
                let decoder = JSONDecoder()
                
                let dat = try decoder.decode(Jank.self, from: Data(Self.gameList[i].utf8))
                
                list += [ MatchCompressed( val: ( i, dat.teamId ) ) ]
                
            } catch {
                print(error)
                return [ MatchCompressed(val: (-1, -1) ) ]
            }
        }
        
        return list.isEmpty ? [ MatchCompressed(val: (-2, -2) )] : list
    }
    
    static func deleteUserDefaults() {
        let uds = UserDefaults.standard
        uds.removeObject(forKey: "JordanSave")
    }
    
    static func updateUserDefaults() {
        let uds = UserDefaults.standard
        let dat = Self.gameList
        
        uds.set(dat, forKey: "JordanSave")
    }
    
    static func loadUserDefaults() {
        let uds = UserDefaults.standard
        
        if let dat = uds.stringArray(forKey: "JordanSave") {
            Self.gameList = dat
        } else {
            Self.gameList = [ ]
        }
    }
    
    static func updateList(newItem: String) {
        Self.gameList.append(newItem)
        updateUserDefaults()
    }
    
    static func loadItem(index: Int) {
        if index >= Self.gameList.count {
            print(index)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            
            let dat = try decoder.decode(Jank.self, from: Data(Self.gameList[index].utf8))
            
            GameData.clear()
            
            GameData.teamId = UInt(dat.teamId)
            GameData.notes = dat.notes
            GameData.playingDefense = dat.defensive
            GameData.gamePeices = dat.makeGamePeiceList()
            GameData.feedLocation = dat.getFeedLocation()
            GameData.endgameStatus = dat.getChargeStationStatus(auto: false)
            GameData.endAutoStatus = dat.getChargeStationStatus(auto: true)
            GameData.feeder = dat.getFeederType()
            
            Self.gameList.remove(at: index)
            
        } catch {
            print(error)
        }
        updateUserDefaults()
    }
    
    static func deleteAt(index: Int) {
        Self.gameList.remove(at: index)
        updateUserDefaults()
    }
    
    
    //TODO: upload code and i find http library aaaaaa
    static func uploadItems() {
        for i in Self.gameList {
            print(i)
        }
    }
}

//
//  CrossFileUtils.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/17/23.
//

import Foundation
import Alamofire

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
    
    public static var matchNumber: UInt = 0
    
    public static var scouter: String = ""
    
    public static var playingDefense: Bool = false
    
    public static var notes: String = ""
    
    public static var feeder: FeederType = .Cone
    
    public static var feedLocation: FeedLocation = .Floor
    
    public static var endGameStatus: ChargeStationStatus = .None
    
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
        //doesnt change scouter by default
        Self.teamId = 0
        Self.playingDefense = false
        Self.notes = ""
        Self.matchNumber = 0
        Self.endGameStatus = .None
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
            "scouter": "\(Self.scouter)",
            "matchId": \(Self.matchNumber),
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
    public var scouter: String
    public var scouterId: Int
    public var defensive: Bool
    public var notes: String
    public var gamePeices: [String]
    public var endGameStatus: String
    public var matchId: Int
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

class GameDataArchive {
    public static var gameList: [String] = [ ]
    private static let dataZone = "https://robotics-scouting-charged-up-production.up.railway.app"
    
    private static var savedScouterId = 0
    private static var isValidated = false
    
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
    
    static func verifyScouter(scouter: String) -> Int {
        enum RequestStatus {
            case Unkown
            case Good(id: Int)
            case Bad(err: String)
            case New(id: Int)
        }
        
        class TempScouter: Codable {
            var name: String = ""
            var id: Int = 0
        }
        
        class TempResult: Codable {
            var statusCode: Int = 0
            var error: String = ""
            var message: String = ""
        }
        
        var temp = TempScouter()
        temp.name = scouter
        
        var status = RequestStatus.Unkown
        let decoder = JSONDecoder()
        
        var isFininished = false
        
        //initial run-through
        let afr1 = AF.request("\(dataZone)/scouters/get-all", method: .get).response { res in
            print("entered closure")
            switch res.result {
            case .success(let dat):
                print("success case")
                if let parsed = try? decoder.decode([TempScouter].self, from: dat!) {
                    print("parsed correctly")
                    for i in parsed {
                        if i.name == scouter {
                            status = .Good(id: i.id)
                            isFininished = true
                            return
                        }
                    }
                    print("out of loop, assigning .New(id: 0)")
                    status = .New(id: 0)
                } else {
                    print("failed parse")
                    if let parsed = try? decoder.decode(TempResult.self, from: dat!) {
                        print("got janky result")
                        status = .Bad(err: "Server returned error code: \(parsed.statusCode): \(parsed.error), \(parsed.message)")
                    } else {
                        print("it borke")
                        status = .Bad(err: "Couldn't Decode JSON. Data: \(String(data: dat!, encoding: .utf8) ?? "failure")")
                    }
                    print("done secondary if/else")
                }
                print("done primary if/else")
                isFininished = true
                return
                
            case .failure(let err):
                print("failure")
                status = .Bad(err: "AFError: \(err)")
                isFininished = true
                return
            }
        }
        
        Thread.sleep(forTimeInterval: .init(floatLiteral: 5.0))
        
        switch status {
        case .Unkown:
            print("something really broke down if you're seeing this.")
            return -1
            
        case .Good(id: let id):
            return id
            
        case .Bad(err: let err):
            print(err)
            return -1
            
        case .New(_):
            break
        }
        
        AF.request("\(dataZone)/scouters/add", method: .post, parameters: temp).response { res in
            switch res.result {
            case .success(let dat):
                if let _ = try? decoder.decode([TempScouter].self, from: dat!) {
                    return
                } else {
                    if let parsed = try? decoder.decode(TempResult.self, from: dat!) {
                        status = .Bad(err: "Server returned error code: \(parsed.statusCode): \(parsed.error), \(parsed.message)")
                    } else {
                        status = .Bad(err: "Couldn't Decode JSON. Data: \(String(data: dat!, encoding: .utf8) ?? "failure")")
                    }
                }
                return
                
            case .failure(let err):
                status = .Bad(err: "AFError: \(err)")
                return
            }
        }
        
        switch status {
        case .Unkown:
            print("something really, REALLY broke down if you're seeing this.")
            return -1
            
        case .Good(_):
            print("this isnt even possible, how!?")
            return -1
            
        case .Bad(let err):
            print(err)
            return -1
            
        case .New(_):
            break
        }
        
        // i mean, its not that bad, is it?
        return verifyScouter(scouter: scouter)
    }
    
    static func handleResponse(_ res: AFDataResponse<Data?>, success: (Data) -> Void, failure: (AFError) -> Void) {
        switch res.result {
        case .success(let dat):
            success(dat!)
            break
        case .failure(let err):
            failure(err)
            break
        }
    }
    
    static func uploadItem(index: Int) {
        let decoder = JSONDecoder()
        
        var dat = try! decoder.decode(Jank.self, from: Data(Self.gameList[index].utf8))
        
        //send request that sees if scouter exists
        //yes: continue
        //no:  send add request, get id
        //send request to add match
        //finish
        
        //MARK: It begins
        
        class TempScouter: Codable {
            var name: String = ""
            var id: Int = 0
        }
        
        class TempResult: Codable {
            var statusCode: Int = 0
            var error: String = ""
            var message: String = ""
        }
        
        func handleErr(_ err: AFError) {
            print(err)
        }
        
        func scouterExists(_ data: Data) {
            if let parsed = try? decoder.decode([TempScouter].self, from: data) {
                for i in parsed {
                    if i.name == dat.scouter {
                        //continue
                        dat.scouterId = i.id
                        Self.savedScouterId = i.id
                        Self.isValidated = true
                        AF.request("\(dataZone)/matches/add", method: .post, parameters: dat, encoder: JSONParameterEncoder.default).response { res in
                            handleResponse(res, success: { data in
                                print("might've worked????")
                                //holy
                                GameDataArchive.gameList.remove(at: index)
                            }, failure: handleErr)

                        }
                    }
                }
                //make new
                var temp = TempScouter()
                temp.name = dat.scouter
                AF.request("\(dataZone)/scouters/add", method: .post, parameters: temp, encoder: JSONParameterEncoder.default).response { res in
                    handleResponse(res, success: scouterExists, failure: handleErr)
                }
            } else {
                if let parsed = try? decoder.decode(TempResult.self, from: data) {
                    print("Server returned error code: \(parsed.statusCode): \(parsed.error), \(parsed.message)")
                } else {
                    print("Couldn't Decode JSON. Data: \(String(data: data, encoding: .utf8) ?? "failure")")
                }
                print("done secondary if/else")
            }
        }
        
        AF.request("\(dataZone)/scouters/get-all").response { res in
            handleResponse(res, success: scouterExists, failure: handleErr)
        }
        
        //MARK: Its over
        
//        AF.request("\(dataZone)/matches/add", method: .post, parameters: dat, encoder: JSONParameterEncoder.default).response { res in
//            debugPrint(res)
//        }
        
        Self.updateUserDefaults()
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
            GameData.matchNumber = UInt(dat.matchId)
            GameData.scouter = dat.scouter
            GameData.notes = dat.notes
            GameData.playingDefense = dat.defensive
            GameData.gamePeices = dat.makeGamePeiceList()
            GameData.feedLocation = dat.getFeedLocation()
            GameData.endGameStatus = dat.getChargeStationStatus(auto: false)
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

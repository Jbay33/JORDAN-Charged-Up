//
//  GameDataArchive.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation
import Alamofire

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
                
                list += [ MatchCompressed( val: ( i, dat.teamNumber, dat.matchNumber ) ) ]
                
            } catch {
                print(error)
                return [ MatchCompressed(val: (-1, -1, -1) ) ]
            }
        }
        
        return list.isEmpty ? [ MatchCompressed(val: (-2, -2, -2) )] : list
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
        
        print(dat.gamePieces)
        
        //send request that sees if scouter exists
        //yes: continue
        //no:  send add request, get id
        //send request to add match
        //finish
        
        //MARK: It begins
        
        class TempScouter: Codable {
            var id: Int = 0
            var name: String = ""
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
                                updateUserDefaults()
                            }, failure: handleErr)

                        }
                        return
                    }
                }
                //make new
                let temp = TempScouter()
                temp.name = dat.scouter
                
                AF.request("\(dataZone)/scouters/add", method: .post, parameters: temp, encoder: JSONParameterEncoder.default).response { res in
                    handleResponse(res, success: { _ in
                        AF.request("\(dataZone)/scouters/get-all").response { res in
                            handleResponse(res, success: scouterExists, failure: handleErr)
                        }
                    }, failure: handleErr)
                }
                
            } else {
                if let parsed = try? decoder.decode(TempResult.self, from: data) {
                    print("Server returned error code: \(parsed.statusCode): \(parsed.error), \(parsed.message)")
                } else {
                    print("Couldn't Decode JSON. Data: \(String(data: data, encoding: .utf8) ?? "failure")")
                }
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
            
            GameData.teamId = UInt(dat.teamNumber)
            GameData.matchNumber = UInt(dat.matchNumber)
            GameData.scouter = dat.scouter
            GameData.notes = dat.notes
            GameData.playingDefense = dat.defensive
            GameData.gamePieces = dat.makeGamePeiceList()
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


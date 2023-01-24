//
//  ContentView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit
import Alamofire

struct ContentView: View {
    @State var teamName = ""
    @State var matchNum = ""
    @State var chargeStationAuto = 0
    @State var scouterName = ""
    @State var savedIcon = "tray.fill"
    let specBlue = CGColor.init(red: 18, green:19, blue:31, alpha:1)
    var body: some View {
        
        NavigationStack {
            
            ZStack{
                Color.init(specBlue).ignoresSafeArea(.all)
                VStack {
                    Text("Beginning of Match")
                    HStack{
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            Text("Team Number")
                                .padding()
                            
                            Spacer()

                            TextField("Team #", text: $teamName)
                                .keyboardType(.numbersAndPunctuation)
                                .textFieldStyle(.roundedBorder)
                                .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.interactively)
                                .frame(width: 100)
                                .onSubmit {
                                    handleNumber()
                                }.onChange(of: teamName) { newValue in
                                    handleNumber()
                                }
                            
                            Spacer()
                        }.frame(height: 100.0)
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            Text("Match Number")
                                .padding()
                            
                            Spacer()

                            TextField("Match #", text: $matchNum)
                                .keyboardType( .numbersAndPunctuation)
                                .textFieldStyle(.roundedBorder)
                                .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.interactively)
                                .frame(width: 100)
                                .onSubmit {
                                    handleMatch()
                                }.onChange(of: matchNum) { newValue in
                                    handleMatch()
                                }
                            
                            Spacer()
                        }.frame(height: 100.0)
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            Text("Scouter Name")
                                .padding()
                            
                            Spacer()
                            
                            TextField("Scouter", text: $scouterName)
                                .keyboardType( .numbersAndPunctuation)
                                .textFieldStyle(.roundedBorder)
                                .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.interactively)
                                .frame(width: 100)
                                .onSubmit {
                                    handleScouter()
                                }.onChange(of: scouterName) { newValue in
                                    handleScouter()
                                }
                            
                            Spacer()
                        }.frame(height: 100.0)
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            Text("Charge Station")
                                .padding()
                            
                            Spacer()
                            
                            Picker("Charge Station", selection: $chargeStationAuto) {
                                Text("Not on").tag(0)
                                Text("In community").tag(1)
                                Text("On but not Balanced").tag(2)
                                Text("On and Balanced").tag(3)
                            }
                            .onChange(of: chargeStationAuto) { newValue in
                                handleStation()
                            }
                            Spacer()
                        }.frame(height: 100.0)
                        
                        Spacer()
                    }.padding()
                    
                    NavigationLink(destination: AutoView()) {
                        Text("Start - Autonomous")
                    }.buttonStyle(.borderedProminent)
                        .padding()
                }
            }
            .onAppear {
                if Flow.waterfall {
                    Flow.waterfall = false
                    teamName = ""
                    chargeStationAuto = 0
                }
                
                if GameDataArchive.gameList.count > 0 {
                    savedIcon = "tray.full.fill"
                } else {
                    savedIcon = "tray.fill"
                }
                
                teamName = GameData.teamId == 0 ? "" : String(GameData.teamId)
                chargeStationAuto = GameData.endAutoStatus.rawValue
                matchNum = String(GameData.matchNumber)
                scouterName = GameData.scouter
            }.toolbar {
                NavigationLink(destination: SavedView()) {
                    HStack {
                        Text("Saved Data")
                        
                        if #available(iOS 16.0, *) {
                            Image(systemName: savedIcon).fontWeight(.semibold)
                        } else {
                            Image(systemName: "tray.fill")
                        }
                    }
                }
            }
        }
        .onAppear {
            GameDataArchive.loadUserDefaults()
        }
    }
    
    func handleScouter() {
        GameData.scouter = scouterName
    }
    
    func handleNumber() {
        if let teamNum = UInt(teamName.trimmingCharacters(in: .whitespacesAndNewlines)) {
            GameData.teamId = teamNum
        } else {
            teamName = ""
        }
    }
    
    func handleMatch() {
        if let match = UInt(matchNum.trimmingCharacters(in: .whitespacesAndNewlines)) {
            GameData.matchNumber = match
        } else {
            matchNum = ""
        }
    }
    
    func handleStation() {
        GameData.endAutoStatus = ChargeStationStatus(rawValue:  chargeStationAuto)!
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

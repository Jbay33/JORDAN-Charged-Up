//
//  MidGame.swift
//  JORDAN Charged Up
//
//  Created by  on 1/17/23.
//

import SwiftUI

struct MidGame: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var chargeStationTele = 0
    @State var groundPick = 0
    @State var gamePiece = 0
    @State var defense = false
    let specBlue = Color("specBlue")
    var body: some View {
        NavigationStack {
            ZStack{
                specBlue.ignoresSafeArea(.all)
                VStack {
                    Text("Mid Game")
                        .bold()
                        .padding()
                        .foregroundColor(Color("goofballPink"))
                        .monospaced()
                        .font(.title)
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text("Charge Station")
                                .foregroundColor(Color("gooberGray"))
                                .padding(Edge.Set.top, 25.0)
                            
                            Spacer()
                            
                            Picker("Charge Station", selection: $chargeStationTele) {
                                Text("Not on").tag(0)
                                Text("In community").tag(1)
                                Text("On but not Balanced").tag(2)
                                Text("On and Balanced").tag(3)
                            }.tint(Color.white).padding(Edge.Set.bottom, 25).onChange(of: chargeStationTele) { num in
                                GameData.endGameStatus = ChargeStationStatus(rawValue: chargeStationTele)!
                            }
                        }.padding()
                        
                        Spacer()
                        
                        VStack{
                            Text("Where can it feed from?")
                                .foregroundColor(Color("gooberGray"))
                                .padding(Edge.Set.top, 25.0)
                            
                            Spacer()
                            
                            Picker("Where can it feed", selection: $groundPick) {
                                Text("Nowhere").tag(-1)
                                Text("Ground").tag(0)
                                Text("Feeder").tag(1)
                                Text("Both").tag(2)
                            }.tint(Color.white).padding(Edge.Set.bottom, 25.0).onChange(of: groundPick) { num in
                                GameData.feedLocation = FeedLocation(rawValue: groundPick)!
                            }
                        }.padding()
                        
                        Spacer()
                        
                        VStack{
                            Text("What can it pick up?")
                                .foregroundColor(Color("gooberGray"))
                                .padding(Edge.Set.top, 25.0)
                            
                            Spacer()
                            
                            Picker("What it pick", selection: $gamePiece) {
                                Text("Nothing").tag(-1)
                                Text("Cone").tag(0)
                                Text("Square").tag(1)
                                Text("Both").tag(2)
                            }.tint(Color.white).padding(Edge.Set.bottom, 25.0)
                                .onChange(of: gamePiece) { num in
                                    GameData.feeder = FeederType(rawValue: gamePiece)!
                                }
                        }.padding()
                        
                        Spacer()
                        
                        VStack {
                            Text("Playing Defense?")
                                .foregroundColor(Color("gooberGray"))
                                .padding(Edge.Set.top, 25.0)
                            
                            Spacer()
                            
                            Toggle("", isOn: $defense).frame(width: 50.0)
                                .padding(Edge.Set.bottom, 25)
                                .onChange(of: defense) { val in
                                    GameData.playingDefense = defense
                                }
                        }.padding()
                        
                        Spacer()
                    }.frame(height: 175)
                }.foregroundColor(.white)
                    .onAppear {
                        if Flow.waterfall {
                            chargeStationTele = 0
                            groundPick = 0
                            gamePiece = 0
                            defense = false
                            dismiss()
                        } else {
                            chargeStationTele = GameData.endGameStatus.rawValue
                            groundPick = GameData.feedLocation.rawValue
                            gamePiece = GameData.feeder.rawValue
                            defense = GameData.playingDefense
                        }
                    }
            }.foregroundColor(.white)
            .toolbar {
                NavigationLink(destination: TeleView()) {
                    HStack {
                        Text("Tele-Op")
                        if #available(iOS 16.0, *) {
                            Image(systemName: "chevron.right").fontWeight(.semibold)
                        } else {
                            Image(systemName: "chevron.right")
                        }
                    }
                }.foregroundColor(Color.white)
            }
        }
    }
}

struct MidGame_Previews: PreviewProvider {
    static var previews: some View {
        MidGame()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

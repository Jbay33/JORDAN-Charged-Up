//
//  MidGame.swift
//  JORDAN Charged Up
//
//  Created by  on 1/17/23.
//

import SwiftUI

struct MidGame: View {
    @State var chargeStationTele = 0
    @State var groundPick = 0
    @State var gamePiece = 0
    @State var defense = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("Charge Station")
                        Picker("Charge Station", selection: $chargeStationTele) {
                            Text("Not on").tag(0)
                            Text("In community").tag(1)
                            Text("On but not Balanced").tag(2)
                            Text("On and Balanced").tag(3)
                        }
                    }.padding()
                    VStack{
                        Text("Where can it feed from?")
                        Picker("Where can it feed", selection: $groundPick) {
                            Text("Nowhere").tag(-1)
                            Text("Ground").tag(0)
                            Text("Feeder").tag(1)
                            Text("Both").tag(2)
                        }
                    }.padding()
                    VStack{
                        Text("What can it pick up?")
                        Picker("What it pick", selection: $gamePiece) {
                            Text("Nothing").tag(-1)
                            Text("Cone").tag(0)
                            Text("Square").tag(1)
                            Text("Both").tag(2)
                        }
                    }.padding()
                    Toggle("Defense", isOn: $defense)
                }
//                NavigationLink(destination: TeleView()) {
//                    Text("Teleop")
//                }.buttonStyle(.borderedProminent).padding()
            }
        } .toolbar {
            NavigationLink(destination: TeleView()) {
                HStack {
                    Text("Tele-Op")
                    if #available(iOS 16.0, *) {
                        Image(systemName: "chevron.right").fontWeight(.semibold)
                    } else {
                        Image(systemName: "chevron.right")
                    }
                }
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

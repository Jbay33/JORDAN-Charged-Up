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
        Text("Tele-OP")
            .padding()
        HStack{
            VStack{
                Text("Charge Station")
                Picker("Charge Station", selection: $chargeStationTele) {
                    Text("Not On").tag(0)
                    Text("On but not Balanced").tag(1)
                    Text("On and Balanced").tag(2)
                }
            }.padding()
            VStack{
                Text("Where can it feed from?")
                Picker("Where can it feed", selection: $groundPick) {
                    Text("Ground").tag(0)
                    Text("Feeder").tag(1)
                    Text("Both").tag(2)
                }
            }.padding()
            VStack{
                Text("What can it pick up?")
                Picker("What it pick", selection: $gamePiece) {
                    Text("Cone").tag(0)
                    Text("Square").tag(1)
                    Text("Both").tag(2)
                }
            }.padding()
            Toggle("Defense", isOn: $defense)
        }
            NavigationLink(destination: TeleView()){
                Text("Tele-OP")
            }
    }
}

struct MidGame_Previews: PreviewProvider {
    static var previews: some View {
        MidGame()
    }
}

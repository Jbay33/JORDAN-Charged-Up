//
//  ContentView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var teamName = ""
    @State var chargeStationAuto = 0
    let specBlue = Color(red: 18, green:19, blue:31)
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    Text("Begining of Match")
                        .padding()
                    TextField("Team: ", text: $teamName)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    Text("Charge Station")
                    Picker("Charge Station", selection: $chargeStationAuto) {
                        Text("Not On").tag(0)
                        Text("On but not Balanced").tag(1)
                        Text("On and Balanced").tag(2)
                    }
                    NavigationLink(destination: AutoView()) {
                        Text("Autonomous")
                    }
                }
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

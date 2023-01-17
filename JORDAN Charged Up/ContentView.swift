//
//  ContentView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
            NavigationView {
                VStack{
                    Text("PLez for chez")
                    NavigationLink(destination: AutoView()) {
                        Text("Autonomous")
                    }
                }
            }
            .navigationTitle("Autonomous")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

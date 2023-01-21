//
//  Mommylo.swift
//  JORDAN Charged Up
//
//  Created by  on 1/17/23.
//

import SwiftUI

struct Mommylo: View {
    //@available(iOS 16, *) typealias NavigationView = NavigationStack
    
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack{
                Text("End of Game")
                    .padding()
                HStack {
                    Button("Submit Data") {
                        showingAlert = true
                    }.padding().buttonStyle(.bordered)
                    
                    Button("Save for Later") {
                        //TODO: replace .finalize() & .toJSON()
                        print(GameData.ToJSON())
                        GameData.finalize()
                        
                        
                        Flow.waterfall = true
                        dismiss()
                    }.padding().buttonStyle(.borderedProminent)
                }
            }.alert("Are you sure?", isPresented: $showingAlert) {
                Button("Yes") {
                    //John  Submit
                    
                    //TODO: replace .clear() & .toJSON()
                    print(GameData.ToJSON())
                    GameData.clear()
                    
                    
                    Flow.waterfall = true
                    dismiss()
                }
                
                Button("No", role: .cancel) { }
            }
        }
    }
}


struct Mommylo_Previews: PreviewProvider {
    static var previews: some View {
        Mommylo()
    }
}

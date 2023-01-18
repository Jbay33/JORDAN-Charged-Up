//
//  Mommylo.swift
//  JORDAN Charged Up
//
//  Created by  on 1/17/23.
//

import SwiftUI

struct Mommylo: View {
    @State private var showingAlert = false

    var body: some View {
        VStack{
            Text("End of Game")
                .padding()
            Button("Submit Data") {
                showingAlert = true
            }.alert("Are you sure?", isPresented: $showingAlert) {
                Button("Yes") {
                    //John  Submit
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

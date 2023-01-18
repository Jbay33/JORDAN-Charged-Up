//
//  TeleView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/12/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct TeleView: View {
    var body: some View {
        NavigationView{
        SpriteView(scene: TeleLayout())
        }.toolbar {
            NavigationLink(destination: Mommylo()) {
                Image(systemName: "arrow.right")
            }
        }
    }
}

struct TeleView_Previews: PreviewProvider {
    static var previews: some View {
        TeleView()
    }
}

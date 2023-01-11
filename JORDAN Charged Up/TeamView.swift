//
//  TeamView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit

struct TeamView: View {
    var body: some View {
        NavigationView {
            VStack {
                SpriteView(scene: FieldLayout())
            }
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}

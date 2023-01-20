//
//  TeamView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit

struct AutoView: View {

    @State var scene: SKScene = {
        let scene = FieldLayout(fileNamed: "FieldLayout")!
        scene.isAuto = true
        scene.size = CGSize(width: 1334, height: 750)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        return scene
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                SpriteView(scene: scene)
                    .foregroundColor(.white)
                    .zIndex(-1)
            }
        }.toolbar{
            NavigationLink(destination: MidGame()) {
                HStack {
                    Text("Mid Game")
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

struct AutoView_Previews: PreviewProvider {
    static var previews: some View {
        AutoView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

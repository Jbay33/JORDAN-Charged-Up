//
//  TeamView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit

struct AutoView: View {

    var scene: SKScene {
        let scene = FieldLayout(fileNamed: "FieldLayout")!
        scene.size = CGSize(width: 1334, height: 750)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        return scene
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SpriteView(scene: scene)
                    .foregroundColor(.white)
                    .zIndex(-1)
            }
        }.toolbar{
            NavigationLink(destination: MidGame()) {
                Image(systemName: "arrow.right")
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

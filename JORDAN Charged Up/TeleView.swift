//
//  TeleView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/12/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct TeleView: View {
    var scene: SKScene {
        let scene = FieldLayout(fileNamed: "FieldLayout")!
        scene.size = CGSize(width: 1334, height: 750)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        return scene
    }
    
    var body: some View {
        NavigationView{
            SpriteView(scene: scene)
                .foregroundColor(.white)
                .zIndex(-1)
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
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

//
//  TeamView.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//

import SwiftUI
import SpriteKit

struct AutoView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var cScheme
    let specBlue = Color("specBlue")
    @State var scene: SKScene = {
        let scene = FieldLayout(fileNamed: "FieldLayout")!
        scene.isAuto = true
        scene.size = CGSize(width: 1334, height: 750)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = UIColor(Color("specBlue"))
        return scene
    }()
    
    var body: some View {
        NavigationStack {
            ZStack{
                specBlue.ignoresSafeArea(.all)
                VStack {
                    SpriteView(scene: scene)
                        .foregroundColor(.white)
                        .zIndex(-1)
                }.onAppear {
                    if Flow.waterfall {
                        dismiss()
                    }
                }
            }.foregroundColor(.white)
            .toolbar{
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
        }.tint(.white)
    }
}

struct AutoView_Previews: PreviewProvider {
    static var previews: some View {
        AutoView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

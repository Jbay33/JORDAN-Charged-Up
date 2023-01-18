//
//  TeleFile.swift
//  JORDAN Charged Up
//
//  Created by  on 1/12/23.
//

import Foundation
import SpriteKit

    class TeleLayout : SKScene{
        var start = SKLabelNode()

        override func didMove(to view: SKView) {
            //start = childNode(withName: "Start") as! SKLabelNode
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let location = touches.first!.location(in: self)
        }
    }

//
//  FieldFile.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//


import Foundation
import SpriteKit
import Alamofire

class FieldLayout : SKScene{
    var pieces = [
        //MARK: sect a
        [SKSpriteNode()],
        [SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        [SKSpriteNode(), SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        [SKSpriteNode()],
        [SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        
        //MARK: sect B
        [SKSpriteNode()],
        [SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        [SKSpriteNode(), SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        [SKSpriteNode()],
        [SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        
        //MARK: sect C
        [SKSpriteNode()],
        [SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        [SKSpriteNode(), SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()],
        
        [SKSpriteNode()],
        [SKSpriteNode()],
        [SKSpriteNode(), SKSpriteNode()]
    ]
    
    var sectA = SKNode()
    var sectB = SKNode()
    var sectC = SKNode()

    override func didMove(to view: SKView) {
        
        sectA = childNode(withName: "Peices")!.childNode(withName: "SectA")!
        sectB = childNode(withName: "Peices")!.childNode(withName: "SectB")!
        sectC = childNode(withName: "Peices")!.childNode(withName: "SectC")!
        
        for i in 0..<9 {
            if pieces[i].count > 1 {
                pieces[i][0] = sectA.childNode(withName: "\(i+1)Cone") as! SKSpriteNode
                pieces[i][1] = sectA.childNode(withName: "\(i+1)Cube") as! SKSpriteNode
            } else {
                pieces[i][0] = sectA.childNode(withName: "\(i+1)") as! SKSpriteNode
            }
        }
        
        for i in 9..<18 {
            if pieces[i].count > 1 {
                pieces[i][0] = sectB.childNode(withName: "\(i-8)Cone") as! SKSpriteNode
                pieces[i][1] = sectB.childNode(withName: "\(i-8)Cube") as! SKSpriteNode
            } else {
                pieces[i][0] = sectB.childNode(withName: "\(i-8)") as! SKSpriteNode
            }
        }
        
        for i in 18..<27 {
            if pieces[i].count > 1 {
                pieces[i][0] = sectC.childNode(withName: "\(i-17)Cone") as! SKSpriteNode
                pieces[i][1] = sectC.childNode(withName: "\(i-17)Cube") as! SKSpriteNode
            } else {
                pieces[i][0] = sectC.childNode(withName: "\(i-17)") as! SKSpriteNode
            }
        }
        
        for i in pieces {
            print(i[0].frame)
        }
        
    }
    
    //ugly please fix please
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        
        print(location)
        
        for i in pieces {
            if i.count > 1 {
                if !i[0].isHidden && i[0].frame.contains(location)  {
                    i[0].isHidden = true
                    i[1].isHidden = false
                    //break
                } else if !i[1].isHidden && i[0].frame.contains(location) {
                    i[1].isHidden = true
                    i[0].isHidden = true
                    //break
                } else if i[0].frame.contains(location) {
                    i[0].isHidden = false
                    i[1].isHidden = true
                    //break
                }
            } else {
                if !i[0].isHidden && i[0].frame.contains(location) {
                    i[0].isHidden = true
                    //break
                } else if i[0].frame.contains(location) {
                    i[0].isHidden = false
                    //break
                }
            }
        }
    }
}



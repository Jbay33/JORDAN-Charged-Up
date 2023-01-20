//
//  FieldFile.swift
//  JORDAN Charged Up
//
//  Created by  on 1/9/23.
//


import Foundation
import SpriteKit
import Alamofire



class FieldLayout : SKScene {
    public var isAuto: Bool = false
    
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
                
                switch GameData.gamePeices[i] {
                    case .Empty:
                        break
                    
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].alpha = 0.5
                            pieces[i][0].isHidden = false
                            break
                        } else {
                            pieces[i][0].isHidden = false
                        }
                    
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].alpha = 0.5
                            pieces[i][1].isHidden = false
                            break
                        } else {
                            pieces[i][1].isHidden = false
                        }
                }
                
            } else {
                pieces[i][0] = sectA.childNode(withName: "\(i+1)") as! SKSpriteNode
                
                switch GameData.gamePeices[i] {
                    case .Empty:
                        break
                    
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].alpha = 0.5
                            pieces[i][0].isHidden = false
                            
                            break
                        } else {
                            pieces[i][0].isHidden = false
                        }
                    
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].alpha = 0.5
                            pieces[i][1].isHidden = false
                            break
                        } else {
                            pieces[i][1].isHidden = false
                        }
                }
            }
        }
        
        for i in 9..<18 {
            if pieces[i].count > 1 {
                pieces[i][0] = sectB.childNode(withName: "\(i-8)Cone") as! SKSpriteNode
                pieces[i][1] = sectB.childNode(withName: "\(i-8)Cube") as! SKSpriteNode
                
                switch GameData.gamePeices[i] {
                    case .Empty:
                        break
                    
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].alpha = 0.5
                            pieces[i][0].isHidden = false
                            break
                        } else {
                            pieces[i][0].isHidden = false
                        }
                    
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].alpha = 0.5
                            pieces[i][1].isHidden = false
                            break
                        } else {
                            pieces[i][1].isHidden = false
                        }
                }
            } else {
                pieces[i][0] = sectB.childNode(withName: "\(i-8)") as! SKSpriteNode
                
                switch GameData.gamePeices[i] {
                    case .Empty:
                        break
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].alpha = 0.5
                            pieces[i][0].isHidden = false
                            break
                        } else {
                            pieces[i][0].isHidden = false
                        }
                    
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].alpha = 0.5
                            pieces[i][1].isHidden = false
                            break
                        } else {
                            pieces[i][1].isHidden = false
                        }
                }
            }
        }
        
        for i in 18..<27 {
            if pieces[i].count > 1 {
                pieces[i][0] = sectC.childNode(withName: "\(i-17)Cone") as! SKSpriteNode
                pieces[i][1] = sectC.childNode(withName: "\(i-17)Cube") as! SKSpriteNode
                
                switch GameData.gamePeices[i] {
                    case .Empty:
                        break
                    
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].alpha = 0.5
                            pieces[i][0].isHidden = false
                            break
                        } else {
                            pieces[i][0].isHidden = false
                        }
                    
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].alpha = 0.5
                            pieces[i][1].isHidden = false
                            break
                        } else {
                            pieces[i][1].isHidden = false
                        }
                }
            } else {
                pieces[i][0] = sectC.childNode(withName: "\(i-17)") as! SKSpriteNode
                
                switch GameData.gamePeices[i] {
                    case .Empty:
                        break
                    
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].alpha = 0.5
                            pieces[i][0].isHidden = false
                            break
                        } else {
                            pieces[i][0].isHidden = false
                        }
                    
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].alpha = 0.5
                            pieces[i][1].isHidden = false
                            break
                        } else {
                            pieces[i][1].isHidden = false
                        }
                }
            }
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isAuto {
            for i in 0..<pieces.count {
                switch GameData.gamePeices[i] {
                    case .Empty:
                        pieces[i][0].isHidden = true
                        pieces[i][0].alpha = 1.0
                        
                        if pieces[i].count > 1 {
                            pieces[i][1].isHidden = true
                            pieces[i][1].alpha = 1.0
                        }
                        break
                        
                    case .Cone(let a):
                        if a != isAuto {
                            pieces[i][0].isHidden = false
                            pieces[i][0].alpha = 0.5
                            
                            if pieces[i].count > 1 {
                                pieces[i][1].isHidden = true
                                pieces[i][1].alpha = 1.0
                            }
                            break
                        } else {
                            pieces[i][0].isHidden = false
                            pieces[i][0].alpha = 1.0
                            break
                        }
                        
                    case .Cube(let a):
                        if a != isAuto {
                            pieces[i][1].isHidden = false
                            pieces[i][1].alpha = 0.5
                            if pieces[i].count > 1 {
                                pieces[i][0].isHidden = true
                                pieces[i][0].alpha = 1.0
                            }
                            break
                        } else {
                            pieces[i][1].isHidden = false
                            pieces[i][1].alpha = 1.0
                            break
                        }
                }
            }
        }
    }
    
    //ugly please fix please
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        for j in 0..<pieces.count {
            let i = pieces[j]
            if i.count > 1 {
                if !i[0].isHidden && i[0].frame.contains(location)  { //Cone->Cube
                    switch GameData.gamePeices[j] {
                        case .Empty:
                            break
                        case .Cone(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                            
                        case .Cube(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                    }
                    
                    i[0].isHidden = true
                    i[1].isHidden = false
                    GameData.gamePeices[j] = .Cube(auto: isAuto)
                    break
                } else if !i[1].isHidden && i[0].frame.contains(location) { //Cube->None
                    switch GameData.gamePeices[j] {
                        case .Empty:
                            break
                        case .Cone(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                            
                        case .Cube(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                    }
                    
                    i[1].isHidden = true
                    i[0].isHidden = true
                    GameData.gamePeices[j] = .Empty
                    break
                } else if i[0].frame.contains(location) { //None->Cone
                    switch GameData.gamePeices[j] {
                        case .Empty:
                            break
                        case .Cone(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                            
                        case .Cube(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                    }
                    
                    i[0].isHidden = false
                    i[1].isHidden = true
                    GameData.gamePeices[j] = .Cone(auto: isAuto)
                    break
                }
            } else {
                if !i[0].isHidden && i[0].frame.contains(location) { //Cone->None
                    switch GameData.gamePeices[j] {
                        case .Empty:
                            break
                        case .Cone(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                            
                        case .Cube(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                    }
                    
                    i[0].isHidden = true
                    GameData.gamePeices[j] = .Empty
                    break
                } else if i[0].frame.contains(location) { //None->Cone
                    switch GameData.gamePeices[j] {
                        case .Empty:
                            break
                        case .Cone(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                            
                        case .Cube(let a):
                            if a != isAuto {
                                return
                            } else {
                                break
                            }
                    }
                    
                    i[0].isHidden = false
                    GameData.gamePeices[j] = .Cone(auto: isAuto)
                    break
                }
            }
        }
    }
}



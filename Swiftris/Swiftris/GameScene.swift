//
//  GameScene.swift
//  Swiftris
//
//  Created by Anthony Hauger on 10/30/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

import SpriteKit
import GameplayKit

let TickingLengthLevelOne = TimeInterval(600)
class GameScene: SKScene {
    
    var tick:(()->())?
    var tickLengthMillis=TickingLengthLevelOne
    var lastTick:NSDate?
    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize){
        super.init(size:size)
        
        //set the anchor point in the top-left corner (OpenGL standards)
        anchorPoint=CGPoint(x:0, y:1.0)
        
        //create an SKSpriteNode, set its anchor point to the top left
        let background=SKSpriteNode(imageNamed: "background")
        background.position=CGPoint(x:0,y:0)
        background.anchorPoint=CGPoint(x:0,y:1.0)
        addChild(background)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }*/
        return
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }*/
        return
    }
    
    func touchUp(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }*/
        return
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        guard let lastTick = lastTick else {
            return
        }
        
        let timePassed=lastTick.timeIntervalSinceNow * -1000.00
        if timePassed>tickLengthMillis{
            self.lastTick=NSDate()
            tick?()
        }
        
    }
}

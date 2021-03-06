//
//  GameScene.swift
//  Swiftris
//
//  Created by Anthony Hauger on 10/30/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

import SpriteKit
import GameplayKit

let BlockSize:CGFloat = 20.0

let TickingLengthLevelOne = TimeInterval(600)
class GameScene: SKScene {
    
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    let LayerPosition = CGPoint(x:6, y:-6)
    
    var tick:(()->())?
    var tickLengthMillis=TickingLengthLevelOne
    var lastTick:NSDate?
    
    var textureCache = Dictionary<String, SKTexture>()
    
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
        
        addChild(gameLayer)
        
        let gameBoardTexture = SKTexture(imageNamed: "gameboard")
        let gameBoard = SKSpriteNode(texture: gameBoardTexture, size: CGSize(width:BlockSize * CGFloat(NumColumns), height:BlockSize * CGFloat(NumRows)))
        gameBoard.anchorPoint = CGPoint(x:0, y:1.0)
        gameBoard.position = LayerPosition
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
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
    
    func startTicking(){
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y = LayerPosition.y - (CGFloat(row) * BlockSize) + (BlockSize / 2)
        return CGPoint(x:x,y:y)
    }
    
    func addPreviewShapeToScene(shape:Shape, completion:@escaping () -> ()) {
        for block in shape.blocks {
            var texture = textureCache[block.spriteName]
            if texture == nil {
                texture = SKTexture(imageNamed: block.spriteName)
                textureCache[block.spriteName] = texture
            }
            let sprite = SKSpriteNode(texture: texture)
            
            sprite.position = pointForColumn(column: block.column, row:block.row-2)
            shapeLayer.addChild(sprite)
            block.sprite = sprite
            
            sprite.alpha = 0
            let moveAction = SKAction.move(to: pointForColumn(column: block.column, row: block.row), duration: TimeInterval(0.2))
            moveAction.timingMode = .easeOut
            let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 0.4)
            fadeInAction.timingMode = .easeOut
            sprite.run(SKAction.group([moveAction, fadeInAction]))
        }
        
        run(SKAction.wait(forDuration: 0.4), completion: completion)
    }
    
    func movePreviewShape(shape:Shape, completion:@escaping ()->()) {
        for block in shape.blocks {
            let sprite = block.sprite!
            let moveTo = pointForColumn(column: block.column, row: block.row)
            let moveToAction:SKAction = SKAction.move(to: moveTo, duration: 0.2)
            moveToAction.timingMode = .easeOut
            sprite.run(
                SKAction.group([moveToAction, SKAction.fadeAlpha(to: 1.0, duration: 0.2)])
            )
        }
        
        run(SKAction.wait(forDuration: 0.2), completion: completion)
    }
    
    func redrawShape(shape:Shape, completion:@escaping () -> ()){
        for block in shape.blocks {
            let sprite = block.sprite!
            let moveTo = pointForColumn(column:block.column, row:block.row)
            let moveToAction:SKAction = SKAction.move(to: moveTo, duration: 0.05)
            moveToAction.timingMode = .easeOut
            if block == shape.blocks.last {
                sprite.run(moveToAction, completion: completion)
            } else {
                sprite.run(moveToAction)
            }
        }
    }
}

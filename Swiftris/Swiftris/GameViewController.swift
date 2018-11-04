//
//  GameViewController.swift
//  Swiftris
//
//  Created by Anthony Hauger on 10/30/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    //allocate the memory for a GameScene object, scene is current a NIL object
    var scene: GameScene!
    var swiftris:Swiftris!
    var panPointReference:CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        //THIS VIEW CANNOT HAVE MULTIPLE TOUCHES REGISTERED
        skView.isMultipleTouchEnabled=false
        
        //initialized a scene equal to our GameScene with the size of the SKView
        scene=GameScene(size: skView.bounds.size)
        
        /*
        when your screen size may differ from the size of the view, you use scaleMode
        aspectFill means fill the size of the view presented
        */
        scene.scaleMode = .aspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        skView.presentScene(scene)
        
        /*
        scene.addPreviewShapeToScene(shape:swiftris.nextShape!){
            self.swiftris.nextShape?.moveTo(column:StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(shape:self.swiftris.nextShape!){
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(shape:nextShapes.nextShape!) {}
            }
        }
        */
        /*OLD CODE DONT DELETE
        if let view = self.view as! SKView? {
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        */
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    func didTick() {
        swiftris.letShapeFall()
        /*
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(shape:swiftris.fallingShape!, completion: {})
        */
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let currentPoint=sender.translation(in: self.view)
        if let originalPoint=panPointReference{
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9){
                if sender.velocity(in: self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .began {
            panPointReference = currentPoint
        }
    }
    
    @IBAction func didSwipe(_ sender: Any) {
        swiftris.dropShape()
    }
    
    private func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    func nextShape(){
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!){}
        self.scene.movePreviewShape(shape: fallingShape){
            self.view.isUserInteractionEnabled=true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(swiftris: Swiftris){
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!){
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
    
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        scene.stopTicking()
        scene.redrawShape(shape: swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(shape: swiftris.fallingShape!) {}
    }
    
}

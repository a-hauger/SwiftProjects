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

class GameViewController: UIViewController {
    //allocate the memory for a GameScene object, scene is current a NIL object
    var scene: GameScene!
    
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
        
        skView.presentScene(scene)
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
}

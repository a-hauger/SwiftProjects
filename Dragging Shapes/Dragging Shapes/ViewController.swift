//
//  ViewController.swift
//  Dragging Shapes
//
//  Created by Anthony Hauger on 10/28/18.
//  Copyright © 2018 Anthony Hauger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let halfSizeOfView = 25.0
        let maxViews = 25
        
        //insetBy returns a rectangle larger/smaller than the source rectangle
        let insetSize = self.view.bounds.insetBy(dx: CGFloat(Int(2 * halfSizeOfView)), dy: CGFloat(Int(2 * halfSizeOfView))).size
        
        //Add the views/squares
        //for _ means that I'm going to go through the for loop but not use the variable
        //0..<maxViews is cool because you're saying 0...maxViews-1, which means from 0->maxViews-1
        for _ in 0..<maxViews {
            
            /*******************************************
            CGFloat is a CoreGraphicsFloat point
            UInt=UnsignedInt
            pointX/pointY is a CoreGraphicsFloat value
            CGFloat takes a number as a parameter
            CGFloat is equal to a UnsignedInteger that takes a number as a parameter
            arc4random() is a Swift 4.1 function to get a random number, DOESN'T EXIST IN SWIFT 4.2
            Modulo the random value by a 32 bit unsigned int value that is the size of the width/height of insetSize
            ********************************************/
            
            let pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
            let pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
            
            //create maxViews number of CoreGraphics rectangles at (pointX,pointY) with a dimension of 50x50
            let newView = MyView(frame: CGRect(x: pointX, y: pointY, width: 50, height: 50))
            self.view.addSubview(newView)
        }
    }


}


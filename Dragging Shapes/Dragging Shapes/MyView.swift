//
//  MyView.swift
//  Dragging Shapes
//
//  Created by Anthony Hauger on 10/28/18.
//  Copyright © 2018 Anthony Hauger. All rights reserved.
//

import UIKit

/********************************************
 UIView is going to be a box that we are going to drag around.  When we talk about moving views around, we are talking about each UIView
 ********************************************/
class MyView: UIView {
    //lastLocation keeps track of the user's last touch -- at the beginning the user hasn't touched anything so its at (0,0)
    //CGPoint contains a coordinate in 2D space
    var lastLocation = CGPoint(x: 0, y: 0)
    
    /******************************************
     The following initializes our UIView in a particular way when it is created
    *******************************************/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        Type CGRect contains the location and dimensions of a rectangle
         
         panRecognizer is a UIPanGestureRecognizer method that is pased a detectPan method; when a pan gesture is recognized on the touch screen, UIPanGestureRecognizer will recognize that pan gesure
         
         #selector is an argument label
         We are saying we want to call our class's detectPan function
        */
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(MyView.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        
        //RGB color selector variables
        let blueVal = CGFloat(Int(arc4random() % 255))/255.0
        let greenVal = CGFloat(Int(arc4random() % 255))/255.0
        let redVal = CGFloat(Int(arc4random() % 255))/255.0
        
        //UIColor is in RGBa
        self.backgroundColor = UIColor(red:redVal, green:greenVal, blue:blueVal, alpha:1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        //the translation variable detects the new coordinates of the view when panning
        let translation = recognizer.translation(in: self.superview)
        
        //we are saying the center of the view is now where our last location + translation variable is
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    override func touchesBegan(_ touches: (Set<UITouch>?), with event: UIEvent!) {
        //The touched view is brought to the front
        self.superview?.bringSubviewToFront(self)
        
        //our last location is now the current center of the view
    }
}

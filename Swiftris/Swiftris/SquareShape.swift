//
//  SquareShape.swift
//  Swiftris
//
//  Created by Anthony Hauger on 11/1/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

class SquareShape: Shape {
    /*
     | 0*| 1 |
     | 2 | 3 |
     
     * is the row column indicator of the shape?
     The square shape will not rotate
    */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            
            //the tuples are the difference from the anchor point to the block its referencing for each orientation
            Orientation.Zero: [(0,0), (1,0), (0,1), (1,1)],
            Orientation.OneEighty: [(0,0), (1,0), (0,1), (1,1)],
            Orientation.Ninety: [(0,0), (1,0), (0,1), (1,1)],
            Orientation.TwoSeventy: [(0,0), (1,0), (0,1), (1,1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [
            //we've created a dictionary of the bottom blocks of the shape for each orientation
            Orientation.Zero: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}

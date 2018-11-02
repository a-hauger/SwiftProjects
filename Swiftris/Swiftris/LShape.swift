//
//  LShape.swift
//  Swiftris
//
//  Created by Anthony Hauger on 11/2/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

class LShape: Shape {
    /*
     Orientation 0
     | 0*|
     | 1 |
     | 2 | 3 |
     
     Orientation 90
           *
     | 2 | 1 | 0 |
     | 3 |
     
     Orientation 180
     | 3 | 2*|
         | 1 |
         | 0 |
     
     Orientation 270
           * | 3 |
     | 0 | 1 | 2 |
    */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0,0),(0,1),(0,2),(1,2)],
            Orientation.OneEighty: [(0,2),(0,1),(0,0),(-1,0)],
            Orientation.Ninety: [(1,1),(0,1),(-1,1),(-1,2)],
            Orientation.TwoSeventy: [(-1,1),(0,1),(1,1),(1,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [
            Orientation.Zero: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]]
        ]
    }
}

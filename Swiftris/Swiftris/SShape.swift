//
//  SShape.swift
//  Swiftris
//
//  Created by Anthony Hauger on 11/2/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

class SShape: Shape{
    /*
     Orientation 0/180
     | 0*|
     | 1 | 2 |
         | 3 |
     
     Orientation 90/270
       * | 1 | 0 |
     | 3 | 2 |
    */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero: [(0,0),(0,1),(1,1),(1,2)],
            Orientation.OneEighty: [(0,0),(0,1),(1,1),(1,2)],
            Orientation.Ninety: [(2,0),(1,0),(1,1),(0,1)],
            Orientation.TwoSeventy: [(2,0),(1,0),(1,1),(0,1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero: [blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty: [blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety: [blocks[FirstBlockIdx],blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx],blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}

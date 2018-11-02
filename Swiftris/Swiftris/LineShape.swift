//
//  LineShape.swift
//  Swiftris
//
//  Created by Anthony Hauger on 11/2/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

class LineShape: Shape {
    /*
    Orientation 0/180
    | 0*|
    | 1 |
    | 2 |
    | 3 |
 
    Orientation 90/270
    | 0 | 1*| 2 | 3 |
    */
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0,0),(0,1),(0,2),(0,3)],
            Orientation.OneEighty: [(0,0),(0,1),(0,2),(0,3)],
            Orientation.Ninety: [(-1,0),(0,0),(1,0),(2,0)],
            Orientation.TwoSeventy: [(-1,0),(0,0),(1,0),(2,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero: [blocks[ThirdBlockIdx]],
            Orientation.OneEighty: [blocks[ThirdBlockIdx]],
            Orientation.Ninety: blocks,
            Orientation.TwoSeventy: blocks
        ]
    }
}

//
//  Block.swift
//  Swiftris
//
//  Created by Anthony Hauger on 11/1/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

import SpriteKit

//creates a (6) max number of colors
let NumberOfColors: UInt32 = 6

enum BlockColor: Int {
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    var spriteName: String{
        switch self{
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Yellow:
            return "yellow"
        case .Teal:
            return "teal"
        }
    }
    
    var description: String{
        return self.spriteName
    }
    
    static func random() -> BlockColor {
        return BlockColor(rawValue:Int(arc4random_uniform(NumberOfColors)))!
    }
}

class Block: Hashable, CustomStringConvertible {
    let color: BlockColor
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    var spriteName: String {
        return color.spriteName
    }
    
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column:Int, row:Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column==rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}

//
//  Array2D.swift
//  Swiftris
//
//  Created by Anthony Hauger on 10/31/18.
//  Copyright © 2018 Bloc. All rights reserved.
//

//<T> allows us to store ANY data type in our Array
class Array2D<T> {
    let columns: Int
    let rows: Int
    
    //initialize our array
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(repeating: nil, count:rows * columns)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get{
            return array[(row*columns) + column]
        }
        
        set(newValue) {
            array[(row*columns) + column] = newValue
        }
    }
    
}

//
//  HashGrid.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 4/27/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import Foundation

class HashGrid<T>{
    
    private var coordTable = [HashCoord: T]()
    private let assertedWidth: Int
    private let assertedHeight: Int
    
    var width: Int {
        get{
            if assertedWidth > 0{
                return assertedWidth
            }
            
            return xMax - xMin + 1
        }
    }
    
    var height: Int {
        get{
            if assertedHeight > 0{
                return assertedHeight
            }
            
            return yMax - yMin + 1
        }
    }
    
    var xMin = 0
    var yMin = 0
    
    var xMax = 0
    var yMax = 0
    
    subscript(x: Int, y: Int) -> T?{
        get{
            assert(indexIsValid(x: x, y: y), "Index out of range")
            return coordTable[HashCoord(x: x,y: y)]
        }
        set(val){
            assert(indexIsValid(x: x, y: y), "Index out of range")
            
            if x < xMin{
                xMin = x
            }
            
            if y < yMin{
                yMin = y
            }
            
            if x > xMax{
                xMax = x
            }
            
            if y > yMax{
                yMax = y
            }
            
            coordTable[HashCoord(x: x,y: y)] = val
        }
    }
    
    init() {
        assertedWidth = -1
        assertedHeight = -1
    }
    
    init(width w: Int, height h: Int) {
        assert(w > 0 && h > 0, "Dimensions must be greater than 0")
        assertedWidth = w
        assertedHeight = h
    }
    
    func normalizeIndeces(){
        var newCoordTable = [HashCoord: T]()
        
        for entry in coordTable{
            entry.key.x -= xMin
            entry.key.y -= yMin
            
            newCoordTable[entry.key] = entry.value
            
        }
        
        coordTable = newCoordTable
        
        xMax -= xMin
        yMax -= yMin
        
        xMin = 0
        yMin = 0
    }
    
    private func indexIsValid(x: Int, y: Int) -> Bool{
        return assertedWidth < 0 || (x < assertedWidth && y < assertedHeight)
    }
    
    
}

private class HashCoord: Hashable, Equatable {
    public var x: Int
    public var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    var hashValue: Int {
        return x.hashValue ^ (y.hashValue &* 7197972913)
    }
    
    static func == (lhs: HashCoord, rhs: HashCoord) -> Bool {
        return (lhs.x == rhs.x && lhs.y == rhs.y)
    }
}

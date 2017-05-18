//
//  DungeonElementData.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/11/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import Foundation

class DungeonElementData{
    
    subscript(i: Int) -> DungeonElementDataEntry{
        get{
            return data[i]
        }
        
        set(val){
            data[i] = val
        }
    }
    
    func append(entry: DungeonElementDataEntry){
        data.append(entry)
    }
    
    func insert(entry: DungeonElementDataEntry, at: Int){
        data.insert(entry, at: at)
    }
    
    func count() -> Int{
        return data.count
    }
    
    private var data = [DungeonElementDataEntry]()
}

class DungeonElementDataEntry{
    var key: String
    var value: String
    
    init(key k: String, value v: String){
        key = k
        value = v
    }
}

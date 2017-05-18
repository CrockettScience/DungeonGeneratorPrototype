//
//  Random.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/8/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import Foundation

class Random{
    private static let A = 48271
    private static let M = 2147483647
    private static let Q = M / A
    private static let R = M % A
    
    private var state = 0
    
    init(){
        self(Date.)
    }
    
    init(seed s: Int){
        var seed = s
        if(seed < 0){
            seed = seed &+ Random.M
        }
    }
}

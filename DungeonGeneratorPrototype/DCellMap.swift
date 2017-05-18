//
//  Dungeon.swift
//  Block Quest
//
//
//  Created by Jonathan Crockett on 5/12/17.

import Foundation

class DCellMap {
    
    var nodeMap = HashGrid<DCellNode>()
    private let dNodeSpawn: DCellNode
    
    
    init(size: Int) {
        dNodeSpawn = DCellNode(x: 0, y: 0, gateLvl: 0, tpe: .spawn)
        
        generateNodeGraph(3, size)
    }
    
    private func generateNodeGraph(_ gates: Int, _ size: Int) {
        //generates basic node structure as a directed graph
        
        var createdNodes = [DCellNode]()
        
        var gateLevelNodes = [DCellNode]()
        
        var gateLevel = 0
        var current = dNodeSpawn
        nodeMap[dNodeSpawn.location.x, dNodeSpawn.location.y] = dNodeSpawn
        
        createdNodes.append(dNodeSpawn)
        var next = DCellNode(x: 0, y: 0, gateLvl: 0, tpe: .normal)
        
        var gateFactor = size / (gates + 1)
        
        while createdNodes.count < size{
            if add(next: next, current: current) {
                createdNodes.append(next)
                gateLevelNodes.append(next)
                nodeMap[next.location.x, next.location.y] = next
                
                if(createdNodes.count > gateFactor){
                    gateLevelNodes[DCellMap.getRand(gateLevelNodes.count - 1) + 1].type = .key
                    gateLevelNodes.removeAll()
                    
                    gateLevel += 1
                    gateFactor += gateFactor
                }
                
                next = DCellNode(x: 0, y: 0, gateLvl: gateLevel, tpe: .normal)
            }
            
            current = createdNodes[DCellMap.getRand(createdNodes.count)]
        }
        
        createdNodes[createdNodes.count - 1].type = .boss
        
        nodeMap.normalizeIndeces()
    }
    
    private func add(next: DCellNode, current: DCellNode) -> Bool{
        let dir = Direction(rawValue: DCellMap.getRand(4))!
        let coords = DCellCoord(x: current.location.x + dir.x, y: current.location.y + dir.y)
        
        if let existingNode = nodeMap[coords.x, coords.y]{
            //make connection to existing node
            current.add(node: existingNode, toSide: dir)
            
            return false
        }
        
        current.add(node: next, toSide: dir)
        return true
    }
    
    public static func getRand(_ bound: Int) -> Int {
        return Int(drand48() * Double(bound))
    }
        
}

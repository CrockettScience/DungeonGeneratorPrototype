//
//  DungeonNode.swift
//  Block Quest
//
//  Created by Jonathan Crockett on 5/12/17.

import Foundation

class DCellNode: DungeonElement {
    public static let WIDTH = 32
    public static let HEIGHT = 24
    
    var elementData = DungeonElementData()
    
    var gateLevel: Int = 0
    
    var dcAbove: Edge?
    var dcBelow: Edge?
    var dcLeft: Edge?
    var dcRight: Edge?
    
    var tileMap: HashGrid<Tile>?
    var gateMap: HashGrid<Gate>?
    var location: DCellCoord
    private var actualType: NodeType
    var type: NodeType {
        get{
            return actualType
        }
        
        set(val){
            elementData[1].value = val.string
            actualType = val
        }
    }
    
    init(x: Int, y: Int, gateLvl: Int, tpe: NodeType){
        location = DCellCoord(x: x, y: y)
        gateLevel = gateLvl
        actualType = tpe
        
        elementData.append(entry: DungeonElementDataEntry(key: "Dungeon Element Type", value: "Dungeon Node"))
        elementData.append(entry: DungeonElementDataEntry(key: "Dungeon Node Type", value: tpe.string))
        elementData.append(entry: DungeonElementDataEntry(key: "Dungeon Coordinates", value: "(" + String(x)  + ", " + String(y) + ")"))
        elementData.append(entry: DungeonElementDataEntry(key: "Gate Level", value: String(gateLvl)))
        elementData.append(entry: DungeonElementDataEntry(key: "Has a left", value: "false"))
        elementData.append(entry: DungeonElementDataEntry(key: "Has a right", value: "false"))
        elementData.append(entry: DungeonElementDataEntry(key: "Has a below", value: "false"))
        elementData.append(entry: DungeonElementDataEntry(key: "Has an above", value: "false"))
        
    }
    
    func add(node: DCellNode, toSide: Direction) {
        
        switch toSide {
            
        case .above:
            elementData[6].value = "True"
            node.elementData[7].value = "True"
            let edge = Edge(size: DCellNode.WIDTH, upLeft: node, downRight: self)
            node.dcBelow = edge
            dcAbove = edge
            
            break
                
        case .below:
            elementData[7].value = "True"
            node.elementData[6].value = "True"
            let edge = Edge(size: DCellNode.WIDTH, upLeft: self, downRight: node)
            node.dcAbove = edge
            dcBelow = edge
            
            break
            
        case .left:
            elementData[4].value = "True"
            node.elementData[5].value = "True"
            let edge = Edge(size: DCellNode.HEIGHT, upLeft: node, downRight: self)
            node.dcRight = edge
            dcLeft = edge
            
            break
            
        case .right:
            elementData[5].value = "True"
            node.elementData[4].value = "True"
            let edge = Edge(size: DCellNode.HEIGHT, upLeft: self, downRight: node)
            node.dcLeft = edge
            dcRight = edge
            
            break
        }
        
        node.location.x = location.x + toSide.x
        node.location.y = location.y + toSide.y
        
        node.elementData[2].value = "(" + String(node.location.x)  + ", " + String(node.location.y) + ")"
    }
    
    private static func randBool() -> Bool{
        return DCellMap.getRand(1) != 0 ? true : false
    }
    
}



class Edge: DungeonElement{
    
    var elementData = DungeonElementData()
    
    var upLeft: DCellNode
    var downRight: DCellNode
    
    var owner: DCellNode{
        if(upLeft.gateLevel > downRight.gateLevel){
            return downRight
        }
        else{
            return upLeft
        }
    }
    
    init(size: Int, upLeft first: DCellNode, downRight second: DCellNode){

        upLeft = first
        downRight = second
        
        elementData.append(entry: DungeonElementDataEntry(key: "Dungeon Element Type", value: "Node Edge"))
        
        elementData.append(entry: DungeonElementDataEntry(key: "Is a Gate?", value: upLeft.gateLevel != downRight.gateLevel ? "True" : "false"))
        
        if upLeft.gateLevel != downRight.gateLevel {
            
            elementData.append(entry: DungeonElementDataEntry(key: "Gate Number", value: String(max(upLeft.gateLevel, downRight.gateLevel))))
        }
    }
}

class DCellCoord: Hashable, Equatable {
    public var x: Int
    public var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    var hashValue: Int {
        return x.hashValue ^ (y.hashValue &* 7197972913)
    }
    
    static func == (lhs: DCellCoord, rhs: DCellCoord) -> Bool {
        return (lhs.x == rhs.x && lhs.y == rhs.y)
    }
}

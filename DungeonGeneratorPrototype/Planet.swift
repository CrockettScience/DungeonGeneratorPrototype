//
//  Planet.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/11/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

class Planet: DungeonElement {
    
    var elementData = DungeonElementData()
    
    var isProto: Bool
    var isMoon: Bool
    var seed: Int
    
    var map: DCellMap?
    var nodeColor: UIColor?
    var edgeColor: UIColor?
    
    var size = 0
    var planet: PlanetClass
    var moons: [Planet]?
    
    init(_ s: Int, type: PlanetClass, isMoon ism: Bool){
        isProto = true
        seed = s
        
        planet = type
        
        isMoon = ism
        
        elementData.append(entry: DungeonElementDataEntry(key: (isMoon ? "Moon" : "Planet") + " not generated yet", value: ""))
    }
    
    func generate(){
        if(isProto){
            elementData[0] = (entry: DungeonElementDataEntry(key: "Dungeon Element Type", value: isMoon ? "Moon" : "Planet"))
            elementData.append(entry: DungeonElementDataEntry(key: "Seed", value: String(seed)))
            elementData.append(entry: DungeonElementDataEntry(key: "Planet Type", value: planet.string))
            
            //set seed
            srand48(seed)
            
            //generate moons
            if !isMoon{
                
                size = Int(drand48() * 20) + 30
                elementData.append(entry: DungeonElementDataEntry(key: "Planet Size", value: String(size)))
                
                let moonCount = Int(drand48() * 3)
                
                moons = [Planet]()
                
                moons?.append(self)
                
                for _ in 0 ..< moonCount {
                    let moon = Planet(seed ^ Int((drand48() * Double(seed))), type: PlanetClass(rawValue: Int(drand48() * 7))!, isMoon: true)
                    moons?.append(moon)
                }
                
                elementData.append(entry: DungeonElementDataEntry(key: "Number of Moons", value: String(moonCount)))
            }
            else{
                size = Int(drand48() * 15) + 10
                elementData.append(entry: DungeonElementDataEntry(key: "Planet Size", value: String(size)))
            }
            
            
            //generate node graph
            
            map = DCellMap(size: size)
            
            //set up node and edge color for dungeon viewer
            switch planet {
            case .earthLike:
                nodeColor = UIColor.green
                edgeColor = UIColor.blue
                
            case .desert:
                nodeColor = UIColor.orange
                edgeColor = UIColor.yellow
                
            case .molten:
                nodeColor = UIColor.red
                edgeColor = UIColor.black
                
            case .selena:
                nodeColor = UIColor.brown
                edgeColor = UIColor.gray
                
            case .swamp:
                nodeColor = UIColor.brown
                edgeColor = UIColor.cyan
                
            case .terra:
                nodeColor = UIColor.brown
                edgeColor = UIColor.darkGray
                
            case .water:
                nodeColor = UIColor.blue
                edgeColor = UIColor.blue
                
            }
            
            isProto = false
        }
    }
}

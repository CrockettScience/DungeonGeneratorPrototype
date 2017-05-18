//
//  System.swift
//  DungeonGeneratorPrototype
//
//
//  Created by Jonathan Crockett on 5/12/17.
import Foundation


class System: DungeonElement{
    
    var elementData = DungeonElementData()
    
    var isProto: Bool
    var seed: Int
    
    var star: StarClass = .mainSequence
    var planets =  [Planet]()
    
    init(_ s: Int){
        isProto = true
        seed = s
        
        elementData.append(entry: DungeonElementDataEntry(key: "System not generated yet", value: ""))
    }
    
    func generate(){
        if(isProto){
            elementData[0] = DungeonElementDataEntry(key: "Dungeon Element Type", value: "Star System")
            elementData.append(entry: DungeonElementDataEntry(key: "Seed", value: String(seed)))
            
            //set seed
            srand48(seed)
            
            //generate star type
            star = StarClass(rawValue: Int(drand48() * 8))!
            elementData.append(entry: DungeonElementDataEntry(key: "Star Class", value: star.string))
            
            //generate planets
            let planetCount = Int(drand48() * 10)
            for _ in 0 ..< planetCount{
                planets.append(Planet(seed ^ Int((drand48() * Double(seed))), type: PlanetClass(rawValue: Int(drand48() * 7))!, isMoon: false))
            }
            
            elementData.append(entry: DungeonElementDataEntry(key: "Number of Planets", value: String(planetCount)))
            
            isProto = false
            
        }
    }
}

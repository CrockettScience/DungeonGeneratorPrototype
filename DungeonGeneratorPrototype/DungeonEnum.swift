//
//  DungeonEnum.swift
//  Block Quest
//
//
//  Created by Jonathan Crockett on 5/12/17.

import Foundation


//DUNGEON GENERATION
enum Gate: Int{
    case gWater
    case gRock
    case gGap
    case gWall
    case gGlass
    case gTree
    case gWeb
    case gFire
    case gIce
    case gPoison
    case gCliff
    case gDirt
    
    var key: Key {
        switch self {
        case .gWater: return .kPlank
        case .gRock: return .kHammer
        case .gGap: return .kLeap
        case .gWall: return .kBomb
        case .gGlass: return .kPhase
        case .gTree: return .kAxe
        case .gWeb: return .kFire
        case .gFire: return .kFireGarb
        case .gIce: return .kIceGarb
        case .gPoison: return .kPoisonGarb
        case .gCliff: return .kLadder
        case .gDirt: return .kPick
        }
    }
}

enum Key{
    case kPlank
    case kHammer
    case kLeap
    case kBomb
    case kPhase
    case kAxe
    case kFire
    case kFireGarb
    case kIceGarb
    case kPoisonGarb
    case kLadder
    case kPick
}

enum Tile{
    case floor
    case wall
    
}

enum Direction: Int{
    case above = 1
    case below = 3
    case left = 2
    case right = 0
    
    public var x: Int {
        switch self {
        case .above:
            return 0
        case .below:
            return 0
        case .left:
            return -1
        case .right:
            return 1
        }
    }
    
    public var y: Int {
        switch self {
        case .above:
            return 1
        case .below:
            return -1
        case .left:
            return 0
        case .right:
            return 0
        }
    }
}

enum NodeType {
    case spawn
    case boss
    case normal
    case key
    
    public var string: String{
        switch self {
            
        case .spawn:
            return "Spawn"
        case .boss:
            return "Boss"
        case .normal:
            return "Normal"
        case .key:
            return "Key"
        }
    }
}

enum StarClass: Int{
    case hyperGiant
    case superGiant
    case brightGiant
    case giant
    case subGiant
    case mainSequence
    case dwarf
    case subDwarf
    
    public var string: String{
        switch self {
        case .hyperGiant:
            return "Hyper Giant"
            
        case .superGiant:
            return "Super Giant"
            
        case .brightGiant:
            return "Bright Giant"
            
        case .giant:
            return "Giant"
            
        case .subGiant:
            return "Subgiant"
            
        case .mainSequence:
            return "Main Sequence"
            
        case .dwarf:
            return "Dwarf"
            
        case .subDwarf:
            return "Subdwarf"
        }
    }
}

enum PlanetClass: Int {
    case earthLike
    case desert
    case molten
    case selena
    case swamp
    case terra
    case water
    
    public var string: String{
        switch self {
            
        case .earthLike:
            return "Earth Like"
            
        case .desert:
            return "Desert"
            
        case .molten:
            return "Molten"
            
        case .selena:
            return "Selena"
            
        case .swamp:
            return "Swamp"
            
        case .terra:
            return "Terrestrial"
            
        case .water:
            return "Water"
        }
    }
}

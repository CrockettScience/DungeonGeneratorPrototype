//
//  DungeonViewer.swift
//  DungeonGeneratorPrototype
//
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

protocol DungeonViewer{
    
    var navigationRoot: DungeonNavigationController? { get set }
    
    var zoomFactor: Int { get set }
    var selectedDungeonElement: DungeonElement? { get set }
    
    func zoomFactorDidChange()
    func advanceToNextDungeonView()
    
    
    
}

//
//  DungeonViewer.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/10/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

protocol DungeonViewer{
    
    var navigationRoot: DungeonNavigationController? { get set }
    
    var zoomFactor: Int { get set }
    var selectedDungeonElement: DungeonElement? { get set }
    
    func zoomFactorDidChange()
    func advanceToNextDungeonView()
    
    
    
}

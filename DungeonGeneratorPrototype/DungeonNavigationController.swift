//
//  DungeonNavigationController.swift
//  DungeonGeneratorPrototype
//
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

class DungeonNavigationController: UINavigationController{
    
    var loadingProgress: UIProgressView?
    var activityWheel: UIActivityIndicatorView?
    var dungeonElementLabel: UILabel?
    
    func visibleDungeonViewController() -> DungeonViewer {
        return self.visibleViewController as! DungeonViewer
    }
    
    

}

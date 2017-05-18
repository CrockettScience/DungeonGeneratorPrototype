//
//  DungeonNavigationController.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/10/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

class DungeonNavigationController: UINavigationController{
    
    var loadingProgress: UIProgressView?
    var activityWheel: UIActivityIndicatorView?
    var dungeonElementLabel: UILabel?
    
    func visibleDungeonViewController() -> DungeonViewer {
        return self.visibleViewController as! DungeonViewer
    }
    
    

}

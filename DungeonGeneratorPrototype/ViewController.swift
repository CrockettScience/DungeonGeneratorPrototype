//
//  ViewController.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 4/25/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectedElementName: UILabel!
    @IBOutlet weak var zoomer: UIStepper!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    
    var viewer: DungeonNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewer"{
            viewer = segue.destination as? DungeonNavigationController
            viewer?.loadingProgress = progressBar
            viewer?.activityWheel = activityWheel
            viewer?.dungeonElementLabel = selectedElementName
            
        }
        else if segue.identifier == "getInfo"{
            
            (segue.destination as? DungeonElementInformationViewController)?.dungeonElementData = viewer?.visibleDungeonViewController().selectedDungeonElement?.elementData
        }
    }
    
    
    @IBAction func zoomWasAdjusted(_ sender: Any) {
        var dungeonViewer = viewer!.visibleDungeonViewController()
        dungeonViewer.zoomFactor = Int(zoomer.value)
        dungeonViewer.zoomFactorDidChange()
        
    }
    
    @IBAction func viewElement(_ sender: Any) {
        let dungeonViewer = viewer!.visibleDungeonViewController()
        dungeonViewer.advanceToNextDungeonView()
    }

}


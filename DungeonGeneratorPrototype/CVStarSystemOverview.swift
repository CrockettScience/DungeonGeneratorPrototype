//
//  CVSystemOverview.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/11/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

private let reuseIdentifier = "systemCell"

class CVStarSystemOverview: UICollectionViewController, DungeonViewer {

    var navigationRoot: DungeonNavigationController?
    
    var zoomFactor = 24
    var selectedDungeonElement: DungeonElement?
    
    func zoomFactorDidChange(){}
    
    func advanceToNextDungeonView(){
        if let _ = selectedDungeonElement! as? Planet{
            performSegue(withIdentifier: "advanceToPlanet", sender: self)
        }
    }
    
    var generatedSystem: System?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generatedSystem = selectedDungeonElement as? System
        generatedSystem!.generate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advanceToPlanet"{
            var next = segue.destination as! DungeonViewer
            next.navigationRoot = navigationRoot
            next.selectedDungeonElement = selectedDungeonElement
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generatedSystem!.planets.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CVSystemOverviewCell
        
        if(indexPath.item == 0){
            cell.image.image = UIImage(named: "star.jpg")
        }
                
        else{
            var loadedImage: UIImage?
            switch generatedSystem!.planets[indexPath.item - 1].planet {
            case .earthLike:
                loadedImage = UIImage(named: "earthlike.jpg")
                    
            case .desert:
                loadedImage = UIImage(named: "desert.jpg")
                    
            case .molten:
                loadedImage = UIImage(named: "molten.jpg")
                    
            case .selena:
                loadedImage = UIImage(named: "selena.jpg")
                    
            case .swamp:
                loadedImage = UIImage(named: "swamp.jpg")
                    
            case .terra:
                loadedImage = UIImage(named: "terra.jpg")
                    
            case .water:
                loadedImage = UIImage(named: "water.png")
            }
                
            cell.image.image = loadedImage
        }
        
        return cell
}
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if(indexPath.item == 0){
            selectedDungeonElement = generatedSystem
            navigationRoot!.dungeonElementLabel!.text = "Star System"
        }
        else{
            selectedDungeonElement = generatedSystem!.planets[indexPath.item - 1]
            navigationRoot!.dungeonElementLabel!.text = "Planet"
        }
    }

}

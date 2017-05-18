//
//  CVPlanetSystemOverviewCollectionViewController.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/12/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

private let reuseIdentifier = "systemCell"

class CVPlanetSystemOverviewCollectionViewController: UICollectionViewController, DungeonViewer {

    var navigationRoot: DungeonNavigationController?
    
    var zoomFactor = 24
    var selectedDungeonElement: DungeonElement?
    
    func zoomFactorDidChange(){}
    
    func advanceToNextDungeonView(){
        performSegue(withIdentifier: "advanceToNodeGraph", sender: self)
    }
    
    var generatedPlanet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generatedPlanet = selectedDungeonElement as? Planet
        generatedPlanet!.generate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advanceToNodeGraph"{
            var next = segue.destination as! DungeonViewer
            next.navigationRoot = navigationRoot
            next.selectedDungeonElement = selectedDungeonElement
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generatedPlanet!.moons!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CVSystemOverviewCell
        
        
        var loadedImage: UIImage?
        switch generatedPlanet!.moons![indexPath.item].planet {
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
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if(indexPath.item == 0){
            selectedDungeonElement = generatedPlanet
            navigationRoot!.dungeonElementLabel!.text = "Planet"
        }
        else{
            selectedDungeonElement = generatedPlanet!.moons![indexPath.item]
            navigationRoot!.dungeonElementLabel!.text = "Moon"
        }
    }
    
}

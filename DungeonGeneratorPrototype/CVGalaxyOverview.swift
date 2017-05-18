//
//  CVGalaxyOverview.swift
//  DungeonGeneratorPrototype
//
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

private let reuseIdentifier = "galaxyCell"

class CVGalaxyOverview: UICollectionViewController, DungeonViewer{
    
    var navigationRoot: DungeonNavigationController?
    var galacticSeed: Int? = Int(arc4random())
    var activityWheel: UIActivityIndicatorView?
    
    var zoomFactor = 24
    var selectedDungeonElement: DungeonElement?
    
    var highlightedStarCell: UICollectionViewCell?
    
    func zoomFactorDidChange() {
        let layout = collectionViewLayout as! CVGalaxyOverviewLayout
        layout.cellHeight = zoomFactor * 4 + 16
        layout.cellWidth = zoomFactor * 4 + 16
        startLoadingWheel()
        layout.invalidateLayout()
        stopLoadingWheel()
    }
    
    var generatedGalaxy: Galaxy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationRoot = (parent! as! DungeonNavigationController)
        
        navigationRoot!.dungeonElementLabel!.text = "Galaxy"
        
        activityWheel = navigationRoot!.activityWheel
        
        startLoadingWheel()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        DispatchQueue.global(qos: .userInitiated).async {
            //Load Galaxy on separate thread
            let progressBar = self.navigationRoot!.loadingProgress!
            let progress = Progress(totalUnitCount: 100)
            progress.completedUnitCount = 0
            
            progressBar.observedProgress = progress
            
            self.generatedGalaxy = Galaxy(size: 200, density: 16, arms: 8, seed: self.galacticSeed!, progress: progress)
            
            
            self.selectedDungeonElement = self.generatedGalaxy
            
            DispatchQueue.main.async {
                //Update our layout
                let layout = self.collectionViewLayout as! CVGalaxyOverviewLayout
                
                layout.generatedGalaxy = self.generatedGalaxy!
                
                layout.invalidateLayout()
                
                self.collectionView!.reloadData()
                
                self.stopLoadingWheel()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let width = generatedGalaxy?.starGrid.width{
            return width
        }
        else{
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let height = generatedGalaxy?.starGrid.height{
            return height
        }
        else{
            return 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advanceToSystem"{
            var next = segue.destination as! DungeonViewer
            next.navigationRoot = navigationRoot
            next.selectedDungeonElement = selectedDungeonElement
        }
        
    }
    
    func startLoadingWheel(){
        activityWheel?.startAnimating()
        
    }
    
    func stopLoadingWheel(){
        activityWheel?.stopAnimating()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if highlightedStarCell != nil{
            highlightedStarCell!.backgroundColor = UIColor.yellow
            highlightedStarCell = nil
        }
        
        if(generatedGalaxy!.starGrid[indexPath.section, indexPath.item] != nil){
            selectedDungeonElement = generatedGalaxy?.starGrid[indexPath.section, indexPath.item]!
            navigationRoot!.dungeonElementLabel!.text = "Star System"
            
            highlightedStarCell = collectionView.cellForItem(at: indexPath)
            highlightedStarCell!.backgroundColor = UIColor.red
        }
        else{
            selectedDungeonElement = generatedGalaxy
            navigationRoot!.dungeonElementLabel!.text = "Galaxy"
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if(generatedGalaxy!.starGrid[indexPath.section, indexPath.item] != nil){
            cell.backgroundColor = UIColor.yellow
        }
        
        else{
            cell.backgroundColor = UIColor.blue
        }
        
        return cell
    }
    
    func advanceToNextDungeonView(){
        if let _ = selectedDungeonElement! as? System{
            performSegue(withIdentifier: "advanceToSystem", sender: self)
        }
    }
    
}

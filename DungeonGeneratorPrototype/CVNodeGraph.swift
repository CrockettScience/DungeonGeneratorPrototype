//
//  CVNodeGraph.swift
//  DungeonGeneratorPrototype
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

private let reuseIdentifier = "nodeGraphCell"

class CVNodeGraph: UICollectionViewController, DungeonViewer {
    
    var navigationRoot: DungeonNavigationController?
    
    var zoomFactor = 24
    var selectedDungeonElement: DungeonElement?
    
    func zoomFactorDidChange(){
        let layout = collectionViewLayout as! CVNodeGraphLayout
        layout.edgeThickness = zoomFactor * 4 + 16
        layout.nodeWidth = layout.edgeThickness * 2
        layout.nodeHeight = layout.nodeWidth
        
        navigationRoot!.activityWheel?.startAnimating()
        layout.invalidateLayout()
        navigationRoot!.activityWheel?.stopAnimating()
    }
    
    func advanceToNextDungeonView(){
        //nope, were at the bottom...
    }
    
    var generatedNodeGraph: DCellMap?
    var nodeColor: UIColor?
    var edgeColor: UIColor?


    override func viewDidLoad() {
        super.viewDidLoad()
        let planet = (selectedDungeonElement as! Planet)
        planet.generate()
        
        generatedNodeGraph = planet.map
        nodeColor = planet.nodeColor
        edgeColor = planet.edgeColor

        let layout = self.collectionViewLayout as! CVNodeGraphLayout
        layout.generatedNodeGraph = generatedNodeGraph!
        
        // Register cell classes
        //self.collectionView!.register(CVNodeGraphCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return generatedNodeGraph!.nodeMap.height * 2 - 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return generatedNodeGraph!.nodeMap.width * 2 - 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CVNodeGraphCell
        
        cell.gateLabel!.text = ""
    
        
        //detirmine if is a real cell
        if ((indexPath.item % 2) != 0) && ((indexPath.section % 2) != 0) {
            cell.backgroundColor = UIColor.white
        }
            
        //detirmine if edge or node
        else if ((indexPath.item % 2) == 0) && ((indexPath.section % 2) == 0){ //is a Node
            //detirmine if there is a real node here
            if let node = generatedNodeGraph!.nodeMap[indexPath.item / 2, indexPath.section / 2] {
                
                cell.gateLabel!.text = String(node.gateLevel)
                
                cell.backgroundColor = node.type == .normal ? nodeColor : UIColor.purple
                
                
            }
            else{
                cell.backgroundColor = UIColor.white
            }
            
        }
        else{//is an Edge
            
            
            //detirmine if there is a real edge here
            var isReal = false
            
            if ((indexPath.item % 2) == 0){// im a vertical edge
                
                if generatedNodeGraph!.nodeMap[indexPath.item / 2, indexPath.section / 2]?.dcAbove != nil{
                    isReal = true
                }
            }
            else{
                
                if generatedNodeGraph!.nodeMap[indexPath.item / 2, indexPath.section / 2]?.dcRight != nil{
                    isReal = true
                }
            }
            
            if isReal {
                cell.backgroundColor = edgeColor
            }
            else{
                cell.backgroundColor = UIColor.white
            }
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if(((indexPath.item % 2) == 0) || ((indexPath.section % 2) == 0)){
            if ((indexPath.item % 2) == 0) && ((indexPath.section % 2) == 0){//is a node
                if let node = generatedNodeGraph!.nodeMap[indexPath.item / 2, indexPath.section / 2]{//and it exists
                    selectedDungeonElement = node
                    navigationRoot!.dungeonElementLabel!.text = "Planet Node"
                }
            }
            else{//is an edge
                if ((indexPath.item % 2) == 0){// is a vertical edge
                    if let edge = generatedNodeGraph!.nodeMap[indexPath.item / 2, indexPath.section / 2]?.dcAbove{//and it exists
                        
                        selectedDungeonElement = edge
                        navigationRoot!.dungeonElementLabel!.text = "Node Edge"
                    }
                }
                else{
                    if let edge = generatedNodeGraph!.nodeMap[indexPath.item / 2, indexPath.section / 2]?.dcRight{
                        
                        selectedDungeonElement = edge
                        navigationRoot!.dungeonElementLabel!.text = "Node Edge"
                    }
                }
            }
        }
    }
}

//
//  CVNodeGraphLayout.swift
//  DungeonGeneratorPrototype
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

class CVNodeGraphLayout: UICollectionViewLayout {
    var nodeWidth = 64
    var nodeHeight = 64
    var edgeThickness = 32
    
    var cellAttrs = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    override var collectionViewContentSize: CGSize{
        get{
            if let graph = generatedNodeGraph{
                let xNodes = graph.nodeMap.width
                let yNodes = graph.nodeMap.height
                
                return CGSize(width: (xNodes * nodeWidth) + ((xNodes - 1) * edgeThickness), height: (yNodes * nodeHeight) + ((yNodes - 1) * edgeThickness))
            }
            
            return CGSize.zero
            
        }
    }
    
    
    var generatedNodeGraph: DCellMap? = nil
    
    override func prepare(){
        if (collectionView?.numberOfSections)! > 0 {
            for section in 0 ..< (collectionView?.numberOfSections)!{
                
                if (collectionView?.numberOfItems(inSection: section))! > 0 {
                    for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                        
                        let cellIndex = IndexPath(item: item, section: section)
                        let xPos = getXPos(x: item) + 8
                        let yPos = getYPos(y: section) + 8
                        let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                        cellAttributes.frame = CGRect(x: xPos, y: yPos, width: getCellWidth(forCellAt: item), height: getCellHeight(forCellAt: section))
                        cellAttributes.zIndex = 1
                        
                        cellAttrs[cellIndex] = cellAttributes
                        
                        
                    }
                }
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrs[indexPath]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = [UICollectionViewLayoutAttributes]()
        
        for attr in cellAttrs{
            if attr.value.frame.intersects(rect){
                attrs.append(attr.value)
            }
        }
        
        return attrs
    }
    
    private func getXPos(x: Int) -> Int{
        //detirmine if edge or node
        if (x % 2) == 0{ //is a Node
            return ((x / 2) * nodeWidth) + ((x / 2) * edgeThickness)
        }
        else{//is an Edge
            return ((x / 2 + 1) * nodeWidth) + ((x / 2) * edgeThickness)
        }
    }
    
    private func getYPos(y: Int) -> Int{
        //detirmine if edge or node
        if (y % 2) == 0{ //is a Node
            return ((y / 2) * nodeHeight) + ((y / 2) * edgeThickness)
        }
        else{//is an Edge
            return ((y / 2 + 1) * nodeHeight) + ((y / 2) * edgeThickness)
        }
    }
    
    private func getCellWidth(forCellAt x: Int) -> Int{
        //detirmine if edge or node
        if (x % 2) == 0{ //is a Node
            return nodeWidth
        }
        else{//is an Edge
            return edgeThickness
        }
    }
    
    private func getCellHeight(forCellAt y: Int) -> Int{
        //detirmine if edge or node
        if (y % 2) == 0{ //is a Node
            return nodeHeight
        }
        else{//is an Edge
            return edgeThickness
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }

}

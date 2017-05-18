//
//  CVGalaxyOverviewLayout.swift
//  DungeonGeneratorPrototype
//
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

class CVGalaxyOverviewLayout: UICollectionViewLayout {
    
    var cellHeight = 16
    var cellWidth = 16
    
    var cellAttrs = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    override var collectionViewContentSize: CGSize{
        get{
            if let gal = generatedGalaxy{
                return CGSize(width: gal.starGrid.width * Int(cellWidth), height: gal.starGrid.height * Int(cellHeight))
            }
            
            return CGSize.zero
            
        }
    }
    
    
    var generatedGalaxy: Galaxy? = nil
    
    override func prepare(){
        if (collectionView?.numberOfSections)! > 0 {
            for section in 0 ..< (collectionView?.numberOfSections)!{
                
                if (collectionView?.numberOfItems(inSection: section))! > 0 {
                    for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                        
                        let cellIndex = IndexPath(item: item, section: section)
                        let xPos = item * cellWidth
                        let yPos = section * cellHeight
                        let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                        cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
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
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    
}

//
//  Galaxy.swift
//  DungeonGeneratorPrototype
//
//
//  Created by Jonathan Crockett on 5/12/17.

import UIKit

class Galaxy: DungeonElement{
    
    var elementData = DungeonElementData()
    
    var starGrid: HashGrid<System>
    var permTable = [Int]()
    
    init(size: Int, density: Int, arms: Int, seed: Int, progress: Progress){
        
        elementData.append(entry: DungeonElementDataEntry(key: "Dungeon Element Type", value: "Galaxy"))
        elementData.append(entry: DungeonElementDataEntry(key: "Random Seed", value: String(seed)))
        elementData.append(entry: DungeonElementDataEntry(key: "Star Density", value: String(density)))
        elementData.append(entry: DungeonElementDataEntry(key: "Number of Arms", value: String(arms)))
        
        starGrid = HashGrid<System>(width: size, height: size)
        
        //set seed
        srand48(seed)
        
        //set up permutation table to hash random numbers from coordinates
        for i in 0 ..< (size * size)
        {
            permTable.append(i)
        }
        for _ in 0 ..< 10
        {
            permTable.sort(by: {_,_ in return drand48() < drand48()})
        }
        
        //setup arm direction table
        let dirInterval =  (2 * M_PI) / Double(arms)
        var dirTable = [Double]()
        
        for i in 0 ..< arms{
            dirTable.append(dirInterval * Double(i))
        }
        
        progress.completedUnitCount = 10
        let progressInterval = 80.0 / Double(arms)
        
        //start spiral generation
        let o = size/2
        let spiralInterval = M_PI / 4
        
        starGrid[o,o] = System(seedForCoordinateAt(x: o, y: o))
        
        for i in 0 ..< dirTable.count{
            var x = o
            var y = o
            var fibIndex = 1.0
            var fibNumber = 1
            var theta = dirTable[i]
            var thetaDelta: Double
            armLoop: while(true){
                thetaDelta = spiralInterval / Double(fibNumber)
                
                for _ in 0 ..< fibNumber {
                    x += Int((cos(theta) * 2).rounded())
                    y += Int((sin(theta) * 2).rounded())
                    
                    
                    if(x < 10 || y < 10 || x > size - 10 || y > size - 10){
                        break armLoop
                    }
                    
                    starGrid[x, y] = System(seedForCoordinateAt(x: o, y: o))
                    
                    
                    theta += thetaDelta
                    
                }
                
                fibIndex += 0.5
                fibNumber = fibCalc(Int(fibIndex.rounded()))
            }
            
            progress.completedUnitCount = 10 + Int64(progressInterval * Double(i))
            
            
        }
        
        //flesh out stars
        var starCount = 0
        
        let tempGrid = HashGrid<System>(width: size, height: size)
        
        for i in 0 ..< size{
            for j in 0 ..< size{
                if starGrid[i,j] != nil{
                    for nestI in i - 5 ..< i + 5{
                        for nestJ in j - 5 ..< j + 5{
                            if density == Int(drand48() * Double(density + 1)) && tempGrid[nestI, nestJ] == nil{
                                tempGrid[nestI, nestJ] = System(seedForCoordinateAt(x: nestI, y: nestJ))
                                starCount += 1
                            }
                        }
                    }
                }
            }
        }
        
        elementData.append(entry: DungeonElementDataEntry(key: "Number of Stars", value: String(starCount)))
        
        starGrid = tempGrid
        
        progress.completedUnitCount = 100
    }
    
    private func seedForCoordinateAt(x: Int, y: Int) -> Int{
        return permTable[(x + permTable[y % permTable.count]) % permTable.count]
    }
    
    private func fibCalc(_ i: Int) -> Int{
        var counter = 0
        var a = 0
        var b = 1
        while(counter < i){
            
            a = a + b
            counter += 1
            
            if (counter < i) {
                b = a + b
                counter += 1
            }
        }
        
        return max(a, b)
    }
    
    private func spiralVectorX(len: Double, rad: Double) -> Int{
        return Int(cos(rad) * len)
    }
    
    private func spiralVectorY(len: Double, rad: Double) -> Int{
        return Int(sin(rad) * len)
    }
    
    
    
}

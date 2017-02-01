//
//  WorldOfWarcraft.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import Foundation


protocol WorldOfWarcraftDelegate: class {
    func worldOfWarcraftNewRound(_ worldOfWarcraft: WorldOfWarcraft)
}

class WorldOfWarcraft {
    
    weak var delegate: WorldOfWarcraftDelegate?
    var cells: [Cell]!
    var dimension: Int!
    
    
    var liveCells: [Cell]! {
        return self.cells.filter { $0.state == .alive }
    }
    
    var deadCells: [Cell]! {
        return self.cells.filter { $0.state != .alive }
    }
    
    
    
    func setup() {
        self.dimension = 6
        self.cells = []
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                let cell = Cell(x: j, y: i)
//                if (i + j) % 2 == 0 {
//                    cell.state = .alive
//                }
                if i == 4 && j == 3 {
                    cell.state = .alive
                }
                
                if i == 5 && j == 4 {
                    cell.state = .alive
                }
                
                if i == 3 && j == 5 {
                    cell.state = .alive
                }
                
                if i == 4 && j == 5 {
                    cell.state = .alive
                }
                
                if i == 5 && j == 5 {
                    cell.state = .alive
                }
               
                cells.append(cell)
            }
        }
        self.delegate?.worldOfWarcraftNewRound(self)
    }
    
    func startIterate() {
        if(self.liveCells.count > 0) {
            let newCells = self.newCells().map { $0.state = .alive }
            let _ = self.dyingCells().map { $0.state = .dead }
            
            self.delegate?.worldOfWarcraftNewRound(self)
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.startIterate()
            }
        } else {
            print("all dead")
        }
    }
    
    
    
    
    private func newCells() -> [Cell]! {
        return self.deadCells.filter {
            let neighborsCount = self.neighborCells(for: $0).filter {
                $0.state == .alive }.count
                
               return neighborsCount == 3
        }
    }
    
    private func dyingCells() -> [Cell]! {
        return self.liveCells.filter {
            let liveNeighborCount = self.neighborCells(for: $0).filter { $0.state == .alive }.count
            return liveNeighborCount != 2 && liveNeighborCount != 3
        }
    }

    private func neighborCells(for cell: Cell) -> [Cell]! {
        
        let neighbors = self.cells.filter { $0.areNeighboring(other: cell) }
        return neighbors
    }

}


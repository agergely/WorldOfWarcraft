//
//  WorldOfWarcraft.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import Foundation


class WorldOfWarcraft {
    
    var cells: [Cell]!
    var dimension: Int!
    
    
    var liveCells: [Cell]! {
        return self.cells.filter { $0.state == .alive }
    }
    
    var deadCells: [Cell]! {
        return self.cells.filter { $0.state != .alive }
    }
    
    
    
    func setup() {
        self.dimension = 5
        self.cells = []
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                let cell = Cell(x: j, y: i)
                if (i + i) % 2 == 0 {
                    cell.state = .alive
                }
                cells.append(cell)
            }
        }
    }
    
    
    
    
    
    private func newCells() -> [Cell]! {
        return self.deadCells.filter { self.neighborCells(for: $0).filter { $0.state == .alive }.count == 3 }
    }
    
    private func dyingCells() -> [Cell]! {
        return self.liveCells.filter {
            let liveNeighborCount = self.neighborCells(for: $0).filter { $0.state == .alive }.count
            return liveNeighborCount != 2 && liveNeighborCount != 3
        }
    }

    private func neighborCells(for cell: Cell) -> [Cell]! {
        return self.cells.filter { $0.areNeighboring(other: cell) }
    }

}


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
    
    private func neighborCells(for cell: Cell) -> [Cell]! {
        return self.cells.filter { $0.areNeighboring(other: cell) }
    }

    
    func newCells() -> [Cell]! {
        return self.deadCells.filter { self.neighborCells(for: $0).filter { $0.state == .alive }.count == 3 }
    }
    
    func dyingCells() -> [Cell]! {
        return self.liveCells.filter {
            let liveNeighborCount = self.neighborCells(for: $0).filter { $0.state == .alive }.count
            return liveNeighborCount != 2 && liveNeighborCount != 3
        }
    }

}


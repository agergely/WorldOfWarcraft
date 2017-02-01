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


enum PlayMode {
    case manual, auto
}

class WorldOfWarcraft {
    
    weak var delegate: WorldOfWarcraftDelegate?
    var cells: [Cell]!
    var dimension: Int! {
        didSet {
            if let _ = self.dimension {
                self.reset()
            }
        }
    }
    var playMode: PlayMode = .manual
    
    
    func liveCells() -> [Cell]! {
        return self.cells.filter { $0.state == .alive }
    }
    
    func deadCells() -> [Cell]! {
        return self.cells.filter { $0.state != .alive }
    }
    
    
    func reset() {
        self.cells = []
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                let cell = Cell(x: j, y: i)
                cells.append(cell)
            }
        }
        self.delegate?.worldOfWarcraftNewRound(self)

    }
    
    func startIterate() {
        if(self.liveCells().count > 0) {
            let newCells: [Cell] = self.newCells()
            let dyingCells: [Cell] = self.dyingCells()
            
            let _ = newCells.map { $0.state = .alive }
            let _ = dyingCells.map { $0.state = .dead }


            self.delegate?.worldOfWarcraftNewRound(self)
            if (self.playMode == .auto) {
                let deadlineTime = DispatchTime.now() + .seconds(5)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    self.startIterate()
                }
            }
        } else {
            print("all dead")
        }
    }
    
    
    
    
    private func newCells() -> [Cell]! {
        return self.deadCells().filter {
            let neighborsCount = self.neighborCells(for: $0).filter {
                $0.state == .alive }.count
                
               return neighborsCount == 3
        }
    }
    
    private func dyingCells() -> [Cell]! {
        return self.liveCells().filter {
            let liveNeighborCount = self.neighborCells(for: $0).filter { $0.state == .alive }.count
            return liveNeighborCount != 2 && liveNeighborCount != 3
        }
    }

    private func neighborCells(for cell: Cell) -> [Cell]! {
        
        let neighbors = self.cells.filter { $0.areNeighboring(other: cell) }
        return neighbors
    }

}


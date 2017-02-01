//
//  Cell.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import UIKit

enum State {
    case alive, dead, neverLived
}


class Cell {
    
    let x,y: Int
    var state: State
    var frame: CGRect
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        self.state = .neverLived
        self.frame = CGRect.zero
    }
    
    
    func areNeighboring(other: Cell) -> Bool {
        let diffX = abs(self.x - other.x)
        let diffY = abs(self.y - other.y)
        
        switch (diffX, diffY) {
        case (1,1), (1,0), (0,1):
            return true
    
        default:
            return false
        }
    }
    
    
}

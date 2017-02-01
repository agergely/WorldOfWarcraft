//
//  PaletteView.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import UIKit

class PaletteView: UIView {
    
    var world: WorldOfWarcraft? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.world = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.world = nil
    }
    
    init(world: WorldOfWarcraft) {
        super.init(frame: CGRect.zero)
        self.world = world
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let world = self.world else {
            super.draw(rect)
            return
        }
        
        let dimension = world.dimension
        let viewWidth = self.frame.size.width
        let viewHeight = self.frame.size.height
        let cellWidth = viewWidth / CGFloat(dimension!)
        let cellHeight = viewHeight / CGFloat(dimension!)
        
        
        if let context = UIGraphicsGetCurrentContext() {
        
            for (index,cell) in world.cells.enumerated() {
                let cellX = CGFloat(cell.x) * cellWidth as CGFloat
                let cellY = CGFloat(cell.y) * cellHeight as CGFloat
                
                let cellFrame = CGRect(x: cellX, y: cellY, width: cellWidth, height: cellHeight)
                
                if index % 2 == 0 {
                    context.setFillColor(UIColor.yellow.cgColor)
                } else {
                    context.setFillColor(UIColor.red.cgColor)
                }
                context.addRect(cellFrame)
                context.fillPath()
            }
//            UIGraphicsEndImageContext()
        }
        
    }
}

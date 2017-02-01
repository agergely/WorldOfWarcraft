//
//  PaletteView.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import UIKit

class PaletteView: UIView, WorldOfWarcraftDelegate {
    
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
    

    private func setup() {
    
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let world = self.world else {
            super.draw(rect)
            return
        }
        
        let dimension = world.dimension
        let viewWidth = self.frame.size.width
        let viewHeight = self.frame.size.height
        let cellWidth = Int(viewWidth / CGFloat(dimension!))
        let cellHeight = Int(viewHeight / CGFloat(dimension!))
        
        
        if let context = UIGraphicsGetCurrentContext() {
        
            for (index,cell) in world.cells.enumerated() {
                let cellX = (cell.x) * Int(cellWidth)
                let cellY = (cell.y) * Int(cellHeight)
                
                let cellFrame = CGRect(x: Int(cellX), y: Int(cellY), width: cellWidth, height: cellHeight)
                
//                if index % 2 == 0 {
//                    context.setFillColor(UIColor.yellow.cgColor)
//                } else {
//                    context.setFillColor(UIColor.red.cgColor)
//                }
                var color: UIColor!
                switch cell.state {
                case .alive:
                    color = .green
                    break
                
                case .dead:
                    color = .yellow
                    break
            
                default:
                    color = .black
                }
                context.setFillColor(color.cgColor)
                       context.setStrokeColor(UIColor.purple.cgColor)
                context.addRect(cellFrame)
         
                context.fillPath()
            }
            UIGraphicsEndImageContext()
        }
    }
    
    func worldOfWarcraftNewRound(_ worldOfWarcraft: WorldOfWarcraft) {
        self.setNeedsDisplay()
    }
}

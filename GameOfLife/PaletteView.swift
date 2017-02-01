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
            if let world = self.world, world.playMode == .auto {
                self.isUserInteractionEnabled = false
            } else {
                self.isUserInteractionEnabled = true
            }
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.world = nil
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.world = nil
        self.setup()
    }
    

    private func setup() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
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
                cell.frame = cellFrame
                var color: UIColor!
                switch cell.state {
                case .alive:
                    color = .green
                    break
                
                case .dead:
                    color = .black
                    break
            
                default:
                    color = .black
                }
                context.setFillColor(color.cgColor)
                       context.setStrokeColor(UIColor.black.cgColor)
                context.addRect(cellFrame)
         
                context.fillPath()
            }
            UIGraphicsEndImageContext()
        }
    }
    
    func worldOfWarcraftNewRound(_ worldOfWarcraft: WorldOfWarcraft) {
        self.setNeedsDisplay()
    }
    
    func handleTap(_ tapRecognizer: UITapGestureRecognizer) {
        
        guard  let world = self.world else {
            return
        }
        
        let touchPoint = tapRecognizer.location(in: self)
        
        
        for cell in world.cells {
            if (cell.frame.contains(touchPoint)) {
                if cell.state == .alive {
                    cell.state = .dead
                } else {
                    cell.state = .alive
                }
                self.setNeedsDisplay()
                break
            }
        }
    }
}

//
//  ViewController.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paletteView: PaletteView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let world = WorldOfWarcraft()
        world.setup()
        self.paletteView.world = world
        
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


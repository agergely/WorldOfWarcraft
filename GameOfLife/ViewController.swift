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
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var playModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dimensionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let world = WorldOfWarcraft()
        world.dimension = 20
        self.dimensionTextField.text = String(world.dimension)
        world.delegate = self.paletteView
        self.paletteView.world = world
        
        self.dimensionTextField.inputAccessoryView = self.dimensionTextField.getDoneTooolbar()
                
    }

    @IBAction func calculateButtonPressed(_ sender: Any) {
        self.paletteView.world?.startIterate()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        self.calculateButton.isEnabled = true
          }
    
    
    @IBAction func playmodeChanged(_ sender: Any) {
        if self.playModeSegmentedControl.selectedSegmentIndex == 0 {
            self.paletteView.world?.playMode = .manual
            self.paletteView.isUserInteractionEnabled = true
            self.calculateButton.isHidden = false
        } else {
            self.paletteView.world?.playMode = .auto
            self.paletteView.isUserInteractionEnabled = false
            self.calculateButton.isHidden = true
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
         self.paletteView.world?.startIterate()
        if startButton.titleLabel?.text == "Start" {
            startButton.setTitle("Stop", for: .normal)
            self.calculateButton.isEnabled = true
            self.dimensionTextField.isEnabled = false
        } else {
            self.paletteView.world?.reset()
            startButton.setTitle("Start", for: .normal)
            if self.paletteView.world!.playMode == .manual {
                self.calculateButton.isEnabled = false
                self.dimensionTextField.isEnabled = true
            }
        }
    }
    @IBAction func dimensionValueChanged(_ sender: Any) {
        if let value = self.dimensionTextField.text {
            self.paletteView.world?.dimension = Int(value)
        } else {
            self.paletteView.world?.dimension = 0
        }
    }
}


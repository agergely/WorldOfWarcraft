//
//  UITextField+DoneButton.swift
//  GameOfLife
//
//  Created by Adam Gergely on 2/1/17.
//  Copyright © 2017 OTT-ONE. All rights reserved.
//

import UIKit

extension UITextField {

public func getDoneTooolbar() -> UIToolbar {
    let screenWidth = UIScreen.main.bounds.width
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    toolbar.barStyle = .default
    let barButtonDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(close(_:)))
    barButtonDone.tintColor = .black
    toolbar.items = [barButtonDone]
    return toolbar
}


    @IBAction private func close(_ sender: AnyObject) {
        self.endEditing(true)
    }


}

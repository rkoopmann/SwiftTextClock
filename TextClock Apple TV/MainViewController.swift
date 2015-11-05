//
//  MainViewController.swift
//  TextClock
//
//  Created by Michael Teeuw on 05-11-15.
//  Copyright © 2015 Michael Teeuw. All rights reserved.
//

import UIKit

class MainViewController: ViewController {

    /**
     Add the constraints to the textClockView to make it a square in the center.
     It uses some heavy AutoLayout Magic. Whenever the screen size changes, everything remains ok.
     Of course, there is a much simpeler way to do this, but I just wanted to demonstrate the possibility ... :)
     */
    override func addConstraints() {
        
        // Set Padding value
        let SCREEN_PADDING:CGFloat = 75
        
        //Disable the automatic constraints
        textClockView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints([
            NSLayoutConstraint(item: textClockView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: (0 - SCREEN_PADDING * 2)),
            NSLayoutConstraint(item: textClockView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: (0 - SCREEN_PADDING * 2)),
            NSLayoutConstraint(item: textClockView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textClockView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
        ])
        
    }
        

}

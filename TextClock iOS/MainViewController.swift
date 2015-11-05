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
        let SCREEN_PADDING:CGFloat = 20
        
        // Disable the automatic constraints
        textClockView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the contraints to make the width less than or equal of the height of the superview and vice versa
        view.addConstraint(NSLayoutConstraint(item: textClockView, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: view, attribute: .Width, multiplier: 1, constant: (0 - SCREEN_PADDING * 2)))
        view.addConstraint(NSLayoutConstraint(item: textClockView, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: view, attribute: .Height, multiplier: 1, constant: (0 - SCREEN_PADDING * 2)))
        
        // Set the height en width, but use a lower priority then above layout constraints
        // Usign this technique, it will always be a fitting square
        let widthConstraint = NSLayoutConstraint(item: textClockView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: (0 - SCREEN_PADDING * 2))
        let heightConstraint = NSLayoutConstraint(item: textClockView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: (0 - SCREEN_PADDING * 2))
        widthConstraint.priority -= 1
        heightConstraint.priority -= 1
        view.addConstraints([widthConstraint, heightConstraint])
        
        // Center the TextClockView
        view.addConstraint(NSLayoutConstraint(item: textClockView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: textClockView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }

}

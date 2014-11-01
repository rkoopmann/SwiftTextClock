//
//  ViewController.swift
//  SwiftTextClock
//
//  Created by Michael Teeuw on 01-11-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let SCREEN_PADDING:CGFloat = 20 // set this to change the margin around the clock
    let textClockView = TextClockView()
    
    /**
    Do we want to show the status bar?
    
    @return bool defining the prefered hidden status
    */
    override func prefersStatusBarHidden() -> Bool {
        
        //disable the status bar
        return true
        
    }
    
    /**
    What to do when the view controller is loaded?
    */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set the background color of the application
        view.backgroundColor = UIColor.blackColor()
    
        // Add the TextClockView to the main view
        view.addSubview(textClockView)

        // Add the constraints to make is a square in the center
        addConstraints()
    
        // Create a timer to update it every second
        NSTimer.scheduledTimerWithTimeInterval(1, target: textClockView, selector: "update", userInfo: nil, repeats: true)
        
    }

    /**
    Add the constraints to the textClockView to make it a square in the center. 
    It uses some heavy AutoLayout Magic. Whenever the screen size changes, everything remains ok.
    */
    func addConstraints() {
        
        //Disable the automatic constraints
        textClockView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
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


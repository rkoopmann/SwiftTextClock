//
//  ViewController.swift
//  SwiftTextClock
//
//  Created by Michael Teeuw on 01-11-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Set config constants
    let SCREEN_PADDING:CGFloat = 20 // set this to change the margin around the clock
    let GESTURE_FACTOR:CGFloat = 2  // set this to change the factor of the gesture movement
    
    // Create the TextClockView.
    let textClockView = TextClockView()
    
    // Create the getter and setter for the background color hue
    var hue : CGFloat {
        get {
            // return the hue from the stored user defaults, or fall back to the default of 0.
            return NSUserDefaults.standardUserDefaults().objectForKey("HUE_VALUE") as? CGFloat ?? 0
        }
        set (newValue) {
            // if a new hue value is set, store it in the user defaults.
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "HUE_VALUE")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    // create the getter and setter for the background color brightness
    var brightness : CGFloat {
        get {
            // return the brightness from the stored user defaults, or fall back to the default of 0.
            return NSUserDefaults.standardUserDefaults().objectForKey("BRIGHTNESS_VALUE") as? CGFloat ?? 0
        }
        set (newValue) {
            // if a new brightness value is set, store it in the user defaults.
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "BRIGHTNESS_VALUE")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

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
        updateBackgroundColor()
    
        // Add the TextClockView to the main view
        view.addSubview(textClockView)

        // Add the constraints to make is a square in the center
        addConstraints()
    
        // Create a timer to update it every second
        NSTimer.scheduledTimerWithTimeInterval(1, target: textClockView, selector: "update", userInfo: nil, repeats: true)
        
        // Add gesture recognizer and bind it to the appropriate method
        let gesture = UIPanGestureRecognizer(target: self, action: "gestureRecognized:")
        view.addGestureRecognizer(gesture)
        
    }

    /**
    Add the constraints to the textClockView to make it a square in the center. 
    It uses some heavy AutoLayout Magic. Whenever the screen size changes, everything remains ok.
    Of course, there is a much simpeler way to do this, but I just wanted to demonstrate the possibility ... :)
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
    
    // MARK: - Background Color Methods
    
    /**
    The method that will be triggered if a Pan Gesture is recognized.
    
    @param gesture:UIPanGestureRecognizer       The gesture recognizer that triggers the method.
    */
    func gestureRecognized(gesture:UIPanGestureRecognizer) {
        
        // Get the translation in the current view.
        let translation = gesture.translationInView(view)
        
        // Update the brightness and hue depending on the movement in the view.
        brightness += CGFloat(-translation.y / view.bounds.width / GESTURE_FACTOR)
        hue += CGFloat(translation.x / view.bounds.height / GESTURE_FACTOR)
        
        // If the hue is larger than 1, substract 1.
        if (hue > 1) {
            hue -= 1
        }

        // If the hue is smaller than 0, add 1.
        if (hue < 0) {
            hue += 1
        }
        
        // If the brightness is larger than 1, reset the value to 1.
        if (brightness > 1) {
            brightness = 1
        }
        
        // If the brightness is smaller than 0, reset the value to 0.
        if (brightness < 0) {
            brightness = 0
        }
        
        // Update the background color.
        updateBackgroundColor()
        
        // Reset the translation in the view.
        gesture.setTranslation(CGPointZero, inView: view)
    }
    
    /** 
    Update the view based on the hue and brightness
    */
    func updateBackgroundColor() {
        view.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: brightness, alpha: 1)
    }

}


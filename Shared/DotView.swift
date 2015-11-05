//
//  DotView.swift
//  SwiftTextClock
//
//  Created by Michael Teeuw on 05-11-15.
//  Copyright © 2015 Michael Teeuw. All rights reserved.
//

import UIKit

class DotView: UIView {
    
    var color = UIColor.whiteColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup();
    }
    
    override func drawRect(rect: CGRect) {
        
        let diameter = min(self.frame.size.width, self.frame.size.height) / 2
        
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: diameter, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)

        color.setFill()
        path.fill()
        
    }
    
    private func setup() {
        backgroundColor = UIColor.clearColor()
    }

}

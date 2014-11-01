//
//  CharacterView.swift
//  SwiftTextClock
//
//  Created by Michael Teeuw on 01-11-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class CharacterView: UILabel {
    
    let FONT_SIZE_FACTOR:CGFloat = 0.75 // Change the size of the text. 1 = the same size as the square of the character.

    /**
    Overwrite the initialisers. Two of them will start the setup.
    */
    override init()
    {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup();
    }
    
    /**
    Setup this view.
    */
    func setup() {
        // Align the text to the center
        self.textAlignment = NSTextAlignment.Center
    }
    
    /**
    If the size of the view changes, update the size of the text.
    */
    override func layoutSubviews() {
        let size = (bounds.width > bounds.height) ? bounds.height : bounds.width
        self.font = UIFont(name: "DINAlternate-Bold", size: size * FONT_SIZE_FACTOR);
    }
}

//
//  NavBar.swift
//  watermelon-tapper
//
//  Created by James Tuttle on 5/15/16.
//  Copyright © 2016 James Tuttle. All rights reserved.
//

import UIKit

class NavBar: UIView {
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 0.0
        //102, 204, 255
        //#66CCFF
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 3.0)
        
    }
}

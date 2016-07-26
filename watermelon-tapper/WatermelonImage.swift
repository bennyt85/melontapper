//
//  WatermelonImage.swift
//  watermelon-tapper
//
//  Created by James Tuttle on 5/29/16.
//  Copyright © 2016 James Tuttle. All rights reserved.
//

import UIKit


class WatermelonImage: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func playEatWatermelon() {
        self.image = UIImage(named: "watermelon2.png")
        
        self.animationImages = nil
 
        var imagArray = [UIImage]()
        for x in 2...6 {
            let img = UIImage(named: "watermelon\(x).png")
            imagArray.append(img!)
        }
        
        // Set image animation properties
        self.animationImages = imagArray
        self.animationDuration = 3.0
        self.animationRepeatCount = 3
        self.startAnimating()
        
    }
    
}

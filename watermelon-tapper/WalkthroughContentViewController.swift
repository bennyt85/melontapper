//
//  WalkthroughContentViewController.swift
//  watermelon-tapper
//
//  Created by James Tuttle on 7/13/16.
//  Copyright © 2016 James Tuttle. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    
    var index = 0
    var heading = ""
    var content = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLbl.text = heading
        contentLbl.text = content
        contentImage.image = UIImage(named: imageFile)
        
    }



}

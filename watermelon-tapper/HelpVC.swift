//
//  HelpVC.swift
//  watermelon-tapper
//
//  Created by James Tuttle on 5/15/16.
//  Copyright © 2016 James Tuttle. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //****************************************
    // This is DRY code, will need to change
    //****************************************
    override func viewWillAppear(_ animated: Bool) {
        // NavigationItem and Controller properties set
        self.navigationItem.title = NavTitle
        self.navigationController!.navigationBar.tintColor = NavButton
        self.navigationItem.backBarButtonItem = NavLeftBackBtn
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    


    }
}

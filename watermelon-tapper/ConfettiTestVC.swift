//
//  ViewController.swift
//  ConfettiTestVC
//
//  Created by James Tuttle on 7/25/16.
//  Copyright © 2016 James Tuttle. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import SAConfettiView


class ViewController: UIViewController {
    
    
    var avPlayer: AVAudioPlayer!
    var confiettiView: SAConfettiView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    func playSound() {
        
        let path = Bundle.main.pathForResource("5-Sec-Crowd-Cheer", ofType:"mp3")!
        let url = NSURL(fileURLWithPath: path)
        
        var err: NSError?
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url as URL)
            avPlayer = sound
            sound.play()
        } catch  {
            print(err.debugDescription)
        }
    }
    
    
    func confettiAnimantion() {
        
        confiettiView = SAConfettiView(frame: self.view.bounds)
        self.view.addSubview(confiettiView)
        confiettiView.startConfetti()
        
    }
    
    func playConfettiTEST() {
   
        
        var imageView = UIImageView(frame: CGRect(x: 60, y: -140, width: 150 , height: 150))
        imageView.image = UIImage(named: "logo4forWeb")
        
        let alertController = UIAlertController(title: "Great find!", message: "Melon is good!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true) {
            
            // closure to stop confetti animation as alert is dismissed
            self.confiettiView.stopConfetti()
        }
        
        
        alertController.view.addSubview(imageView)
        
        
        playSound()
        confettiAnimantion()
    }
    
}

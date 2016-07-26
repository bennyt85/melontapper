//
//  HomeVC.swift
//  watermelon-tapper
//
//  Created by James Tuttle on 5/20/16.
//  Copyright © 2016 James Tuttle. All rights reserved.
//


import UIKit
import AVFoundation
import MessageUI
import SAConfettiView

class HomeVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate, MFMailComposeViewControllerDelegate {

    
    
    
    // MARK: - %% TEMP %%% --- Using labels for debug readings on beta app
    @IBOutlet weak var dbLinearOutputLbl: UILabel!
    @IBOutlet weak var dbLinearOutputLABEL: UILabel!
    
    @IBOutlet weak var dbOutputLABEL: UILabel!
    @IBOutlet weak var dbOutputLbl: UILabel!
    
    @IBOutlet weak var numberOfSamplesLABEL: UILabel!
    @IBOutlet weak var numberOfSampleLbl: UILabel!
    
    @IBOutlet weak var averageDbLbl: UILabel!
    @IBOutlet weak var avergaeDbLABEL: UILabel!
    
    @IBOutlet weak var dbAvgTotalLbl: UILabel!
    @IBOutlet weak var dbAvgTotalLABEL: UILabel!
    
    @IBOutlet weak var dbgSwitch: UISwitch!
    @IBOutlet weak var listenBUTTON: UIButton!
    // %% END Temp
    
    
    // MARK: - Properties
    
    @IBOutlet weak var breifInstructionsLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var handBtn: UIButton!
    @IBOutlet weak var watermelonImage: WatermelonImage!
    
    var soundRecorder: AVAudioRecorder!
    var SoundPlayer: AVAudioPlayer!
    var confiettiView: SAConfettiView!
    
    var AudioFileName = "sound.m4a"
    
    var levelTimer = Timer()
    
    var alert = SweetAlert()
    
    var soundTotal: Float = 0.0
    var hitTotal: Float = 0.0
    var soundTotals: Float = 0.0

    
    let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),
                          AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),
                          AVNumberOfChannelsKey : NSNumber(value: 1),
                          AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]
    
    // MARK: - View Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Hide watermelon image at startup
        self.watermelonImage.isHidden = true
        dbgSwitchOff()
        setupRecorder()
        breifInstructionsLbl.text = BREIF_INSTRUCTIONS
        
    }

    //-------------------------------------------------------------------
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        if let pageViewController =
//            storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController")
//                as? WalkthroughPageVC {
//            presentViewController(pageViewController, animated: true, completion:
//                nil)
//        }
//    }
    //-------------------------------------------------------------------
    
    
    // MARK: - Functions
    
    func isFirstTimeAppRan() -> Bool {
        
        let userDefaults = UserDefaults.standard
        
        if let isFirstTimeAppRan = userDefaults.string(forKey: "isFirstTimeAppRan") {
            print("APP ALREADY LUANCHED FOR THE FIRST TIME!")
            return true
        } else {
            
            userDefaults.set(true, forKey: "isFirstTimeAppRan")
            
            let userDefaults: UserDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "isFirstTimeAppRan")
            
            userDefaults.synchronize()
            
            // Launch TutorialVC
            return false
        }
    }
    
       override func viewWillAppear(_ animated: Bool) {
            // NavigationItem and Controller properties set
            self.navigationItem.title = NavTitle
            self.navigationController!.navigationBar.tintColor = NavButton
            self.navigationItem.backBarButtonItem = NavLeftBackBtn
            self.navigationController?.navigationBar.titleTextAttributes = attributes
    
    }
    
    func preparePlayer(){
        
        do {
            try SoundPlayer = AVAudioPlayer(contentsOf: directoryURL()!)
            SoundPlayer.delegate = self
            SoundPlayer.prepareToPlay()
            SoundPlayer.volume = 1.0
        } catch {
            print("Error playing")
        }
        
    }
    
    func setupRecorder(){
        
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //ask for permission
        if (audioSession.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("Permission Granted\n")
                    
                    //set category and activate recorder session
                    do {
                        //----
                        let fileManager = FileManager.default
                        let urls = fileManager.urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)
                        //----
                        let documentDirectory = urls[0] as URL
                        let soundURL = try! documentDirectory.appendingPathComponent("sound.m4a")
                        
                        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                        
                        try self.soundRecorder = AVAudioRecorder(url: soundURL, settings: self.recordSettings)
                        
                       let micInput = try AVAudioRecorder(url
                        : soundURL, settings: self.recordSettings)
                        
                        
                        self.soundRecorder.prepareToRecord()
                        self.soundRecorder.updateMeters()
                        
                        
                        
                    } catch {
                        
                        print("Error Recording");
                        
                    }
                    
                }
            })
        }
        
    }
    
    
    func recordTimer() {
        /* After 5 seconds, let's stop the recording process */
        let delayInSeconds = 10.0
        let delayInNanoSeconds = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.after(when: delayInNanoSeconds, execute: {
            self.soundRecorder!.stop()
            self.handBtn.isHidden = false
            self.messageLbl.text = "Tap Hand to Start"
            self.messageLbl.font = UIFont(name:"AppleGothic" , size: 22)
            self.watermelonImage.isHidden = true
            self.breifInstructionsLbl.isHidden = false
            self.breifInstructionsLbl.text = BREIF_INSTRUCTIONS
            
            //BREIF_INSTRUCTIONS
            
            // Call decision function / good or bad?
           //------> self.decisionMaker(self.soundTotal, hits: self.hitTotal)
            
        })
        
    }


     
    func directoryURL() -> URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)
        let documentDirectory = urls[0] as URL
        let soundURL = try! documentDirectory.appendingPathComponent("sound.m4a")
        return soundURL
    }


    
    func listner() {
        // hide static UI
        self.messageLbl.text = "Listening..."
        self.handBtn.isHidden = true
        watermelonImage.isHidden = false
        breifInstructionsLbl.isHidden = true
        
        //clear label values
        dbAvgTotalLbl.text = "0.0"
        averageDbLbl.text = "0.0"
        numberOfSampleLbl.text = "0.0"
        
        // start animation
        watermelonImage.playEatWatermelon()
        
    }

    func gatherInput() {
        
        
        soundRecorder.isMeteringEnabled = true
        
      
        //instantiate a timer to be called with whatever frequency we want to grab metering values
        self.levelTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(HomeVC.levelTimerCallback), userInfo:nil, repeats: true)
 
        
        if !levelTimer.isValid {
            print("TIMER STILL RUNNING...")
            
        } else {
            
            print("*******++++++++++ ELSE FOR: if !levelTimer.valid ++++++++********")
            
        }
        
        
    }

    
    func decisionMaker(_ dbAverage: Float, hits: Float) {
       // soundTotals = totalHits / soundTotals
        
        if  soundTotal >= 24.99  {
            
            // good watermelon
            // alert user
            SweetAlert().showAlert("Congrats, it's Good!", subTitle: "Enjoy!", style: AlertStyle.none)
        
        } else {
            
            //watermelon is bad
            // alert user on try again
            SweetAlert().showAlert("This Watermelon is Bad!", subTitle: "Please choose another one", style: AlertStyle.none)
        }
     
    }

    // -----------------------------------------------------------------------------
    // This selector/function is called every time our timer (levelTimer) fires
    // -----------------------------------------------------------------------------
    
    func levelTimerCallback() {
        
        //update meters before getting the metering values
        soundRecorder.updateMeters()
        
        // ---- test db for every pass  --------------------------------------------
        
        var dbTEST: Float = 0.0
        dbTEST = soundRecorder.averagePower(forChannel: 0)
        
        // --------------------------------------------------------------------------
        
        var dBValue: Float = 0.0
        let linearValue: Float = pow(10, (0.05 * soundRecorder.averagePower(forChannel: 0)))
        
        dBValue = soundRecorder.averagePower(forChannel: 0)
        
            //print to the console if we are beyond a threshold value.
            if soundRecorder.averagePower(forChannel: 0) > -30
            {
                dBValue = 20 * (log10(abs(dBValue)))
                
                soundTotal = soundTotal + dBValue
                hitTotal = hitTotal + 1
                
                // label print info
                dbOutputLbl.text = "\(dBValue)"
                dbLinearOutputLbl.text = "\(linearValue)"
                averageDbLbl.text = "\(soundTotal)"
                
                soundTotals = (soundTotal / hitTotal)
                
                dbAvgTotalLbl.text = "\(soundTotals)"
                numberOfSampleLbl.text = "\(hitTotal)"
                
                // DEBUG PRINT info \\\\\\\\\\\\\\\\\\\\\\\
                print("[METHOD START")
                print(" ")
                print("1.1 - dB Value Equivalent: \(abs(dBValue))")
                print(" ")
                print("1.3 - Linear Value Equivalent : \(linearValue)")
                print(" ")
                print("Sound Total: \(soundTotal)")
                print("Total Hits: \(hitTotal)")
                print("-------------------- END METHOD ------------------------")
                print(" ")
                
            }
    }
    

    func dbgSwitchOn() {
        dbLinearOutputLbl.isHidden = false
        dbLinearOutputLABEL.isHidden = false
        averageDbLbl.isHidden = false
        avergaeDbLABEL.isHidden = false
        dbOutputLbl.isHidden = false
        dbOutputLABEL.isHidden = false
        listenBUTTON.isHidden = false
        dbAvgTotalLABEL.isHidden = false
        dbAvgTotalLbl.isHidden = false
        numberOfSamplesLABEL.isHidden = false
        numberOfSampleLbl.isHidden = false
        breifInstructionsLbl.isHidden = true
        
    }
    
    func dbgSwitchOff() {
        
        dbLinearOutputLbl.isHidden = true
        dbLinearOutputLABEL.isHidden = true
        averageDbLbl.isHidden = true
        avergaeDbLABEL.isHidden = true
        dbOutputLbl.isHidden = true
        dbOutputLABEL.isHidden = true
        listenBUTTON.isHidden = true
        dbAvgTotalLABEL.isHidden = true
        dbAvgTotalLbl.isHidden = true
        numberOfSamplesLABEL.isHidden = true
        numberOfSampleLbl.isHidden = true
        breifInstructionsLbl.isHidden = false
    }
    
    // MARK: - Email Funcs
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["melontapper@gmail.com"])
            mail.setSubject("Feedback Results")
            
            let eMailMsg = "<html><body><p>Here is my last melon test.</p> <p><b>Total db: </b>\(soundTotal)</p><p><b>Total # of samples: </b>\(hitTotal)</p><p><b>dB: </b> \(soundTotals)</p><p><b>Melon was: </b><input type='checkbox' name='results' value='good'> Ripe     <input type='checkbox' name='results' value='bad'>Not Ripe<br></P></body></html>"
            
            mail.setMessageBody(eMailMsg, isHTML: true)
            
            present(mail, animated: true, completion: nil)
            
        } else {
            
            // show failure alert
            let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func clearGlobalVariablesOnTap() {
        self.hitTotal = 0
        self.soundTotal = 0
        self.soundTotals = 0
    }

    
    func playCheer() {
        
        let path = Bundle.main.pathForResource("5-Sec-Crowd-Cheer", ofType:"mp3")!
        let url = NSURL(fileURLWithPath: path)
        
        var err: NSError?
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url as URL)
            SoundPlayer = sound
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


    
    
    // MARK: - Actions
    
    @IBAction func debugSwitch(_ sender: UISwitch) {
        
        if dbgSwitch.isOn == true {
            dbgSwitchOn()
            
        } else {
            dbgSwitchOff()
        
        }
    }
    
    @IBAction func emailResultsTapped(_ sender: AnyObject) {
    sendEmail()
        
    }
    
    @IBAction func handTapped(_ sender: UIButton) {
        
        clearGlobalVariablesOnTap()
        listner()
        soundRecorder.record()
        recordTimer()
        gatherInput()
        
    }
    @IBAction func playTapped(_ sender: AnyObject) {
        
        preparePlayer()
        SoundPlayer.play()
    }
    
    @IBAction func ConfettiTEST(_ sender: AnyObject) {
        
        var imageView = UIImageView(frame: CGRect(x: 60, y: -150, width: 150 , height: 150))
        imageView.image = UIImage(named: "logo4forWeb")
        
        let alertController = UIAlertController(title: "Great find!", message: "Melon is good!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true) {
            
            // closure to stop confetti animation as alert is dismissed
            self.confiettiView.stopConfetti()
        }
        
        
        alertController.view.addSubview(imageView)
        
        
        
        playCheer()
        confettiAnimantion()
    }
}





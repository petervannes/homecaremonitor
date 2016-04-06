//
//  ViewController.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 01-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var sortOnSeverityButton: UIButton!
    @IBOutlet weak var sortOnTimeButton: UIButton!
    
    // severity button
    let severityButtonAnimSteps :Int = 20
    var severityButtonAnimStep = 0
    let severityButtonAnimBasename :String = "severity_"
    var severitySort = "up" // up | down
    var severityButtonTimer = NSTimer.init()
    let severityButtonTimeInterval: NSTimeInterval = 0.02
    
    
    let timeButtonAnimSteps :Int = 20
    var timeButtonAnimStep :Int = 0
    let timeButtonForwAnimBasename = "timeforward_"
    let timeButtonBackwAnimBasename = "timebackward_"
    var timeSort = "forward"   // forward | backward
    var timeButtonTimer = NSTimer()
    let timeButtonTimeInterval: NSTimeInterval = 0.5
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        var images = NSBundle.mainBundle().pathsForResourcesOfType("time*.png", inDirectory: "")
//        
//        print("images found: \(images.count)")
//        for image in images {
//            print("\(image)")
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

//    func animateButton(button :UIButton, step :Int, maxSteps: Int, basename: String ) {
    func animateButton() {
        
        if (severitySort == "down") {
            severityButtonAnimStep += 1
        } else {
            severityButtonAnimStep -= 1
        }
        
        if (severityButtonAnimStep == severityButtonAnimSteps) {
            severityButtonTimer.invalidate()
        }

        if (severityButtonAnimStep == 0) {
            severityButtonTimer.invalidate()
        }

        print("image severityButtonAnimBasename_\(String(format:"%02i",severityButtonAnimStep))")

        if let image = UIImage(named: String(severityButtonAnimBasename) + String(format:"%02i",severityButtonAnimStep)) {
            sortOnSeverityButton.setImage(image, forState: .Normal)
        }
        
        
    }

    
    
    
    @IBAction func sortOnSeverityButtonTouchInside(sender: UIButton) {

        
        let dictionary: [String : AnyObject] = ["Button" : sortOnSeverityButton,
                                                "start": 0,
                                                "stop": 20,
                                                "basefilename": severityButtonAnimBasename,
                                                "timer": severityButtonTimer]
        
        
     
        // Change sort order
        if (severitySort == "up") {
            severitySort = "down"
        } else {
            severitySort = "up"
        }

        // Start animation
       // let sevButtonAnimD§ict = timer.userInfo as NSDictionary
        if (!severityButtonTimer.valid) {
            print("Timer sortOnSeverityButtonTouchInside")
            
        //    let buttonAnimation :ButtonAnimation = ButtonAnimation(arguments: dictionary)!

//            severityButtonTimer = NSTimer.scheduledTimerWithTimeInterval(severityButtonTimeInterval, target: buttonAnimation , selector: #selector(ButtonAnimation.animateButton), userInfo: nil, repeats: true)
            
            severityButtonTimer = NSTimer.scheduledTimerWithTimeInterval(severityButtonTimeInterval, target: self , selector: #selector(ButtonAnimation.animateButton), userInfo: dictionary, repeats: true)
        
            
            //        severityButtonTimer = NSTimer.scheduledTimerWithTimeInterval(severityButtonTimeInterval, target: self, selector: #selector(ViewController.animateButton), userInfo: nil, repeats: true)
            //            severityButtonTimer = NSTimer.scheduledTimerWithTimeInterval(severityButtonTimeInterval, target: ButtonAnimation.self(arguments: dictionary) , selector: #Selector("add"), userInfo: nil, repeats: true)
        
        
    }
        
    }
    
    
    @IBAction func sortOnTimeButtonTouchInside(sender: UIButton) {
        
        
    }
    
    
    


}


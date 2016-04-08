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
    let severityButtonAnimBasename :String = "severity_"
    var severitySort = "up" // up | down
    var severityButtonTimer = HCTimerWrapper()
    let severityButtonTimeInterval: NSTimeInterval = 0.02
    
    
    let timeButtonForwAnimBasename = "timeforward_"
    let timeButtonBackwAnimBasename = "timebackward_"
    var timeSort = "forward"   // forward | backward
    var timeButtonTimer = HCTimerWrapper()
    let timeButtonTimeInterval: NSTimeInterval = 0.02
    
    
    
    
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
    

    
    @IBAction func sortOnSeverityButtonTouchInside(sender: UIButton) {
        
        var dictionary: [String : AnyObject] = [:]
                print("first line")
//        let pausableTimer = severityButtonTimer
 
        
        // Start animation if none running
        if (!severityButtonTimer.valid) {
            // Change sort order
            if (severitySort == "up") {
                severitySort = "down"
                dictionary = ["Button" : sortOnSeverityButton,
                              "start": 0,
                              "stop": 20,
                              "basefilename": severityButtonAnimBasename,
                              "crossfade": false,
                              "timer": severityButtonTimer]
            } else {
                severitySort = "up"
                dictionary = ["Button" : sortOnSeverityButton,
                              "start": 20,
                              "stop": 0,
                              "basefilename": severityButtonAnimBasename,
                              "crossfade": false,
                              "timer": severityButtonTimer]
            }
            
            let buttonAnimation :ButtonAnimation = ButtonAnimation()
            
//            severityButtonTimer = NSTimer.scheduledTimerWithTimeInterval(severityButtonTimeInterval, target: buttonAnimation , selector: #selector(ButtonAnimation.self.animateButton), userInfo: dictionary, repeats: true)

            severityButtonTimer.pausableScheduledTimerWithTimeInterval(severityButtonTimeInterval, target: buttonAnimation , selector: #selector(ButtonAnimation.self.animateButton), userInfo: dictionary, repeats: true)
            
        }
        
    }
    
    
    @IBAction func sortOnTimeButtonTouchInside(sender: UIButton) {

        var dictionary: [String : AnyObject] = [:]
      //  let pausableTimer = severityButtonTimer
        
        // Start animation if none running
        if (!timeButtonTimer.valid) {
            // Change sort order
            if (timeSort == "forward") {
                timeSort = "backward"
                dictionary = ["Button" : sortOnTimeButton,
                              "start": 0,
                              "stop": 20,
                              "basefilename": timeButtonBackwAnimBasename,
                              "crossfade": true,
                              "timer": timeButtonTimer]
            } else {
                timeSort = "forward"
                dictionary = ["Button" : sortOnTimeButton,
                              "start": 0,
                              "stop": 20,
                              "basefilename": timeButtonForwAnimBasename,
                              "crossfade": true,
                              "timer": timeButtonTimer]
            }
            
            let buttonAnimation :ButtonAnimation = ButtonAnimation()
            
            timeButtonTimer.pausableScheduledTimerWithTimeInterval(timeButtonTimeInterval, target: buttonAnimation , selector: #selector(ButtonAnimation.self.animateButton), userInfo: dictionary, repeats: true)
            
        }
        
    }
    
    
    


}


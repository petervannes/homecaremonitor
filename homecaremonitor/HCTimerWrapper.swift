//
//  HCTimerWrapper.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 08-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import Foundation
import UIKit

class HCTimerWrapper {
    
    var hcTimerInterval :NSTimeInterval!
    var hcTarget :AnyObject!
    var hcSelector :Selector!
    var hcUserInfo :AnyObject!
    var hcRepeats :Bool!
    var hcTimer :NSTimer!
    var valid : Bool {
        get {
            if hcTimer != nil  {
                return hcTimer.valid
            } else {
                return false
            }
        }
    }
    
    
    func pausableScheduledTimerWithTimeInterval(ti: NSTimeInterval, target aTarget: AnyObject, selector aSelector: Selector, userInfo: AnyObject?, repeats yesOrNo: Bool) {
        
        let hcInstanceTimer = NSTimer.scheduledTimerWithTimeInterval(ti,target: aTarget, selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
        
        self.hcTimerInterval = ti
        self.hcTarget = aTarget
        self.hcSelector = aSelector
        self.hcUserInfo = userInfo!
        self.hcRepeats = yesOrNo
        self.hcTimer = hcInstanceTimer
        
    }
    
    
    func pause() {
        
        self.hcTimer.invalidate()
    }
    
    func resume() {
        
        self.hcTimer = NSTimer.scheduledTimerWithTimeInterval(self.hcTimerInterval, target: self.hcTarget, selector: self.hcSelector, userInfo: self.hcUserInfo, repeats: self.hcRepeats)
    }
    
    
}




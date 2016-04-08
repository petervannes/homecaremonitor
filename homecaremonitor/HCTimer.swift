//
//  HCTimer.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 07-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import CoreFoundation
import CoreGraphics
import Darwin
import Foundation


class HCTimer: NSTimer {

    var hcTimerInterval :NSTimeInterval!
    var hcTarget :AnyObject!
    var hcSelector :Selector!
    var hcUserInfo :AnyObject!
    var hcRepeats :Bool!
    var hcTimer :HCTimer!
    
    class func pausableScheduledTimerWithTimeInterval(ti: NSTimeInterval, target aTarget: AnyObject, selector aSelector: Selector, userInfo: AnyObject?, repeats yesOrNo: Bool) -> HCTimer {
        
        let hcInstanceTimer = super.scheduledTimerWithTimeInterval(ti,target: aTarget, selector: aSelector, userInfo: userInfo, repeats: yesOrNo) as! HCTimer
        
        hcInstanceTimer.hcTimerInterval = ti
        hcInstanceTimer.hcTarget = aTarget
        hcInstanceTimer.hcSelector = aSelector
        hcInstanceTimer.hcUserInfo = userInfo!
        hcInstanceTimer.hcRepeats = yesOrNo
        hcInstanceTimer.hcTimer = hcInstanceTimer
        
        return hcInstanceTimer
    }
    
    func pause() {
        
        self.invalidate()
    }
    
    func resume() {
        
        self.hcTimer = HCTimer.pausableScheduledTimerWithTimeInterval(hcTimerInterval, target: hcTarget, selector: hcSelector, userInfo: hcUserInfo, repeats: hcRepeats)
    }
    
    func isValid() -> BooleanType {
        
        print ("IS VALID \(self.hcTimer)")
        return self.hcTimer != nil
        
    }
    
    

}


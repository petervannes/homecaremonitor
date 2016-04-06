//
//  ButtonAnimation.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 06-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import Foundation
import UIKit


class ButtonAnimation {
    
    let animationButtion :UIButton!
    let animationLastStep : Int
    let animationStepIncrement : Int
    let timer : NSTimer
    let baseName : String
    var animationStep: Int
    
    
  //  required init?(arguments: [String : AnyObject]) {
    required init?(animationTimer: NSTimer) {
        
        self.timer = animationTimer
        let configuration: [String : AnyObject] = self.timer.userInfo as! [String : AnyObject]
        
            self.animationButtion =  configuration["Button"] as! UIButton
            self.animationLastStep = configuration["stop"] as! Int
            self.animationStep = configuration["start"] as! Int
           
        self.baseName = configuration["basefilename"] as! String
        
        if (self.animationLastStep > self.animationStep) {
            self.animationStepIncrement = 1
        } else { self.animationStepIncrement = -1 }
        
    }
    

    @objc
    func animateButton() {
        
        self.animationStep += self.animationStepIncrement
        
        if (self.animationStep == self.animationLastStep) {
            self.timer.invalidate()
        }
        
        print("image severityButtonAnimBasename_\(String(format:"%02i",self.animationStep))")
        
        if let image = UIImage(named: String(self.baseName ) + String(format:"%02i",self.animationStep)) {
            self.animationButtion.setImage(image, forState: .Normal)
        }
        
        
    }
    
        
    
    
}

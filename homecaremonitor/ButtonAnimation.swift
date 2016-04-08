//
//  ButtonAnimation.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 06-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import Foundation
import UIKit


@objc class ButtonAnimation : NSObject {
    
    var animationButton :UIButton!
    var animationLastStep : Int = 0
    var animationStepIncrement : Int = 0
    var timer : NSTimer!
    var baseName : String = ""
    var animationStep: Int = 0
    var startValue: Int = 0
    var pausableTimer: HCTimerWrapper!
    var crossfade: Bool = false
    
    
    @objc
    func animateButton(animationTimer: NSTimer) {
        
        if (self.timer == nil) {
            
            self.timer = animationTimer
                let configuration: [String : AnyObject] = self.timer.userInfo as! [String : AnyObject]
                    self.animationButton =  configuration["Button"] as! UIButton
                    self.animationLastStep = configuration["stop"] as! Int
                    self.animationStep = configuration["start"] as! Int
                    self.baseName = configuration["basefilename"] as! String
                    self.pausableTimer = configuration["timer"] as! HCTimerWrapper
                    self.crossfade = configuration["crossfade"] as! Bool
            
                    if (self.animationLastStep > self.animationStep) {
                        self.animationStepIncrement = 1
                    } else { self.animationStepIncrement = -1 }
            
            self.startValue = self.animationStep
            
        }
        

        print("ButtonAnimation animateButton")

  
        
        if (self.animationStep == self.animationLastStep) {
            //self.timer.invalidate()
            self.pausableTimer.pause()
        }
        
        print("image \(self.baseName)\(String(format:"%02i",self.animationStep))")
        
        if (self.animationStep == self.startValue && self.crossfade) {

            if let image = UIImage(named: String(self.baseName ) + String(format:"%02i",self.animationStep)) {
                self.animationButton.setImage(image, forState: .Normal)
            }
            
            self.pausableTimer.pause()
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.5)
            CATransaction.setCompletionBlock {
                 self.pausableTimer.resume()
                            }
            let transition = CATransition()
            transition.type = kCATransitionFade
//            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            self.animationButton.layer.addAnimation(transition, forKey: kCATransition)
            CATransaction.commit()
    //        self.pausableTimer.resume()
            
//            print("Animate")
//            self.pausableTimer.pause()
//            
//            UIView.animateWithDuration(0.2, animations: {
//                self.animationButton.alpha = CGFloat(0)
//                }, completion: {
//                    (value: Bool) in
//                    
//                    if let image = UIImage(named: String(self.baseName ) + String(format:"%02i",self.animationStep)) {
//                        self.animationButton.setImage(image, forState: .Normal)
//                    }
//                    
//                    UIView.animateWithDuration(0.2, animations: {
//                        self.animationButton.alpha = CGFloat(1)
//                    }, completion: {
//                                (value: Bool) in
//                                print("Animation Done!")
//                                self.pausableTimer.resume()
//                    })
//                    
//                })
    
        } else {
        
        if let image = UIImage(named: String(self.baseName ) + String(format:"%02i",self.animationStep)) {
            self.animationButton.setImage(image, forState: .Normal)
        }
        }
        
              self.animationStep += self.animationStepIncrement


    }
    
    


    
}

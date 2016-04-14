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
    var baseName : String = ""
    var animationStep: Int = 0
    var startValue: Int = 0
    var pausableTimer: HCTimerWrapper!
    var crossfade: Bool = false
    
    
    /*
     * Objective; Animate button
     * Invoke using NSTimer with
     *   - Using an instance of this class as the target
     *   - The method 'animateButton' as the selector e.g. #selector(ButtonAnimation.self.animateButton)
     *   - A dictionary containing the animation properties as userInfo
     *       Dictionary should have the following keys with corresponding types
     *         Button           UIButton
     *         start            Int
     *         stop             Int
     *         basefilename     String
     *         crossfade        Bool
     *         timer            HCTimerWrapper
     */
    
    @objc
    func animateButton(animationTimer: NSTimer) {
        
        // first invocation by NSTimer initializes properties
        if (self.pausableTimer == nil) {
            
            let configuration: [String : AnyObject] = animationTimer.userInfo as! [String : AnyObject]
            
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
        
        // Stop timer
        if (self.animationStep == self.animationLastStep) {
            self.pausableTimer.pause()
        }

        // If first animationstep and crossfade is selected
        if (self.animationStep == self.startValue && self.crossfade) {
            
            if let image = UIImage(named: String(self.baseName ) + String(format:"%02i",self.animationStep)) {
                self.animationButton.setImage(image, forState: .Normal)
            }
 
            // Pause Timer
            self.pausableTimer.pause()
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.5)
            CATransaction.setCompletionBlock {  // resume timer after animation
                self.pausableTimer.resume()
            }
            
            let transition = CATransition()
            transition.type = kCATransitionFade
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

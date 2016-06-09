//
//  CheatSheetController.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 07-06-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//


import UIKit
import AVFoundation
import CoreData


class CheetSheetViewController: UIViewController {
    
    
    @IBOutlet weak var remoteNotificationDeviceToken: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
      remoteNotificationDeviceToken.text = DeviceToken.sharedDeviceToken.token
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    
    
    
}
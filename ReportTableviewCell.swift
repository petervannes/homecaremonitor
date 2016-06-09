//
//  ReportTableviewCell.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 11-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import UIKit


class ReportTableviewCell : UITableViewCell {
    
    @IBOutlet weak var reportCellSeverityOutlet: UIImageView!
    @IBOutlet weak var reportCellDateTimeOutlet: UILabel!
    @IBOutlet weak var reportCellViewedIndicatorOutlet: UIImageView!
    @IBOutlet weak var reportCellCustomerLabelOutlet: UILabel!
    @IBOutlet weak var reportCell: UIView!
    @IBOutlet weak var reportCellInfoOutlet: UITextView!
    @IBOutlet weak var reportCelInfoMaskOutlet: UIView!
    
    var cellIsSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Internal border
        self.layer.borderColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0).CGColor
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 4.0
        
        
        
        // Delete autolayout constraints
        reportCell.translatesAutoresizingMaskIntoConstraints = false
        reportCellSeverityOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellDateTimeOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellInfoOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellViewedIndicatorOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellCustomerLabelOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCelInfoMaskOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        
        // viewed Indicator constraints
        let viewedIndicatorConstraints: [NSLayoutConstraint] = [
            reportCellViewedIndicatorOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -2),
            reportCellViewedIndicatorOutlet.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -2)
        ]
        NSLayoutConstraint.activateConstraints(viewedIndicatorConstraints)
        
        // Date/time indicator constraints
        let DateTimeConstraints: [NSLayoutConstraint] = [
            reportCellDateTimeOutlet.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 20),
            reportCellDateTimeOutlet.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10)
        ]
        NSLayoutConstraint.activateConstraints(DateTimeConstraints)
        
        // Customerlabel constraints
        let CustomerLabelConstraints: [NSLayoutConstraint] = [
            reportCellCustomerLabelOutlet.leftAnchor.constraintGreaterThanOrEqualToAnchor(reportCellDateTimeOutlet.rightAnchor, constant: 10),
            reportCellCustomerLabelOutlet.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10),
            reportCellCustomerLabelOutlet.rightAnchor.constraintLessThanOrEqualToAnchor(reportCellSeverityOutlet.leftAnchor, constant: -10),
            reportCellCustomerLabelOutlet.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
        ]
        NSLayoutConstraint.activateConstraints(CustomerLabelConstraints)
        
        // severity indicator constraints
        let SeverityConstraints: [NSLayoutConstraint] = [
            reportCellSeverityOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -20),
            reportCellSeverityOutlet.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10)
        ]
        NSLayoutConstraint.activateConstraints(SeverityConstraints)
        
        // info text constraints
        let InfoOutletConstraints: [NSLayoutConstraint] = [
            reportCellInfoOutlet.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 18),
            reportCellInfoOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -18),
            reportCellInfoOutlet.topAnchor.constraintEqualToAnchor(reportCellCustomerLabelOutlet.bottomAnchor, constant: 5),
           // reportCellInfoOutlet.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -10)
            
        ]
        NSLayoutConstraint.activateConstraints(InfoOutletConstraints)
        
        // info text gradient constraints
        let reportCelInfoMaskConstraints: [NSLayoutConstraint] = [
            reportCelInfoMaskOutlet.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 18),
            reportCelInfoMaskOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -18),
            reportCelInfoMaskOutlet.topAnchor.constraintEqualToAnchor(reportCellInfoOutlet.topAnchor),
            reportCelInfoMaskOutlet.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor)
            
        ]
        NSLayoutConstraint.activateConstraints(reportCelInfoMaskConstraints)
        
 //       fadeDescription()
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        
        //      reportCellInfoOutlet.sizeToFit()
        
       // print("Selected? \(selected)")
        
        super.setSelected(selected, animated: animated    )
        
        print("set selected")
        
        if (selected) {
            print("Selected!")
        } else {
            print("NOT selected")
            fadeDescription()
        }
        
        // fadeDescription()
        
   
        
//        if (selected) {
//            fadeDescription()
//            //            if let containerView = self.reportCellDescriptionOutlet {
//            
//            //                print("set gradient")
//            
//            //                let gradient = CAGradientLayer(layer: containerView.layer)
//            //                gradient.frame = containerView.bounds
//            //                gradient.colors = [UIColor.clearColor().CGColor, UIColor.blueColor().CGColor]
//            //                gradient.startPoint = CGPoint(x: 0.0, y: 1)
//            //                var labelHeight = self.reportCellDescriptionOutlet.frame.height
//            //                print("Labelheigt: \(labelHeight)")
//            //                //       self.sizeToFit()
//            //
//            //
//            //
//            //                gradient.endPoint = CGPoint(x: 0.0, y: 0.48)
//            //                containerView.layer.mask = gradient
//            //            }
//            
//            
//        }
    }
    
    
    func fadeDescription() {
        
        print("fadeDescription")
        
        if let containerView = reportCelInfoMaskOutlet {
//        if let containerView = self.reportCellInfoOutlet {
            
            // option 1
            let gradient = CAGradientLayer(layer: containerView.layer)
            gradient.frame = containerView.bounds
//            print("Frame size \(gradient.frame.size)")
            gradient.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
        //    gradient.startPoint = CGPoint(x: 0.0, y: 1)
      
            
//            let labelHeight = self.reportCellInfoOutlet.frame.height
//            print("Labelheigt: \(labelHeight)")
            
          //  gradient.endPoint = CGPoint(x: 0.0, y: 0.48)
            gradient.locations = [0.0, 0.88]
            containerView.layer.mask = gradient
            
            
            //option 2
            
//            let gradient = CAGradientLayer(layer: containerView.layer)
//            
//            gradient.frame = containerView.bounds
//            
//            let clearColor = UIColor.clearColor().CGColor
//            let blackColor = UIColor.blueColor().CGColor
//            
//            gradient.colors = [blackColor, clearColor]
//            gradient.locations = [0.0, 0.48]
//            containerView.layer.mask = gradient
            
    
            
        }
        
          //      reportCellInfoOutlet.backgroundColor = UIColor.clearColor()
    }
    
    
    
}

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
//    @IBOutlet weak var reportCellDescriptionOutlet: UILabel!
    @IBOutlet weak var reportCellViewedIndicatorOutlet: UIImageView!
    @IBOutlet weak var reportCellCustomerLabelOutlet: UILabel!
    @IBOutlet weak var reportCell: UIView!
    @IBOutlet weak var reportCellInfoOutlet: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Internal border
        self.layer.borderColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0).CGColor
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 4.0
        
        fadeDescription()
        
        // Delete autolayout constraints
        reportCell.translatesAutoresizingMaskIntoConstraints = false
        reportCellSeverityOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellDateTimeOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellInfoOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellViewedIndicatorOutlet.translatesAutoresizingMaskIntoConstraints = false
        reportCellCustomerLabelOutlet.translatesAutoresizingMaskIntoConstraints = false
        
   
        
//        reportCellViewedIndicatorOutlet.translatesAutoresizingMaskIntoConstraints = false
//        reportCellDateTimeOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        // viewed Indicator constraints
        let viewedIndicatorConstraints: [NSLayoutConstraint] = [
            
     //       reportCellViewedIndicatorOutlet.topAnchor.constraintEqualToAnchor(reportCell.topAnchor),
            reportCellViewedIndicatorOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -3),
            reportCellViewedIndicatorOutlet.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -3)
        
        ]
//        reportCell.addSubview(reportCellViewedIndicatorOutlet)
        NSLayoutConstraint.activateConstraints(viewedIndicatorConstraints)

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
//
        let SeverityConstraints: [NSLayoutConstraint] = [
            reportCellSeverityOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -20),
            reportCellSeverityOutlet.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activateConstraints(SeverityConstraints)
//
        
//        // Description constraints
//        let DescriptionOutletConstraints: [NSLayoutConstraint] = [
//            reportCellDescriptionOutlet.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 20),
//            reportCellDescriptionOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: 20),
//            reportCellDescriptionOutlet.topAnchor.constraintEqualToAnchor(reportCellCustomerLabelOutlet.bottomAnchor, constant: 5),
//            reportCellDescriptionOutlet.heightAnchor.constraintEqualToAnchor(self.heightAnchor, multiplier: 1)
//            
//            
//        ]
//        NSLayoutConstraint.activateConstraints(DescriptionOutletConstraints)
        
        let InfoOutletConstraints: [NSLayoutConstraint] = [
            reportCellInfoOutlet.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 20),
            reportCellInfoOutlet.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: 20),
            reportCellInfoOutlet.topAnchor.constraintEqualToAnchor(reportCellCustomerLabelOutlet.bottomAnchor, constant: 5),
            //reportCellInfoOutlet.heightAnchor.constraintEqualToAnchor(self.heightAnchor, multiplier: 1)
            
            
        ]
        NSLayoutConstraint.activateConstraints(InfoOutletConstraints)
        
        
        
        
//        let cellMargins = reportCell.layoutMarginsGuide
        
    //    reportCellViewedIndicatorOutlet.bottomAnchor.constraintEqualToAnchor(reportCell.bottomAnchor, constant: 10)
     
    //    reportCellViewedIndicatorOutlet.rightAnchor.constraintEqualToAnchor(reportCell.rightAnchor, constant:-80)
        
        
    //   reportCellDescriptionOutlet.translatesAutoresizingMaskIntoConstraints = false
  //
//       reportCellDescriptionOutlet.leftAnchor.constraintEqualToAnchor(reportCell.leftAnchor, constant: 10).active = true
//       reportCellDescriptionOutlet.rightAnchor.constraintEqualToAnchor(reportCell.rightAnchor, constant: 10).active = true
        
        
        // severity indicator
        
     //     reportCellSeverityOutlet.topAnchor.constraintEqualToAnchor(reportCell.topAnchor, constant: 10).active = true
  //     reportCellSeverityOutlet.rightAnchor.constraintEqualToAnchor(reportCell.rightAnchor, constant: 10).active = true
  //      reportCellSeverityOutlet.trailingAnchor.constraintEqualToAnchor(reportCell.trailingAnchor, constant: 10).active = true

     //   reportCellSeverityOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        
        

        
//        myView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
//        
//        reportCellViewedIndicatorOutlet.bottomAnchor = reportCell.bottomAnchor -2
//
//        subview.l
//  reportCellSeverityOutlet.Le
        
        /*
         VFL constraints Table View Cell
         */

//        var cellAllConstraints = [NSLayoutConstraint]()
//        let cellDictionary = [
//            "reportCellDateTime": reportCellDateTimeOutlet,
//            "reportCellViewedIndicator" : reportCellViewedIndicatorOutlet,
//            "reportCellDescription" : reportCellDescriptionOutlet ]
//        //        // set constraint on UILabel reportCellDateTimeOutlet in cell ReportCell
//        ////        cellAllConstraints.removeAll()
//        
//        
//        reportCellDateTimeOutlet.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(reportCellDateTimeOutlet)
//        //   alertTableView.addSubview(cell.reportCellDateTimeOutlet)
//        let dateTimeHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[reportCellDateTime(>=200)]-|",options: [], metrics: nil, views:  cellDictionary)
//        //
//        cellAllConstraints += dateTimeHorizontalConstraints
//        
//                NSLayoutConstraint.activateConstraints(cellAllConstraints)
    
    
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
       //      reportCellInfoOutlet.sizeToFit()
        
        print("Selected? \(selected)")
        
        super.setSelected(selected, animated: animated    )
        
        print("set selected")
        
        if (selected) {
            fadeDescription()
//            if let containerView = self.reportCellDescriptionOutlet {
            
//                print("set gradient")
            
                //                let gradient = CAGradientLayer(layer: containerView.layer)
                //                gradient.frame = containerView.bounds
                //                gradient.colors = [UIColor.clearColor().CGColor, UIColor.blueColor().CGColor]
                //                gradient.startPoint = CGPoint(x: 0.0, y: 1)
                //                var labelHeight = self.reportCellDescriptionOutlet.frame.height
                //                print("Labelheigt: \(labelHeight)")
                //                //       self.sizeToFit()
                //
                //
                //
                //                gradient.endPoint = CGPoint(x: 0.0, y: 0.48)
                //                containerView.layer.mask = gradient
//            }
            
            
        }
    }
    
    
    func fadeDescription() {
        
        print("fadeDescription")
        
        if let containerView = self.reportCellInfoOutlet {
            
            let gradient = CAGradientLayer(layer: containerView.layer)
            gradient.frame = containerView.bounds
            gradient.colors = [UIColor.clearColor().CGColor, UIColor.blueColor().CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1)
            var labelHeight = self.reportCellInfoOutlet.frame.height
            print("Labelheigt: \(labelHeight)")
            //       self.sizeToFit()
            
            
            
            gradient.endPoint = CGPoint(x: 0.0, y: 0.48)
            containerView.layer.mask = gradient
            
        }
    }
    
    
    
}

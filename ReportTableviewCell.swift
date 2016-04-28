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
    @IBOutlet weak var reportCellDescriptionOutlet: UILabel!
    @IBOutlet weak var reportCellViewedIndicatorOutlet: UIImageView!
    @IBOutlet weak var reportCellCustomerLabelOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Internal border
        self.layer.borderColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0).CGColor
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 4.0
        
        
        
        
        fadeDescription()
        
//        
//        subview.l
//  reportCellSeverityOutlet.Le
        
        /*
         VFL constraints Table View Cell
         */

        var cellAllConstraints = [NSLayoutConstraint]()
        let cellDictionary = [
            "reportCellDateTime": reportCellDateTimeOutlet,
            "reportCellViewedIndicator" : reportCellViewedIndicatorOutlet,
            "reportCellDescription" : reportCellDescriptionOutlet ]
        //        // set constraint on UILabel reportCellDateTimeOutlet in cell ReportCell
        ////        cellAllConstraints.removeAll()
        
        
        reportCellDateTimeOutlet.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(reportCellDateTimeOutlet)
        //   alertTableView.addSubview(cell.reportCellDateTimeOutlet)
        let dateTimeHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[reportCellDateTime(>=200)]-|",options: [], metrics: nil, views:  cellDictionary)
        //
        cellAllConstraints += dateTimeHorizontalConstraints
        
                NSLayoutConstraint.activateConstraints(cellAllConstraints)
    
        
        
        
//        NSLayoutConstraint(item: reportCellDescriptionOutlet, attribute: .Leading, relatedBy: .Equal, toItem: ReportTableviewCell., attribute: .LeadingMargin, multiplier: 1.0, constant: 50.0).active = true
        
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        
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
        
        if let containerView = self.reportCellDescriptionOutlet {
            
            let gradient = CAGradientLayer(layer: containerView.layer)
            gradient.frame = containerView.bounds
            gradient.colors = [UIColor.clearColor().CGColor, UIColor.blueColor().CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1)
            var labelHeight = self.reportCellDescriptionOutlet.frame.height
            print("Labelheigt: \(labelHeight)")
            //       self.sizeToFit()
            
            
            
            gradient.endPoint = CGPoint(x: 0.0, y: 0.48)
            containerView.layer.mask = gradient
            
        }
    }
    
    
    
}

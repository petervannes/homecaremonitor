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
    @IBOutlet weak var reportCellCustomerLabelOutlet: UILabel!
    @IBOutlet weak var reportCellDescriptionOutlet: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated    )
    }
}

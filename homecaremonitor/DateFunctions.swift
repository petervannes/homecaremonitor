//
//  DateFromNow.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 14-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import Foundation


struct DateFunctions {
    
    static func getDateDescr(currentDate :NSDate) -> String {
    
        
        var  dateDescription :String  = "1 lightyear from now"
        let now :NSDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        
        
        let dateComponents :NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: now, toDate: currentDate, options: NSCalendarOptions())
        
        switch dateComponents {

            
        case let(dc) where dc.year > 1:
            dateDescription = "\(dc.year) years ago"
        case let(dc) where dc.year == 1:
            dateDescription = "\(dc.year) year ago"
        case let(dc) where dc.month > 1:
            dateDescription = "\(dc.month) months ago"
        case let(dc) where dc.month == 1:
            dateDescription = "a \(dc.month) month ago"
        case let(dc) where dc.weekOfYear > 1:
            dateDescription = "\(dc.weekOfYear) weeks ago"
        case let(dc) where dc.weekOfYear == 1:
            dateDescription = "a \(dc.weekOfYear) week ago"
        case let(dc) where dc.day > 1:
            dateDescription = "\(dc.day) days ago"
        case let(dc) where dc.day == 1:
            dateDescription = "a \(dc.day) day ago"
        case let(dc) where dc.hour > 1:
            dateDescription = "\(dc.day) hours ago"
        case let(dc) where dc.day == 1:
            dateDescription = "an \(dc.day) hour ago"
        case let(dc) where dc.minute > 15:
            dateDescription = "\(dc.minute) minutes ago"
        case let(dc) where dc.minute <= 15:
            dateDescription = "just now"
        default:
            dateDescription = "a lightyear ago"
        }

        
        
        return dateDescription

    }
    
    
    
}
 
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
        let earliest = now.earlierDate(currentDate)
        let latest = (earliest == now) ? currentDate : now
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponents :NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        switch dateComponents {
            
            
        case let dd where dateComponents.year > 1:
            dateDescription = "\(dd.year) yrs ago"
        case _ where dateComponents.year == 1:
            dateDescription = "a year ago"
        case let dd where dateComponents.month > 1:
            dateDescription = "\(dd.month) mnths ago"
        case _ where dateComponents.month == 1:
            dateDescription = "a month ago"
        case let dd where dateComponents.weekOfYear > 1:
            dateDescription = "\(dd.weekOfYear) wks ago"
        case _ where dateComponents.weekOfYear == 1:
            dateDescription = "a weekk ago"
        case let dd where dateComponents.day > 1:
            dateDescription = "\(dd.day) days ago"
        case _ where dateComponents.day == 1:
            dateDescription = "a day ago"
        case let dd where dateComponents.hour > 1:
            dateDescription = "\(dd.hour) hrs ago"
        case _ where dateComponents.hour == 1:
            dateDescription = "an hour ago"
        case let dd where dateComponents.minute >= 1:
            dateDescription = "\(dd.minute) min. ago"
        case  _ where dateComponents.minute < 1:
            dateDescription = "just now"
        default:
            dateDescription = "a lightyear ago"
        }
        
        
        return dateDescription
        
    }
    
    
    
}
 
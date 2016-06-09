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
        
        print("DC M \(dateComponents.minute)")
        print("DC H \(dateComponents.hour)")
        print("DC D \(dateComponents.day)")
        print("DC W \(dateComponents.weekOfYear)")
        print("DC M \(dateComponents.month)")
        print("DC Y \(dateComponents.year)")
        
        
        
        switch dateComponents {

            
        case let dd where dateComponents.year > 1:
            dateDescription = "\(dd.year) years ago"
        case let dd where dateComponents.year == 1:
            dateDescription = "\(dd.year) year ago"
        case let dd where dateComponents.month > 1:
            dateDescription = "\(dd.month) months ago"
        case let dd where dateComponents.month == 1:
            dateDescription = "a \(dd.month) month ago"
        case let dd where dateComponents.weekOfYear > 1:
            dateDescription = "\(dd.weekOfYear) weeks ago"
        case let dd where dateComponents.weekOfYear == 1:
            dateDescription = "a \(dd.weekOfYear) week ago"
        case let dd where dateComponents.day > 1:
            dateDescription = "\(dd.day) days ago"
        case let dd where dateComponents.day == 1:
            dateDescription = "a \(dd.day) day ago"
        case let dd where dateComponents.hour > 1:
            dateDescription = "\(dd.hour) hours ago"
        case let dd where dateComponents.hour == 1:
            dateDescription = "an \(dd.hour) hour ago"
        case let dd where dateComponents.minute > 1:
            dateDescription = "\(dd.minute) minutes ago"
            print(" ..... \(dd.minute) minutes ago")
        case  _ where dateComponents.minute <= 1:
            dateDescription = "just now"
        default:
            dateDescription = "a lightyear ago"
        }

        
        
        return dateDescription

    }
    
    
    
}
 
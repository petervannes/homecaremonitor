//
//  Report+CoreDataProperties.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 09-06-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Report {

    @NSManaged var customer: String?
    @NSManaged var reportDate: NSDate?
    @NSManaged var severity: NSNumber?
    @NSManaged var message: String?
    @NSManaged var viewed: NSNumber?

}

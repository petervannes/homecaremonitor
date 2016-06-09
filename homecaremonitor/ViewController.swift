//
//  ViewController.swift
//  homecaremonitor
//
//  Created by Peter van Nes on 01-04-16.
//  Copyright © 2016 reddipped.com. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var sortOnSeverityButton: UIButton!
    @IBOutlet weak var sortOnTimeButton: UIButton!
    @IBOutlet weak var alertTableView: UITableView!
    
    // severitysort button
    let severityButtonAnimBasename :String = "severity_"
    var severitySort = "up" // up | down
    var severityButtonTimer = HCTimerWrapper()
    let severityButtonTimeInterval: NSTimeInterval = 0.02
    
    // timesort button
    let timeButtonForwAnimBasename = "timeforward_"
    let timeButtonBackwAnimBasename = "timebackward_"
    var timeSort = "forward"   // forward | backward
    var timeButtonTimer = HCTimerWrapper()
    let timeButtonTimeInterval: NSTimeInterval = 0.02
    
    // sortmethod
    enum sortMethods { case Time, Severity }
    var sortMethod = sortMethods.Time
//    var sortmethod = "time" // "time" or "severity"
    
    // Selected cell
    var selectedCellIndexPath: NSIndexPath?
    let selectedCellHeight: CGFloat = 135.0
    let unselectedCellHeight: CGFloat = 95.0
    
    //Hidden
    
    static let RefreshNotification = "RefreshNotification"
    
//    let demoData = [
//        
//        [ "viewed" : false,
//            "severity" : 1,
//            "reportDate": NSDate(),
//            "customer" : "Jan",
//            "shortMessage": "TV Running, no activity. So there is more text than can be displayed. Try to fix it over more lines. But it does not seem to fit. So try to overload this",
//            "longMessage": "Sensor a has notices that TV is running, but no movement has been detected for 2 hours in the house. So there is more to see here."
//        ],
//        ["viewed" : false,
//            "severity": 2,
//            "reportDate": NSDate().dateByAddingTimeInterval(60*60),
//            "customer": "Piet",
//            "shortMessage": "Light on after midnight",
//            "longMessage": "Light is still on after midnight"
//        ],
//        ["viewed" : false,
//            "severity": 3,
//            "reportDate": NSDate().dateByAddingTimeInterval(24*60*60),
//            "customer": "Klaes",
//            "shortMessage": "Room temperature exremely high",
//            "longMessage": "Temperature is over 32 degrees in the livingroom"]
//        
//        
//    ]
    
    
    var reports: [Report] = [ ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTableView.delegate = self
        alertTableView.dataSource = self
        
        // Register ReportCell
        let nib = UINib(nibName: "ReportCell", bundle: nil)
        alertTableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        
        // trying to use  NSLayoutAnchor class for constraints
//        let cell:ReportTableviewCell = self.alertTableView.dequeueReusableCellWithIdentifier("cell") as! ReportTableviewCell
//
//        NSLayoutConstraint(item: cell.reportCellDescriptionOutlet, attribute: .Leading, relatedBy: .Equal, toItem: cell.reportCellDescriptionOutlet, attribute: .LeadingMargin, multiplier: 1.0, constant: 50.0).active = true
        /*
            VFL constraints Table View Cell
        */
//        let cell:ReportTableviewCell = self.alertTableView.dequeueReusableCellWithIdentifier("cell") as! ReportTableviewCell
//        var cellAllConstraints = [NSLayoutConstraint]()
//        let cellDictionary = [
//                                      "reportCellDateTime": cell.reportCellDateTimeOutlet,
//                                      "reportCellViewedIndicator" : cell.reportCellViewedIndicatorOutlet,
//            "reportCellDescription" : cell.reportCellDescriptionOutlet ]
//        // set constraint on UILabel reportCellDateTimeOutlet in cell ReportCell
////        cellAllConstraints.removeAll()
//        cell.reportCellDateTimeOutlet.translatesAutoresizingMaskIntoConstraints = false
     //   alertTableView.addSubview(cell.reportCellDateTimeOutlet)
//        let dateTimeHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[reportCellDateTime(300)]-|",options: [], metrics: nil, views:  cellDictionary)
//
//        cellAllConstraints += dateTimeHorizontalConstraints
//
//        
//        
//        // set constraint on Image View ReportCellViewedIndicatorOutlet in cell ReportCell
//        
////        cellAllConstraints.removeAll()
//        cell.reportCellViewedIndicatorOutlet.translatesAutoresizingMaskIntoConstraints = false
//        alertTableView.addSubview(cell.reportCellViewedIndicatorOutlet)
//        let viewedIndicatorHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[reportCellViewedIndicator]-6-|",options: [], metrics: nil, views:  cellDictionary)
//        let viewedIndicatorVerticallConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[reportCellViewedIndicator]-6-|",options: [], metrics: nil, views:  cellDictionary)
//        
//        cellAllConstraints += viewedIndicatorHorizontalConstraints
//        cellAllConstraints += viewedIndicatorVerticallConstraints
//        
//        
//        // set constraint on Image View ReportCellViewedIndicatorOutlet in cell ReportCell
//        
//        //        cellAllConstraints.removeAll()
//        cell.reportCellDescriptionOutlet.translatesAutoresizingMaskIntoConstraints = false
//        alertTableView.addSubview(cell.reportCellDescriptionOutlet)
//        let reportCellDescriptionHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[reportCellDescription]|",options: [.AlignAllCenterX], metrics: nil, views:  cellDictionary)
////        let viewedIndicatorVerticallConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[reportCellDescription]-6-|",options: [], metrics: nil, views:  cellDictionary)
//        
//        cellAllConstraints += reportCellDescriptionHorizontalConstraints
//    //    cellAllConstraints += viewedIndicatorVerticallConstraints
//        
//        
//
//        NSLayoutConstraint.activateConstraints(cellAllConstraints)
        
        
        
        
        
  
                
                
        /// DEMO DATA INIT vv
        
//        for demod in demoData {
//            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//            let report = NSEntityDescription.insertNewObjectForEntityForName("Report", inManagedObjectContext: context) as! Report
//            report.viewed = demod["viewed"] as! Bool!
//            report.severity = demod["severity"] as! NSNumber!
//            report.reportDate = demod["reportDate"] as! NSDate!
//            report.customer = demod["customer"] as! String!
//            report.shortMessage = demod["shortMessage"] as! String!
//            report.longMessage = demod["longMessage"] as! String!
//            
//            
//            do {
//                try context.save()
//            } catch let saveError as NSError {
//                print("Saving error: \(saveError.localizedDescription)" )
//                
//            }
//        }
        
        /// DEMO DATA INIT ^^
        
//        self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending})
        
        // read core-data
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Report")
        self.reports = (try! context.executeFetchRequest(request)) as! [Report]
        self.alertTableView.reloadData()
        
        // sort cells
        self.sortCells()
        
        
           NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.receivedRefreshNotification(_:)), name: ViewController.RefreshNotification, object: nil)
        
        
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func receivedRefreshNotification(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let request = NSFetchRequest(entityName: "Report")
            self.reports = (try! context.executeFetchRequest(request)) as! [Report]
            self.alertTableView.reloadData()
    print("Refresh received!")
           // self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
//            selectedCellIndexPath = nil
//        } else {
//            selectedCellIndexPath = indexPath
//        }
//        
//        print("Selected cell : \(selectedCellIndexPath)")
//        
//        tableView.beginUpdates()
//        tableView.endUpdates()
//        
//        if selectedCellIndexPath != nil {
//            // This ensures, that the cell is fully visible once expanded
//            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
//        }
//        
////        self.alertTableView.rowHeight = 10
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
             print ("cellForRowAtIndexPath row \(indexPath.row) value viewed \(reports[indexPath.row].viewed)   value  severity \(reports[indexPath.row].severity!.stringValue)")
        //        let cell = UITableViewCell()
        ////        let sound = notesArray[indexPath.row]
        //        cell.textLabel!.text = "een note"
        //        return cell
        
        let cell:ReportTableviewCell = self.alertTableView.dequeueReusableCellWithIdentifier("cell") as! ReportTableviewCell
        
        //        cell.reportCellCustomerLabelOutlet.text = "A random customer (" + String(indexPath.row) + ")"
        cell.reportCellCustomerLabelOutlet.text = reports[indexPath.row].customer
       

        //        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" //format style. Browse online to get a format that fits your needs.
        //        cell.reportCellDateTimeOutlet.text = dateFormatter.stringFromDate(reports[indexPath.row].reportDate!)
        cell.reportCellDateTimeOutlet.text = DateFunctions.getDateDescr(reports[indexPath.row].reportDate!)
        print ("Row: \(indexPath.row) -- Date: \(reports[indexPath.row].reportDate!)")
        
        cell.reportCellInfoOutlet.text = reports[indexPath.row].shortMessage
        //        print("row: \(indexPath.row) severity: \(reports[indexPath.row].severity!)")
        //        print(reports[indexPath.row].severity!.stringValue)
        cell.reportCellSeverityOutlet.image = UIImage(named:  "severity_level_" + reports[indexPath.row].severity!.stringValue)
        
        
        cell.reportCellViewedIndicatorOutlet.alpha = reports[indexPath.row].viewed == true ? 0 : 1
        
  //      cell.reportCellInfoOutlet.scrollRangeToVisible(NSRange(location:0, length:0))

        
        
        
    //    fadeDescription(cell)
        
        


        
        return cell
    }
    
    
    
    // Viewed
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        print ("Clicked row \(indexPath.row) value viewed \(reports[indexPath.row].viewed)   severity \(reports[indexPath.row].severity!.stringValue)")
        
        
        if (!reports[indexPath.row].viewed!.boolValue) {
            print ("Not viewed yet")
            
            reports[indexPath.row].viewed = true 
            
        //    let cell:ReportTableviewCell = self.alertTableView.dequeueReusableCellWithIdentifier("cell") as! ReportTableviewCell
        //    cell.reportCellViewedIndicatorOutlet.alpha = 1
            
            let hcmDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context = hcmDelegate.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Report")
       //     request.predicate = NSPredicate(format: "customer = %@ and reportDate = %@", reports[indexPath].customer! as String, reports[indexPath].reportDate! as String)
            let requestAttributeCustomer = reports[indexPath.row].customer! as String
            let requestAttributeReportDate = reports[indexPath.row].reportDate! as NSDate
            request.predicate = NSPredicate(format: "customer = %@ and reportDate = %@", requestAttributeCustomer,requestAttributeReportDate)
   
            do {
            if let fetchResults = try hcmDelegate.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                
                    let managedObject = fetchResults[0]
                    managedObject.setValue(reports[indexPath.row].viewed, forKey: "viewed")
                    do {
                        try context.save()
                    } catch _ as NSError  {
                    }
                    
                }
            }
            self.alertTableView.reloadData()
            } catch _ as NSError {}
            
            
            
        }
        
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
            
        } else {
            selectedCellIndexPath = indexPath
        }
        
        print("Selected cell : \(selectedCellIndexPath)")
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (selectedCellIndexPath != nil && selectedCellIndexPath == indexPath) {
            
            return selectedCellHeight
        }
        
        
        return unselectedCellHeight
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        <#code#>
//    }
//    
//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if selectedCellIndexPath == indexPath {
//            return selectedCellHeight
//        }
//        return unselectedCellHeight
//        
//    }
//    optional public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if selectedCellIndexPath == indexPath {
//            return selectedCellHeight
//        }
//        return unselectedCellHeight
//    }
    

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch(editingStyle) {
        case .Delete:
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            context.deleteObject(reports[indexPath.row] as NSManagedObject)
            reports.removeAtIndex(indexPath.row)
            
            do {
                try context.save()
            } catch let deleteError as NSError {
                print ("failed to delete row  \(indexPath.row) \(deleteError.localizedDescription) ")
            }
            
            self.alertTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default: return
        }
    }
    
    
    
    @IBAction func sortOnSeverityButtonTouchInside(sender: UIButton) {
        
        var dictionary: [String : AnyObject] = [:]
        
        
        switch sortMethod {
            
            case .Severity:
            
            
            
    
        
        // Start animation if none running
        if (!severityButtonTimer.valid) {
            // Change sort order
            if (severitySort == "up") {
                severitySort = "down"
                dictionary = ["Button" : sortOnSeverityButton,
                              "start": 0,
                              "stop": 20,
                              "basefilename": severityButtonAnimBasename,
                              "crossfade": false,
                              "timer": severityButtonTimer]
            } else {
                severitySort = "up"
                dictionary = ["Button" : sortOnSeverityButton,
                              "start": 20,
                              "stop": 0,
                              "basefilename": severityButtonAnimBasename,
                              "crossfade": false,
                              "timer": severityButtonTimer]
            }
            
            let buttonAnimation :ButtonAnimation = ButtonAnimation()
            
            severityButtonTimer.pausableScheduledTimerWithTimeInterval(severityButtonTimeInterval, target: buttonAnimation , selector: #selector(ButtonAnimation.self.animateButton), userInfo: dictionary, repeats: true)
            
            
        }
            self.sortCells() ;
            
            
        case .Time:
            
            sortMethod = .Severity
            self.sortCells() ;

            
            
        }
        
//            if (severitySort == "up") {
//                self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedAscending})
//            } else {
//                self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedDescending})
//            }
            
//                          self.sortCells()
            self.alertTableView.reloadData()
            
      //  }
        
    }
    
    
    @IBAction func sortOnTimeButtonTouchInside(sender: UIButton) {
        
        var dictionary: [String : AnyObject] = [:]
        
        
        
        switch sortMethod {
            
        case .Time:
            
            
        // Start animation if none running
        if (!timeButtonTimer.valid) {
            // Change sort order
            if (timeSort == "forward") {
                timeSort = "backward"
                dictionary = ["Button" : sortOnTimeButton,
                              "start": 0,
                              "stop": 20,
                              "basefilename": timeButtonBackwAnimBasename,
                              "crossfade": true,
                              "timer": timeButtonTimer]
            } else {
                timeSort = "forward"
                dictionary = ["Button" : sortOnTimeButton,
                              "start": 0,
                              "stop": 20,
                              "basefilename": timeButtonForwAnimBasename,
                              "crossfade": true,
                              "timer": timeButtonTimer]
            }
            
            let buttonAnimation :ButtonAnimation = ButtonAnimation()
            
            timeButtonTimer.pausableScheduledTimerWithTimeInterval(timeButtonTimeInterval, target: buttonAnimation , selector: #selector(ButtonAnimation.self.animateButton), userInfo: dictionary, repeats: true)
        }
        self.sortCells() ;
            
            
        case .Severity:
            
            sortMethod = .Time
            self.sortCells() ;
            
            
            
        }
            
            
//            if (timeSort == "forward") {
//                self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedAscending})
//                self.alertTableView.reloadData()
//            } else {
//                self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending})
//                self.alertTableView.reloadData()
//            }
//            
          //              self.sortCells()
            
            self.alertTableView.reloadData()
            
    //    }
        
    }
    
    
    func sortCells() {
        
        switch sortMethod {
            
        case .Time:
            
            sortOnSeverityButton.highlighted = true
            
            if (timeSort == "forward") {
                self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedAscending})
                self.alertTableView.reloadData()
            } else {
                self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending})
                self.alertTableView.reloadData()
            }
            
        case .Severity:
            
            sortOnTimeButton.highlighted = true
            
            if (severitySort == "up") {
                self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedAscending})
            } else {
                self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedDescending})
            }
            
        }
        
        
        
        
    }
    
//    
//    func sortCells() {
//        
//        
//        // Sort cells on Date and Severity
//        // First on date, subsort on Severity
//        
//        if ((timeSort == "forward") && (severitySort == "up")) {
//            self.reports.sortInPlace({($0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedAscending) &&
//                ($0.severity?.compare($1.severity!) == NSComparisonResult.OrderedAscending)})
//
//        } else if ((timeSort != "forward") && (severitySort == "up")) {
//            self.reports.sortInPlace({($0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending) &&
//                ($0.severity?.compare($1.severity!) == NSComparisonResult.OrderedAscending)})
//        } else if ((timeSort == "forward") && (severitySort != "up")) {
//            self.reports.sortInPlace({($0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedAscending) &&
//                ($0.severity?.compare($1.severity!) == NSComparisonResult.OrderedDescending)})
//        } else if ((timeSort != "forward") && (severitySort != "up")) {
//            self.reports.sortInPlace({($0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending) &&
//                ($0.severity?.compare($1.severity!) == NSComparisonResult.OrderedDescending)})
//        }
//        
//        
//        
////        if (severitySort == "up") {
////            self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedAscending})
////        } else {
////            self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedDescending})
////        }
//        
//        
//        
//    }
    
    
//    func fadeDescription(currentCell :ReportTableviewCell?) {
//        
//        print("fadeDescription")
//        
//        if let containerView = currentCell!.reportCelInfoMaskOutlet {
//            //        if let containerView = self.reportCellInfoOutlet {
//            
//            // option 1
//            let gradient = CAGradientLayer(layer: containerView.layer)
//            gradient.frame = containerView.bounds
//            //            print("Frame size \(gradient.frame.size)")
//            gradient.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
//            //    gradient.startPoint = CGPoint(x: 0.0, y: 1)
//            
//            
//            //            let labelHeight = self.reportCellInfoOutlet.frame.height
//            //            print("Labelheigt: \(labelHeight)")
//            
//            //  gradient.endPoint = CGPoint(x: 0.0, y: 0.48)
//            gradient.locations = [0.0, 0.88]
//            containerView.layer.mask = gradient
//            
//            
//            //option 2
//            
//            //            let gradient = CAGradientLayer(layer: containerView.layer)
//            //
//            //            gradient.frame = containerView.bounds
//            //
//            //            let clearColor = UIColor.clearColor().CGColor
//            //            let blackColor = UIColor.blueColor().CGColor
//            //
//            //            gradient.colors = [blackColor, clearColor]
//            //            gradient.locations = [0.0, 0.48]
//            //            containerView.layer.mask = gradient
//            
//            
//            
//        }
//        
//        //      reportCellInfoOutlet.backgroundColor = UIColor.clearColor()
//    }
    
    
    
    
    
}


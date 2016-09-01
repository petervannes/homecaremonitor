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
    
    // Selected cell
    var selectedCellIndexPath: NSIndexPath?
    let selectedCellHeight: CGFloat = 135.0
    let unselectedCellHeight: CGFloat = 95.0
    
    // Notification definition for postNotification
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
//            report.message = demod["message"] as! String!
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:ReportTableviewCell = self.alertTableView.dequeueReusableCellWithIdentifier("cell") as! ReportTableviewCell
        
        cell.reportCellCustomerLabelOutlet.text = reports[indexPath.row].customer
        cell.reportCellDateTimeOutlet.text = DateFunctions.getDateDescr(reports[indexPath.row].reportDate!)
//      cell.reportCellInfoOutlet.text = reports[indexPath.row].shortMessage
        cell.reportCellSeverityOutlet.image = UIImage(named:  "severity_level_" + reports[indexPath.row].severity!.stringValue)
        cell.reportCellViewedIndicatorOutlet.alpha = reports[indexPath.row].viewed == true ? 0 : 1
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        print ("Clicked row \(indexPath.row) value viewed \(reports[indexPath.row].viewed)   severity \(reports[indexPath.row].severity!.stringValue)")
        
        
        if (!reports[indexPath.row].viewed!.boolValue) {
            
            reports[indexPath.row].viewed = true 
            
            
            let hcmDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = hcmDelegate.managedObjectContext
            let request = NSFetchRequest(entityName: "Report")
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
        
            self.alertTableView.reloadData()
            
        
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
            
            self.alertTableView.reloadData()
        
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
    
    
}


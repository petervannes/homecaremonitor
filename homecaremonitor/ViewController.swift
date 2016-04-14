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
    
    // severity button
    let severityButtonAnimBasename :String = "severity_"
    var severitySort = "up" // up | down
    var severityButtonTimer = HCTimerWrapper()
    let severityButtonTimeInterval: NSTimeInterval = 0.02
    
    
    let timeButtonForwAnimBasename = "timeforward_"
    let timeButtonBackwAnimBasename = "timebackward_"
    var timeSort = "forward"   // forward | backward
    var timeButtonTimer = HCTimerWrapper()
    let timeButtonTimeInterval: NSTimeInterval = 0.02
    let demoData = [
        
        [ "severity" : 1,
            "reportDate": NSDate(),
            "customer" : "",
            "shortMessage": "TV Running, no activity",
            "longMessage": "Sensor a has notices that TV is running, but no movement has been detected for 2 hours in the house"
        ],
        ["severity": 2,
            "reportDate": NSDate().dateByAddingTimeInterval(60*60),
            "customer": "",
            "shortMessage": "Light on after midnight",
            "longMessage": "Light is still on after midnight"
        ],
        ["severity": 3,
            "reportDate": NSDate().dateByAddingTimeInterval(24*60*60),
            "customer": "",
            "shortMessage": "Room temperature exremely high",
            "longMessage": "Temperature is over 32 degrees in the livingroom"]
        
        
    ]
    
    
    var reports: [Report] = [ ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTableView.delegate = self
        alertTableView.dataSource = self
        
        // Register ReportCell
        let nib = UINib(nibName: "ReportCell", bundle: nil)
        alertTableView.registerNib(nib, forCellReuseIdentifier: "cell")


        /// DEMO DATA INIT vv
        
        for demod in demoData {
            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let report = NSEntityDescription.insertNewObjectForEntityForName("Report", inManagedObjectContext: context) as! Report
            report.severity = demod["severity"] as! NSNumber!
            report.reportDate = demod["reportDate"] as! NSDate!
            report.customer = demod["customer"] as! String!
            report.shortMessage = demod["shortMessage"] as! String!
            report.longMessage = demod["longMessage"] as! String!

        
        do {
            try context.save()
        } catch let saveError as NSError {
            print("Saving error: \(saveError.localizedDescription)" )

        }
        }
        
          /// DEMO DATA INIT ^^
        
        self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending})
        
//        reports.append(Report(severity: 1, reportDate: NSDate(), customer: "Ms. Moneypenny", shortMessage: "TV Running, no activity", longMessage: "Sensor a has notices that TV is running, but no movement has been detected for 2 hours in the house"))
//        reports.append(Report(severity: 2, reportDate: NSDate().dateByAddingTimeInterval(60*60), customer: "Mr. Moneypenny", shortMessage: "Light on after midnight", longMessage: "Light is still on after midnight"))
//        reports.append(Report(severity: 3, reportDate: NSDate().dateByAddingTimeInterval(24*60*60), customer: "Mr. Moneypenny", shortMessage: "Room temperature exremely high", longMessage: "Temperature is over 32 degrees in the livingroom"))
        
        
        
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Report")
        self.reports = (try! context.executeFetchRequest(request)) as! [Report]
        self.alertTableView.reloadData()

        
        
        
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
        
               cell.reportCellDescriptionOutlet.text = reports[indexPath.row].shortMessage
//        print("row: \(indexPath.row) severity: \(reports[indexPath.row].severity!)")
//        print(reports[indexPath.row].severity!.stringValue)
        cell.reportCellSeverityOutlet.image = UIImage(named:  "severity_level_" + reports[indexPath.row].severity!.stringValue)
        
        return cell
    }
    
    
    
    
    @IBAction func sortOnSeverityButtonTouchInside(sender: UIButton) {
        
        var dictionary: [String : AnyObject] = [:]
        
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
            
            
            if (timeSort == "up") {
                self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedAscending})
            } else {
                self.reports.sortInPlace({$0.severity?.compare($1.severity!) == NSComparisonResult.OrderedDescending})
            }
            self.alertTableView.reloadData()
            
        }
        
    }
    
    
    @IBAction func sortOnTimeButtonTouchInside(sender: UIButton) {

        var dictionary: [String : AnyObject] = [:]
        
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
            
            if (timeSort == "forward") {
                self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedAscending})
                self.alertTableView.reloadData()
            } else {
                self.reports.sortInPlace({$0.reportDate?.compare($1.reportDate!) == NSComparisonResult.OrderedDescending})
                  self.alertTableView.reloadData()
            }
            
        }
        
    }
    
    
    


}


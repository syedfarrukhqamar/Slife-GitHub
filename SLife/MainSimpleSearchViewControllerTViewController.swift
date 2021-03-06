//
//  FirstViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.

import UIKit
import AVFoundation

var recent_from_flag = true
var recentr_to_flag = true

let FROM_ORIGIN = "From"
let TO_DESTINATION = "To"


var origin = "From"
var origin_StationId = String()

var destination = "To"
var destination_StationId = String()

var from_to_flag = String()
var advancedOptionsFlag = false
let VIA_DESTINATION = "Via"
var via = "Via"
var via_StationId = String()

// flags and centralise values
var errorCode_generic_flag = false // false means no Error reported, true means error has been reported 

var errorCode_generic = String()
var errorCode_Specific_Message = String()
var errorMessage_generic = String()

// Trip Time/ Date / Arrival / Departure

var simple_expectedTripDate = String()
var simple_expectedTripTime = String()
var simple_earliestDepartLatestArrival_flag = false
var simple_earliestDepartLatestArrival_Value = 0

// Time Table or Real Time
var simple_realTimeFlag = true

// variables for object serialization

var sr_fromStation_name = String()
var sr_fromStation_id = String()
var sr_toStation_name = String()
var sr_toStation_ID = String()
let RECENTTRIPS = "RecentTrips"
let FAVOURITES = "Favourites"


class MainSimpleSearchViewControllerTViewController : UITableViewController,UIPopoverPresentationControllerDelegate,popOverValue {
    weak var mDelegate:MyProtocol?

    var fromStation_SiteId = String()
    var toStation_SiteId = String()
    
    //let DEFAULT = "Default"
    
//    @IBOutlet var ShowTrafficStatusDetails: [UITableViewCell]!
    
//    @IBOutlet weak var error_Message_Display_Outlet: UIButton!
//    @IBOutlet weak var error_Title_Display_Outlet: UIButton!
    @IBOutlet weak var busesStatusIcon: UIImageView!
    @IBOutlet weak var metroStatusIcon: UIImageView!
    @IBOutlet weak var lightRailStatusIcon: UIImageView!
    @IBOutlet weak var railTrainStatusIcon: UIImageView!
    @IBOutlet weak var tramStatusIcon: UIImageView!
    @IBOutlet weak var ferryStatusIcon: UIImageView!
    
    @IBOutlet weak var favourite_Cell_outlet: UITableViewCell!
    
    // MARK: Recentr Trips First Row
    @IBOutlet weak var recentTrips_first_row: UIView!
    @IBOutlet weak var rec_trip_from_first_row: UILabel!
    @IBOutlet weak var rec_trip_from_Station_first_row: UILabel!
    @IBOutlet weak var rec_trip_to_first_row: UILabel!
    @IBOutlet weak var rec_trip_to_Station_first_row: UILabel!
    
    // MARK: Recentr Trips Second Row
    @IBOutlet weak var rec_trip_from_second_row: UILabel!
    
    @IBOutlet weak var rec_trip_to_StationID_second_row: UILabel!
    @IBOutlet weak var rec_trip_to_second_row: UILabel!
    @IBOutlet weak var rec_trip_from_Station_ID_second_row: UILabel!
    // MARK: Recentr Trips Third Row
    
    
//    @IBOutlet weak var rec_trip_from_third_row: UILabel!
//    
//    @IBOutlet weak var rec_trip_from_StationID_third_row: UILabel!
//    
//    @IBOutlet weak var rec_trip_to_third_row: UILabel!
    
    @IBOutlet weak var rec_trip_from_third_Row: UILabel!
    @IBOutlet weak var rec_trip_from_Station_ID_third_Row: UILabel!
    @IBOutlet weak var rec_trip_from_to_third_Row: UILabel!
    @IBOutlet weak var rec_trip_to_Station_id_third_Row: UILabel!
    
    @IBOutlet weak var recent_trips_first_row: UIView!
    
    @IBOutlet weak var recent_trips_first_cell: UITableViewCell!
    
    @IBOutlet weak var recent_trips_second_cell: UITableViewCell!
    @IBOutlet weak var recent_trips_third_cell: UITableViewCell!
//    @IBOutlet weak var genericErrorDisplay: UITableViewCell!
    
    
    @IBOutlet weak var dateTimeTrip: UIButton!
    @IBOutlet weak var latestArrivalOutlet: UIButton!
    @IBOutlet weak var now: UIButton!
    @IBOutlet weak var earliestDeparture: UIButton!
   
    @IBAction func origin_action(sender: UIButton) {
       
        
        
        if (!(from_Origin_Input.titleLabel?.text?.isEmpty)! && !((to_destination_Input.titleLabel?.text?.isEmpty)!)){
        self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
    }
    // MARK: Swap Origin Destination
    @IBOutlet weak var swap_origin_Destination_Outlet: UIButton!
    @IBAction func swap_Origin_Destination(sender: UIButton) {
     /*
        let oldOrigin = origin
        let oldDestination = destination
       
        print("Line 130:oldOrigin Value: = \(origin)" )
        print("Line 130:oldDestination Value: = \(destination)" )
   
        // swap them
        destination = oldOrigin
        origin = oldDestination
        
        print("Line 130:newOrigin Value: = \(origin)" )
        print("Line 130:newDestination Value: = \(destination)" )
        
        
        from_Origin_Input.setTitle(origin, for: .normal)
        to_destination_Input.setTitle(destination, for: .normal)
        
        print("Line 130:newOrigin Value: = Title Values: \(from_Origin_Input.titleLabel?.text)" )
        print("Line 130:newDestination Value: = Title Values:\(to_destination_Input.titleLabel?.text)" )
        
  */
        if (!(from_Origin_Input.titleLabel?.text?.isEmpty)! && !((to_destination_Input.titleLabel?.text?.isEmpty)!)){
            let oldOrigin = origin
            let oldDestination = destination
         
            let oldOriginSiteID = origin_StationId
            let oldDestinationSiteID = destination_StationId
            
            print("Line 153: oldOriginSiteID = \(oldOriginSiteID) ")
            
            print("Line 153: oldDestinationSiteID = \(oldDestinationSiteID) ")
           
            
            origin_StationId = oldDestinationSiteID
            destination_StationId = oldOriginSiteID
           
            print("Line 153: origin_StationId = \(origin_StationId) ")
            
            print("Line 153: destination_StationId = \(destination_StationId) ")
            
            
            print("Line 130:oldOrigin Value: = \(origin)" )
            print("Line 130:oldDestination Value: = \(destination)" )
            
            // swap them
            destination = oldOrigin
            origin = oldDestination
            
            print("Line 130:newOrigin Value: = \(origin)" )
            print("Line 130:newDestination Value: = \(destination)" )
            
            
            from_Origin_Input.setTitle(origin, for: .normal)
            to_destination_Input.setTitle(destination, for: .normal)
            
            print("Line 130:newOrigin Value: = Title Values: \(from_Origin_Input.titleLabel?.text)" )
            print("Line 130:newDestination Value: = Title Values:\(to_destination_Input.titleLabel?.text)" )
            
            /*
            let oldOrigin = origin
            let oldDestination = destination
            
            // swap them
            destination = oldOrigin
            origin = oldDestination
            
            from_Origin_Input.titleLabel?.text = origin
            to_destination_Input.titleLabel?.text = destination
            
            */
            
            /*
            let
            oldOrigin = from_Origin_Input.titleLabel?.text
            let oldDestination = to_destination_Input.titleLabel?.text
            
            
            print("origin OLD:::::\(from_Origin_Input.titleLabel?.text) = Origin Value = \(origin)")
            print("Destination old:::::\(to_destination_Input.titleLabel?.text) = Destination Value = \(destitnationValue)")
            
            from_Origin_Input.titleLabel?.text = "destitnationValue"
            to_destination_Input.titleLabel?.text = "origin"
            
            print("origin NEW:::::\(from_Origin_Input.titleLabel?.text) = Origin Value = \(origin)")
            print("Destination NEW:::::\(to_destination_Input.titleLabel?.text) = Destination Value = \(destitnationValue)")
          
            */
        }

        
    }
    @IBAction func destination_action(sender: UIButton) {
        print("ORIGIN STATUS: = \(from_Origin_Input.titleLabel?.text?.isEmpty) ")
        print("Destination STATUS:Current = \(from_Origin_Input.titleLabel?.text?.isEmpty) ")
        
        if (!(from_Origin_Input.titleLabel?.text?.isEmpty)! && !((to_destination_Input.titleLabel?.text?.isEmpty)!)){
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    /*
    @IBAction func showDatePickerAction(sender: UIButton) {
        
        
        let popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("DatePickerViewController") as! DatePickerViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(300,250)
        popover!.delegate = self
        popover!.sourceView = self.view
        //        popover!.sourceRect = CGRectMake(100,100,0,0)
        popover!.sourceRect = CGRectMake(0,400,0,0)
        
        self.presentViewController(nav, animated: true, completion: nil)

        self.performSegueWithIdentifier("showDatePicker", sender: self)
        
    }
 */
    
 @IBAction func dateTimeTripAction(sender: UIButton) {
        
// MARK: Swift 3
        print("date time trip action:::::: test in main simple search")
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
    
        popoverContent.preferredContentSize = CGSize(width: 300, height: 250) //CGSizeMake(300,250)
        popover!.delegate = self
        popover!.sourceView = self.view
//        popover!.sourceRect = CGRectMake(100,100,0,0)
    
        // MARK: Swift 3
    
        popover!.sourceRect = CGRect(origin: CGPoint(x: 0, y: 400), size: CGSize(width: 0, height: 0)) //CGRectMake(0,400,0,0)
        
        self.present(nav, animated: true, completion: nil)
        
         popoverContent.delegate = self
    }
    @IBAction func latestArrivalAction(sender: UIButton) {
        
        dateTimeTrip.isUserInteractionEnabled = true
        simple_earliestDepartLatestArrival_Value = 1
        
        simple_earliestDepartLatestArrival_flag = true

        
        Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: latestArrivalOutlet, disableButtonSecond: earliestDeparture, disableButtonThird: now)
    }
    @IBAction func nowAction(sender: UIButton) {
    
        dateTimeTrip.isUserInteractionEnabled = false
        dateTimeTrip.setTitle(HelpingMethods.currentDateTime(), for: UIControlState.normal)
       
        simple_earliestDepartLatestArrival_flag = false
        simple_earliestDepartLatestArrival_Value = 0
        simple_expectedTripTime = HelpingMethods.currentDateTime()
        simple_expectedTripDate = HelpingMethods.currentDateTime()
        
        Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: now, disableButtonSecond: earliestDeparture, disableButtonThird: latestArrivalOutlet)
    }
    @IBAction func earliestDepartureAction(sender: UIButton) {
        dateTimeTrip.isUserInteractionEnabled = true
        simple_earliestDepartLatestArrival_Value = 0
        
        simple_earliestDepartLatestArrival_flag = true
        

        Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: earliestDeparture, disableButtonSecond: latestArrivalOutlet, disableButtonThird: now)
    }
    
    @IBOutlet weak var from_Origin_Input: UIButton!
    
    @IBOutlet weak var to_destination_Input: UIButton!
    
    @IBOutlet weak var timeTable: UIButton!
  
    @IBOutlet weak var realTime: UIButton!
    
    @IBAction func realTimeAction(sender: UIButton) {
         simple_realTimeFlag = true
     Buttons.enableOneAndDisableOneButton(enableButtonFirst: realTime,disableButtonSecond: timeTable)
    }
    
    @IBAction func timeTableAction(sender: UIButton) {
        simple_realTimeFlag = false
        
        Buttons.enableOneAndDisableOneButton(enableButtonFirst: timeTable, disableButtonSecond: realTime)
    }
    
    //    @IBOutlet weak var From: UITextField!
    //    @IBOutlet weak var To: UITextField!
    
    //@IBOutlet weak var Text: UITextField!
    
    
    //    @IBOutlet weak var From: UILabel!
    //    @IBOutlet weak var To: UILabel!
    
    // @IBOutlet weak var To: UIButton!
    //@IBOutlet weak var From: UIButton!
    //    @IBAction func searchTrip(sender: UIButton) {
    //    }
    
    // to be implemented the ajax function later
    // implement the ajax function later
    // @IBOutlet weak var from: UITextField!
    
    //@IBOutlet weak var to: UITextField!
    
    var fromDestinationSearchTrip = "centralen"
    var toDestinationSearchTrip = "kista"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("error code check in main simple.............")
        // MARK: Navigation Search Disable
    
        let testCheck = "From"
        let condition = (from_Origin_Input.titleLabel?.text != testCheck)
         print(condition)
        // EARLIEST AND LATEST ARRIVAL
        
        if (simple_earliestDepartLatestArrival_flag == true) {
            
            //     Buttons.enableButton(button: now, title: "")
           
            if(simple_earliestDepartLatestArrival_Value == 1){
            // latest arrival is 1
            
            Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: latestArrivalOutlet, disableButtonSecond: now, disableButtonThird: earliestDeparture)
            
            } else if (simple_earliestDepartLatestArrival_Value == 0){
            // earliest dep is 0
                
            Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: earliestDeparture, disableButtonSecond: now, disableButtonThird: latestArrivalOutlet)
            
            }
            
            //Buttons.disableButton(button: now, title: "")
            
            dateTimeTrip.isUserInteractionEnabled = true
            
        } else
            
        {
            dateTimeTrip.isUserInteractionEnabled = false
            Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: now, disableButtonSecond: earliestDeparture, disableButtonThird: latestArrivalOutlet)
              simple_expectedTripTime = HelpingMethods.currentTime24Hour()
            simple_expectedTripDate = HelpingMethods.currentDate()
           
           
            dateTimeTrip.setTitle(HelpingMethods.currentDateTime(), for: UIControlState.normal)
            
            // Buttons.enableButton(button: now, title: "")
            
        }

        
        if (from_Origin_Input.titleLabel?.text != "From") && (to_destination_Input.titleLabel?.text != "To")
        {
            swap_origin_Destination_Outlet.isEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }


     //   swap_origin_Destination_Outlet.isEnabled = false
       // self.navigationItem.rightBarButtonItem?.isEnabled = false
        // testing user defaults
               
        print("-view did apear----here.-.--.-.")
        
        // temp 28th july testing traffic status central---start
        
        //
        // temp 28th july testing traffic status central---start
        
        // Do any additional setup after loading the view, typically from a nib.
        print(jsonTrafficStatusLoaded)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
          //---------------------
        print("view did appear--------------")
        
        print("Line 421:from_Origin_Input.titleLabel?.text view will appear = simple = \(from_Origin_Input.titleLabel?.text)----origin-\(origin)")
        print("Line 421:to_destination_Input.titleLabel?.text?.text view will appear = simple = \(to_destination_Input.titleLabel?.text)----destination-\(destination)")
         if(from_Origin_Input.titleLabel?.text == "From"){
            navigationItem.rightBarButtonItem?.isEnabled = false
            swap_origin_Destination_Outlet.isEnabled = false
            
        print("++simple++++++FROM+++++++++++++++++CAUGHT")
         } else if (to_destination_Input.titleLabel?.text == "To") {
            navigationItem.rightBarButtonItem?.isEnabled = false
            swap_origin_Destination_Outlet.isEnabled = false
            
         print("++simple++++++To+++++++++++++++++CAUGHT")
            print("----------ending-----------------")
        
        } else {
        
            print("++simple++++++else caught ++from and to has some value+++++++++++++++++CAUGHT")
            
            if ( from_Origin_Input.titleLabel?.text != to_destination_Input.titleLabel?.text){
                
            navigationItem.rightBarButtonItem?.isEnabled = true
            swap_origin_Destination_Outlet.isEnabled = true
           
            }
            else {
           print("simple----From and To should not be same")
                print("---------------end-------------")
            }
         }
       // MARK: NIL
//        
//        print("ORIGIN STATUS: = \(from_Origin_Input.titleLabel?.text!) ")
//        print("Destination STATUS: = \(to_destination_Input.titleLabel?.text?.isEmpty) ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("-viewWillAppear:----------fromStation_SiteId---\(origin_StationId)------& origin = \(origin)-------2-----------------")
         print("-viewWillAppear:-----------toStation_SiteId---\(destination_StationId)----Destination = \(destination)---------2-----------------")
        print("-viewWillAppear--- from origin button =\(from_Origin_Input.titleLabel?.text) ")
        print("-viewWillAppear--- from origin button =\(to_destination_Input.titleLabel?.text) ")
        
        
        rec_trip_to_Station_first_row.isHidden = true
        rec_trip_from_Station_first_row.isHidden = true
        rec_trip_from_Station_ID_second_row.isHidden = true
        rec_trip_to_StationID_second_row.isHidden = true
        rec_trip_from_Station_ID_third_Row.isHidden = true
        rec_trip_to_Station_id_third_Row.isHidden = true
         //MARK: Fav and Rec trips check
          print("inside Simple screen : check fav and recent trips.......")
        let fav_array = SlifeMethods.deSerializeObject(objectKeyNameToDeserialize: FAVOURITES)
        let rec_array = SlifeMethods.deSerializeObject(objectKeyNameToDeserialize: RECENTTRIPS)
     if ((fav_array.count == 0) && (rec_array.count == 0)){
        
            //MARK: Recentr Cells All Hide
            
            // hide  3rd cell and show first two
            recent_trips_first_cell.isHidden = true
            recent_trips_second_cell.isHidden = true
            recent_trips_third_cell.isHidden = true
            
        favourite_Cell_outlet.isUserInteractionEnabled = false
        
        } else {
            print("recentr trips on the simple screen have been found === ")
            print("-account-\(rec_array.count)------recent trips is not zero...else..")
            
            // MARK: Keys
            // fromStationName, toStationId, fromStationId, toStation_Name
            let fromStationName = "fromStationName"
            let toStationId = "toStationId"
            let fromStationId = "fromStationId"
            let toStation_Name = "toStation_Name"
            
            // set from and to values same as first index
//            from_Origin_Input.setTitle("From", for: .normal)
//            to_destination_Input.setTitle("To", for: .normal)

            let typeTrip_display = rec_array.firstObject as! NSDictionary
//            if (recent_from_flag == true){
//            from_Origin_Input.setTitle(typeTrip_display.value(forKey: fromStationName) as? String, for: .normal)
//            
//            
//            origin_StationId = (typeTrip_display.value(forKey: fromStationId)  as? String)!
//            
//            }
//            if (recentr_to_flag == true){
//                to_destination_Input.setTitle(typeTrip_display.value(forKey: toStation_Name)   as? String, for: .normal)
//            
//                
//                destination_StationId = (typeTrip_display.value(forKey: toStationId)  as? String)!
//            }
            print("-------SETTING DEFAULT VALUES----------------------")
            print("-------Origin Name= \(typeTrip_display.value(forKey: fromStationName) as? String)")
            print("-------Destination Name= \(typeTrip_display.value(forKey: fromStationId)   as? String)")
            print("-------Origin Station ID = \(origin_StationId)")
            print("-------Origin Station ID = \(destination_StationId)")
            
            
            if (rec_array.count == 1){
                
                //MARK: Recent Trip Rows Switch Off
                // hide 2nd and 3rd cell and show first
                recent_trips_first_cell.isHidden = false
                recent_trips_second_cell.isHidden = true
                recent_trips_third_cell.isHidden = true
                
                
                print("--------recent trips is not zero.....")
                
                
                let typeTrip = rec_array.firstObject as! NSDictionary
                print("typeTrip ==1====simple==\(typeTrip.allKeys)")
                
                print(typeTrip.allKeys)
                rec_trip_from_first_row.text = typeTrip.value(forKey: fromStationName) as? String
                rec_trip_from_Station_first_row.text = typeTrip.value(forKey: fromStationId)   as? String
                rec_trip_to_first_row.text = typeTrip.value(forKey: toStation_Name)  as? String
                rec_trip_to_Station_first_row.text = typeTrip.value(forKey: toStationId)  as? String
                print("RECENT TRIPS IS 1......")
                print("fromStationName = \(typeTrip.value(forKey: fromStationName) as? String)")
                print("fromStationId = \(typeTrip.value(forKey: fromStationId) as? String)")
                print("toStation_Name = \(typeTrip.value(forKey: toStation_Name) as? String)")
                print("toStationId = \(typeTrip.value(forKey: toStationId) as? String)")
                // MARK: Rec Trips First Row
                rec_trip_from_first_row.text = typeTrip.value(forKey: fromStationName) as? String
                rec_trip_from_Station_first_row.text = typeTrip.value(forKey: fromStationId)   as? String
                rec_trip_to_first_row.text = typeTrip.value(forKey: toStation_Name)  as? String
                rec_trip_to_Station_first_row.text = typeTrip.value(forKey: toStationId)  as? String
                recentTrips_first_row.viewWithTag(0)
            
            } else if (rec_array.count == 2) {
                
                // hide  3rd cell and show first two
                recent_trips_first_cell.isHidden = false
                recent_trips_second_cell.isHidden = false
                recent_trips_third_cell.isHidden = true

                
                let typeTrip = rec_array.firstObject as! NSDictionary
                let typeTrip_second = rec_array[1] as! NSDictionary
                print("2---typeTrip=== \(typeTrip)")
                print("2---typeTrip_second=== \(typeTrip_second)")
                
                
                print("typeTrip =2=====simple==\(typeTrip.allKeys)")
                print(typeTrip.allKeys)
                print("RECENT TRIPS two 2......")
                print("fromStationName = \(typeTrip.value(forKey: fromStationName) as? String)")
                print("fromStationId = \(typeTrip.value(forKey: fromStationId) as? String)")
                print("toStation_Name = \(typeTrip.value(forKey: toStation_Name) as? String)")
                print("toStationId = \(typeTrip.value(forKey: toStationId) as? String)")

                
                // MARK: Rec Trips First & Second Row
                rec_trip_from_first_row.text = typeTrip.value(forKey: fromStationName) as? String
                rec_trip_from_Station_first_row.text = typeTrip.value(forKey: fromStationId)   as? String
                
                rec_trip_to_first_row.text = typeTrip.value(forKey: toStation_Name)  as? String
                rec_trip_to_Station_first_row.text = typeTrip.value(forKey: toStationId)  as? String
                // 2nd Row
                rec_trip_from_second_row.text = typeTrip_second.value(forKey: fromStationName) as? String
                rec_trip_from_Station_ID_second_row.text = typeTrip_second.value(forKey: fromStationId)   as? String
//              rec_trip_from_Station_ID_second_row
                rec_trip_to_second_row.text = typeTrip_second.value(forKey: toStation_Name)  as? String
              
                rec_trip_to_StationID_second_row.text = typeTrip_second.value(forKey: toStationId)  as? String
                print("RECENT TRIPS IS 2......")
 
            }
            
            else if (rec_array.count >= 3) {
                
                
                // hide  3rd cell and show first two
                recent_trips_first_cell.isHidden = false
                recent_trips_second_cell.isHidden = false
                recent_trips_third_cell.isHidden = false
                
                let typeTrip = rec_array.firstObject as! NSDictionary
                let typeTrip_second = rec_array[1] as! NSDictionary
                let typeTrip_third = rec_array[2] as! NSDictionary
                print("3---typeTrip=== \(typeTrip)")
                print("3---typeTrip_second=== \(typeTrip_second)")
                print("3---typeTrip_third=== \(typeTrip_third)")
                
                print("typeTrip ======simple==\(typeTrip.allKeys)")
                print(typeTrip.allKeys)
                print("RECENT TRIPS are 3......")
                print("fromStationName = \(typeTrip.value(forKey: fromStationName) as? String)")
                print("fromStationId = \(typeTrip.value(forKey: fromStationId) as? String)")
                print("toStation_Name = \(typeTrip.value(forKey: toStation_Name) as? String)")
                print("toStationId = \(typeTrip.value(forKey: toStationId) as? String)")

                // MARK: Rec Trips First ,Second & Third Row
                rec_trip_from_first_row.text = typeTrip.value(forKey: fromStationName) as? String
                rec_trip_from_Station_first_row.text = typeTrip.value(forKey: fromStationId)   as? String
                
                rec_trip_to_first_row.text = typeTrip.value(forKey: toStation_Name)  as? String
                rec_trip_to_Station_first_row.text = typeTrip.value(forKey: toStationId)  as? String
                // 2nd row
                
                rec_trip_from_second_row.text = typeTrip_second.value(forKey: fromStationName) as? String
                rec_trip_from_Station_ID_second_row.text = typeTrip_second.value(forKey: fromStationId)   as? String
                
                rec_trip_to_second_row.text = typeTrip_second.value(forKey: toStation_Name)  as? String
                rec_trip_to_StationID_second_row.text = typeTrip_second.value(forKey: toStationId)  as? String
                
                // 3rd row
                
                
//                @IBOutlet weak var rec_trip_from_third_Row: UILabel!
//                @IBOutlet weak var rec_trip_from_Station_ID_third_Row: UILabel!
//                @IBOutlet weak var rec_trip_from_to_third_Row: UILabel!
//                @IBOutlet weak var rec_trip_to_Station_id_third_Row: UILabel!
//
                
                rec_trip_from_third_Row.text = typeTrip_third.value(forKey: fromStationName) as? String
                rec_trip_from_Station_ID_third_Row.text = typeTrip_third.value(forKey: fromStationId)   as? String
                rec_trip_from_to_third_Row.text = typeTrip_third.value(forKey: toStation_Name)  as? String
                rec_trip_to_Station_id_third_Row.text = typeTrip_third.value(forKey: toStationId)  as? String
                

              print("RECENT TRIPS IS 3......")
            
            
            }
         
            
            favourite_Cell_outlet.isUserInteractionEnabled = true
//        var i = recentTrips_first_row.viewWithTag(1) as! UILabel
//            
//        i.text = "RECENT TRIPS........"
        
        }
        print("fav_array.count..@SIMPLE screen............")
        print(fav_array.count)
        print("rec_array.count..............")
        print(rec_array.count)
        let serialQueue = DispatchQueue(label: "myQueue")
        //MARK:- Extract Values to construct url
        serialQueue.async() { () -> Void in
            
            
            
            //let serialQueue = dispatch_queue_create("com.appcoda.imagesQueue", DISPATCH_QUEUE_SERIAL)
            //dispatch_async(serialQueue) { () -> Void in
            
            TrafficStatusCentralProcessor.get_data_from_url(url: trafficStatusURL)
        }
        
        
        serialQueue.async() { () -> Void in
            
            print("about to load traffic status...............\(downloadingNotFinishedTrafficStatus)")
            while (downloadingNotFinishedTrafficStatus) {
                
                // MARK: Traffic status check download
                // print("downloading......................")
                
                if (downloadingNotFinishedTrafficStatus == false){
                    
                    print("dataSourceTrafficStatus::::main simple:::\(dataSourceTrafficStatus.count)")
                    
                    // swift 3                dispatch_async(dispatch_get_main_queue(), {
                    DispatchQueue.main.async(execute: {
                        
                        var i = 0
                        for index in dataSourceTrafficStatus {
                            
                            let trafficTypes = dataSourceTrafficStatus[i] as! TrafficType
                            print("-----------------------traffic types being printed....\(trafficTypes.trafficEvents.count)")
                            print(trafficTypes.name)
                            print(trafficTypes.statusIcon)
                            print(trafficTypes.type)
                            
                            // switch case check to change the icon
                            var iconName = String()
                            
                            
                            // check for events inside each transport tpe
                            var g = 0
                            var deviation = false
                            var deviationMinor = false
                            for ind in trafficTypes.trafficEvents {
                                print("trafficTypes.trafficEvents[g].statusIcon +====\(trafficTypes.trafficEvents[g].statusIcon )")
                                
                                
                                
                                if (trafficTypes.trafficEvents[g].statusIcon != EVENTGOOD_ICON){
                                    
                                    
                                    
                                    if (trafficTypes.trafficEvents[g].statusIcon == EVENTMINOR_ICON)
                                    {
                                        iconName = EVENTMINOR_ICON + ".png"
                                        deviationMinor = true
                                        deviation = true
                                        
                                        // change icon name master
                                    } else if (trafficTypes.trafficEvents[g].statusIcon == EVENTPLANNED_ICON )
                                    {
                                        if (deviationMinor == false){
                                            iconName = EVENTPLANNED_ICON + ".png"
                                            deviation = true
                                        }
                                        // change icon name master
                                        
                                    }
                                }
                                else if (deviation == false) {
                                    
                                    iconName = EVENTGOOD_ICON + ".png"
                                    
                                }
                                
                                g += 1
                                
                            }
                            
                            print("current icon name is =\(iconName)")
                            
                            switch (trafficTypes.type) {
                            // 0 metro
                            case "metro":
                                
                                print("metro found .........metro.iconName\(iconName).")
                                
                                self.metroStatusIcon.image = UIImage(named: iconName)
                                // self.busesStatusIcon.image = UIImage(named: "EventGood.png")
                                break
                                
                                // respond to value 1
                                
                            // 1 train
                            case "train":
                                
                                print("train found ........train..iconName\(iconName).")
                                self.railTrainStatusIcon.image = UIImage(named: iconName)
                                break
                            // 2 local
                            case "local":
                                print("local found ........local..iconName\(iconName).")
                                self.lightRailStatusIcon.image = UIImage(named: iconName)
                                
                                break
                                
                                
                            // 3 tram
                            case "tram":
                                print("tram found ........tram..iconName\(iconName).")
                                self.tramStatusIcon.image = UIImage(named: iconName)
                                
                                break
                                
                                
                            // 4 bus
                            case "bus":
                                print("bus found ........bus..iconName\(iconName).")
                                self.busesStatusIcon.image = UIImage(named: iconName)
                                
                                break
                                
                            // 5fer
                            case "fer":
                                print("fer found ........fer..iconName\(iconName).")
                                self.ferryStatusIcon.image = UIImage(named: iconName)
                                
                                break
                                
                            default:
                                print("default..........default...iconName\(iconName)")
                                //otherwise, do something else
                            }
                            
                            
                            // switch case check to change the icon ends here
                            
                            
                            i += 1
                            
                        }
                        //  self.busesStatusIcon.image = UIImage(named: "EventGood.png")
                    })
                    
                    //print("image name is= 909 \(self.busesStatusIcon.description)")
                }
            }
            
            
            //            var image = UIImage(named: "EventGood")
            //            
            //            self.busesStatusIcon = UIImageView(image: image)
            
            print("downloaded.....................\(self.busesStatusIcon.image)")
        }
   //--------
        print("-view did apear----here.-.--.-.21")
        // setting default values and presentation
        // enabling now button
        if (errorCode_generic_flag == true) {
           // self.title = "Error Reported...."
             print("error Code has been caught... error should be displayed....")

            let real_titleAlert = "Network Problem:" + errorCode_generic
            let real_titleMessage = errorMessage_generic
            print("Error:101: \(real_titleMessage)")
            let display_message = real_titleMessage
            
            let alert = UIAlertController(title: real_titleAlert, message: real_titleMessage, preferredStyle: UIAlertControllerStyle.alert)
            // MARK: Error Reset
            
            errorCode_generic_flag = false
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //   genericErrorDisplay.backgroundColor = UIColor.red
            print("Error Code flag is Red..........")
         }
        else {


            print("Error Code flag is White:: No Error Found..........")
            
            
        }
        
        // enable time table
        Buttons.enableOneAndDisableOneButton(enableButtonFirst: realTime, disableButtonSecond: timeTable)
      // MARK: temp date trip
        
        //  dateTimeTrip.setTitle(HelpingMethods.currentDateTime(), for: UIControlState.normal)
          //  dateTimeTrip.userInteractionEnabled = false
        
//       Buttons.disableButton(dateTimeTrip, title: <#T##String#>)
        // from_Origin_Input.setTitle("some", forState: .Normal)
        print("from ORIGIN input STATUS: = \(from_Origin_Input.titleLabel?.text) ")
      //  print("from ORIGIN input STATUS: = \(from_Origin_Input.titleLabel?.text!) ")
        
        print("-selected index path-----viewWillAppear----)")
        print("from to flag = \(from_to_flag)")
        print("station.site_id= \(station.site_id)")
        print("station.name:::::::::= \(station.name)")
        
        print("from_to_value=\(from_to_value)")
        // MARK: Date Button Settings
        // earliest and latest arrival setting
        
        if (simple_earliestDepartLatestArrival_flag == true) {
            
            let tripDateTime_Simple = simple_expectedTripDate + "-" + simple_expectedTripTime
            print("Last Saved Date & Time = \(tripDateTime_Simple)")
            dateTimeTrip.setTitle(tripDateTime_Simple, for: .normal)
            
            if(earliestDepartLatestArrival_Value == 0){
                
                Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: earliestDeparture, disableButtonSecond: now, disableButtonThird: latestArrivalOutlet)
                dateTimeTrip.isUserInteractionEnabled = true
                
            } else if (earliestDepartLatestArrival_Value == 1) {
                
                
                Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: latestArrivalOutlet, disableButtonSecond: now, disableButtonThird: earliestDeparture)
    dateTimeTrip.isUserInteractionEnabled = true
            }

            
//            Buttons.enableButton(button: now, title: "")
      
//            Buttons.disableButton(button: now, title: "")
         } else
        
        {
            
            dateTimeTrip.isUserInteractionEnabled = false
            
            
         Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: now, disableButtonSecond: earliestDeparture, disableButtonThird: latestArrivalOutlet)
            
            //Buttons.enableButton(button: now, title: "")
         }
        
        // print("from_Origin_Input.titleLabel = \(from_Origin_Input.titleLabel?.text!)")
        
        if (from_to_flag == FROM_ORIGIN){
            origin = from_to_value
            from_Origin_Input.setTitle(origin, for: .normal)
            print(" from_Origin_Input = from:origin= \( from_Origin_Input.titleLabel?.text)")
            // = from_to_value
            print("from value is = \(from_to_value)")
            origin_StationId = station.site_id
            // assigning values for object serialization ( from values)
            sr_fromStation_name = from_to_value
            sr_fromStation_id = station.site_id
        } else if (from_to_flag == TO_DESTINATION){
            print(" from_Origin_Input = to:destination = \( from_Origin_Input.titleLabel?.text)")
            
            destination = from_to_value
            to_destination_Input.setTitle(destination, for: .normal)
            print("to value is in search trip controller = \(from_to_value)")
            destination_StationId = station.site_id
            
            // assigning values for object serialization
            sr_toStation_name = from_to_value
            sr_toStation_ID = station.site_id

        }
        // MARK: Default Values Setting
        
        from_Origin_Input.setTitle(origin, for: .normal)
        to_destination_Input.setTitle(destination, for: .normal)
        print("Line: 941: from_to_flag = \(from_to_flag)")
        
        print("Line: 941: origin = \(origin) & Origin.station id = \(origin_StationId)")
        print("Line: 941: destination = \(destination) & destination Dest.station id = \(destination_StationId)")
        
       // print("1) from_Origin_Input.titleLabel = \(from_Origin_Input.titleLabel?.text!)")
        print("010-----origin = \(origin)")
        print("010------station.site_id-----\(station.site_id)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  //  @IBOutlet weak var w: UIButton!
    // MARK: Swift 3
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      
        
        print("indexPath.section = \(indexPath.section)")
        print("Index Path Row is = \(indexPath)")
        
        if (indexPath.section == 0){
            print("traffic status selection has been called")
     
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

            let vc = storyBoard.instantiateViewController(withIdentifier: "TrafficStatusViewController") as! TrafficStatusViewController
           
            self.navigationController?.pushViewController(vc, animated: true)
            
            print("moving towards TrafficStatusViewController---------")
        
        }
            
        else if (indexPath.section == 6) {
        print("RECENT TRIPS SECTION TOUCHED........")
            var from_Station_ID = String()
            var to_Station_ID = String()
            
            if (indexPath.row == 0){
                print("indexPath 0......")
            from_Station_ID = rec_trip_from_Station_first_row.text!
            to_Station_ID = rec_trip_to_Station_first_row.text!
                
            } else if (indexPath.row == 1) {
            print("indexPath 1......")
                from_Station_ID = rec_trip_from_Station_ID_second_row.text!
            to_Station_ID = rec_trip_to_StationID_second_row.text!
            
            } else if(indexPath.row == 2) {
                print("indexPath 2......")
            from_Station_ID = rec_trip_from_Station_ID_third_Row.text!
            to_Station_ID = rec_trip_to_Station_id_third_Row.text!
            
            }
            print("------S1--------")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            print("------S2--------")
            let vc = storyBoard.instantiateViewController(withIdentifier: "TripSuggestion") as! TripSuggestionsTViewController
            print("------S3--------")
        
            vc.setValue(from_Station_ID, forKey: "from")
            print("------S4--------")
            vc.setValue(to_Station_ID, forKey: "to")
            print("------S5--------")
            vc.setValue("0", forKey: "searchForArrivals")
            print("------S6--------")
            self.navigationController?.pushViewController(vc, animated: true)
            print("------S7--------")
        }
    
    }
    // MARK: Swift 3
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // MARK: Resetting Traffic Status
    print("---------------------------1---------------\(segue.identifier)--")
        advancedOptionsFlag = false
        if(segue.identifier == "showDate"){
            
//            mDelegate  = self
            print("simple date picker called ")
        print("step 1")
        let popOverViewController = segue.destination.popoverPresentationController
        print("step 2")
            popOverViewController!.delegate = self
            
 
        }
        
        if(segue.identifier == "showDatePicker")
        {
            let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            let nav = UINavigationController(rootViewController: popoverContent)
            
            nav.modalPresentationStyle = UIModalPresentationStyle.popover
           
            let popover = nav.popoverPresentationController
            
            // MARK: SWIFT 3 cgrect etc
            popoverContent.preferredContentSize = CGSize(width: 300,height: 200) //CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 300,height: 200)) //CGSizeMake(300,250)
            popover!.delegate = self
            popover!.sourceView = self.view
            //        popover!.sourceRect = CGRectMake(100,100,0,0)
           
            popover!.sourceRect = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 0,height: 400))// CGRectMake(0,400,0,0)
           
            //popover!.sourceRect = CGRectMake(0,400,0,0)
            
            self.present(nav, animated: true, completion: nil)

            popoverContent.delegate = self
        
        }
        if (segue.identifier == "From") {
         
//            origin_StationId = (from_Origin_Input.titleLabel?.text)!
//            destination_StationId = (to_destination_Input.titleLabel?.text)!
//            
//            recent_from_flag = false
            realTimeFlag = true
            advancedOptionsFlag = false
            
            print("from segue has been caught")
            from_to_flag = FROM_ORIGIN
            
        }
        else if (segue.identifier == "To"){
            
//            origin_StationId = (from_Origin_Input.titleLabel?.text)!
//            destination_StationId = (to_destination_Input.titleLabel?.text)!
//            
//            
//            recentr_to_flag = false
            from_to_flag = TO_DESTINATION
            realTimeFlag = true
            advancedOptionsFlag = false
            
            print("to has been caught")
            
            
        }
        
        
        if (segue.identifier == "tripSuggestions" || segue.identifier == "tripSuggestionsNew") || (segue.identifier == "withHeader") {
            print("-Prepare for Segue:----------fromStation_SiteId---\(origin_StationId)------& origin = \(origin)-------2-----------------")
            print("-Prepare for Segue:-----------toStation_SiteId---\(destination_StationId)----Destination = \(destination)---------2-----------------")
            
            from_to_flag = ""
            segue.destination.setValue(origin_StationId, forKey: "from")
            segue.destination.setValue(destination_StationId, forKey: "to")
            segue.destination.setValue("0", forKey: "searchForArrivals")
            }
        /*
        if (segue.identifier == "recent_first_row") {
            print("--recent_first_row---seague------fromStation_SiteId---\(rec_trip_from_Station_first_row)-------------2-----------------")
            print("---recent_first_row------seague--toStation_SiteId---\(rec_trip_to_Station_first_row)-------------2-----------------")
            segue.destination.setValue(rec_trip_from_Station_first_row, forKey: "from")
            segue.destination.setValue(rec_trip_to_Station_first_row, forKey: "to")
            segue.destination.setValue("0", forKey: "searchForArrivals")
        }
         */
        
        
    }
    // MARK: Date Set
    func receiveValueFromPopOver(Date: String, Time: String) {
        
        simple_expectedTripDate = Date
        simple_expectedTripTime = Time
        let showSelectedDateAndTime = Date + " " + Time
        
        print("1-----delegate has returned value= \("valueRecieve= \(showSelectedDateAndTime)")")
        
        dateTimeTrip.titleLabel?.text = showSelectedDateAndTime
        dateTimeTrip.setTitle(showSelectedDateAndTime, for: UIControlState.normal)
        
        
        print("2-----delegate has returned value= \(dateTimeTrip.titleLabel?.text)")
        
        
        print("3-----delegate has returned value= \("valueRecieve= \(showSelectedDateAndTime)")")
        
    }
    
    
//    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
//        print("----------------sssssssss-------------\(dateAndTimeSelection)")
//        
//        dateTimeTrip.setTitle(dateAndTimeSelection, for: UIControlState.normal)
//    }
//    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
        
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("some thing has been selected -------")
    }
    
    
func doSomething(){
        
        print("do some thing has been called")
        
        dateTimeTrip.setTitle(dateAndTimeSelection, for: UIControlState.normal)
    }
  
    
}

protocol MyProtocol: class

{
    func sendValueToPreviousVC (myValue: String)
    
    //print("My Protocol has been called")
    
}

/*
//
//  MainSimpleSearchViewControllerTViewController.swift
//
//
//  Created by syed farrukh Qamar on 09/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class MainSimpleSearchViewControllerTViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

     */
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
 */


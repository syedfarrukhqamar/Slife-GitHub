//
//  SearchTripsTableViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 31/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit


var transportModes = String()

// Trip Time/ Date / Arrival / Departure

var expectedTripDate = String()
var expectedTripTime = String()
var earliestDepartLatestArrival_flag = false
var earliestDepartLatestArrival_Value = 0

// simple options
// Time Table or Real Time
var realTimeFlag = true

// Via Flag
var viaStationFlag = false
var viaStopOverMinutesFlags = false
var stopOverMinutes = 0

// advanced options
// Master reset
var moreOptionsFlag = false

// change or no change flag
let CHANGED = "Changed"
let NOCHANGES = "no changes"

//-1- Intermediate Stops
var intermediateStopsFalg = false
//-2-MARK Transport Type
var transportTypesFlag = false
var transportModeDict = NSMutableDictionary()
var transportModeFlag = false
let useMetro = "useMetro"
let useTrain = "useTrain"
let useTram = "useTram"
let useBus = "useBus"
let useFerry = "useFerry"
let useShip = "useShip"


//-3- Line Choices

var lineChoicesFlag = false


var lineChoiceIncludeOrExclude = String()
var lineChoices = String()

//-4- Walkaway

var walkawayFlag = false
var dataSourceDistancePicker = ["2 km","1 km","500 m","200 m"]
var walkAwaySelection = 0
var canWalkButtonEnabled = false
//-5- Transport Changes
var transportChangesFlag = false
//var transportExtraMinutesFlag = false

var maxTransportChanges = 0 // contains actual figure
var extraTimeBetweenTransportChanges = 0 // contains actual figure
var extraTimeFlag = false
var timeBetweenChangesDataSource = ["2 min","5 min","10 min","15 min"]

//var changesPickerDataSource = [0,1,2,3,4,5]
// data source for timeBetweenChanges

var  changesPickerDataSource = ["No Restriction","No Changes","Max 1 Change","Max 2 Changes","Max 3 Changes"]


class SearchTripsTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate,popOverValue  {

     weak var mDelegate:MyProtocol?
    
 //   @IBOutlet weak var showLineNumbers: UILabel!
    var fromStation_SiteId = String()
    var toStation_SiteId = String()
    var viaStation_SiteId = String()
//    let FROM_ORIGIN = "From"
//    let TO_DESTINATION = "To"
//    let VIA_STATION = "Via"
    //let DEFAULT = "Default"
   // var from_to_flag = String()

var tripDateShow = Bool()
    
    @IBOutlet weak var swapFromTo_Outlet: UIButton!
    @IBAction func swapFromTo(sender: UIButton) {
        
        let origin = from_Origin_Input.titleLabel?.text
        let destination = to_destination_Input.titleLabel?.text
        
        from_Origin_Input.titleLabel?.text = destination
        to_destination_Input.titleLabel?.text = origin
        
    }
    @IBOutlet weak var from_Origin_Input: UIButton!
    @IBOutlet weak var to_destination_Input: UIButton!
    @IBOutlet weak var via_Input: UIButton!
 //   @IBOutlet weak var stopOverMinutes: UIButton!
    
    @IBOutlet weak var stopOverMinutesInput: UITextField!
 //   @IBOutlet weak var stopOverMinutesInput: UITextField!
  
      @IBOutlet weak var walkAwayFlagLabelSummaryScreen: UILabel!
    @IBOutlet weak var whenDoneCell: UITableViewCell!
    
//    @IBOutlet weak var walkAwayFlagLabelSummaryScreen: UITableViewSection!
    @IBOutlet weak var latestArrivalOutlet: UIButton!
    @IBOutlet weak var earliestDepartureOutlet: UIButton!
    @IBOutlet weak var timeTable: UIButton!
    @IBOutlet weak var realTime: UIButton!
    @IBOutlet weak var from_Origin: UIButton!
  //  @IBOutlet weak var to_Destination: UIButton!
    @IBOutlet weak var via_Value: UIButton!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var whenTripDateShow: UIButton!
    @IBOutlet weak var tripDate: UIDatePicker!
   // flags
    @IBOutlet weak var transportModesChangedFlag: UILabel!
    @IBOutlet weak var lineChoicesChangedFlag: UILabel!
  //  @IBOutlet weak var walkawayChangedFlag: UILabel!
    @IBOutlet weak var transportChangesChangedFlag: UILabel!
    @IBOutlet weak var allowAlternativeStopsSwitchValue: UISwitch!
    @IBAction func stopOverMinutesAction(sender: UITextField) {
        
        var test = String()
        
        if(Int(stopOverMinutesInput.text!) == nil){
        
        print("not a number in text")
        
        }
        else {
        
            stopOverMinutes =  NumberFormatter().number(from: stopOverMinutesInput.text!)!.intValue
            print("1---stop over minutes")
            
            if (stopOverMinutes > 0) {
                
                viaStopOverMinutesFlags = true
            } else if ( stopOverMinutes == 0){
                viaStopOverMinutesFlags = false
            }
            
            print("viaStopOverMinutesFlags status = \(viaStopOverMinutesFlags)")
            print("stopOverMinutesInput.text!\(stopOverMinutesInput.text!)")
            
        
        }
        
    
        print("Stop Over Minutes Value is = \(stopOverMinutes)")
    }
    
    @IBAction func switchFromTo(sender: UIButton) {
        let fromValue = from_Origin.titleLabel?.text!
        let toValue = to_destination_Input.titleLabel?.text!
        from_Origin.setTitle(toValue, for: UIControlState.normal )
        to_destination_Input.setTitle(fromValue, for: UIControlState.normal )
    }
    
    /*
    @IBAction func currentDateShow(sender: UIButton) {
       
        print("tripDateShow value should be true")
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // MARK: Swift 3
        popoverContent.preferredContentSize = CGSize(width: 300, height: 250)//CGSizeMake(300,250)
        //popover!.delegate = self
        popover!.sourceView = self.view
        //        popover!.sourceRect = CGRectMake(100,100,0,0)
        
        popover!.sourceRect =  CGRect(origin: CGPoint(x: 0,y:0), size: CGSize(width:0, height:400))
        // CGRectMake(0,400,0,0)
        
        self.present(nav, animated: true, completion: nil)
  //WHenDoneCell is a cell (Pink color old date
       // whenDoneCell.isHidden = false
       // datePickerCell.hidden = false
        tripDateShow = true
        print("tripDateShow value should be true now = \(tripDateShow)")
    }
    */
    @IBAction func latestArrival(sender: UIButton) {
        whenTripDateShow.isUserInteractionEnabled = true
         earliestDepartLatestArrival_Value = 1
         earliestDepartLatestArrival_flag = true
        
        let date = Date()
        let dateFormat = DateFormatter()
        let timeFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy:MM:dd"
        // Mark: Swift 3
        timeFormat.dateFormat = "HH:mm"
        
        //timeFormat.date(dateFormat)
        
        let strDate = dateFormat.string(from: date as Date)
        let strtime = timeFormat.string(from: date as Date)
        
       // let strtime = "swift 3 prob"
       
        let today = strDate + " " + strtime
        whenTripDateShow.setTitle(today, for: UIControlState.normal)
        
        now.backgroundColor = UIColor.white
        now.setTitleColor(UIColor.blue, for: UIControlState.normal)
       
        latestArrivalOutlet.backgroundColor = UIColor.blue
        latestArrivalOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        earliestDepartureOutlet.backgroundColor = UIColor.white
        earliestDepartureOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
       
        tripDateShow = true
        print("LA-tripDateShow = true = \(tripDateShow)")
        print("Latest Arrival:::::::current value of earliestDepLatestArrival is = \(earliestDepartLatestArrival_flag)")
        tableView.reloadData()
    }
    @IBOutlet weak var now: UIButton!
    @IBAction func nowAction(sender: UIButton) {
        
        whenTripDateShow.isUserInteractionEnabled = false
        earliestDepartLatestArrival_Value = 0
        
        now.backgroundColor = UIColor.blue
        now.setTitleColor(UIColor.white, for: UIControlState.normal)
    
        
        earliestDepartLatestArrival_flag = false
        earliestDepartureOutlet.backgroundColor = UIColor.white
        latestArrivalOutlet.backgroundColor = UIColor.white
        
        earliestDepartureOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        latestArrivalOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        expectedTripDate = "yyyy-MM-dd"
        expectedTripTime = "HH:mm"
        tripDateShow = false
        
        whenTripDateShow.setTitle(HelpingMethods.currentDateTime(), for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func earliestDeparture(sender: UIButton) {
        whenTripDateShow.isUserInteractionEnabled = true
        earliestDepartLatestArrival_Value = 0
        earliestDepartLatestArrival_flag = true
        let date = NSDate()
        let dateFormat = DateFormatter()
        let timeFormat = DateFormatter()
        

        dateFormat.dateFormat = "yyyy:MM:dd"
        timeFormat.dateFormat = "HH:mm"
        let strDate = dateFormat.string(from: date as Date)
        let strtime = timeFormat.string(from: date as Date)
        let today = strDate + " " + strtime
        whenTripDateShow.setTitle(today, for: UIControlState.normal)
        tripDateShow = true

        
        now.backgroundColor = UIColor.white
        now.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        latestArrivalOutlet.backgroundColor = UIColor.white
        latestArrivalOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        earliestDepartureOutlet.backgroundColor = UIColor.blue
        earliestDepartureOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        print("ED-tripDateShow = true = \(tripDateShow)")
        print("earliestDeparture:::::current value of earliestDepLatestArrival is = \(earliestDepartLatestArrival_flag)")
        tableView.reloadData() 
    }
    
    
    @IBAction func accessTimeTable(sender: UIButton) {
        
        timeTable.backgroundColor = UIColor.blue
        timeTable.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        realTime.backgroundColor = UIColor.white
        realTime.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        // false if user wants to see the time table
        
        
        print("accessTimeTable: old current realTimeFlag Value is = \(realTimeFlag)")
        realTimeFlag = false
        print("accessTimeTable: current realTimeFlag Value is = \(realTimeFlag)")
    }
    
    @IBAction func accessRealTime(sender: UIButton) {
        // false if user wants to see the REAL TIME DATA
        // BY DEFAULT THE VALUE IS TRUE MEANS realtime
        timeTable.backgroundColor = UIColor.white
        timeTable.setTitleColor(UIColor.blue, for: UIControlState.normal)
        realTime.backgroundColor = UIColor.blue
        realTime.setTitleColor(UIColor.white, for: UIControlState.normal)
        print("Real time: old realTimeFlag Value is = \(realTimeFlag)")
        realTimeFlag = true
        print("Real time: current realTimeFlag Value is = \(realTimeFlag)")
        
    }
   //MARK: OLD PINK DATE PICKER
    /*
    @IBOutlet weak var showDateTimePicker: UIButton!
 */
 //MARK: ADVANCE DATE PICKER REAL
    @IBAction func showDate_advance_Picker(_ sender: UIButton) {
        
        print("showDate_advance_Picker:::adv:::::1:")
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // MARK: Swift 3
        print("showDate_advance_Picker::::adv::::2:")
        
        popoverContent.preferredContentSize = CGSize(width: 300, height: 250)//CGSizeMake(300,250)
        popover!.delegate = self
        popover!.sourceView = self.view
        //        popover!.sourceRect = CGRectMake(100,100,0,0)
        print("showdate Time Picker Action:::adv:::::3:")
        popover!.sourceRect =  CGRect(origin: CGPoint(x: 0,y:0), size: CGSize(width:0, height:400))
        // CGRectMake(0,400,0,0)
        print("showdate Time Picker Action::::adv::::4:")
        self.present(nav, animated: true, completion: nil)
        
        popoverContent.delegate = self

    }
// MARK: OLD PINK DATE PICKER
    /*
    @IBAction func showDateTimePickerAction(sender: UIButton) {
        print("showdate Time Picker Action::::::::1:")
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // MARK: Swift 3
        print("showdate Time Picker Action::::::::2:")
        
        popoverContent.preferredContentSize = CGSize(width: 300, height: 250)//CGSizeMake(300,250)
        popover!.delegate = self
        popover!.sourceView = self.view
        //        popover!.sourceRect = CGRectMake(100,100,0,0)
              print("showdate Time Picker Action::::::::3:")
        popover!.sourceRect =  CGRect(origin: CGPoint(x: 0,y:0), size: CGSize(width:0, height:400))
        // CGRectMake(0,400,0,0)
              print("showdate Time Picker Action::::::::4:")
        self.present(nav, animated: true, completion: nil)
        
        popoverContent.delegate = self

    }
*/
//    @IBAction func showDate(sender: UIDatePicker) {
//        
//        print(tripDate.date)
//        
//    }
// 
    // MARK: OLD DATE PICKER PINK
    /*
    @IBAction func doneDatePickAction(sender: UIButton) {
        // whenDoneCell.hidden = false
        // datePickerCell.hidden = true
         // tripDateShow = false
        print("tripDateShow value should be false = \(tripDateShow)")
        var dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        dateFormatter.dateFormat = "yyyy-MM-dd"
      
       // print("tripdate.date ====\(String(tripDate.date))")
        print("tripDate.date.......\(tripDate.date)")
        var strDate = dateFormatter.string(from: tripDate.date)
        var strTime = timeFormatter.string(from: tripDate.date)
        print(".-........-.-")
        print(strTime)
        print(".-........-.-")
        print(strDate)
        print(".-........-.-")
//        self.selectedDate.text = strDate
         let dateShow = strDate + "--"+strTime
      
        expectedTripDate = strDate
        expectedTripTime = strTime
        //tripDateTime_Flag = true
    whenTripDateShow.setTitle(dateShow, for: UIControlState.normal)
        tableView.reloadData()
    }
    
    */
    @IBOutlet weak var clearViaOutlet: UIButton!
    @IBAction func allowAlternativeStops(sender: UISwitch) {
    print("allow alternative stops.................")
    print(allowAlternativeStopsSwitchValue.isOn)
  
    
    }
    
    @IBAction func clearVia(sender: UIButton) {

        
        viaStationFlag = false
        viaStopOverMinutesFlags = false
        
        stopOverMinutesInput.isUserInteractionEnabled = false
        
        clearViaOutlet.backgroundColor = UIColor.white
        clearViaOutlet.setTitle("Via", for: UIControlState.normal)
       // clearViaOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        via_Input.setTitle("Via", for: UIControlState.normal)
        stopOverMinutesInput.backgroundColor = UIColor.lightGray
        stopOverMinutesInput.text = "0"
        stopOverMinutes = 0
        
        
    }
    override func viewDidLoad() {

        super.viewDidLoad()
    
        
        
          print("view didLoad has been called---0909--")
        
        print("from_Origin_Input = \(from_Origin_Input.titleLabel?.text!)")
        print("to_destination_Input-= \(to_destination_Input.titleLabel?.text!)")
        
//        
//        if (from_Origin_Input.titleLabel?.text! != "From") && (to_destination_Input.titleLabel?.text! != "To")
//        {
//            print("------should be enabled both---------")
//            swapFromTo_Outlet.enabled = true
//            self.navigationItem.rightBarButtonItem?.enabled = true
//        }
//        else {
//            print("--both advanced disabled------------")
//            
//        swapFromTo_Outlet.enabled = false
//        self.navigationItem.rightBarButtonItem?.enabled = false
//        }
        
//        tableView.estimatedRowHeight = 89
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedSectionHeaderHeight = 89
//        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
//        
        whenDoneCell.isHidden = true
       // datePickerCell.hidden = true
//        
        whenDoneCell.sizeToFit()
        print("TESTING ......1..")

      //  datePickerCell.sizeToFit()
        
        print("TESTING ........")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
      
        //MARK: Error Check Alert
        // enabling now button
        if (errorCode_generic_flag == true) {
            errorCode_generic_flag = false
           //  self.title = "Error Reported...."
            print("error Code has been caught... error should be displayed....")
            // genericErrorDisplay.isHidden = false
            //            error_Title_Display_Outlet.titleLabel?.text = "Network Problem"
            //            error_Message_Display_Outlet.titleLabel?.text = "Please Try Again after checking your internet connection!"
            //            error_Title_Display_Outlet.setTitleColor(UIColor.red, for: .normal)
            //            error_Message_Display_Outlet.setTitleColor(UIColor.red, for: .normal)
            let real_titleAlert = "Network Problem:" + errorCode_generic
            let real_titleMessage = errorMessage_generic
            print("Error:101: \(real_titleMessage)")
            let display_message = real_titleMessage
            let alert = UIAlertController(title: real_titleAlert, message: display_message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //   genericErrorDisplay.backgroundColor = UIColor.red
            print("Error Code flag is Red..........")
        }
        else {
            
            errorMessage_generic = String()
            errorCode_generic = String()
            errorCode_generic_flag = false
            
            // genericErrorDisplay.isHidden = true
            //            error_Title_Display_Outlet.titleLabel?.text = ""
            //            error_Message_Display_Outlet.titleLabel?.text = ""
            //            error_Title_Display_Outlet.setTitleColor(UIColor.red, for: .normal)
            //            error_Message_Display_Outlet.setTitleColor(UIColor.red, for: .normal)
            
            
           
            // genericErrorDisplay.backgroundColor = UIColor.white
            print("Error Code flag is White:: No Error Found..........")
            
            
        }
        
        
        
        // set current date and time
        print("view will appear advanced has been called....  ")
        print("from origin input.title Label = \(from_Origin_Input.titleLabel?.text)")
        print("to Destination input.title Label = \(to_destination_Input.titleLabel?.text )")
        
                //MARK: SET CURRENT DATE
        //showDateTimePicker.setTitle(HelpingMethods.currentDateTime(), for: UIControlState.normal)
        
        if (earliestDepartLatestArrival_flag == false){
        // done
        now.backgroundColor = UIColor.blue
            now.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            let date = NSDate()
            let dateFormat = DateFormatter()
            let timeFormat = DateFormatter()
             dateFormat.dateFormat = "yyyy:MM:dd"
            timeFormat.dateFormat = "HH:mm"
            let strDate = dateFormat.string(from: date as Date)
            let strtime = timeFormat.string(from: date as Date)
            _ = strDate + " " + strtime
            whenTripDateShow.setTitle(HelpingMethods.currentDateTime(), for: UIControlState.normal)
            tripDateShow = true
            whenTripDateShow.isUserInteractionEnabled = false
            Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: now, disableButtonSecond: earliestDepartureOutlet, disableButtonThird: latestArrivalOutlet)
           
            expectedTripTime = HelpingMethods.currentTime24Hour()
            expectedTripDate = HelpingMethods.currentDate()
            
            tableView.reloadData()
        } else if (earliestDepartLatestArrival_flag == true){
        
            
            let tripDateTime_Simple = expectedTripDate + "-" + expectedTripTime
            
            print("Last Saved Date & Time = \(tripDateTime_Simple)")
            
            whenTripDateShow.setTitle(tripDateTime_Simple, for: .normal)
            
            
            if(earliestDepartLatestArrival_Value == 0){
                
            Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: earliestDepartureOutlet, disableButtonSecond: now, disableButtonThird: latestArrivalOutlet)
            
            } else if (earliestDepartLatestArrival_Value == 1) {
            
                
                Buttons.enableOneAndDisableTwoButtons(enableButtonFirst: latestArrivalOutlet, disableButtonSecond: now, disableButtonThird: earliestDepartureOutlet)
            }
        }
       //-------from --To---Via---start
        print("-selected index path-----viewWillAppear----)")
        
        if (from_to_flag == FROM_ORIGIN){
            origin = from_to_value
            
            from_Origin_Input.setTitle(origin, for: .normal)
            
            // = from_to_value
            print("from value is =origin= \(origin)")
            print("..................from origin input.........")
            print(from_Origin_Input.title(for: .normal))
            origin_StationId = station.site_id
           // from_to_value = ""
            
        } else if (from_to_flag == TO_DESTINATION){
            
            destination = from_to_value
            to_destination_Input.setTitle(destination, for: .normal)
            print("to value is in search trip controller =destination \(destination)")
            destination_StationId = station.site_id
            //from_to_value = ""
            
        }
        else if (from_to_flag == VIA_DESTINATION){
            stopOverMinutesInput.backgroundColor = UIColor.white
            
            viaStationFlag = true
             stopOverMinutesInput.isUserInteractionEnabled = true
            clearViaOutlet.backgroundColor = UIColor.blue
            clearViaOutlet.setTitle("X", for: UIControlState.normal)
            clearViaOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)

            
            via = from_to_value
        via_Input.setTitle(from_to_value, for: .normal)
        via_StationId = station.site_id
            
            print("-via destination---via--\(via)")
            //from_to_value = ""
        }
        
        from_Origin_Input.setTitle(origin, for: .normal)
        to_destination_Input.setTitle(destination, for: .normal)
        via_Input.setTitle(via, for: .normal)
       print("-station.site_id-----\(station.site_id)")
       
        // -------from---to-via----end
        print("view will appear has been called-----")

        // MARK: intermediate stop
        
        // MARK: transport type
       if (transportTypesFlag == true ){
            print(transportModeDict)
             print("transportTypesFlag latest value in SearchTrips = true? \(transportTypesFlag)")
            transportModesChangedFlag.text = CHANGED
        } else {
             print("transportTypesFlag latest value in SearchTrips = false? \(transportTypesFlag)")
            transportModesChangedFlag.text = NOCHANGES
            print(transportModeDict)
        }
        // MARK: line choices
        
        if (lineChoicesFlag == true)
        {
            //showLineNumbers.text = lineChoicesDetails[0]
            lineChoicesChangedFlag.text = CHANGED
            print("Line Choices Flag is (true) = \(lineChoicesFlag)----")
            print("True:Line Choice was \(walkAwaySelection)")
            print("lineChoicesDetails[0]  =\(lineChoicesDetails[0]) \(lineChoicesFlag)----")
            
        }
        else {
            lineChoicesChangedFlag.text = NOCHANGES
            print("Line Choices Flag is (false) = \(lineChoicesFlag)----")
            print("false:Line Choice was \(walkAwaySelection)")
            print("lineChoicesDetails[0]  =\(lineChoicesDetails[0]) \(lineChoicesFlag)----")
            
        }
        // MARK: walkaway
        print("walk away flag value is =====\(walkawayFlag)")
        print("walkwawy status label value is = \(walkAwayFlagLabelSummaryScreen.text)")
        if (walkawayFlag == false){
            print("Walk Away Flag =false... \(walkawayFlag)")
            
            walkAwayFlagLabelSummaryScreen.text = NOCHANGES
            
        } else if (walkawayFlag == true){
        
            walkAwayFlagLabelSummaryScreen.text = CHANGED
        
        
        }
        // MARK: transportation changes
        if (transportChangesFlag == true){
        
        transportChangesChangedFlag.text = CHANGED
        
        } else if (transportChangesFlag == false){
            
            transportChangesChangedFlag.text = NOCHANGES
        
        
        }
        
        
        //---------------- start
        
        
        print("from_Origin_Input.titleLabel?.text view will appear = advanced = \(from_Origin_Input.titleLabel?.text)")
        print("to_destination_Input.titleLabel?.text?.text view will appear = advanced = \(to_destination_Input.titleLabel?.text)")
        
        
        if(from_Origin_Input.title(for: .normal) == "From"){
            
            navigationItem.rightBarButtonItem?.isEnabled = false
            swapFromTo_Outlet.isEnabled = false
            
            print("++adv++++++FROM+++++++++++++++++CAUGHT")
            
            
            
        } else if (to_destination_Input.title(for: .normal) == "To") {
            navigationItem.rightBarButtonItem?.isEnabled = false
            swapFromTo_Outlet.isEnabled = false
            
            print("++adv++++++To+++++++++++++++++CAUGHT")
            
        } else {
            
            print("++adv++++++else caught ++from and to has some value+++++++++++++++++CAUGHT")
            
            
            if ( from_Origin_Input.title(for: .normal) != to_destination_Input.title(for: .normal)){
                
                print("adv----From and To are not same.... should be enabled....")

                navigationItem.rightBarButtonItem?.isEnabled = true
                swapFromTo_Outlet.isEnabled = true
                
            }
            else {
                
                navigationItem.rightBarButtonItem?.isEnabled = false
                swapFromTo_Outlet.isEnabled = false

                print("adv----From and To should not be same")
            }
        }
        
    
        
        //---------------- end

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      print("---tableview.rowHeight---\(super.tableView(tableView, heightForRowAt: indexPath))")
     
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
    
//        print("------cell.height ? =\(cell?.bounds)")
         print("index.section general value is = \(indexPath.section)")
         print("index.section.row is  general value is = \(indexPath.row)")
       
       // print("hieg-----tripDateShow  = \(tripDateShow)")
        
        if (indexPath.section == 2 && tripDateShow == true){
            
             print("indexPath.section = \(indexPath.section)")
            if (indexPath.row == 2){
                 print("indexPath.row = \(indexPath.row)")
            return 50
            }
        }
        else if (indexPath.section == 2 && tripDateShow == false)
        {
            if (indexPath.row == 2 || indexPath.row == 1){
                print("indexPath.row = \(indexPath.row)")
                return 0
            }
    }
        
            //return UITableViewAutomaticDimension
        
        
            return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    // MARK: Date Set
    func receiveValueFromPopOver(Date: String, Time: String) {
        expectedTripDate = Date
        expectedTripTime = Time
        
//        simple_expectedTripDate = Date
//        simple_expectedTripTime = Time

        let showSelectedDateAndTime = Date + " " + Time
        
        print("1--advance---delegate has returned value= \("valueRecieve= \(showSelectedDateAndTime)")")
        
        
        whenTripDateShow.titleLabel?.text = showSelectedDateAndTime
        whenTripDateShow.setTitle(showSelectedDateAndTime, for: UIControlState.normal)
        
        
        print("2--advance---delegate has returned value= \(whenTripDateShow.titleLabel?.text)")
        
        
        print("3--advance---delegate has returned value= \("valueRecieve= \(showSelectedDateAndTime)")")
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showDate_advance"){
            
            //            mDelegate  = self
            
            print("step 1")
            let popOverViewController = segue.destination.popoverPresentationController
            print("step 2")
          //  popOverViewController!.delegate = self
            
            
        }
        

        
        
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        advancedOptionsFlag = true
        print("---------------------------1---------------\(segue.identifier)--")
        
        if (segue.identifier == FROM_ORIGIN) {
            print("from segue has been caught")
            from_to_flag = FROM_ORIGIN
            
        }
        else if (segue.identifier == TO_DESTINATION){
            from_to_flag = TO_DESTINATION
            print("to has been caught")
            
            
        }
     
        else if (segue.identifier == VIA_DESTINATION){
            from_to_flag = VIA_DESTINATION
            print("Via has been caught")
            
        }
        
        if (segue.identifier == "tripSuggestions" || segue.identifier == "tripSuggestionsNew") || (segue.identifier == "withHeader") {
         
            print("--------2---------origin_StationId=\(origin_StationId)--------")
            print("--------2---------Destination_StationId=\(destination_StationId)--------")
            
            segue.destination.setValue(origin_StationId, forKey: "from")
            segue.destination.setValue(destination_StationId, forKey: "to")
            // now reset the values of from and to
            
//            fromStation_SiteId = ""
//            toStation_SiteId = ""
//            from_Origin_Input.setTitle("", forState: .Normal)
//            to_destination_Input.setTitle("", forState: .Normal)
//            from_to_value = ""
            
            //                    segue.destinationViewController.setValue(from_Origin_Input.titleLabel, forKey: "from")
            //                    segue.destinationViewController.setValue(to_destination_Input.titleLabel, forKey: "to")
            //
            segue.destination.setValue("0", forKey: "searchForArrivals")
        }

        
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        <#code#>
//    }
//    
//    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
        
//        if (section == 2){
//        
//        print("section 2 has been caught here ...................")
//        return 10
//        }
        return 10
    }
  
    // MARK: - Table view data source
/*
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

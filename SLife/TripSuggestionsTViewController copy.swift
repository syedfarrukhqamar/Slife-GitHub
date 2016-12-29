/* switching off completely 23rdec 0835 start ....
//  TableViewController.swift
//  headerSectionTableView
//
//  Created by syed farrukh Qamar on 25/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.

import UIKit
import QuartzCore
/* redeclaration probelm
var convertedJsonIntoNSDict1 = NSDictionary()
var selectedLegJourneyDetailedRef = String()
var tripRootMapFlag = false
var rootMap_Geom_Ref = String()
var rootMap_Ref = String()
var rootMap_Ref_Dict = NSMutableDictionary()
var colorFlag = true
// Being used in custom trips for next departures in trip info
// MARK: Border Header & Trip Info Rounded Corner
let headerBorderWidth = CGFloat(4.0)
let cellBorderWidth = CGFloat(0.2)

// icon & row sizes
var headerHeightDict = NSMutableDictionary()
// stack view height is 68
let headerCell_StackView_Height = 15 + 70 + 15

//let default_startingPoint = CGPoint(x: 5.0,y: legIcons_y!)
let defaultBottomSpaceLeave = 15.0
let defaultTopSpaceLeave = 15.0
let defaultStackViewBottomSpaceBeforeIconLeave = 10

let default_startingSize = CGSize(width:35.0,height:35.0)
let default_orientation = "x"  // x, y, or xy
let default_innerSpacing = CGPoint(x:-1,y:0)
let default_innerLegSpacing = CGPoint(x:10,y:0)
let default_sizeFactor = CGSize(width: 0.0,height: 0.0)

let cellBackgroundColor = UIColor(red: (235/255), green: (236/255), blue: (237/255), alpha: 1.0)
//----------------------------------------------------------------
let headerRowDefaultColor = UIColor(red: (235/255), green: (237/255), blue: (237/255), alpha: 1.0)
let originTextColor = UIColor(red: (0/255), green: (104/255), blue: (55/255), alpha: 1.0)
let originColor = UIColor(red: (180/255), green: (239/255), blue: (186/255), alpha: 1.0)
let detinationTextColor = UIColor.red

let destinationColor = UIColor(red: (247/255), green: (121/255), blue: (121/255), alpha: 1.0)

let legColorFirst = UIColor(red: (242/255), green: (228/255), blue: (160/255), alpha: 1.0).cgColor
let legColorSecond = UIColor(red: (146/255), green: (172/255), blue: (244/255), alpha: 1.0).cgColor
//----------------------------------------------------------------
let headerRowSelectedColor =  UIColor(red: (206/255), green: (229/255), blue: (242/255), alpha: 1.0)
//let headerRowDefaultColor =  UIColor.white

var custom_Trip_NextDepartures_Dict = NSMutableDictionary()
var collectionCellColor = false
 var oldSectionValue = -10

let studentName = ["Stockholm","London","Paris","Oslo","Stockholm","London","Paris","Oslo","Stockholm","London","Paris","Oslo"]
let firstLegImage   = "firstLeg.png"
let middleLegImage  = "middleLeg.png"
let lastLegImage    = "lastLeg.png"
let onlyLegImage    = "onlyLeg.png"

*/
class TripSuggestionsTViewControllerCopy: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
   func Clicked(sender: UIButton) {
    let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
    let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
    // set value for show hide cell
    print("Sender's tag is = \(sender.tag)")
    print("Current tag of header cell when button clicked s = \(currentCell.tag)")
    print("Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
    if (currentHeaderTrip.showHideCell == true) {
    
    
        sender.backgroundColor = UIColor.red
        currentHeaderTrip.showHideCell = false
    } else {
        
        sender.backgroundColor = UIColor.green
        
        currentHeaderTrip.showHideCell = true
        
    
    }
    }
    
    func Clicked2(sender: UIButton) {
        let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
        let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
        // set value for show hide cell
        
        print("Current tag of header cell when button clicked s = \(currentCell.tag)")
        print("Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
        if (currentHeaderTrip.showHideCell == true) {
            
            
            sender.backgroundColor = UIColor.red
            currentHeaderTrip.showHideCell = false
        } else {
            
            sender.backgroundColor = UIColor.green
            
            currentHeaderTrip.showHideCell = true
            
            
        }
        

    
    print("After:current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
    
    print("Current Cell clicked by bytton = \(currentCell.from_station)")
    
        print("Button Clicked..............\(sender.tag)...")
    tableView.reloadData()
        
    }
    
    //  @IBOutlet weak var showNextDeparturesIn_TripInfoAction: UIButton!
    var showTripDetail_Dict = NSMutableDictionary()
    var showNextDeparturesTripInfo = NSMutableDictionary()
    var nextDepartureMasterDict = NSMutableDictionary()
    var showDeparture = false
    var departureCounter = 0
    
    var transportTypeFlag = String()
    
    // show hide trip info
    var showTripInfo = false
    var sectionShow = 10
    var showHideArray = [Bool]()
    
    //Mark: Autolayout Variables
    var legIconsLineCounter = 0
    let legIconsHeight = default_startingSize.height
    let headerCellHeight = 90 //100 //80 //60
    var legIconsLineTerminateCount = 1
    
    //  @IBOutlet weak var mapReferenceAction: UIButton!
    //    MARK:- showTripOnMapAction
    var addToFav_flag = false
    @IBAction func addToFavourite(sender: UIBarButtonItem) {
        
        print("--------from-------------")
        print(sr_fromStation_name)
        print(sr_fromStation_id)
        print("--------To-------------")
        print(sr_toStation_name)
        print(sr_toStation_ID)
        
        if (addToFav_flag == false){
            print("--------from---inside add to fav----------")
            
            SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: FAVOURITES)
            addToFav_flag = true
        }
        else {
            
            print("Already added......")
            
        }
    }
    
    @IBAction func showTripOnMapAction(sender: UIButton) {
        print("showTripOnMapAction .......")
        
        print("newTrip.count = \(newTrip.count)")
        print("sender.tag\(sender.tag)")
        
        let tripCell = newTrip[sender.tag - 1] as! Trip
        
        print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
        selectedRootTripForMap = tripCell.LegList
        //
        print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
        //
        //        print("\()")
        rootMap_Ref =   rootMap_Ref_Dict.value(forKey: String(sender.tag)) as! String
        
        tripRootMapFlag = true
        print("map Referrence Action = \(rootMap_Ref)")
    }
    
    @IBAction func mapReferenceAction(sender: UIButton) {
        
        let tripCell = newTrip[sender.tag - 1] as! Trip
        selectedRootTripForMap = tripCell.LegList
        //
        print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
        //
        //        print("\()")
        rootMap_Ref =   rootMap_Ref_Dict.value(forKey: String(sender.tag)) as! String
        
        tripRootMapFlag = true
        print("map Referrence Action = \(rootMap_Ref)")
    }
    
    @IBAction func showNextDepartures_InTripInfo(_ sender: UIButton) {
    print("showNextDepartures_InTripInfo has been Pressed :::::::::::::")
        //     let currentCell = sender.superview as! LegListCells
        //  if(newTrip.count != 0) {
        
        
        var clicked = false
        
        let button = sender as! UIButton
        let view = button.superview!
        //MARK: Departure temp off 9th nov 8pm
        // get values from the departure button clicked (from its super view)
           
        let currentCell = view.superview as! LegListCells
            let departureCellIndex = Int(currentCell.rowInfo)! + 1
            print("current cell show hidden value is = \(currentCell.showHideDepartureCell)")
        
        if (currentCell.showHideDepartureCell == false){
            // before cell was hidden
            // show departure cell
            let image = UIImage(contentsOfFile: "TripInfoDeparturesSelected.png")
            currentCell.nextDeparturesOutlet.setImage(image, for: .normal)
            // get the data
        //---------------------------end departure collection view old
        let customTripClass = CustomTripMethods()
            print("about to call webservice ......")
        customTripClass.get_data_from_url(from: currentCell.from_station.text!, to: currentCell.to_station.text!, tableView: tableView, headerSectionId: currentCell.sectionInfo, legRow_id: String((Int(currentCell.rowInfo)! + 1)))
       //MARK: EXTRA
            // insert into newtrip
            print("Custom Trip Next Departure dict status = \(custom_Trip_NextDepartures_Dict.count)")
//            if (custom_Trip_NextDepartures_Dict.count != 0)
//            {
                // MARK: replace it later with collection dict
                let newDepartureObject = TripInfoDepartures()
                print("Adding in new trip ........")
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(newDepartureObject, at: departureCellIndex)
                
            //    (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(custom_Trip_NextDepartures_Dict, at: departureCellIndex)
         //   }
            currentCell.showHideDepartureCell = true
            print("setting value to true for currentcell.showhide........")
            }
            else if (currentCell.showHideDepartureCell == true)
        {
            print("setting value to false......and removing object.......")
            let image = UIImage(contentsOfFile: "TripInfoDepartures.png")
            currentCell.nextDeparturesOutlet.setImage(image, for: .normal)
            
            print("Before Removal::::tableviews current count = \(tableView.subviews.count)")
            (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.removeObject(at: departureCellIndex)
            
            
            currentCell.showHideDepartureCell = false
//           
//            tableView.subviews[0].removeFromSuperview()
//            tableView.subviews[1].removeFromSuperview()
//            
        //    tableView.subviews[2].removeFromSuperview()
            
            tableView.reloadData()
            
        print("Removed:::::tableviews current count = \(tableView.subviews.count)")
      
            
            print("Removed:::::tableviews current count = \(tableView.subviews.count)")
        }
        // Departure new code start 9th nov 10Am friday 2016-----start
        // 1) get current section and index
        print("newtrip count = in departure action = \(newTrip.count)")
      
            // 1.1) check current object
        // MARK: temp off departures 9pm 9th nov
            
            /*
            let tripLegOrDepartureObject = (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList[Int(currentCell.rowInfo)!] as! AnyObject
            // 1.1.1) if LEG then add departure object
            print("checking for type of object received ::::::.")
            if (RealTidMethods.checkIfLeg(objectToCheck: tripLegOrDepartureObject)){
                // add leg object after the current index
                print("current index = \(currentCell.rowInfo)")
                print("Leg is present inside........")
                
                let newDepartureObject = TripInfoDepartures()
                print("adding  departure object in the trip.... at index = \(currentCell.rowInfo)")
                let trip = newTrip[Int(currentCell.sectionInfo)!] as! Trip
                
                print("\(trip.LegList.count)")
                
           print("Before Adding NewTrip.Leglist.Count = \(trip.LegList.count)")
                let departureCellIndex = Int(currentCell.rowInfo)! + 1
                print("Deprture Cell Index ======== \(departureCellIndex)")
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(newDepartureObject, at: departureCellIndex)
                //let trip = newTrip(Int(currentCell.sectionInfo) as! Trip
//                let LegList = trip.LegList.count
                print("After Adding...NewTrip.Leglist.Count = \(trip.LegList.count)")
                
            }
                // 1.1.2) if DEPARTURE then remove departure object
                
            else if (RealTidMethods.checkIfDepartureObject(objectToCheck: tripLegOrDepartureObject)){
            
//            let departureObjectToRemove = 
                // Remove the current object at current rwo for current section within the newtrip
                let trip = newTrip[Int(currentCell.sectionInfo)!] as! Trip
              
                
                print("Before Removing Depart object = \(trip.LegList.count)")
           
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.removeObject(at: Int(currentCell.rowInfo)!)
                
                
         
                print("After Removing..Departure Object = \(trip.LegList.count)")
                
                
            
            
            }
        
        */
        
        // depart new code 9th nov friday -----------------------end
        
        //----------------------------------------------
        
        
        // Update Master Departure
        /* //------temp off 9th nov friday 10Am

        var currentSectionDict = nextDepartureMasterDict.value(forKey: String(currentCell.sectionInfo)) as! NSMutableDictionary
        print("All keys in next departureMasterDict = \(nextDepartureMasterDict.allKeys)")
        print("All keys in current section dict = Trip Info Level = \(currentSectionDict)")
        
        // get section and row as key
        let currentTripInfoCellValue = currentSectionDict.value(forKey: String(currentCell.rowInfo)) as! Int
        print("Current Cell Section = \(currentCell.sectionInfo) && Row = \(currentCell.rowInfo)")
        
        print("current Trip info CEll Value = \(currentTripInfoCellValue)")
        if (currentTripInfoCellValue == 0){
            
            currentSectionDict.setValue(1, forKey: String(currentCell.rowInfo))
            
            print("old=0new value for the current row = \(currentCell.rowInfo) = 1)")
            
            
        } else if (currentTripInfoCellValue == 1){
            
            
            currentSectionDict.setValue(0, forKey: String(currentCell.rowInfo))
            
            print("old=1 new value for the current row = \(currentCell.rowInfo) = 0)")
            
        }
         
         
         nextDepartureMasterDict.setValue(currentSectionDict, forKey: String(currentCell.sectionInfo))
         
 */ //        temp off 9th nov friday 10AM
        
        // update the tripinfo value against respective section
        
        
        
        
        // get section as key
        
        // receive dict and then receive value from index.row as key
        
        
        //----------------------------------------------
        print("current button tag =  \(sender.tag)" )
        
        // let indexPath = itemTable.indexPathForCell(currentCell)
        
        print("currentcell.sectioninfo & row = \(currentCell.sectionInfo) & \(currentCell.rowInfo)")
        
        print("currentCell.from_station.text station= \(currentCell.from_station.text)")
        
        print("current cell values  to station = \(currentCell.to_station.text)")
        
         // tableView.reloadData()
    
        
        //}
        }
    // Leg Image Names
    //MARK: Show Trip Details
    @IBAction func sectionAction(sender: UIButton) {
        print("section button is pressed with :\(sender.state) ")
        
        print(sender.tag)
        sectionShow = sender.tag
        print("Section Show sender = \(sectionShow)")
        print("Dict Section Show current keys = \(showTripDetail_Dict.allKeys)")
      var button = sender
        
        let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(sectionShow))
        print("---------show more pressed............trip_detail_flag=\(trip_detail_flag)")
        
            print("---------show more pressed............end")
        
        //        let testing = sender.superview as! HeaderCells
        //        testing.backgroundColor = UIColor.red
        // MARK: Show /Hide Trip Info
        if (trip_detail_flag.contains("null"))
        {
            button.isSelected = true
            print("Button current state in = null = \(button.state)")
           // button.state = UIControlState.selected
            
            print("show Trip info now for......")
            //             let valueNowb4 = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            //
            print("-------null caught on section === \(sectionShow))")
            
            
            showTripDetail_Dict.setValue(true, forKey: String(
                sectionShow))
            let valueNow = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            
            print("now = in null \(valueNow)")
            
        }
        else
        {
            
            
            let  valueNowb4_true = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            
            
            print("-------NOT null caught on section === \(sectionShow))")
            
            if (valueNowb4_true == true){
                
                button.isSelected = false
                print("Button current state in = True = \(button.state)")
 
                
                print("value was true ....trip info switch off....")
                showTripDetail_Dict.setValue(false, forKey: String(
                    sectionShow))
                
                
            }
            else if (valueNowb4_true == false) {
                
                button.isSelected = true
                print("Button current state in = false = \(button.state)")
                
                showTripDetail_Dict.setValue(true, forKey: String(
                    sectionShow))
                
                
            }
            //   print("current value of flag is=b4=true = \(valueNowb4_true)")
            let valueNow = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            print("-------------section #  \(sectionShow)")
            
            print("--------------------------------------now = \(valueNow)")
            print("Total keys in showtripDetail Dict = \(showTripDetail_Dict.allKeys)")
            print("key count is = \(showTripDetail_Dict.count)")
            
            
        }
        
        
        
        print("Button current state = \(button.state)")
        print("Before setting button current image = \(button.currentImage)")
        
        
   // button.setImage(UIImage(named:"Plus_Close.png"), for: UIControlState.normal)
        
        button.setBackgroundImage(UIImage(named:"Plus_Close.png"), for: UIControlState.init(rawValue: 1))
        button.setBackgroundImage(UIImage(named:"Plus_options.png"), for: UIControlState.init(rawValue: 5))
        
        
        print("button . tag = \(button.tag)")
//        button.backgroundColor = UIColor.red
//        button.setTitle("SOME", for: UIControlState.normal)
//        //button.setBackgroundImage(UIImage(named:"Plus_options.png"), for: UIControlState.selected)
        print("After setting button current image = \(button.currentImage)")
        
        tableView.reloadData()
        
    }
    
    //MARK: Old Leg Image Constant Place
    
    // Header Data Source--( Sections
    var newTrip = NSMutableArray()
    
    // Rows Data Source
    
    //    var newTrip = [Trip]()
    let legList = ["test-0","test-1","test-2"]
    //    var trips = [Trips]()
    
    var from = String()
    var to = String()
    var searchForArrivals = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: AutoRowHeight
        // tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //        tableView.estimatedSectionHeaderHeight = 100
        //        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        tripRootMapFlag = false
        
        // print("-selected index path---------\(self.tableView.indexPathForSelectedRow)")
        let searchTrips = WebServiceHandler()
        var url = String()
        
        print("from = = = = = \(from)")
        print("to = = = = = \(to)")
        
        // recent trips addition
        // MARK: Recent Trips Adding
        
        
        print(" sr_fromStation_id \(sr_fromStation_id) && count is \(sr_fromStation_id.characters.count)")
        print(" sr_fromStation_id \(sr_toStation_ID) && count is \(sr_toStation_ID.characters.count)")
        
        SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
        //
        //        if (advancedOptionsFlag == false){
        //         url = searchTrips.constructURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
        if (advancedOptionsFlag == false){
            // coming from simple screen
            
            self.title = simple_expectedTripDate + "-" + simple_expectedTripTime
            
            url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
            // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            //             from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
        } else if (advancedOptionsFlag == true){
            
            self.title = expectedTripDate + "-" + expectedTripTime
            
            //        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
        }
        print("-------------------url----\(url)")
        get_data_from_url(url: url)
        print("-----------------------ended--090")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        //        tableView.backgroundColor = UIColor.white
        
        print("view will current real_time_flag value is ==== \(real_time_flag)")
    
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-----webservice start
    func get_data_from_url(url:String)
    {
        
        
        print("Trip Suggestions inside url : \(url)")
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        //    let testurl = NSURLConnection(request: request, delegate: request)
        
        request.httpMethod = "GET"
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("---json step 1------")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error- has been caught")
                return
            }
            print("---json step 2------")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("-trip--7.1--about to return after parsing")
                
                //          let tripFlag = RealTidMethods.checkIfArray(convertedJsonIntoNSDict1["TripList"]!["Trip"])
                // MARK: Nil check
                
                // call method to check if nil has encountered
                // check if the nsdict has error message
                // check if
                
                print("about to check the generic error---------")
                // Mark: Release check error
                // in slife method, produce error out of nil some how and see what happens
                // check for null
                // if null then go back with error message
                // else if not null then go below
                print("about to check ErrorCheckFlag....inside..errorCheckFlag =....before.....")
                
                
                // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
                let nullCheck = RealTidMethods.checkIfKeyExists(objectToCheck: convertedJsonIntoNSDict1, keyName: "TripList")
                
                if (nullCheck == false){
                    
                    self.navigationController?.popViewController(animated: true)
                    print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED......null........")
                    
                } else {
                    
                    let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
                    
                    if (errorCheckFlag == true){
                        print("errorCheckFlag....inside.......")
                        //MARK: release nil found
                        self.navigationController?.popViewController(animated: true)
                        print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED.......error.......")
                        
                    }
                    else if (errorCheckFlag == false){
                        let tripArray = (convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
                        print("-trip--7.1---A--")
                        
                        self.getTrips(json: convertedJsonIntoNSDict1)
                        print("-trip--7.1---B--")
                        //--for-1--------------------------------------------------------------------------------------------------
                        print("-trip--7.2--about to return after parsing")
                        // reload the table here
                        self.tableView.reloadData()
                    }
                }
                // dispatch_async(dispatch_get_main_queue(), {
                print("before return....")
                return
            })
        }
        task.resume()
    }
    
    func extract_json(jsonData:NSData)
    {
        print("---json step 3------")
        let json: AnyObject?
        do {
            print("json downloading in progres........4........")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject?
            print("json just downloaded.......5........\(json?.allKeys)")
            //MARK: Nil
            //print("json just downloaded.......5........\((json?["TripList"]!! as AnyObject).description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            // NIL json check
            
            json = nil
            
            
            return
        }
        
        convertedJsonIntoNSDict1 = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---6-----convertedJSON is being printed = \(convertedJsonIntoNSDict1.allKeys)")
    }
    
    func getTrips(json: NSDictionary){
        let tripArray = (convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
        //--for-1-------------------------------------------------------------------------------for 1---
        var forMain1 = 0
        for tripArray in tripArray {
            //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
            print("--------------------------------------------------------------------------------forMain1 \(forMain1)-----")
            
            //    var tripOneByOne = Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: tripArray.valueForKey("dur") as! String)
            //                         print("--tripArray is \(tripArray.allKeys)")
            //                     print("--tripArray.leglist is \(tripArray["LegList"])")
            //                    print("--tripArray.leglist is \(tripArray["LegList"])")
            //
            //---1720---15th of may
            //trips.append()
            
            
            
            // print("---LegList.allKeys--LegList is \(LegList.allKeys)")
            
            
            
            // var dur = ""
            let origin = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
            let destination = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
            
            var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: origin , destinationDetail: destination)
            let dur = (tripArray as! NSDictionary).value(forKeyPath: "dur")! as! String
            
            
            print("duration in trip suggestionsTViewController......\(dur)")
            //  print("tripArray----all Keys \(tripArray.allKeys)")
            
            var chg = ""
            var co2 = ""
            
            var tariffRemark = ""
            var tariffZones = ""
            // var LegList = [Leg]()
            // some variables which will be populated by external functions
            
            var from_time = ""
            var from_station = ""
            var to_Station = ""
            var to_time = ""
            print("----1A------------")
            trip.dur = (tripArray as! NSDictionary).value(forKey: "dur")! as! String
            trip.chg = (tripArray as! NSDictionary).value(forKey: "chg")! as! String
            trip.co2 = (tripArray as! NSDictionary).value(forKey: "co2")! as! String
            let change = trip.chg
            print("----2A------------")
            // <Trip><LegList><PriceInformation>----------------------------------------<PriceInformation>
            //<Trip><LegList><Leg>----------------------------------------------<Leg>
            
            // <Trip><LegList><Leg><Origin>---------------------------------<Origin>
            // move below lines inside origin to extract the value
            
            //            trip.from_time = tripArray.valueForKey("dur")! as! String
            //            trip.from_station = tripArray.valueForKey("dur")! as! String
            // <Trip><LegList><Leg><Destination>---------------------------------<Destination>
            //            trip.to_Station = tripArray.valueForKey("dur")! as! String
            //            trip.to_time = tripArray.valueForKey("dur")! as! String
            //
            
            //--Priceinfo--Start--------gather legs inside LegList-----start
            
            
            //  let priceInfo = tripArray.valueForKey("LegList")!["PriceInfo"] as! NSDictionary
            
            
            
            
            if let priceInfo = (tripArray as! NSDictionary).value(forKey: "PriceInfo") {
                print("------price info found---yes--")
                //                print("Price Info -----\(priceInfo.allKeys)")
                
                trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
                print("trip suggestions 1...test")
                trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
                print("trip suggestions 2...test")
                
                //print("Price Info -----\(priceInfo.allKeys)")
                
            } else {
                
                
                trip.tariffRemark = "Tariff Remarks N/A"
                trip.tariffZones = "Zones Not Available"
                
                print("------price info not found-----")
                
            }
            //  let priceInfo = tripArray.valueForKey("PriceInfo")! as! NSDictionary
            
            
            //            print("Price Info -----\(priceInfo.allKeys)")
            //
            //            trip.tariffRemark = (priceInfo["TariffRemark"] as! NSDictionary)["$"] as! String
            //            trip.tariffZones = (priceInfo["TariffZones"] as! NSDictionary)["$"] as! String
            //
            // trip.tariffZones =  priceInfo["TariffZones"] as! NSDictionary
            
            //--Priceinfo--End--------gather legs inside LegList-----start
            
            var forMain11 = 0
            // create a leglist as an array to add the legs in the leglist
            var leglist = NSMutableArray()
            if (change == "0") {
                // MARK: Swift 3 doubtful
                //                leglist.addObject(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                
                print("trip suggestions 4...\((tripArray as! NSDictionary).value(forKey: "LegList"))")
                print("change is 0 in trip suggestions tv")
                
                //leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
                
                
                let triparrayTest = tripArray as! NSDictionary
                print("trip array test.....\(triparrayTest.allKeys)")
                
                print(triparrayTest.count)
                
                
                let tripDicTest = triparrayTest.value(forKey: "LegList") as!NSDictionary
                
                print("tripDicTest----890----------\(tripDicTest.allKeys)")
                let legTestDict = tripDicTest.value(forKey: "Leg") as! NSDictionary
                
                print("legTestDict::::::\(legTestDict.allKeys)")
                
                
                leglist.add(legTestDict)
                
                //   print("trip.value.leglist............\(tripDicTest.allKeys)")
                
                
                // MARK: SWIFT 3 Commenting
                
                //                let leglistDictTest = (trip.value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                //
                //                print("leglistDictTest test.....\(leglistDictTest.allKeys)")
                //
                //                print(leglistDictTest.count)
                //
                //                let legDictTest = trip.value(forKey: "Leg") as! NSDictionary
                //
                //                print("legDictTest test.....\(legDictTest.allKeys)")
                //
                //                print(legDictTest.count)
                //
                //
                //
                //
                //                leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
                //      )
                
                
                
                // leglist.append(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                //print("tripArray.valueForKey('LegList')--- \(tripArray.valueForKey("LegList")?.count)")
            }
            else {
                let tempLegList = ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSArray
                var i = 0
                print("forMain1---- \(forMain1)")
                print("forMain11---- \(forMain11)")
                for (tempLegList) in tempLegList {
                    
                    
                    let legCheck = tempLegList as! NSDictionary
                    
                    let orgCheck = legCheck.value(forKey: "Origin")
                    
                    print("legCheck all keys......\(legCheck.allKeys)")
                    print("orgCheck all keys......\(orgCheck)")
                    
                    
                    //  print("legCheck::::::tempLegList \(legCheck.journeyType)")
                    leglist.add(tempLegList)
                    print("tempLegList.count is---- \((tempLegList as AnyObject).count)")
                    print("i---- \(i)")
                    i += 1
                }
            }
            var legs = NSMutableArray()
            let legListCount = leglist.count
            
            print("leglist.count-b4---999\(leglist.count)")
            //--for-1------------------------------------------------------------------------------from 11
            for leglist in leglist {
                let someValue = leglist as! NSDictionary
                
                // type could be "METRO" or "WALK"
                //  let legCount = leglist["Leg"]!
                
                print("test first inside lieglist......\(someValue.allKeys)")
                print("test first inside lieglist......\((leglist as! NSDictionary).value(forKey: "Leg"))")
                
                //  here you are receiving leglist as dictionary, now iterate through the keys and use the result
                
                //let legCount = (leglist as! NSDictionary).value(forKey: "Leg") as! NSArray
                
                print("leglist.count---- \((leglist as AnyObject).count)")
                print("forMain 1---- \(forMain11)")
                print("forMain 2---- \(forMain11)")
                
                let journeyType = (leglist as! NSDictionary)["type"]! as! String
                // if leg type is WALK then create a legwalk object populate it and then add it to trip
                var destinDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
                var originDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
                print("-----journey type = \(journeyType)")
                //-----------------if condition walk and travel---------start
                
                //                if (journeyType == "WALK"){
                
                // common variable extraction
                // extract ---------------------------------name-, type, idx
                let nameValue = (leglist as! NSDictionary)["name"]! as! String
                let idxValue = (leglist as! NSDictionary)["idx"]! as! String
                let typeValue = (leglist as! NSDictionary)["type"]! as! String
                
                // extract ---------------------------------Geometry Reference
                let geomRef = (leglist as! NSDictionary)["GeometryRef"]
                let geometryReference = (geomRef as! NSDictionary)["ref"] as! String
                print("leglist.allKeys......... in trip suggestion checking")
                // print(leglist.allKeys)
                
                
                // MARK: Geometry Reference
                // MARK: RTU Message Check
                //                if (leglist["RTUMessages"] is NSNull){
                //
                //                print("NS NULL FOR RTU MESSAGES.....")
                //
                //                } else if (leglist["RTUMessages"] == nil){
                //                    print("NS NULL FOR RTU MESSAGES.....")
                //
                //
                //                } else
                //                {
                //
                //                    let rtuMessages = leglist["RTUMessages"] as! NSDictionary
                //                    print("rtuMessages.allKeys")
                //
                //                    print(rtuMessages.allKeys)
                //
                //                }
                // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
                
                print("GEOMETRY REFERENCE VALUE IS .......\(geometryReference)")
                // --------------------------dist, hide---------------walk related variable extraction
                //------variables for walk
                var hideValue = "FALSE"
                var distValue = DEFAULT
                // -----variables for travel -
                var dirValue = DEFAULT
                var journeyDetailRefValue = DEFAULT
                var lineValue = DEFAULT
                print("journey type is : \(journeyType)")
                if(journeyType == "WALK"){
                    
                    distValue = (leglist as! NSDictionary)["dist"]! as! String
                    print("--distValue is -----\(distValue)")
                    //var hideValue = ""
                    if let hide = (leglist as! NSDictionary)["hide"] as? String {
                        print(".......1.0")
                        hideValue = hide
                    }
                        
                    else {
                        print(".......1.1")
                        hideValue = "False"
                    }
                }
                    // travel related variable extraction
                    // --------------------------dir, line, JourneyDetailReference
                    
                else if (journeyType != "WALK"){
                    print("---inside not walk---stuck")
                    dirValue = (leglist as! NSDictionary)["dir"]! as! String
                    
                    print("---dir----\(dirValue)")
                    
                    let journeyDetailRef_Key = (leglist as! NSDictionary)["JourneyDetailRef"] as! NSDictionary
                    journeyDetailRefValue = journeyDetailRef_Key["ref"] as! String
                    lineValue = (leglist as! NSDictionary)["line"]! as! String
                    
                }
                
                print("Journey Type = \(journeyType)")
                let origin = (leglist as! NSDictionary)["Origin"] as! NSDictionary
                //trip.from_time = origin["time"]! as! String
                let originNameVal = origin["name"]! as! String
                let originTypeVal = origin["type"]! as! String
                let originIdVal = origin["id"]! as! String
                let originLonVal = origin["lon"]! as! String
                let originLatVal = origin["lat"]! as! String
                let originTimeVal = origin["time"]! as! String
                let originDateVal = origin["date"]! as! String
                print("---check point temp")
                var originRouteIdx = String()
                if (journeyType == "WALK"){
                    
                    originRouteIdx = "WALK"
                    
                }
                else {
                    
                    originRouteIdx = origin["routeIdx"] as! String
                    
                }
                // let originRouteIdx = "routeIdx"
                //     print("-12----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                
                //  Address(name: <#T##String#>, type: <#T##String#>, id: <#T##String#>, lon: <#T##String#>, lat: <#T##String#>, time: <#T##String#>, date: <#T##String#>, routeIdx: <#T##String#>)
                originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal,routeIdx: originRouteIdx)
                
                //                    print("---12--originNameVal-\(originNameVal)")
                //                    print("--12---originDetail.name-\(originDetail.name)")
                //
                //                    print("---12--Origin- originNameVal-\(originNameVal)")
                //
                //
                //                    print("-12----Origin- originNameVal-\(originNameVal)")
                
                //                    let destination = leglist["Destination"] as! NSDictionary
                //    print("nested loop current index \(forMain11)")
                print("test 1.1")
                let destination = (leglist as! NSDictionary)["Destination"] as! NSDictionary
                // trip.from_time = origin["time"]! as! String
                let destinNameVal = destination["name"]! as! String
                let destinTypeVal = destination["type"]! as! String
                print("test 1.2")
                let destinIdVal = destination["id"]! as! String
                let destinLonVal = destination["lon"]! as! String
                print("test 1.3")
                let destinLatVal = destination["lat"]! as! String
                let destinTimeVal = destination["time"]! as! String
                let destinDateVal = destination["date"]! as! String
                
                var destRoutIdx = String()
                
                if (journeyType == "WALK"){
                    
                    destRoutIdx = "WALK"
                } else {
                    destRoutIdx = destination["routeIdx"]! as! String
                }
                print("test 1")
                print("------destination.allkeys = \(destination.allKeys)")
                destinDetail = Address(name: destinNameVal, type: destinTypeVal, id: destinIdVal, lon: destinLonVal, lat: destinLatVal, time: destinTimeVal, date: destinDateVal, routeIdx: destRoutIdx)
                print("test 2")
                // DECIDED TO KEEP WALK AS IT IS , before it was being saved with key but there is no use of having key and saving it because then it is hard to access as well as below you can see it is being saved as LEGWALK
                // let legWalkDict = ["WALK": legwalkDict] as NSDictionary
                //    var legWalk = LegWalk(journeyType: journeyType, legWalk: legWalkDict as! Dictionary<String, Walk, originValue: originDetail , destinationValue: destinDetail)
                
                //                    var legWalk = LegWalk(journeyType: journeyType, legWalk: legwalkDict, originValue: originDetail , destinationValue: destinDetail)
                
                print("test 3")
                
                print("--End--------------End------------------forMain11  \(forMain11)-----")
                print("leglist count is---head--=\(legListCount)")
                print("--logic main---forMain11  is = \(forMain11 + 1)-----Leglist count is =\(legListCount)")
                // check the value of count
                print("()---originDetail.name= \(originDetail.name)")
                print("()---destinDetail.name= \(destinDetail.name)")
                
                // extracting origin and destination for Trip (complete journey)
                // extracting origin and destination for trip each leg
                // case A   --onlyLeg
                if (legListCount == 1){
                    print("leglist count is-----=\(legListCount)")
                    trip.originDetail = originDetail.mutableCopy() as! Address
                    trip.destinationDetail = destinDetail.mutableCopy() as! Address
                    print("---A------------------originDetail= \(originDetail.name)")
                    print("----A-----------------originDetail= \(trip.originDetail.name)")
                }
                    // CASE B -First----first leg
                else if (legListCount > 1 && forMain11 == 0)
                {
                    print("leglist count is-88-origin--=\(legListCount)")
                    trip.originDetail = originDetail.mutableCopy() as! Address
                    print("----B-----------------originDetail= \(originDetail.name)")
                    print("----B-----------------originDetail= \(originDetail.name)")
                    print("-----B----------------originDetail= \(trip.originDetail.name)")
                    
                }
                else if (legListCount > 1 && ((forMain11 + 1) == legListCount))
                {
                    print("leglist count is-88-destin--\(legListCount)")
                    
                    trip.destinationDetail = destinDetail.mutableCopy() as! Address
                    print("---C------------------destinationDetail= \(destinDetail.name)")
                    print("---C------------------destinationDetail= \(trip.destinationDetail.name)")
                    
                    print("legListCount > 1 && ((forMain11) == count ---------")
                }
                var legImageName = String(DEFAULT)
                let i  = forMain11 + 1
                
                if (legListCount == 1) {
                    // onlyLegImage
                    legImageName = onlyLegImage
                    
                } else if (legListCount == 2 ){
                    
                    // firstImage
                    if (i == 1){
                        legImageName = firstLegImage
                        
                    }
                        // lastImage
                        
                    else if (i == 2){
                        legImageName = lastLegImage
                        
                    }
                    
                }
                    // firstLeg, middle, lastLeg
                else if (legListCount > 2) && (i == 1) {
                    // firstLegImage
                    legImageName = firstLegImage
                    
                }
                    // middleLegImage
                else if (legListCount > 2) && (i != legListCount) {
                    
                    legImageName = middleLegImage
                    
                }
                    // lastLegImage
                    
                else if (legListCount > 2) && (i == legListCount) {
                    
                    legImageName = lastLegImage
                }
                
                print("dist value is going to the final= \(distValue)")
                //    let rtuMessages_Exists = leglist["RTUMessag"] != nil
                let checkKeyExist = RealTidMethods.checkIfKeyExists(objectToCheck: leglist as AnyObject, keyName: "RTUMessages")
                var rtuMessageString = String()
                if (checkKeyExist == true) {
                    let leglistRTUMessage = (leglist as! NSDictionary)["RTUMessages"] as! NSDictionary
                    // MARK: Rtu Message Get
                    var rtuMessage = RealTidMethods.checkIfKeyExists(objectToCheck: leglistRTUMessage, keyName: "RTUMessage")
                    if (rtuMessage == true){
                        
                        print("--------rtu Message.....status................\(leglistRTUMessage.allKeys).")
                        print(rtuMessage)
                        //    print(leglistRTUMessage["RTUMessage"]!["$"] as! String)
                        rtuMessageString = (leglistRTUMessage["RTUMessage"]! as! NSDictionary)["$"] as! String
                    }
                    
                    
                }
                print("check if Key Exist or not ======== \(checkKeyExist)")
                // MARK: Leg Population
                let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString)
                print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                print("rtu message status from leg = message = \(leg.rtu_Message)")
                trip.LegList.add(leg)
                forMain11 += 1
                //----------------if condition walk & travel----------end
            }
            print("---LegList.allKeys----duration being entered is :\(dur)")
            self.newTrip.add(trip)
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1 += 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        print("section count is = \(newTrip.count)")
        
        return newTrip.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("row has been selected..........\(indexPath.row)")
        print("\(tableView.cellForRow(at: indexPath)?.tag)")
        // reset intermediat stops if it is already initialised
        
        if (intermediateStops.intermediateStops.count == 0){
            
            print("still intermediate stops is nil....in did select row at ind... in trip suggestionsT View Controller")
            
        }
        else {
            print("----about to reset INTERMEDIATE STOPS....")
            IntermediateStopsViewController.resetIntermediateStops(intermediateStopsFullObject: intermediateStops)
            
        }
        // let leg = legList.LegList[indexPath.row] as! Leg
        
        //        print("Leg Journey Detailed Ref: \()")
        
        
        let legList = newTrip[indexPath.section] as! Trip
        //let test = NSMutableArray()
        
        //test.addObject(legList.LegList[indexPath.row])
        //        let startingPoint = CGPoint(x: 35.0,y: 30.0)
        //        let startingSize = CGSize(width:20.0,height:20.0)
        //        let orientation = "x"  // x, y, or xy
        //        let innerSpacing = CGPoint(x:10,y:0)
        //        let innerLegSpacing = CGPoint(x:25,y:0)
        //        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        //        // ------------setting Leg Images---------START
        print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
        var count = legList.LegList.count
        count = count - 1
        print("--Row = \(indexPath.row)----count = \(count)")
        let leg = legList.LegList[indexPath.row] as! Leg
        print("checking transport type........ when leg is being selected....\(leg.type)")
        // reset intermediate stops
        if (leg.type != "WALK"){
            setJourneyDetailedReference = leg.journeyDetailRef
            setOriginStop = Int(leg.origin.routeIdx)!
            setDestinationStop = Int(leg.destination.routeIdx)!
            
            // set the origin name & time
            setRootLegOriginTime = leg.origin.time
            setRootLegOriginStation = leg.origin.name
            // set the destination name & time
            setRootLegDestinationTime = leg.destination.time
            setRootLegDestinationStation = leg.destination.name
            print("current indexPath.row = \(indexPath.row)")
            print("Current journey detail reference is \(leg.journeyDetailRef)")
            print("passing det ref = \(selectedLegJourneyDetailedRef)")
            print("::::origin id. ...... \(setOriginStop)")
            print("Root Cell Selection : Origin : \(leg.origin.name)")
            print("::::dest id. ...... \(setDestinationStop)")
            print("::Root Cell Selection : Destination : \(leg.destination.name)")
            
            //cell.legImage.image = UIImage(named: leg.legImageName)
            
            
            print("SECTION SELECTED = ")
            print(indexPath.section)
            print("CELL SELECTED = ")
            print(indexPath.row)
            print("section  ?  SELECTED =  tableView.indexPathForSelectedRow = ")
            print(tableView.indexPathForSelectedRow)
            
            
        } else {
            
            transportTypeFlag = "WALK"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return newTrip[section].legList.count
        let legList = newTrip[section] as! Trip
        print("----LegList Count is in number of rows in section=\(legList.LegList.count)")
        print("section show value in number of rows in section = \(sectionShow)")
        
        // extract value of section if not null
        // check if it is true then show
        // else return 0
        
        // check for null
        print("section # is \(section)")
        let section_null_or_not = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        
        
        if (section_null_or_not.contains("null")){
            
            
            
            print("section null or not contains===== false = \(section_null_or_not)")
            
            
        } else if (section_null_or_not.contains("true")) {
            
            
            
            print("section null or not contains===== True = \(section_null_or_not)")
            
            print(" \(legList.LegList.count)")
            
            //MARK: NextDepartureCEll Count Return
            
//            var departureCellCount = 0
            //----------------------------
            
            
            //  let key = String(currentCell.sectionInfo)  + String(currentCell.rowInfo)
            //                let nextDepartureShowFlag = RealTidMethods.checkIfKeyExists(objectToCheck: showNextDeparturesTripInfo, keyName: String(key))
            //                print("nextDepartureShowFlag= \(nextDepartureShowFlag)")
            //                print("showNextDeparturesTripInfo-------\(showNextDeparturesTripInfo.allKeys)")
            //                print("Checking for next departure cell show value....in number of rows in cell... in show next departure action....")
            //                if (nextDepartureShowFlag == true){
            //                    print("Key exists for show hide..in number of rows in cell....some one has checked before as well....")
            //                    // key found
            //                    // check for previous value
            //                    let value =  showNextDeparturesTripInfo.value(forKey: key) as! Bool
            //
            //                    print("value received is == \(value)")
            //                    if (value == true){
            //
            //                        // value is true , show cell
            //                        // increase count for departure cell to show
            //                        departureCellCount = 1
            //
            //                       print("Departure cell count new value is 1-SHOW. .... hide collection view.....")
            //
            //                    } else if (value == false ){
            //                    departureCellCount = 0
            //                        print("Departure cell count new value is 0-HIDE. .... hide collection view.....")
            //
            //
            //                    }
            //                }
            //
            
            //---------------------------
            
            
            // ------------temp of master dict on 9th nov 10am friday-----------start---------
            
            /*
             var departureCellCount = 0
             // Departure Master Creation ------
            var sectionTripInfoDict = NSMutableDictionary()
            // get count for currection section number of rows
            // creat this only first time
            // var currentSectionDepartureCells = 0
            
            var currentTripInfoDepartCount = 0
            
            var i = 0
            
            // check if master dict is empty or not ()
            
            let masterDepartDictFlag  = RealTidMethods.checkIfKeyExists(objectToCheck: nextDepartureMasterDict, keyName: String(section))
            
            if (masterDepartDictFlag == false){
                
                // add the section level key
                
                nextDepartureMasterDict.setValue(sectionTripInfoDict, forKey: String(section))
                
                // get object and update it
                let currentTripInfoDepartDictObj = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                
                // add the trip info level keys
                var i = 0
                for index in legList.LegList {
                    
                    // set value as 0 for each tripinfo cell row index
                    currentTripInfoDepartDictObj.setValue(0, forKey: String(i))
                    
                    print("---------------------Section = \(section) && i = \(i) value = \(0)")
                    i += 1
                }
                
                print("currentTripInfoDepartDictObj all keys = \(currentTripInfoDepartDictObj.allKeys)")
                
                print("currentTripInfoDepartDictObj.count = \(currentTripInfoDepartDictObj.count)")
                print("leglist.leglist.count = \(legList.LegList.count)")
                
                // update it back to the main object
                
                nextDepartureMasterDict.setValue(currentTripInfoDepartDictObj, forKey: String(section))
                
                
                
            } else if (masterDepartDictFlag == true){
                // extract current trip info level dict object
                let currentTripInfoDepartDictObj = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                print("currentTripInfo DepartDictObj === \(currentTripInfoDepartDictObj.allKeys)")
                // iterate throught the object and
                var i = 0
                //  let tripInfoDepartDict =  currentTripInfoDepartDictObj.value(forKey: String(section)) as! NSMutableDictionary
                
                for (key,index) in currentTripInfoDepartDictObj {
                    let iStr = String(i)
                    if (iStr.contains(key as! String))
                    {
                        
                        currentTripInfoDepartCount += currentTripInfoDepartDictObj[iStr] as! Int
                        
                    }
                    
                    i += 1
                }
                
                // add to main return number of cell counts
                
                
                
                
            }
            
            
            //                let currentMasterDepartDict = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
            //
            //                if (currentMasterDepartDict.count == 0){
            //                for index in legList.LegList.count {
            //                    print("section ::: \(section) && i = \(i) Count = \(legList.LegList.count)")
            //                  // resetting all departure values
            //                    sectionTripInfoDict.setValue(0, forKey: String(i))
            //                    }
            //                } else {
            //                // if the dict has keys more than 0 then update the return count based on
            //                    var i = 0
            //                    for index in legList.LegList.count {
            //
            //
            //
            //                    }
            //
            //                    currentSectionDepartureCells +=
            //                }
            
            
            //                print("sectionTripInfo All Keys = \(sectionTripInfoDict.allKeys)")
            //                print("sectionTripInfo Dict Total Count = \(sectionTripInfoDict.count)")
            //
            // once created then iterate through current section values and add it to total current count
            
            
            //  print("number of rows in Section: LegList= \(newTrip[section].)")
            
            //  print("s[section].Rows are = \(s[section].count)")
            
            
            
            
            print("LegList.Leglist.Count = \(legList.LegList.count) && DepartureCellCount = \(currentTripInfoDepartCount)")
            let totReturn = legList.LegList.count + currentTripInfoDepartCount
            
            return totReturn //legList.LegList.count + currentTripInfoDepartCount
            */
            
            // ------------temp of master dict on 9th nov 10am friday-----------
        return legList.LegList.count
        }
        // if not null then check if true
        //            rip_detail_flag.contains("null")
        
        // if true then return leglist as below
        
        /*
         if (section == sectionShow){
         
         print(" \(legList.LegList.count)")
         return legList.LegList.count
         }
         */
        //-------------------------
        return 0
    }
    
    // MARk: Collection View Methods
//    swiitching off on 23rd Dec
    // MARK: Check , 23rd dec, same almost
    /*
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // triplegiconscollection view cell name is old but now it is being used for next departures collection view show
        
        //          tableView.backgroundColor = UIColor.white
        print("-------------Section = \(indexPath.section) & Row = \(indexPath.row)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuseIdentifier", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
       
        // MARK: border collection view
    
        
       // cell.from_time.layer.backgroundColor  = UIColor.red.cgColor
      //  cell.from_time.layer.cornerRadius = 5
        
        
        //headerCell.layer.borderColor = UIColor.gray.cgColor
       
      /*
        if (colorFlag == true){
            
            cell.backgroundColor = UIColor.lightGray
            cell.from_time.textColor = UIColor.white
            cell.to_time.textColor = UIColor.white
            
            colorFlag = false
        } else {
            
            cell.backgroundColor = UIColor.white
            cell.from_time.textColor = UIColor.black
            cell.to_time.textColor = UIColor.black
            
            colorFlag = true
            
        }
        */
        //        if(indexPath.row == 2){
        //
        //            cell.backgroundColor = UIColor.red
        //
        //        }
        
        
        
        var layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        //layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        print("Custom Trip Next Departures\(custom_Trip_NextDepartures_Dict.allKeys)")
        if (custom_Trip_NextDepartures_Dict.count > 0 ){
            
            let currentSection = String(indexPath.section)
            let currentRow = String(indexPath.row)
            let view = collectionView.superview!
            // MARK: Collection view friday eve 9th nov temp off
//            
 
//            let currentCell = view.superview as! LegListCells
            

            let currentCell = view.superview as! LegTripNextDeparturesTableViewCell
           let keyNameTemp = currentCell.keyName
            print("printing cells..keyname temp from current cell = \(keyNameTemp)")
            let keyName = currentSection + currentRow
            print("Collection ALL KEYS = \(custom_Trip_NextDepartures_Dict.allKeys)")
            print("generated current key via indexpth.section and row = \(keyNameTemp)")
            print("index path row values in collection cell for = \(indexPath.row)")
            if let collection_Values_flag = custom_Trip_NextDepartures_Dict[keyNameTemp]
            {
                
                //if (collection_Values_flag == true){
                let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                
                print("customDepTripArray Count = \(customDepTripArray.count)")
                
                print("-----test 10989")
                // MARK: temp wed 14 th dec changing
                
//                let tripCustom = customDepTripArray[indexPath.row] as! Trip
                let tripCustom = customDepTripArray[indexPath.section] as! Trip
              print("Collection View Cell Section  =\(indexPath.section) && Row = \(indexPath.row)")
                
                //MARK: Temp 14th dec changes
                //let leg = tripCustom.LegList.firstObject as! Leg
               // let leg = tripCustom.LegList[indexPath.row] as! Leg
             // MARK: 23rd dec problem
                
           //     let leg = tripCustom.LegList[indexPath.row] as! Leg
            // -----temp
                print("tripCustom.LegList.count===\(tripCustom.LegList.count)")
                
                print("firstTripDep =\(tripCustom.originDetail.name) ")
                //-------------collection view border ------------start
                
                // MARK: DepartureCells icon X Spacing
                var middleLeg_x_spacing = CGFloat(8)
                var firstLeg_x_spacing = CGFloat(10)
                var lastLeg_x_spacing = CGFloat(7)
                var onlyLeg_x_spacing = CGFloat(8)
                var leg_x_spacing = CGFloat(0)
                
                // MARK: CollectionView Border
                
                
                
                print("Before IF old section value = \(oldSectionValue) & section = \(indexPath.section) & ROW = \(indexPath.row)")
                if (oldSectionValue != indexPath.section){
                    print("JUST INSIDE IF -old section value = \(oldSectionValue) & section = \(indexPath.section)")
                    if (collectionCellColor == false)
                    {
                        collectionCellColor =  true
                    } else {
                        
                        collectionCellColor = false
                        
                    }
                    oldSectionValue = indexPath.section
                    
                }
                print("Collection CellColor = \(collectionCellColor)")
                print("After if---old section value = \(oldSectionValue) & section = \(indexPath.section)")
                
                // following value will be true/false for each leg
                
                
                
                if (collectionCellColor == true){
                    //collectionCellColor = false
                   // cell.layer.masksToBounds = true
                 //   cell.layer.borderWidth = 2.0 // cellBorderWidth
                  //  cell.layer.cornerRadius = 10.0
                //    cell.layer.borderColor = legColorFirst
                
                    //UIColor.lightGray.cgColor
                    //tableView.backgroundColor = UIColor.lightGray
                    
                    print("collectionCellColor = FALSE section \(indexPath.section) & row \(indexPath.row)")
                } else {
                    
                    //collectionCellColor = true
                    cell.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
                 //   cell.layer.masksToBounds = true
                  //  cell.layer.borderWidth = 2.0 // cellBorderWidth
                 //   cell.layer.cornerRadius = 10.0
                  //  cell.layer.borderColor = legColorSecond//UIColor.yellow.cgColor//UIColor.lightGray.cgColor
                    print("collectionCellColor = TRUE section \(indexPath.section) & row \(indexPath.row)")
                }
                print("Current Cell size = width =  \(cell.frame.size.width)")
                print("Current Cell size = height =\(cell.frame.size.height)")
                 // -------------collection view border end
                // MARK: origin and destination color----start
                
                let lastIndex = (tripCustom.LegList.count - 1)
                
                // MARK: TripInfo Departure Result Only Leg
                if (tripCustom.LegList.count == 1){
              
                    cell.duration.text = "Dur:" + tripCustom.dur
                    
                    leg_x_spacing = onlyLeg_x_spacing
                    
                    print("Only result is being printed: Image is = DepartureBorderOnly_1.png")
                    print("cell.frame.size.width= Dep:Cell:Size = \(cell.frame.size) ")
                    
               cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "DepartureBorderOnly_1.png")!)
                    
                // change origin and destination colors
                print("COUNT FOR COLLECTION VIEW IS ONLY ONE.........")
               
//                cell.from_time.backgroundColor = originColor
//                cell.to_time.backgroundColor = destinationColor
                cell.from_time.textColor = originTextColor
                    cell.to_time.textColor = detinationTextColor
                    
                }
                    // MARK: TripInfo Departure Result Multiple Legs

                else {
                    // Mark: Departure Cells  first leg: recurring departure
                    
                    if (indexPath.row == 0){
                        
                        cell.duration.text = ">---->"
                        leg_x_spacing = firstLeg_x_spacing
                        
                        cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "DepartureBorderFirst.png")!)
                            
                            
                 //  cell.from_time.backgroundColor = originColor
                  cell.from_time.textColor = originTextColor
                    print("count wasnt equal to 1, caught in first row...setting origin color")
                    
                    }
                    // Mark: Departure Cells  Middle Legs
                    
                    else if ((tripCustom.LegList.count > 2) && (indexPath.row < lastIndex)){
                        
                        cell.duration.text = ">---->"
                        leg_x_spacing = middleLeg_x_spacing
                        
                        cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "Middle.png")!)
                        
                    
                    }
                    //Mark: Departure Cells Last Leg
                    else if (lastIndex == indexPath.row){
                        cell.duration.text = "Dur:" +  tripCustom.dur
                        
                        
                        leg_x_spacing = lastLeg_x_spacing
                        
                        cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "DepartureBorderLast.png")!)
                        
//                   cell.to_time.backgroundColor = destinationColor
                        
                cell.to_time.textColor = detinationTextColor
                    print("Collection view last index caught, now setting destination color.")
                     }
                 }
                
                //--------------origin and destination color end
                //   let tripCustom = custom_Trip_NextDepartures_Dict[0] as! Trip
                //     let legList = newTrip[indexPath.section] as! Trip
                print("generated current key via indexpth.section and row = \(keyNameTemp)")
                print("dddddd = \(tripCustom.originDetail.time)")
                print("dddddd = \(tripCustom.destinationDetail.time)")
                //              cell.to_time.setTitle(tripCustom.destinationDetail.time, for: .normal)
                
                //let legList = newTrip[indexPath.section] as! Trip
                //print("From Station id = \(legList.originDetail)")
                let testCollectionMArray = NSMutableArray()
                
                // MARK: Collection View Departure icon count
                
                testCollectionMArray.add(tripCustom.LegList[indexPath.row])
                
                print("testCollectionMArray Count = \(testCollectionMArray.count)")
                //MARK: Collection View Cell Background Image
                
                //                let View=UIView()
                //                View.backgroundColor=UIColor(patternImage:UIImage(named:"LegBorderStart.png")!)
                //
                //                cell.backgroundView = View
                //print("cell size = \()")
                
                
                // MARK: Collection view label rounds
                
                cell.from_time.layer.masksToBounds = true
                cell.from_time.layer.cornerRadius = 5
                cell.to_time.layer.masksToBounds = true
                cell.to_time.layer.cornerRadius = 5
                
//                cell.layer.masksToBounds = true
//                cell.layer.borderWidth = 4.0 // cellBorderWidth
//                cell.layer.cornerRadius = 10.0
//
                print("Trip Info: Section : \(indexPath.section) Row:\(indexPath.row)")
                
                print("cell.from_time.frame.origin.x = \(cell.from_time.frame.origin.x)")
                print("cell.from_time.frame.origin.x = \(leg_x_spacing)")
                
                let x = leg_x_spacing //.from_time.frame.origin.x + leg_x_spacing
                let y = CGFloat(50.0) //cell.from_time.frame.size.height + 7
                
                let startingPoint = CGPoint(x: x,y: y)
                // let startingPoint = CGPoint(x: 35.0,y: -130.0)
                let startingSize = CGSize(width:27.0,height:27.0)//default_startingSize  //CGSize(width:20.0,height:20.0)
                let orientation = "x"  // x, y, or xy
                let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
                let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
                let sizeFactor = CGSize(width: 0.0,height: 0.0)
                // line color and line number ?
                // cell.line_number.text = tripCustom.chg
                
                print("-------------Section = \(indexPath.section) & Row = \(indexPath.row)")
                
                print("tripCustom.leglist.count = \(tripCustom.LegList.count)")
                print("test 1")
                
                print("-Section = \(indexPath.section)--R=\(indexPath.row)--------key name is ==== \(keyNameTemp)")
                
                print("String(leg.line) = \(leg.line)")
                print("------------key name is ==== \(keyNameTemp)")
                
                //let some = Int(cell.from_time.frame.size.width)
                
                cell.to_time.frame.origin.x = cell.from_time.frame.size.width + startingSize.width + startingSize.width
                
                
                //  SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                // MARK: temp friday draw 2 COLLECTION VIEW
            
                // MARK: Departure Cell Icon Printing
                
                print("Departure Cell: Collection View Sizes : Icon :Starting Point:\(startingPoint)------Section & Row = \(indexPath.section)-- \(indexPath.row)")
                print("Departure Cell: Collection View Sizes : Icon :Starting Size: \(startingSize)")
                print("Departure Cell: Collection View Sizes : Icon :Size Factor: \(startingSize)")
                print(" Cell.fromTime.Startpoint = \(cell.from_time.frame.origin)")
               
                if (cell.viewWithTag(30) == nil) {
                print("button is null........ ")
                
                
                } else {
                
                let iconButton = cell.viewWithTag(30) as! UIButton
                    iconButton.isHidden = true
                    
                let iconUILabel_button = cell.viewWithTag(35) as! UIButton
                    
                    iconUILabel_button.isHidden = true
                
                }
                
                SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: testCollectionMArray, collectionViewCell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                print("Collection View cell tag is = \( cell.viewWithTag(30))")
                //MARK: Departure Cell Info Filling
                
                
                let width = 8
                
                cell.from_station.text = leg.origin.name
                
                
                cell.to_station.text = leg.destination.name
                
                
                
                //cell.line_number.text = String(leg.line)
                print("test 2")
                cell.from_time.text = leg.origin.time
                cell.to_time.text = leg.destination.time
            
                //cell.from_time.setTitle(leg.origin.time, for: .normal)
                print("test 3")
                //cell.to_time.setTitle(leg.destination.time, for: .normal)
                print("test 4")
                //                cell.from_time.setTitle(tripCustom.originDetail.time, for: .normal)
            }
            else {
                
                print("nothing.....in collection num itms")
            }
            
            
            print("-----end--------Section = \(indexPath.section) & Row = \(indexPath.row)")
            
            
        }
        
        
        //        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        //
        //
        //
        //            // Use collectionViewFlowLayout
        //
        //        }
        
        collectionView.setNeedsLayout()
        
        //        collectionView.set
        
        print("---collectionView.collectionViewLayout.collectionViewContentSize.width\(collectionView.collectionViewLayout.collectionViewContentSize.width)")
        
        //  cell.legLineNo.setTitle("11", for: .normal)
        // cell.legImage.backgroundColor = UIColor.yellow
        // cell.contentView.frame.size.width = 10.0
        
        print("collectionView.frame.width = \(collectionView.frame.width)")
        
        
        print("collectionView.frame.width = \(collectionView.frame.width)")
        
        
        print("collectionView.intrinsicContentSize = \(collectionView.intrinsicContentSize)")
        
        
        print("collectionView.contentSize.width = \(collectionView.contentSize.width)")
        
        
        print("collectionView.contentSize.width = \(collectionView.contentSize.width)")
        
        
        print("in collection view number of items in section---cell--\(indexPath.row)--")
        
        
        
        return cell
        
    }
    
    */
    /*
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
     
     cell.contentView.backgroundColor = UIColor.blue
     
     //   let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 120))
     
     
     //CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
     //        CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
     
     let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x:0,y:10), size: CGSize(width: self.view.frame.width,height: 120)))
     
     
     whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
     whiteRoundedView.layer.masksToBounds = false
     whiteRoundedView.layer.cornerRadius = 2.0
     
     // whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
     whiteRoundedView.layer.shadowOffset = CGSize(width:-1,height: 1)
     whiteRoundedView.layer.shadowOpacity = 0.2
     print("size of white rounder is = \(whiteRoundedView.frame.width) : \(whiteRoundedView.frame.height)")
     cell.contentView.addSubview(whiteRoundedView)
     cell.contentView.sendSubview(toBack: whiteRoundedView)
     }
     */
    
    
    @available(iOS 6.0, *)
    // MARK: Conflict 23rd Dec
    /*
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
        
    }
    */
    //MARK: COMPARED with file compare: almost same: return statement problem may be
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       //        let tripCell = newTrip[section] as! Trip
        //
        //        print("Trip Cell (Number of items in section--\(tripCell.LegList.count)")
        //        return tripCell.LegList.count
        //
        
        var number = 0
        print("section number for collection view = \(section)")
        print("custom_Trip_NextDepartures_Dict.allkeys.numberofItemsInSection=\(custom_Trip_NextDepartures_Dict.allKeys)")
        if (custom_Trip_NextDepartures_Dict.count > 0){
            let currentSection = String(section)
            //let currentRow = String(indexPath.row)
            let view = collectionView.superview!
            let currentCell = view.superview as! LegTripNextDeparturesTableViewCell
            //MARK: Collection View old till 9th nov 8pm
            // let currentCell = view.superview as! LegListCells
            
            let keyNameTemp = currentCell.keyName
            print("cell.tag current = \(currentCell.tag)")
            print("keyname temp from current cell = \(keyNameTemp)")
            // let keyName = currentSection + currentRow
            print("key name temp = \(keyNameTemp)")
            print("num sections customtrip next departures total count = \(custom_Trip_NextDepartures_Dict.count)")
            print("num sections -customtrip next departures total count = \(custom_Trip_NextDepartures_Dict.allKeys)")
            //           if let collection_Values_flag = RealTidMethods.checkIfKeyExists(objectToCheck: custom_Trip_NextDepartures_Dict, keyName: keyNameTemp)
            
            //  if (collection_Values_flag == true){
            if let customDepTrip = custom_Trip_NextDepartures_Dict[keyNameTemp]
            {
                let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                print("-----test 10989")
                let tripInfoDepartureCount = customDepTripArray[section] as! Trip
                //--------------- start
                //if (collection_Values_flag == true){
                //let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                
                print("customDepTripArray Count = \(customDepTripArray.count)")
                
                print("-----test 10989")
                let tripCustom = customDepTripArray[section] as! Trip
                print("tripCustom.LegList.count==number of items =\(tripCustom.LegList.count)")
                var i = 0
                print("Returning collection view item count = tripCustom.LegList.count ")
             //   return tripCustom.LegList.count
                
                // MARK: Collection View item count latest
                var itemCountComplete = 0
        
                for index in tripCustom.LegList {

                    let leg = tripCustom.LegList[i] as! Leg
                    
                    print("----i = \(i)----------------------start-------------------")
                    print("leg.origin.name = \(leg.origin.name)")
                    print("leg.Destination.name = \(leg.destination.name)")
                    print("leg.dir = \(leg.dir)")
                    print("--------------------------end-------------------")
                    i += 1
                
                }
                
                //--------------- end
                 print("customDepTripArray Count= items in number of sections...... = \(tripCustom.LegList.count)")
                number = customDepTripArray.count
               // return customDepTripArray.count
            }
            
        }
        
        print("custom_Trip_NextDepartures_Dict = count = \(custom_Trip_NextDepartures_Dict.count)")
        print("Section for collection view count = \(section) ")
        print("Count for collection view count = \(number) ")
        return number
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get current trip object
        print("current section in cell for row at\(indexPath.section) && \(indexPath.row)")
        
        let tripCurrentObj = newTrip[indexPath.section] as! Trip
        
        print("tripcurrentObject show hide value is = \(tripCurrentObj.showHideCell)")
        // current leglist object
        let legListTemp = tripCurrentObj.LegList as! NSMutableArray
        // get object at current row
        let legObjToCheck = legListTemp[indexPath.row] as! AnyObject
        // 1.0) check for the type of object
        if (RealTidMethods.checkIfDepartureObject(objectToCheck: legObjToCheck))
        {
        // if object is departure then return depart object
        // copy paste departure code......
        print("cell departure must be printed now.......1..")
        //    departureCounter += 1
        let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
        cellDeparture.keyName = String(indexPath.section) + String(indexPath.row)
            
        cellDeparture.tag = indexPath.row
            //MARK: CollectionView temp off
            
              cellDeparture.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
            
        print("cell departure must be printed now......2...")
        
        showDeparture = false
        print("cell Departure Size = \(cellDeparture.frame.size.width) && height = \(cellDeparture.frame.size.height)")
            
        return cellDeparture
    }
        
        // if object is normal then return normal object
        // show normal cells......BECAUSE Show Departure should be false
        print("SHOW DEPARTURE IS FALSE = \(showDeparture)")
        
        print("in printing normal cells ,current indexpath.row = \(indexPath.row) && departureCounter = \(departureCounter)")
        
        let currentIndex = indexPath.row - departureCounter
        print("IndexPath.Row = \(indexPath.row)")
        print("Calculated Current Index = \(currentIndex)")
        
        // copy paste code for normal cell......
        
        // ----------------------------------NORMAL CELL......................-----------START------
        let legList = newTrip[indexPath.section] as! Trip
        
        
        let test = NSMutableArray()
        var count = legList.LegList.count
        print("indexPath.row = \(indexPath.row) && Total count is = \(count)")
        //
        //        if (indexPath.row <= count){
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
        
        
        print("cellCurrent value is hidden or not =Before=\(cell.isHidden)" )
        print("tripCurrentObj.showHideCell  value is hidden or not =Before=\(tripCurrentObj.showHideCell )" )
        
  /*
        if (tripCurrentObj.showHideCell == false){
        cell.isHidden = false
        
        } else if (tripCurrentObj.showHideCell == true){
        
        cell.isHidden = true
            
        }
    
        print("cellCurrent value is hidden or not =After = \(cell.isHidden)" )
//        tableView.headerView(forSection: <#T##Int#>)
        if (cell.showHideDepartureCell == true)
        {
        
cell.nextDeparturesOutlet.isSelected = true
            
        } else {
        
            
            cell.nextDeparturesOutlet.isSelected = false
            
            
        
        }
*/
        //MARK: Trip info Hidden views
    
        cell.backgroundColor = UIColor.white
        print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
        print("CELL INTERACTION STATUS = \(indexPath.section) && row = \(indexPath.row) = interaction = \(cell.isUserInteractionEnabled)")
        //MARK:BorderTripInfo
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = cellBorderWidth
        
        //headerCell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.lightGray
        
        
        //        let border = CALayer()
        //        let width = CGFloat(15.0)
        //        border.borderColor = UIColor.darkGray.cgColor
        //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
        //
        //        border.borderWidth = width
        //        tableView.layer.addSublayer(border)
        //        tableView.layer.masksToBounds = true
        
        
        /*
         cell.layer.borderWidth = 10.0
         cell.layer.borderColor = UIColor.green.cgColor
         
         */
        
        cell.tag = indexPath.row
        cell.nextDeparturesOutlet.tag = indexPath.row
        
        cell.sectionInfo = String(indexPath.section)
        cell.rowInfo = String(indexPath.row)
        
        cell.keyName = cell.sectionInfo + cell.rowInfo
        
        print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
        cell.name.isHidden = true
        //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
        cell.towards_or_walk.isHidden = true
        
        // MARK# Collection View
        // MARK: cell
        
        //MARK: CollectionView temp off
        
        //   cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        
        //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
        
        // 3
        // Configure the cell...
        // MARK: Move to collection 1
        
        print("From Station id = \(legList.originDetail)")
        // MARK: Trip info icon Printing
        
        test.add(legList.LegList[indexPath.row])
        
        
        let startingPoint = CGPoint(x: cell.to_time.frame.origin.x,y: cell.to_time.frame.size.height + 20)
        
        //        let startingPoint = CGPoint(x: 35.0,y: 30.0)
//        
        
        //let startingPoint = CGPoint(x: 35.0,y: 30.0)
        // let startingPoint = CGPoint(x: 35.0,y: -130.0)
        let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
        let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        // MARK: Move to collection 1 ---end
        // ------------setting Leg Images---------START
        print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
        count = count - 1
        print("--Row = \(indexPath.row)----count = \(count)")
        let leg = legList.LegList[indexPath.row] as! Leg
        
        cell.legImage.image = UIImage(named: leg.legImageName)
        // MARK: Leg
        print("cell for row  at index ===\(indexPath)-------------------------")
        print("leg image name ==\(leg.legImageName)")
        print("leg.line ==\(leg.line)")
        print("leg.dir ==\(leg.dir)")
        print("leg.journeyType ==\(leg.journeyType)")
        print("leg.name ==\(leg.name)")
        print("leg.origin ==\(leg.origin)")
        // legList.originDetail.name
        //----#1-----#2------------------------ Origin Station....Leg
        cell.from_station.text = leg.origin.name
        print("cell.from_station.text::::\(cell.from_station.text)")
        // temp cell.from_time.text = legList.originDetail.time
        cell.from_time.text = leg.origin.time
        // MARK: RTU Message Cell Level
        if (leg.rtu_Message_Flag == true){
            print("cell:: RTU Message ::::")
            print(leg.rtu_Message)
            cell.rtuMessage.isHidden = false
            cell.rtuMessage.text = leg.rtu_Message
            cell.rtuMessage.textColor = UIColor.red
        } else {
            cell.rtuMessage.isHidden = true
        }
        // cell.transportTypeOutlet.text = leg.origin.type
        //        if (leg.dir != "Default"){
        //        cell.towards_or_walk.text = leg.dir
        //        }
        cell.towards_or_walk.text = ""
        print("cell.towards_or_walk.text  :\(leg.dir)")
        
        // set root map reference
        // set root map geometry reference
        
        print("------090--------- cell.from_time.text--989=")
        print(cell.to_time.text)
        
        print("printing indexpath.row = in cell Level \(indexPath.row)")
        print("current Geom Ref is = \(leg.geomRef)")
        
        print("current Geom Ref is journeyDetailRef...........= \(leg.journeyDetailRef)")
        
        //-----#3------Visual Leg
        
        print(test.count)
        // MARK: Move to collection 2
        // MARK: temp friday draw 3 cell view
        let tagValuesReceived = SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: indexPath.row,indexValueFromCurrentLeg: 0,iconTagIntValue: 0 ,lineNoIntValue: 0)
        
        print("startingPoint_101001----\(startingPoint)")
        //----#4------
        cell.name.text = ""//leg.name
        
        //----#4.5------
        //----#5------line/dist
        cell.transportTypeOutlet.text = leg.journeyType
        cell.transportTypeOutlet.isHidden = true
        
        
        print("--212----journey type is =\(leg.journeyType)")
        print("--dist---- =\(leg.dist)")
        print("--Line--- =\(leg.line)")
        
        print("-leg.dir--- =\(leg.dir)")
        var line_dist = String()
        var helpingWord = String()
        print("leg.journey Type..... = \(leg.journeyType)")
        if (leg.journeyType == "WALK"){
            
            print("switching off walk cell to be touched..........")
        cell.isUserInteractionEnabled = false
            
            //        cell.multipleTouchEnabled = false
            
            
        }
        else {
            cell.isUserInteractionEnabled = true
        }
        if (leg.journeyType == "WALK"){
            line_dist = leg.name + " "+leg.dist + " Meters"
            // helpingWord = "Meters"
        }
        else if (leg.journeyType != "WALK")
        {
            line_dist =  "Towards:\n" + leg.dir //leg.name + " Towards " + leg.dir
            //            helpingWord = "Towards"
            
        }
        else {
            line_dist = "--??---"
            helpingWord = "?????"
            
        }
        cell.line_dist.text = line_dist
        print("line_dist ::__:::\(line_dist)")
        //    cell.towards_or_walk.text = helpingWord
        
        //        cell.legImage.image = UIImage(named: "firstLeg.png")
        //        print("----image value is--\(cell.legImage)")
        //        cell.legImage.image = UIImage(named: "lastLeg.png")
        
        
        
        
        
        //-----#6-----#7------------------------ Destination Station....Leg
        cell.to_station.text = leg.destination.name
        cell.to_time.text = leg.destination.time
        // cell.transportTypeOutlet.text = leg.destination.type
        
        print("------090---------cell.to_time.text--989=")
        print(cell.to_time.text)
        
        
        print("------090---------cell.to_time.text--989=")
        print(cell.to_time.text)
        
        
        return cell
        
        //-----------------------------------------------------------------------------------------------------------Start
        // temp switch off
        // 9th nov friday 10 am--------------------start
        /*
        //-----------------------------------SECTION HANDLING--------------------------------------------start--------
        print("Start in cell for row at = \(indexPath)")
        // section handling
        var currentSection = 0
        
        if (currentSection == indexPath.section){
            
            print("Current Section is equal to indexpath.seection = \(currentSection) && \(indexPath.section)")
            
        }
        else if (currentSection != indexPath.section){
            
            // if session is new then counter reset
            // reset it for every new section.....
            print("New Section is being printed....Resetting all values....................")
            
            currentSection = indexPath.section
            departureCounter = 0
            showDeparture = false
        }
        // show departure reset
        
        //-----------------------------------SECTION HANDLING--------------------------------------------start--------
        
        ////MARK: Master Trip Dic--------------------Get Value Master Dict (For Current Section)-------------------start--------
        
        // get the value from master dict
        // Get value for current section
        // you will receive a dict of all values for rows within section
        
        let currentTripInfoDepartCellStatus = nextDepartureMasterDict.value(forKey: String(indexPath.section)) as! NSMutableDictionary
        
        // it should have values for all trip info cells
        // count of keys shuold be equal to trip info cells within current section
        print("currentTripInfoDepartureCell Status = allKeys =\(currentTripInfoDepartCellStatus.allKeys)")
        
        // get value for current Row
        print("indexPath Row = \(indexPath.row)")
        print("indexPath Section = \(indexPath.startIndex)")
        let valueDepartureCurrentRow = currentTripInfoDepartCellStatus.value(forKey: String(indexPath.row)) as! Int
        print("value departure current row = == \(valueDepartureCurrentRow)")
        
        // if value is 0 then show departure set true
        if (valueDepartureCurrentRow == 1){
            showDeparture = true
            departureCounter += 1
            
            print("Current Value Departure Counter === \(departureCounter)")
            print("Current Value of Departure Status == \(showDeparture)")
        }
        
        //-----------------------------------Get Value Master Dict (For Current Section)-------------------end--------
        
        //-----------------------------------show normal cell / show departure cel if true-----------start--------
        print("Show Departure Last Value ===== \(showDeparture)")
        if (showDeparture == true){
            
            // copy paste departure code......
            
            print("cell departure must be printed now.......1..")
            //    departureCounter += 1
            
            let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
            
            print("cell departure must be printed now......2...")
            
            showDeparture = false
            
            return cellDeparture
            
            
        }
        
        //if (showDeparture == false) {
        
        
        
        
        
        // show normal cells......BECAUSE Show Departure should be false
        print("SHOW DEPARTURE IS FALSE = \(showDeparture)")
        
        print("in printing normal cells ,current indexpath.row = \(indexPath.row) && departureCounter = \(departureCounter)")
        
        let currentIndex = indexPath.row - departureCounter
        print("IndexPath.Row = \(indexPath.row)")
        print("Calculated Current Index = \(currentIndex)")
        
        // copy paste code for normal cell......
        
        // ----------------------------------NORMAL CELL......................-----------START------
        let legList = newTrip[indexPath.section] as! Trip
        let test = NSMutableArray()
        var count = legList.LegList.count
        
        print("indexPath.row = \(indexPath.row) && Total count is = \(count)")
        //
        //        if (indexPath.row <= count){
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
        cell.backgroundColor = UIColor.white
        print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
        
        //MARK:BorderTripInfo
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = cellBorderWidth
        
        //headerCell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.lightGray
        //
        //
        //        let border = CALayer()
        //        let width = CGFloat(15.0)
        //        border.borderColor = UIColor.darkGray.cgColor
        //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
        //
        //        border.borderWidth = width
        //        tableView.layer.addSublayer(border)
        //        tableView.layer.masksToBounds = true
        
        
        /*
         cell.layer.borderWidth = 10.0
         cell.layer.borderColor = UIColor.green.cgColor
         
         */
        
        cell.tag = indexPath.row
        cell.nextDeparturesOutlet.tag = indexPath.row
        
        cell.sectionInfo = String(indexPath.section)
        cell.rowInfo = String(indexPath.row)
        
        cell.keyName = cell.sectionInfo + cell.rowInfo
        
        print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
        cell.name.isHidden = true
        //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
        cell.towards_or_walk.isHidden = true
        
        // MARK# Collection View
        // MARK: cell
        
        //MARK: CollectionView temp off
        
        //   cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        
        //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
        
        // 3
        // Configure the cell...
        // MARK: Move to collection 1
        
        print("From Station id = \(legList.originDetail)")
        
        test.add(legList.LegList[indexPath.row])
        let startingPoint = CGPoint(x: 35.0,y: 30.0)
        // let startingPoint = CGPoint(x: 35.0,y: -130.0)
        let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
        let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        // MARK: Move to collection 1 ---end
        // ------------setting Leg Images---------START
        print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
        count = count - 1
        print("--Row = \(indexPath.row)----count = \(count)")
        let leg = legList.LegList[indexPath.row] as! Leg
        
        cell.legImage.image = UIImage(named: leg.legImageName)
        // MARK: Leg
        print("cell for row  at index ===\(indexPath)-------------------------")
        print("leg image name ==\(leg.legImageName)")
        print("leg.line ==\(leg.line)")
        print("leg.dir ==\(leg.dir)")
        print("leg.journeyType ==\(leg.journeyType)")
        print("leg.name ==\(leg.name)")
        print("leg.origin ==\(leg.origin)")
        // legList.originDetail.name
        //----#1-----#2------------------------ Origin Station....Leg
        cell.from_station.text = leg.origin.name
        print("cell.from_station.text::::\(cell.from_station.text)")
        // temp cell.from_time.text = legList.originDetail.time
        cell.from_time.text = leg.origin.time
        // MARK: RTU Message Cell Level
        if (leg.rtu_Message_Flag == true){
            print("cell:: RTU Message ::::")
            print(leg.rtu_Message)
            cell.rtuMessage.isHidden = false
            cell.rtuMessage.text = leg.rtu_Message
            cell.rtuMessage.textColor = UIColor.red
        } else {
            cell.rtuMessage.isHidden = true
        }
        // cell.transportTypeOutlet.text = leg.origin.type
        //        if (leg.dir != "Default"){
        //        cell.towards_or_walk.text = leg.dir
        //        }
        cell.towards_or_walk.text = ""
        print("cell.towards_or_walk.text  :\(leg.dir)")
        
        // set root map reference
        // set root map geometry reference
        
        print("------090--------- cell.from_time.text--989=")
        print(cell.to_time.text)
        
        print("printing indexpath.row = in cell Level \(indexPath.row)")
        print("current Geom Ref is = \(leg.geomRef)")
        
        print("current Geom Ref is journeyDetailRef...........= \(leg.journeyDetailRef)")
        
        //-----#3------Visual Leg
        
        print(test.count)
        // MARK: Move to collection 2
        
        SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
        print("startingPoint_101001----\(startingPoint)")
        //----#4------
        cell.name.text = ""//leg.name
        
        //----#4.5------
        //----#5------line/dist
        cell.transportTypeOutlet.text = leg.journeyType
        cell.transportTypeOutlet.isHidden = true
        
        
        print("--212----journey type is =\(leg.journeyType)")
        print("--dist---- =\(leg.dist)")
        print("--Line--- =\(leg.line)")
        
        print("-leg.dir--- =\(leg.dir)")
        var line_dist = String()
        var helpingWord = String()
        print("leg.journey Type..... = \(leg.journeyType)")
        if (leg.journeyType == "WALK"){
            
            print("switching off walk cell to be touched..........")
            cell.isUserInteractionEnabled = false
            
            //        cell.multipleTouchEnabled = false
            
            
        }
        
        if (leg.journeyType == "WALK"){
            line_dist = leg.name + " "+leg.dist + " Meters"
            // helpingWord = "Meters"
        }
        else if (leg.journeyType != "WALK")
        {
            line_dist =   leg.name + " Towards " + leg.dir
            //            helpingWord = "Towards"
            
        }
        else {
            line_dist = "--??---"
            helpingWord = "?????"
            
        }
        cell.line_dist.text = line_dist
        print("line_dist ::__:::\(line_dist)")
        //    cell.towards_or_walk.text = helpingWord
        
        //        cell.legImage.image = UIImage(named: "firstLeg.png")
        //        print("----image value is--\(cell.legImage)")
        //        cell.legImage.image = UIImage(named: "lastLeg.png")
        
        
        
        
        
        //-----#6-----#7------------------------ Destination Station....Leg
        cell.to_station.text = leg.destination.name
        cell.to_time.text = leg.destination.time
        // cell.transportTypeOutlet.text = leg.destination.type
        
        print("------090---------cell.to_time.text--989=")
        print(cell.to_time.text)
        
        
        print("------090---------cell.to_time.text--989=")
        print(cell.to_time.text)
        
        
        return cell
        
        // ----------------------------------NORMAL CELL......................-----------END------
        // MASTer dict switching off on 9th nov for departure object insertion and deletion mecahnism 
        // 9th nov friday 10 Am
        */
        
        
        
        //   }
        
        // if show departure == true
        
        // departure cell print
        
        // else if show departure is false
        // print normal cells
        
        //            }
        //        else {
        //
        //
        //
        //        }
    }
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        <#code#>
    //    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//    
//        
//        return 100
//    }
 
    
    // MARK: Height of row
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleHeader = "SLife:" + String(section)
        return titleHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        let headerCellTemp = tableView.viewWithTag(section) as!TripSuggestionsCell_new
        //
        //        print("HeaderCellTemp tag value is = \(headerCellTemp.tag)")
        //
        //print("TableView Subview Counts = \(tableView.subviews.count)")
        
        //let headerCellTemp = tableView.subviews[section]. as! TripSuggestionsCell_new
        
        //              print("HeaderCellTemp tag value is = \(headerCellTemp.tag)")
        
        let tripCell = newTrip[section] as! Trip
        print("heightForHeaderInSection...........\(section).")
        print(legIconsLineCounter)
        print(tripCell.LegList.count)
        var lineCount = (tripCell.LegList.count*2) / legIconsLineTerminateCount
        
        let remainder = (tripCell.LegList.count*2) % legIconsLineTerminateCount
        //        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //
        
        print("Line count is  = \(lineCount)")
        print("remainder is (header) \(remainder) ")
        if (remainder != 0){
            lineCount+=1
            print("total line count is =inside heighForHeader==for section \(section)==is=\(lineCount)")
            
        }
        
        let icon_Count_Total = tripCell.LegList.count
        let screenWidth = UIScreen.main.bounds.width
        
        print("heightForHeaderInSection-----section  = \(section)")
        let total_icon_lines = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(60.0 + 10.0))
        // print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
        
        
        //MARK: Header Height Section
        print("header height : : SECTION = \(section) total icon lines = \(total_icon_lines)")
        let headerCellTotalHeight = (Int(legIconsHeight) * total_icon_lines.lineCount) + headerCellHeight
        print("headerCellTotalHeight = \(headerCellTotalHeight)")
        print("legIconsHeight = \(legIconsHeight)")
        print("lineCount = \(lineCount)")
        print("CGFloat::\(headerCellTotalHeight)")
        
        //heightFixed = true
        // var icon_Count_Total = tripCell.LegList.count
        // var lineTest = SlifeMethods.lineCountsToDisplayIcons(availableWidth: UIScreen.main.bounds.width, iconsCount: icon_Count_Total, iconWidth: CGFloat(20.0))
        // print("line Test is = \(lineTest)")
        //        var icon_counts = SlifeMethods.iconCountsToDisplayIcons(availableWidth: UIScreen.main.bounds.width, iconsCount: icon_Count_Total, iconWidth: CGFloat(20.0))
        //  print("icon counts total = \(icon_counts)")
        
        
        print("headerHeightDict==== \(headerHeightDict.allKeys)")
        // -----------header height cell testing
        //        let defaultBottomSpaceLeave = 15.0
        //        let defaultTopSpaceLeave = 15.0
        //        let defaultStackViewBottomSpaceBeforeIconLeave = 10
        
        
        let headerHeightCalculation = headerCell_StackView_Height + (total_icon_lines.lineCount * Int(default_startingSize.height))
        
        // -----------header height cell testing end
        
        print(".---------------------------------------------------Height Calculation HeaderCEll---.")
        print("total ICon Lines = \(total_icon_lines)")
        print("DefaultBottomSpace Leave = \(defaultBottomSpaceLeave)")
        print("(total_icon_lines * defaultBottomSpaceLeave) = \(defaultBottomSpaceLeave)")
        print("HeaderCell_StackViewHeight = \(headerCell_StackView_Height)")
        
        print("Returning with HeaderCell Trip Suggestion Height = \(headerHeightCalculation)")
        print(".-----------------------------------------------------.")
        return CGFloat(headerHeightCalculation)
        
        // temp check on above headerheightcalculation return CGFloat(headerCellTotalHeight)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCells") as! TripSuggestionsCell_new
        
          let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
           //let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        if (trip_detail_flag.contains("true")){
        
            print("trip detail flag = True?= \(trip_detail_flag)")
        
        headerCell.sectionSelected.isSelected = true
        } else {
            
            print("trip detail flag = False?= \(trip_detail_flag)")

            headerCell.sectionSelected.isSelected = false
        
        
        }
        
        
        headerCell.showTripRouteOnMapOutlet.isHidden = true
        headerCell.tag = section
        print("header cell tag = \(headerCell.tag)")
        headerCell.sectionSelected.tag = 100 + section
        print("header cell section selected tag = \(headerCell.sectionSelected.tag)")
        let stackView = headerCell.viewWithTag(10)
        print("stackView?.frame.height StackView Height = \(stackView?.frame.height)")
        //MARK: Header Cell Selected Check
        
        //    check for count of dict
        //        check for null value if value not found then ?
        //        if null then set value as false ?
        //        or just if null  or false returned then set white
        
        
        let headerSelectionFlagNull = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        print("header selection flag null = \(headerSelectionFlagNull)")
        if (headerSelectionFlagNull.contains("null") || headerSelectionFlagNull.contains("false")){
            headerCell.backgroundColor = headerRowDefaultColor
            print("null or false is here .... \(headerSelectionFlagNull)")
         }
        else if (headerSelectionFlagNull.contains("true")){
            headerCell.backgroundColor = headerRowSelectedColor
             print("True is here .... \(headerSelectionFlagNull)")
        }
        //MARK: TripSuggestionBorder
        //MARK: Corner Radius
        /*
         headerCell.layer.cornerRadius = 6 //set corner radius here
         headerCell.layer.borderColor = UIColor.lightGray.cgColor  // set cell border color here
         headerCell.layer.borderWidth = 2 // set border width here
         */
        //MARK: HeaderRowColor
        //   headerCell.backgroundColor = headerRowSelectedColor
        //___________________________
        headerCell.layer.masksToBounds = true
        headerCell.layer.borderWidth = headerBorderWidth
        //        headerCell.layer.borderColor = UIColor.gray.cgColor
        headerCell.layer.borderColor = UIColor.lightGray.cgColor
        
        
        //        let border = CALayer()
        //        let width = CGFloat(2.0)
        //        border.borderColor = UIColor.darkGray.cgColor
        //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
        
        
        print(tableView.rowHeight)
        headerCell.sectionSelected.tag = section
        // MARK: ShowTripDetail_Dict
        
        //        print("before setting dict values..................")
        //        showTripDetail_Dict.setValue(false, forKey: String(section))
        
        print("tableView.frame.size.height ........")
        print(tableView.frame.size.height)
        print("headerCell.frame.size.height ........")
        print(headerCell.frame.size.height)
        print("--heADER CELL BUTTON ID-")
        print(headerCell.sectionSelected)
        //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
        // headerCell.backgroundColor = UIColor.blue
        print("cell-header cell---\(headerCell)")
        
        let head = newTrip[section] as! Trip
        
        print("-In Sections--[Sections]=\(section)--)")
        print(".....head.count is \(head.dur)")
        
        //print(".....head.count is \()")
        print("-----section # \(section)")
        
        //      label.text = data[indexPath.row]
        
        // function getLabel(cell: dequeReusable as ! tripSugg,current index: int, legListPictorialSummary: some array)
        
        //        drawLeg()
        // try to run a for loop as all info is inside tripcell.
        
        let xy = CGPoint(x: 10.0,y: 0.0)
        let size = CGSize(width:10,height:10)
        
        let spacingFloat = CGPoint(x: size.width,y: size.height )
        
        
        //  let tripCell = trips[indexPath.row]
        //let tripCell = newTrip[indexPath.row]
        
        let tripCell = newTrip[section] as! Trip
        
        //drawLeg(xy, size: size, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, indexPath: <#T##NSIndexPath#>, orientation: <#T##Character#>, spacingFactor: <#T##Float#>)
        //  let startingPoint = CGPoint(x: 5.0,y: 2.0)
        
        let legIcons_y = headerCell.viewWithTag(10)?.frame.size.height
        
        // old starting vlaue of y is = 100
        
        print("y positions is ==== \(legIcons_y)")
        var startingPoint = CGPoint(x: 5.0,y: (legIcons_y! + 20.0))
        let startingSize = default_startingSize // CGSize(width:30.0,height:30.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = CGPoint(x:-1,y:0)
        let innerLegSpacing = CGPoint(x:10,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        // MARK: Draw Leg Icons
        print("tripCell.LegList.Count ==== \(tripCell.LegList.count)")
        print("headerCell.contentView.Frame:::::\(headerCell.contentView.frame)")
        var iconLegLine = 0
        legIconsLineCounter = 0
        var y = 0
        var line = 1
        var column = 1
        var icon_Count_Total = tripCell.LegList.count
        var screenWidth = UIScreen.main.bounds.width
        // MARK: Leg Image width required
        let iconLimits = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(70.0))
        print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
        // MARK: Line Termination
        
        var iconLiveCount = 1
        var iconLineLiveCount = 0
        var increment = 0
        // move this to above
        let legIconTopSpace = 10.0
        var defaultPositionToStart =  CGPoint(x: 5.0,y: (legIcons_y! + 10.0))
        let iconVerticalSpaceFactor = 2.0
        
        let iconHorizontalSpaceFactor = 2.0
        
        for index in tripCell.LegList {
            print("tripcell:LegList Value is here ::::\(tripCell.LegList)")
            let someObject = tripCell.LegList[increment] as! AnyObject
            print("someObject............ \(someObject)")
            if (RealTidMethods.checkIfDepartureObject(objectToCheck: someObject)){
            
            print("Departure Cell has been found = at increment value = \(increment)")
            
            }
           else {
            print("Top:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
            
            // change to next line if icon printing limit has reached
            if (iconLiveCount == iconLimits.iconCount){
                print("if:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                
                iconLiveCount = 1
                iconLineLiveCount += 1
                startingPoint.x = defaultPositionToStart.x
                startingPoint.y += startingSize.height //+ iconVerticalSpaceFactor
                     
            }
                
            else if (increment != 0) {
                print("Else:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                
                startingPoint.x += startingSize.width +  startingSize.width //+ iconHorizontalSpaceFactor
                iconLiveCount += 1
            }
            // keep printing icons
            let ns = NSMutableArray()
            var t = 0
            for index in tripCell.LegList {
            print(" current index counter t = \(t)")
            
            let obj2check = tripCell.LegList[t] as! AnyObject
                print("obj2check = \(obj2check)")
                if (RealTidMethods.checkIfDepartureObject(objectToCheck: obj2check)){
                
                print("Obj2Check = Departure Cell found")
                
                } else {
                
                print("LegIcon  found .......")
                }
            
            t += 1
            }
            
//                let t = tripCell.LegList[0] as! Leg

                
                
                print("tripCell.LegList.count = \(tripCell.LegList.count)")
            ns.add(tripCell.LegList[increment])
            print("leglist to print = \(ns.count)")
            
         // MARK: temp friday draw 1
                print("increment.........value is = \(increment)")
            print("Count of leglists === \(tripCell.LegList.count)")
      //MARK: Temp friday 9th of drawLegs
                //MARK: Header Cell Leg Icon Printing
              // creating tag
                // get section
                // get leg current indexPath
                // join them together
                // merge 0 or 1 accordingly
                   let tagSeriesStart = "6"
                let sectionIndexString = String(section)
                let legIndexString = String(increment)
                let sectionLegIndexUnion = tagSeriesStart + sectionIndexString + legIndexString
             
                let iconTagString = sectionLegIndexUnion + "0"
                let lineNoTagString = sectionLegIndexUnion + "1"
                let iconTagInt = Int(iconTagString)
                let lineNoInt = Int(lineNoTagString)
                
                print("Creating Tag for icon Legs:::::----------")
                print("Current Section:\(section)")
                print("Current Leg-Index:\(increment) & TotalLegs=\(tripCell.LegList.count)")
                
                print("---------Do we have same tag values Test 1----packagin---")
                print("----------String---------------")
                print("iConTagString: \(iconTagString)")
                print("lineNoTagString: \(lineNoTagString)")
                print("----------Int---------------")
                print("iconTagInt: \(iconTagString)")
                print("lineNoTagString: \(lineNoTagString)")
                
                print("---------Do we have same tag values Test 1---Values Sent----")
                
                let tagValueReceives = SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: default_startingSize, legs: ns , cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: section,indexValueFromCurrentLeg: increment, iconTagIntValue: iconTagInt!, lineNoIntValue: lineNoInt!)
                // Extract buttons which have been added
              
                print("---------Do we have same tag values Test 1-----Values Received--")
                print("Current Section:\(section)")
                print(" tagValueReceives.iconTagIntReturned = \(tagValueReceives.iconTagIntReturned)")
                print(" tagValueReceives.lineNoIntReturned = \(tagValueReceives.lineNoIntReturned)")
                
                
//                let iconButton = headerCell.contentView.v
                
//                print("iconButton:::::: \(iconButton)")
                

         
                 
                let iconNumberButton = headerCell.contentView.viewWithTag(tagValueReceives.iconTagIntReturned) as! UIButton
                
                print("iconButton Accessibility identifier: \(iconNumberButton.accessibilityIdentifier)")
                
                
                let lineNumberButton = headerCell.contentView.viewWithTag(tagValueReceives.lineNoIntReturned) as! UIButton
               
                
                if (tripCell.showHideCell == true){
                
                iconNumberButton.backgroundColor = UIColor.green
                }
                else {
                
                iconNumberButton.backgroundColor = UIColor.red
                
                
                }
                print("lineNumberButton Accessibility identifier: \(lineNumberButton.accessibilityIdentifier)")
                
          
                print("legicon:::::::")
             
                lineNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.Clicked), for: UIControlEvents.touchUpInside)
                lineNumberButton.backgroundColor = UIColor.red
                iconNumberButton.backgroundColor = UIColor.cyan
                
                iconNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.Clicked), for: UIControlEvents.touchUpInside)
                
        }
            increment += 1
          //  }
            
            
            // temp skip departure cell end here------------------------
        }
        
        
        
        
        
        // create header cell height dict bank
        
        // add section as key
        
        // calculate height by
        
        var heightHeaderCalculation = 20 + Int((headerCell.viewWithTag(10)?.frame.height)!) + (line * 30)
        headerHeightDict.setValue(heightHeaderCalculation, forKey: String(section))
        print("headerheight5dict has value of header cell = \(heightHeaderCalculation)")
        //MARK: header cell section line column
        print("HeaderCell:View: Section = \(section) Line : \(line) Column: \(column)")
        print("------from station = \(tripCell.originDetail.name)")
        print("------from time = \(tripCell.originDetail.time)")
        
        print("------to station = \(tripCell.destinationDetail.name)")
        print("---12341---to time = \(tripCell.destinationDetail.time)")
        
        headerCell.from_station.text = tripCell.originDetail.name
        headerCell.from_time.text = tripCell.originDetail.time
        headerCell.to_station.text = tripCell.destinationDetail.name
        headerCell.to_time.text = tripCell.destinationDetail.time
        headerCell.duration.text = tripCell.dur
        print(tripCell.originDetail.name)
        print(tripCell.originDetail.type)
        print(tripCell.originDetail.id)
        // MARK: Zone & Price Info
        
        var tariffZones_text = String()
        var tariffRemarks_price = String()
        
        if (tripCell.tariffZones.contains("Not")){
            tariffZones_text = "SL"
            
            
        } else {
            
            tariffZones_text = tripCell.tariffZones
            
        }
        if (tripCell.tariffRemark.contains("remarks")){
            
            tariffRemarks_price = "SL"
            
        } else {
            
            tariffRemarks_price = tripCell.tariffRemark
        }
        
        headerCell.ZoneInfo.text = tariffZones_text
        headerCell.PriceInfo.text = tariffRemarks_price
        // MARK: ZoneInfo Hide
        //MARK: TariffiInfo Hide
        headerCell.ZoneInfo.isHidden = true
        headerCell.PriceInfo.isHidden = true
        
        print("tripcell.duration is =)")
        // MARK: MapReference temp friday off
      
        /*
        let leg =  tripCell.LegList[0] as! Leg
        headerCell.mapReference.tag = section + 1
        headerCell.mapReference.accessibilityIdentifier = leg.journeyDetailRef
        headerCell.mapReference.isHidden = true
        headerCell.showTripRouteOnMapOutlet.tag = section + 1
        headerCell.showTripRouteOnMapOutlet.accessibilityIdentifier = leg.journeyDetailRef
        let mapReferenceKey = section + 1
        rootMap_Ref_Dict.setValue(leg.journeyDetailRef, forKey: String(mapReferenceKey))
        // MARK: AutoLayout
        */
        let evenOrNot = even(number: section)
        
        if (evenOrNot){
            
            // headerCell.backgroundColor = UIColor.lightGray
        }
        
        print("section::::::header:::\(section)")
        
        
        
        return headerCell
    }
    
    func even(number: Int) -> Bool {
        // Return true if number is evenly divisible by 2.
        return number % 2 == 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        <#code#>
        //    }
        //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "intermediateStops"){
            
            let selectedLegCell = sender as! LegListCells
            print("selected Leg Cell ===== \(selectedLegCell.transportTypeOutlet.text)")
            print("transportType Flag in prepare for segue == \(transportTypeFlag)")
            
            if (selectedLegCell.transportTypeOutlet.text != "WALK"){
                let vc = segue.destination as! IntermediateStopsViewController
                
                //  vc.setValue(selectedLegJourneyDetailedRef, forKey: "JourneyDetailedReference")
                print("selectedLegJourneyDetailedRef = \(setJourneyDetailedReference)")
                //segue.destinationViewController.setValue(selectedLegJourneyDetailedRef, forKey: "JourneyDetailedReference")
                
            } else {
                
                setJourneyDetailedReference = ""
                transportTypeFlag = "WALK"
                
            }
            
            
        }
        else if (segue.identifier == "TripMap")
        {
            
            tripRootMapFlag = true
            
            
        }
        
     
    }
    
    //
    //    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCells") as! HeaderCells
    //        headerCell.backgroundColor = UIColor.cyanColor()
    //
    //        let head = newTrip[section] as! Trip
    //
    //
    //
    //         print("-In Sections--[Sections]=\(section)--)")
    //        print(".....head.count is \(head.dur)")
    //        print("-----section # \(section)")
    ////        headerCell.from_time.text = head[section] as! String
    //        headerCell.from_time.text = head.destinationDetail.name
    //     //   switch (section) {
    //
    //
    //
    ////        case 0:
    ////            headerCell.from_time.text = head[section] as! String//"Europe";
    ////        //return sectionHeaderView
    ////        case 1:
    ////            headerCell.from_time.text = head[section] as! String //"Asia";
    ////        //return sectionHeaderView
    ////        case 2:
    ////            headerCell.from_time.text = head[section] as! String //"South America";
    ////        case 3:
    ////            headerCell.from_time.text = head[section] as! String //"South America";
    ////        case 4:
    ////            headerCell.from_time.text = head[section] as! String //"South America";
    ////        //return sectionHeaderView
    ////        default:
    ////            headerCell.from_time.text = "Other";
    ////        }
    //
    //        return headerCell
    //    }
    //
    //
    //    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
    //        footerView.backgroundColor = UIColor.blackColor()
    //
    //        return footerView
    //    }
    //
    //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 40.0
    //    }
    //
    
    }
    
*/

// Switching off 23rd dec 0700 HRS Morning------------END

// MARK: Possible problem start on 22nd december///---------start------23rd dec 0700

    
    func Clicked(sender: UIButton) {
        let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
        let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
        // set value for show hide cell
        
        print("Current tag of header cell when button clicked s = \(currentCell.tag)")
        print("Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
        if (currentHeaderTrip.showHideCell == true) {
            
            
            sender.backgroundColor = UIColor.red
            currentHeaderTrip.showHideCell = false
        } else {
            
            sender.backgroundColor = UIColor.green
            
            currentHeaderTrip.showHideCell = true
            
            
        }
}
// temp 23rd dec 0700
/*
        func Clicked2(sender: UIButton) {
            let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
            let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
            // set value for show hide cell
            
            print("Current tag of header cell when button clicked s = \(currentCell.tag)")
            print("Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
            if (currentHeaderTrip.showHideCell == true) {
                
                
                sender.backgroundColor = UIColor.red
                currentHeaderTrip.showHideCell = false
            } else {
                
                sender.backgroundColor = UIColor.green
                
                currentHeaderTrip.showHideCell = true
                
                
            }
            
            
            
            print("After:current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
            
            print("Current Cell clicked by bytton = \(currentCell.from_station)")
            
            print("Button Clicked..............\(sender.tag)...")
            tableView.reloadData()
            
        }
  */
        //  @IBOutlet weak var showNextDeparturesIn_TripInfoAction: UIButton!
        var showTripDetail_Dict = NSMutableDictionary()
        var showNextDeparturesTripInfo = NSMutableDictionary()
        var nextDepartureMasterDict = NSMutableDictionary()
        var showDeparture = false
        var departureCounter = 0
        
        var transportTypeFlag = String()
        
        // show hide trip info
        var showTripInfo = false
        var sectionShow = 10
        var showHideArray = [Bool]()
        
        //Mark: Autolayout Variables
        var legIconsLineCounter = 0
        let legIconsHeight = default_startingSize.height
        let headerCellHeight = 90 //100 //80 //60
        var legIconsLineTerminateCount = 1
        
        //  @IBOutlet weak var mapReferenceAction: UIButton!
        //    MARK:- showTripOnMapAction
        var addToFav_flag = false
        @IBAction func addToFavourite(sender: UIBarButtonItem) {
            
            print("--------from-------------")
            print(sr_fromStation_name)
            print(sr_fromStation_id)
            print("--------To-------------")
            print(sr_toStation_name)
            print(sr_toStation_ID)
            
            if (addToFav_flag == false){
                print("--------from---inside add to fav----------")
                
                SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: FAVOURITES)
                addToFav_flag = true
            }
            else {
                
                print("Already added......")
                
            }
        }
        
        @IBAction func showTripOnMapAction(sender: UIButton) {
            print("showTripOnMapAction .......")
            
            print("newTrip.count = \(newTrip.count)")
            print("sender.tag\(sender.tag)")
            
            let tripCell = newTrip[sender.tag - 1] as! Trip
            
            print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
            selectedRootTripForMap = tripCell.LegList
            //
            print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
            //
            //        print("\()")
            rootMap_Ref =   rootMap_Ref_Dict.value(forKey: String(sender.tag)) as! String
            
            tripRootMapFlag = true
            print("map Referrence Action = \(rootMap_Ref)")
        }
        
        @IBAction func mapReferenceAction(sender: UIButton) {
            
            let tripCell = newTrip[sender.tag - 1] as! Trip
            selectedRootTripForMap = tripCell.LegList
            //
            print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
            //
            //        print("\()")
            rootMap_Ref =   rootMap_Ref_Dict.value(forKey: String(sender.tag)) as! String
            
            tripRootMapFlag = true
            print("map Referrence Action = \(rootMap_Ref)")
        }
        
        @IBAction func showNextDepartures_InTripInfo(_ sender: UIButton) {
            print("showNextDepartures_InTripInfo has been Pressed :::::::::::::")
            //     let currentCell = sender.superview as! LegListCells
            //  if(newTrip.count != 0) {
            
            
            var clicked = false
            
            let button = sender as! UIButton
            let view = button.superview!
            //MARK: Departure temp off 9th nov 8pm
            // get values from the departure button clicked (from its super view)
            
            let currentCell = view.superview as! LegListCells
            let departureCellIndex = Int(currentCell.rowInfo)! + 1
            print("current cell show hidden value is = \(currentCell.showHideDepartureCell)")
            
            if (currentCell.showHideDepartureCell == false){
                // before cell was hidden
                // show departure cell
                let image = UIImage(contentsOfFile: "TripInfoDeparturesSelected.png")
                currentCell.nextDeparturesOutlet.setImage(image, for: .normal)
                // get the data
                //---------------------------end departure collection view old
                let customTripClass = CustomTripMethods()
                print("about to call webservice ......")
                customTripClass.get_data_from_url(from: currentCell.from_station.text!, to: currentCell.to_station.text!, tableView: tableView, headerSectionId: currentCell.sectionInfo, legRow_id: String((Int(currentCell.rowInfo)! + 1)))
                
                // insert into newtrip
                print("Custom Trip Next Departure dict status = \(custom_Trip_NextDepartures_Dict.count)")
                //            if (custom_Trip_NextDepartures_Dict.count != 0)
                //            {
                // MARK: replace it later with collection dict
                let newDepartureObject = TripInfoDepartures()
                print("Adding in new trip ........")
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(newDepartureObject, at: departureCellIndex)
                
                //    (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(custom_Trip_NextDepartures_Dict, at: departureCellIndex)
                //   }
                currentCell.showHideDepartureCell = true
                print("setting value to true for currentcell.showhide........")
            }
            else if (currentCell.showHideDepartureCell == true)
            {
                print("setting value to false......and removing object.......")
                let image = UIImage(contentsOfFile: "TripInfoDepartures.png")
                currentCell.nextDeparturesOutlet.setImage(image, for: .normal)
                
                print("Before Removal::::tableviews current count = \(tableView.subviews.count)")
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.removeObject(at: departureCellIndex)
                
                
                currentCell.showHideDepartureCell = false
                //
                //            tableView.subviews[0].removeFromSuperview()
                //            tableView.subviews[1].removeFromSuperview()
                //
                //    tableView.subviews[2].removeFromSuperview()
                
                tableView.reloadData()
                
                print("Removed:::::tableviews current count = \(tableView.subviews.count)")
                
                
                print("Removed:::::tableviews current count = \(tableView.subviews.count)")
            }
            // Departure new code start 9th nov 10Am friday 2016-----start
            // 1) get current section and index
            print("newtrip count = in departure action = \(newTrip.count)")
            
            // 1.1) check current object
            // MARK: temp off departures 9pm 9th nov
            
            /*
             let tripLegOrDepartureObject = (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList[Int(currentCell.rowInfo)!] as! AnyObject
             // 1.1.1) if LEG then add departure object
             print("checking for type of object received ::::::.")
             if (RealTidMethods.checkIfLeg(objectToCheck: tripLegOrDepartureObject)){
             // add leg object after the current index
             print("current index = \(currentCell.rowInfo)")
             print("Leg is present inside........")
             
             let newDepartureObject = TripInfoDepartures()
             print("adding  departure object in the trip.... at index = \(currentCell.rowInfo)")
             let trip = newTrip[Int(currentCell.sectionInfo)!] as! Trip
             
             print("\(trip.LegList.count)")
             
             print("Before Adding NewTrip.Leglist.Count = \(trip.LegList.count)")
             let departureCellIndex = Int(currentCell.rowInfo)! + 1
             print("Deprture Cell Index ======== \(departureCellIndex)")
             (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(newDepartureObject, at: departureCellIndex)
             //let trip = newTrip(Int(currentCell.sectionInfo) as! Trip
             //                let LegList = trip.LegList.count
             print("After Adding...NewTrip.Leglist.Count = \(trip.LegList.count)")
             
             }
             // 1.1.2) if DEPARTURE then remove departure object
             
             else if (RealTidMethods.checkIfDepartureObject(objectToCheck: tripLegOrDepartureObject)){
             
             //            let departureObjectToRemove =
             // Remove the current object at current rwo for current section within the newtrip
             let trip = newTrip[Int(currentCell.sectionInfo)!] as! Trip
             
             
             print("Before Removing Depart object = \(trip.LegList.count)")
             
             (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.removeObject(at: Int(currentCell.rowInfo)!)
             
             
             
             print("After Removing..Departure Object = \(trip.LegList.count)")
             
             
             
             
             }
             
             */
            
            // depart new code 9th nov friday -----------------------end
            
            //----------------------------------------------
            
            
            // Update Master Departure
            /* //------temp off 9th nov friday 10Am
             
             var currentSectionDict = nextDepartureMasterDict.value(forKey: String(currentCell.sectionInfo)) as! NSMutableDictionary
             print("All keys in next departureMasterDict = \(nextDepartureMasterDict.allKeys)")
             print("All keys in current section dict = Trip Info Level = \(currentSectionDict)")
             
             // get section and row as key
             let currentTripInfoCellValue = currentSectionDict.value(forKey: String(currentCell.rowInfo)) as! Int
             print("Current Cell Section = \(currentCell.sectionInfo) && Row = \(currentCell.rowInfo)")
             
             print("current Trip info CEll Value = \(currentTripInfoCellValue)")
             if (currentTripInfoCellValue == 0){
             
             currentSectionDict.setValue(1, forKey: String(currentCell.rowInfo))
             
             print("old=0new value for the current row = \(currentCell.rowInfo) = 1)")
             
             
             } else if (currentTripInfoCellValue == 1){
             
             
             currentSectionDict.setValue(0, forKey: String(currentCell.rowInfo))
             
             print("old=1 new value for the current row = \(currentCell.rowInfo) = 0)")
             
             }
             
             
             nextDepartureMasterDict.setValue(currentSectionDict, forKey: String(currentCell.sectionInfo))
             
             */ //        temp off 9th nov friday 10AM
            
            // update the tripinfo value against respective section
            
            
            
            
            // get section as key
            
            // receive dict and then receive value from index.row as key
            
            
            //----------------------------------------------
            print("current button tag =  \(sender.tag)" )
            
            // let indexPath = itemTable.indexPathForCell(currentCell)
            
            print("currentcell.sectioninfo & row = \(currentCell.sectionInfo) & \(currentCell.rowInfo)")
            
            print("currentCell.from_station.text station= \(currentCell.from_station.text)")
            
            print("current cell values  to station = \(currentCell.to_station.text)")
            
            // tableView.reloadData()
            
            
            //}
        }
        // Leg Image Names
        //MARK: Show Trip Details
        @IBAction func sectionAction(sender: UIButton) {
            print("section button is pressed with :\(sender.state) ")
            
            print(sender.tag)
            sectionShow = sender.tag
            print("Section Show sender = \(sectionShow)")
            print("Dict Section Show current keys = \(showTripDetail_Dict.allKeys)")
            var button = sender
            
            let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(sectionShow))
            print("---------show more pressed............trip_detail_flag=\(trip_detail_flag)")
            
            print("---------show more pressed............end")
            
            //        let testing = sender.superview as! HeaderCells
            //        testing.backgroundColor = UIColor.red
            // MARK: Show /Hide Trip Info
            if (trip_detail_flag.contains("null"))
            {
                button.isSelected = true
                print("Button current state in = null = \(button.state)")
                // button.state = UIControlState.selected
                
                print("show Trip info now for......")
                //             let valueNowb4 = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
                //
                print("-------null caught on section === \(sectionShow))")
                
                
                showTripDetail_Dict.setValue(true, forKey: String(
                    sectionShow))
                let valueNow = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
                
                print("now = in null \(valueNow)")
                
            }
            else
            {
                
                
                let  valueNowb4_true = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
                
                
                print("-------NOT null caught on section === \(sectionShow))")
                
                if (valueNowb4_true == true){
                    
                    button.isSelected = false
                    print("Button current state in = True = \(button.state)")
                    
                    
                    print("value was true ....trip info switch off....")
                    showTripDetail_Dict.setValue(false, forKey: String(
                        sectionShow))
                    
                    
                }
                else if (valueNowb4_true == false) {
                    
                    button.isSelected = true
                    print("Button current state in = false = \(button.state)")
                    
                    showTripDetail_Dict.setValue(true, forKey: String(
                        sectionShow))
                    
                    
                }
                //   print("current value of flag is=b4=true = \(valueNowb4_true)")
                let valueNow = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
                print("-------------section #  \(sectionShow)")
                
                print("--------------------------------------now = \(valueNow)")
                print("Total keys in showtripDetail Dict = \(showTripDetail_Dict.allKeys)")
                print("key count is = \(showTripDetail_Dict.count)")
                
                
            }
            
            
            
            print("Button current state = \(button.state)")
            print("Before setting button current image = \(button.currentImage)")
            
            
            // button.setImage(UIImage(named:"Plus_Close.png"), for: UIControlState.normal)
            
            button.setBackgroundImage(UIImage(named:"Plus_Close.png"), for: UIControlState.init(rawValue: 1))
            button.setBackgroundImage(UIImage(named:"Plus_options.png"), for: UIControlState.init(rawValue: 5))
            
            
            print("button . tag = \(button.tag)")
            //        button.backgroundColor = UIColor.red
            //        button.setTitle("SOME", for: UIControlState.normal)
            //        //button.setBackgroundImage(UIImage(named:"Plus_options.png"), for: UIControlState.selected)
            print("After setting button current image = \(button.currentImage)")
            
            tableView.reloadData()
            
        }
        
        //MARK: Old Leg Image Constant Place
        
        // Header Data Source--( Sections
        var newTrip = NSMutableArray()
        
        // Rows Data Source
        
        //    var newTrip = [Trip]()
        let legList = ["test-0","test-1","test-2"]
        //    var trips = [Trips]()
        
        var from = String()
        var to = String()
        var searchForArrivals = String()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // MARK: AutoRowHeight
            // tableView.backgroundColor = UIColor.white
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 200
            
            //        tableView.estimatedSectionHeaderHeight = 100
            //        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
            
            tripRootMapFlag = false
            
            // print("-selected index path---------\(self.tableView.indexPathForSelectedRow)")
            let searchTrips = WebServiceHandler()
            var url = String()
            
            print("from = = = = = \(from)")
            print("to = = = = = \(to)")
            
            // recent trips addition
            // MARK: Recent Trips Adding
            
            
            print(" sr_fromStation_id \(sr_fromStation_id) && count is \(sr_fromStation_id.characters.count)")
            print(" sr_fromStation_id \(sr_toStation_ID) && count is \(sr_toStation_ID.characters.count)")
            
            SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
            //
            //        if (advancedOptionsFlag == false){
            //         url = searchTrips.constructURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            if (advancedOptionsFlag == false){
                // coming from simple screen
                
                self.title = simple_expectedTripDate + "-" + simple_expectedTripTime
                
                url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
                
                // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                
                //             from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
                
            } else if (advancedOptionsFlag == true){
                
                self.title = expectedTripDate + "-" + expectedTripTime
                
                //        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
                url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            }
            print("-------------------url----\(url)")
            get_data_from_url(url: url)
            print("-----------------------ended--090")
            
        }
        override func viewWillAppear(_ animated: Bool) {
            
            
            //        tableView.backgroundColor = UIColor.white
            
            print("view will current real_time_flag value is ==== \(real_time_flag)")
            
            
            
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        //-----webservice start
        func get_data_from_url(url:String)
        {
            
            
            print("Trip Suggestions inside url : \(url)")
            let url:NSURL = NSURL(string: url)!
            let session = URLSession.shared
            
            let request = NSMutableURLRequest(url: url as URL)
            //    let testurl = NSURLConnection(request: request, delegate: request)
            
            request.httpMethod = "GET"
            
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            
            print("---json step 1------")
            let task = session.dataTask(with: request as URLRequest) {
                (
                data, response, error) in
                
                guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                    print("error- has been caught")
                    return
                }
                print("---json step 2------")
                DispatchQueue.main.async(execute: {
                    self.extract_json(jsonData: data! as NSData)
                    print("-trip--7.1--about to return after parsing")
                    
                    //          let tripFlag = RealTidMethods.checkIfArray(convertedJsonIntoNSDict1["TripList"]!["Trip"])
                    // MARK: Nil check
                    
                    // call method to check if nil has encountered
                    // check if the nsdict has error message
                    // check if
                    
                    print("about to check the generic error---------")
                    // Mark: Release check error
                    // in slife method, produce error out of nil some how and see what happens
                    // check for null
                    // if null then go back with error message
                    // else if not null then go below
                    print("about to check ErrorCheckFlag....inside..errorCheckFlag =....before.....")
                    
                    
                    // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
                    let nullCheck = RealTidMethods.checkIfKeyExists(objectToCheck: convertedJsonIntoNSDict1, keyName: "TripList")
                    
                    if (nullCheck == false){
                        
                        self.navigationController?.popViewController(animated: true)
                        print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED......null........")
                        
                    } else {
                        
                        let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
                        
                        if (errorCheckFlag == true){
                            print("errorCheckFlag....inside.......")
                            //MARK: release nil found
                            self.navigationController?.popViewController(animated: true)
                            print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED.......error.......")
                            
                        }
                        else if (errorCheckFlag == false){
                            let tripArray = (convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
                            print("-trip--7.1---A--")
                            
                            self.getTrips(json: convertedJsonIntoNSDict1)
                            print("-trip--7.1---B--")
                            //--for-1--------------------------------------------------------------------------------------------------
                            print("-trip--7.2--about to return after parsing")
                            // reload the table here
                            self.tableView.reloadData()
                        }
                    }
                    // dispatch_async(dispatch_get_main_queue(), {
                    print("before return....")
                    return
                })
            }
            task.resume()
        }
        
        func extract_json(jsonData:NSData)
        {
            print("---json step 3------")
            let json: AnyObject?
            do {
                print("json downloading in progres........4........")
                json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject?
                print("json just downloaded.......5........\(json?.allKeys)")
                //MARK: Nil
                //print("json just downloaded.......5........\((json?["TripList"]!! as AnyObject).description)")
                
                // load this json into Trip---start
                // load this json intro trip end here
                
            } catch {
                // NIL json check
                
                json = nil
                
                
                return
            }
            
            convertedJsonIntoNSDict1 = (json as? NSDictionary)!
            //getTrips(convertedJsonIntoNSDict)
            print("---6-----convertedJSON is being printed = \(convertedJsonIntoNSDict1.allKeys)")
        }
        
        func getTrips(json: NSDictionary){
            let tripArray = (convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
            //--for-1-------------------------------------------------------------------------------for 1---
            var forMain1 = 0
            for tripArray in tripArray {
                //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
                print("--------------------------------------------------------------------------------forMain1 \(forMain1)-----")
                
                //    var tripOneByOne = Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: tripArray.valueForKey("dur") as! String)
                //                         print("--tripArray is \(tripArray.allKeys)")
                //                     print("--tripArray.leglist is \(tripArray["LegList"])")
                //                    print("--tripArray.leglist is \(tripArray["LegList"])")
                //
                //---1720---15th of may
                //trips.append()
                
                
                
                // print("---LegList.allKeys--LegList is \(LegList.allKeys)")
                
                
                
                // var dur = ""
                let origin = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
                let destination = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
                
                var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: origin , destinationDetail: destination)
                let dur = (tripArray as! NSDictionary).value(forKeyPath: "dur")! as! String
                
                
                print("duration in trip suggestionsTViewController......\(dur)")
                //  print("tripArray----all Keys \(tripArray.allKeys)")
                
                var chg = ""
                var co2 = ""
                
                var tariffRemark = ""
                var tariffZones = ""
                // var LegList = [Leg]()
                // some variables which will be populated by external functions
                
                var from_time = ""
                var from_station = ""
                var to_Station = ""
                var to_time = ""
                print("----1A------------")
                trip.dur = (tripArray as! NSDictionary).value(forKey: "dur")! as! String
                trip.chg = (tripArray as! NSDictionary).value(forKey: "chg")! as! String
                trip.co2 = (tripArray as! NSDictionary).value(forKey: "co2")! as! String
                let change = trip.chg
                print("----2A------------")
                // <Trip><LegList><PriceInformation>----------------------------------------<PriceInformation>
                //<Trip><LegList><Leg>----------------------------------------------<Leg>
                
                // <Trip><LegList><Leg><Origin>---------------------------------<Origin>
                // move below lines inside origin to extract the value
                
                //            trip.from_time = tripArray.valueForKey("dur")! as! String
                //            trip.from_station = tripArray.valueForKey("dur")! as! String
                // <Trip><LegList><Leg><Destination>---------------------------------<Destination>
                //            trip.to_Station = tripArray.valueForKey("dur")! as! String
                //            trip.to_time = tripArray.valueForKey("dur")! as! String
                //
                
                //--Priceinfo--Start--------gather legs inside LegList-----start
                
                
                //  let priceInfo = tripArray.valueForKey("LegList")!["PriceInfo"] as! NSDictionary
                
                
                
                
                if let priceInfo = (tripArray as! NSDictionary).value(forKey: "PriceInfo") {
                    print("------price info found---yes--")
                    //                print("Price Info -----\(priceInfo.allKeys)")
                    
                    trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
                    print("trip suggestions 1...test")
                    trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
                    print("trip suggestions 2...test")
                    
                    //print("Price Info -----\(priceInfo.allKeys)")
                    
                } else {
                    
                    
                    trip.tariffRemark = "Tariff Remarks N/A"
                    trip.tariffZones = "Zones Not Available"
                    
                    print("------price info not found-----")
                    
                }
                //  let priceInfo = tripArray.valueForKey("PriceInfo")! as! NSDictionary
                
                
                //            print("Price Info -----\(priceInfo.allKeys)")
                //
                //            trip.tariffRemark = (priceInfo["TariffRemark"] as! NSDictionary)["$"] as! String
                //            trip.tariffZones = (priceInfo["TariffZones"] as! NSDictionary)["$"] as! String
                //
                // trip.tariffZones =  priceInfo["TariffZones"] as! NSDictionary
                
                //--Priceinfo--End--------gather legs inside LegList-----start
                
                var forMain11 = 0
                // create a leglist as an array to add the legs in the leglist
                var leglist = NSMutableArray()
                if (change == "0") {
                    // MARK: Swift 3 doubtful
                    //                leglist.addObject(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                    
                    print("trip suggestions 4...\((tripArray as! NSDictionary).value(forKey: "LegList"))")
                    print("change is 0 in trip suggestions tv")
                    
                    //leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                    
                    
                    
                    let triparrayTest = tripArray as! NSDictionary
                    print("trip array test.....\(triparrayTest.allKeys)")
                    
                    print(triparrayTest.count)
                    
                    
                    let tripDicTest = triparrayTest.value(forKey: "LegList") as!NSDictionary
                    
                    print("tripDicTest----890----------\(tripDicTest.allKeys)")
                    let legTestDict = tripDicTest.value(forKey: "Leg") as! NSDictionary
                    
                    print("legTestDict::::::\(legTestDict.allKeys)")
                    
                    
                    leglist.add(legTestDict)
                    
                    //   print("trip.value.leglist............\(tripDicTest.allKeys)")
                    
                    
                    // MARK: SWIFT 3 Commenting
                    
                    //                let leglistDictTest = (trip.value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                    //
                    //                print("leglistDictTest test.....\(leglistDictTest.allKeys)")
                    //
                    //                print(leglistDictTest.count)
                    //
                    //                let legDictTest = trip.value(forKey: "Leg") as! NSDictionary
                    //
                    //                print("legDictTest test.....\(legDictTest.allKeys)")
                    //
                    //                print(legDictTest.count)
                    //
                    //
                    //
                    //
                    //                leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                    
                    //      )
                    
                    
                    
                    // leglist.append(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                    //print("tripArray.valueForKey('LegList')--- \(tripArray.valueForKey("LegList")?.count)")
                }
                else {
                    let tempLegList = ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSArray
                    var i = 0
                    print("forMain1---- \(forMain1)")
                    print("forMain11---- \(forMain11)")
                    for (tempLegList) in tempLegList {
                        
                        
                        let legCheck = tempLegList as! NSDictionary
                        
                        let orgCheck = legCheck.value(forKey: "Origin")
                        
                        print("legCheck all keys......\(legCheck.allKeys)")
                        print("orgCheck all keys......\(orgCheck)")
                        
                        
                        //  print("legCheck::::::tempLegList \(legCheck.journeyType)")
                        leglist.add(tempLegList)
                        print("tempLegList.count is---- \((tempLegList as AnyObject).count)")
                        print("i---- \(i)")
                        i += 1
                    }
                }
                var legs = NSMutableArray()
                let legListCount = leglist.count
                
                print("leglist.count-b4---999\(leglist.count)")
                //--for-1------------------------------------------------------------------------------from 11
                for leglist in leglist {
                    let someValue = leglist as! NSDictionary
                    
                    // type could be "METRO" or "WALK"
                    //  let legCount = leglist["Leg"]!
                    
                    print("test first inside lieglist......\(someValue.allKeys)")
                    print("test first inside lieglist......\((leglist as! NSDictionary).value(forKey: "Leg"))")
                    
                    //  here you are receiving leglist as dictionary, now iterate through the keys and use the result
                    
                    //let legCount = (leglist as! NSDictionary).value(forKey: "Leg") as! NSArray
                    
                    print("leglist.count---- \((leglist as AnyObject).count)")
                    print("forMain 1---- \(forMain11)")
                    print("forMain 2---- \(forMain11)")
                    
                    let journeyType = (leglist as! NSDictionary)["type"]! as! String
                    // if leg type is WALK then create a legwalk object populate it and then add it to trip
                    var destinDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
                    var originDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
                    print("-----journey type = \(journeyType)")
                    //-----------------if condition walk and travel---------start
                    
                    //                if (journeyType == "WALK"){
                    
                    // common variable extraction
                    // extract ---------------------------------name-, type, idx
                    let nameValue = (leglist as! NSDictionary)["name"]! as! String
                    let idxValue = (leglist as! NSDictionary)["idx"]! as! String
                    let typeValue = (leglist as! NSDictionary)["type"]! as! String
                    
                    // extract ---------------------------------Geometry Reference
                    let geomRef = (leglist as! NSDictionary)["GeometryRef"]
                    let geometryReference = (geomRef as! NSDictionary)["ref"] as! String
                    print("leglist.allKeys......... in trip suggestion checking")
                    // print(leglist.allKeys)
                    
                    
                    // MARK: Geometry Reference
                    // MARK: RTU Message Check
                    //                if (leglist["RTUMessages"] is NSNull){
                    //
                    //                print("NS NULL FOR RTU MESSAGES.....")
                    //
                    //                } else if (leglist["RTUMessages"] == nil){
                    //                    print("NS NULL FOR RTU MESSAGES.....")
                    //
                    //
                    //                } else
                    //                {
                    //
                    //                    let rtuMessages = leglist["RTUMessages"] as! NSDictionary
                    //                    print("rtuMessages.allKeys")
                    //
                    //                    print(rtuMessages.allKeys)
                    //
                    //                }
                    // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
                    
                    print("GEOMETRY REFERENCE VALUE IS .......\(geometryReference)")
                    // --------------------------dist, hide---------------walk related variable extraction
                    //------variables for walk
                    var hideValue = "FALSE"
                    var distValue = DEFAULT
                    // -----variables for travel -
                    var dirValue = DEFAULT
                    var journeyDetailRefValue = DEFAULT
                    var lineValue = DEFAULT
                    print("journey type is : \(journeyType)")
                    if(journeyType == "WALK"){
                        
                        distValue = (leglist as! NSDictionary)["dist"]! as! String
                        print("--distValue is -----\(distValue)")
                        //var hideValue = ""
                        if let hide = (leglist as! NSDictionary)["hide"] as? String {
                            print(".......1.0")
                            hideValue = hide
                        }
                            
                        else {
                            print(".......1.1")
                            hideValue = "False"
                        }
                    }
                        // travel related variable extraction
                        // --------------------------dir, line, JourneyDetailReference
                        
                    else if (journeyType != "WALK"){
                        print("---inside not walk---stuck")
                        dirValue = (leglist as! NSDictionary)["dir"]! as! String
                        
                        print("---dir----\(dirValue)")
                        
                        let journeyDetailRef_Key = (leglist as! NSDictionary)["JourneyDetailRef"] as! NSDictionary
                        journeyDetailRefValue = journeyDetailRef_Key["ref"] as! String
                        lineValue = (leglist as! NSDictionary)["line"]! as! String
                        
                    }
                    
                    print("Journey Type = \(journeyType)")
                    let origin = (leglist as! NSDictionary)["Origin"] as! NSDictionary
                    //trip.from_time = origin["time"]! as! String
                    let originNameVal = origin["name"]! as! String
                    let originTypeVal = origin["type"]! as! String
                    let originIdVal = origin["id"]! as! String
                    let originLonVal = origin["lon"]! as! String
                    let originLatVal = origin["lat"]! as! String
                    let originTimeVal = origin["time"]! as! String
                    let originDateVal = origin["date"]! as! String
                    print("---check point temp")
                    var originRouteIdx = String()
                    if (journeyType == "WALK"){
                        
                        originRouteIdx = "WALK"
                        
                    }
                    else {
                        
                        originRouteIdx = origin["routeIdx"] as! String
                        
                    }
                    // let originRouteIdx = "routeIdx"
                    //     print("-12----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                    
                    //  Address(name: <#T##String#>, type: <#T##String#>, id: <#T##String#>, lon: <#T##String#>, lat: <#T##String#>, time: <#T##String#>, date: <#T##String#>, routeIdx: <#T##String#>)
                    originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal,routeIdx: originRouteIdx)
                    
                    //                    print("---12--originNameVal-\(originNameVal)")
                    //                    print("--12---originDetail.name-\(originDetail.name)")
                    //
                    //                    print("---12--Origin- originNameVal-\(originNameVal)")
                    //
                    //
                    //                    print("-12----Origin- originNameVal-\(originNameVal)")
                    
                    //                    let destination = leglist["Destination"] as! NSDictionary
                    //    print("nested loop current index \(forMain11)")
                    print("test 1.1")
                    let destination = (leglist as! NSDictionary)["Destination"] as! NSDictionary
                    // trip.from_time = origin["time"]! as! String
                    let destinNameVal = destination["name"]! as! String
                    let destinTypeVal = destination["type"]! as! String
                    print("test 1.2")
                    let destinIdVal = destination["id"]! as! String
                    let destinLonVal = destination["lon"]! as! String
                    print("test 1.3")
                    let destinLatVal = destination["lat"]! as! String
                    let destinTimeVal = destination["time"]! as! String
                    let destinDateVal = destination["date"]! as! String
                    
                    var destRoutIdx = String()
                    
                    if (journeyType == "WALK"){
                        
                        destRoutIdx = "WALK"
                    } else {
                        destRoutIdx = destination["routeIdx"]! as! String
                    }
                    print("test 1")
                    print("------destination.allkeys = \(destination.allKeys)")
                    destinDetail = Address(name: destinNameVal, type: destinTypeVal, id: destinIdVal, lon: destinLonVal, lat: destinLatVal, time: destinTimeVal, date: destinDateVal, routeIdx: destRoutIdx)
                    print("test 2")
                    // DECIDED TO KEEP WALK AS IT IS , before it was being saved with key but there is no use of having key and saving it because then it is hard to access as well as below you can see it is being saved as LEGWALK
                    // let legWalkDict = ["WALK": legwalkDict] as NSDictionary
                    //    var legWalk = LegWalk(journeyType: journeyType, legWalk: legWalkDict as! Dictionary<String, Walk, originValue: originDetail , destinationValue: destinDetail)
                    
                    //                    var legWalk = LegWalk(journeyType: journeyType, legWalk: legwalkDict, originValue: originDetail , destinationValue: destinDetail)
                    
                    print("test 3")
                    
                    print("--End--------------End------------------forMain11  \(forMain11)-----")
                    print("leglist count is---head--=\(legListCount)")
                    print("--logic main---forMain11  is = \(forMain11 + 1)-----Leglist count is =\(legListCount)")
                    // check the value of count
                    print("()---originDetail.name= \(originDetail.name)")
                    print("()---destinDetail.name= \(destinDetail.name)")
                    
                    // extracting origin and destination for Trip (complete journey)
                    // extracting origin and destination for trip each leg
                    // case A   --onlyLeg
                    if (legListCount == 1){
                        print("leglist count is-----=\(legListCount)")
                        trip.originDetail = originDetail.mutableCopy() as! Address
                        trip.destinationDetail = destinDetail.mutableCopy() as! Address
                        print("---A------------------originDetail= \(originDetail.name)")
                        print("----A-----------------originDetail= \(trip.originDetail.name)")
                    }
                        // CASE B -First----first leg
                    else if (legListCount > 1 && forMain11 == 0)
                    {
                        print("leglist count is-88-origin--=\(legListCount)")
                        trip.originDetail = originDetail.mutableCopy() as! Address
                        print("----B-----------------originDetail= \(originDetail.name)")
                        print("----B-----------------originDetail= \(originDetail.name)")
                        print("-----B----------------originDetail= \(trip.originDetail.name)")
                        
                    }
                    else if (legListCount > 1 && ((forMain11 + 1) == legListCount))
                    {
                        print("leglist count is-88-destin--\(legListCount)")
                        
                        trip.destinationDetail = destinDetail.mutableCopy() as! Address
                        print("---C------------------destinationDetail= \(destinDetail.name)")
                        print("---C------------------destinationDetail= \(trip.destinationDetail.name)")
                        
                        print("legListCount > 1 && ((forMain11) == count ---------")
                    }
                    var legImageName = String(DEFAULT)
                    let i  = forMain11 + 1
                    
                    if (legListCount == 1) {
                        // onlyLegImage
                        legImageName = onlyLegImage
                        
                    } else if (legListCount == 2 ){
                        
                        // firstImage
                        if (i == 1){
                            legImageName = firstLegImage
                            
                        }
                            // lastImage
                            
                        else if (i == 2){
                            legImageName = lastLegImage
                            
                        }
                        
                    }
                        // firstLeg, middle, lastLeg
                    else if (legListCount > 2) && (i == 1) {
                        // firstLegImage
                        legImageName = firstLegImage
                        
                    }
                        // middleLegImage
                    else if (legListCount > 2) && (i != legListCount) {
                        
                        legImageName = middleLegImage
                        
                    }
                        // lastLegImage
                        
                    else if (legListCount > 2) && (i == legListCount) {
                        
                        legImageName = lastLegImage
                    }
                    
                    print("dist value is going to the final= \(distValue)")
                    //    let rtuMessages_Exists = leglist["RTUMessag"] != nil
                    let checkKeyExist = RealTidMethods.checkIfKeyExists(objectToCheck: leglist as AnyObject, keyName: "RTUMessages")
                    var rtuMessageString = String()
                    if (checkKeyExist == true) {
                        let leglistRTUMessage = (leglist as! NSDictionary)["RTUMessages"] as! NSDictionary
                        // MARK: Rtu Message Get
                        var rtuMessage = RealTidMethods.checkIfKeyExists(objectToCheck: leglistRTUMessage, keyName: "RTUMessage")
                        if (rtuMessage == true){
                            
                            print("--------rtu Message.....status................\(leglistRTUMessage.allKeys).")
                            print(rtuMessage)
                            //    print(leglistRTUMessage["RTUMessage"]!["$"] as! String)
                            rtuMessageString = (leglistRTUMessage["RTUMessage"]! as! NSDictionary)["$"] as! String
                        }
                        
                        
                    }
                    print("check if Key Exist or not ======== \(checkKeyExist)")
                    // MARK: Leg Population
                    let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString)
                    print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                    print("rtu message status from leg = message = \(leg.rtu_Message)")
                    trip.LegList.add(leg)
                    forMain11 += 1
                    //----------------if condition walk & travel----------end
                }
                print("---LegList.allKeys----duration being entered is :\(dur)")
                self.newTrip.add(trip)
                print("--End--------------End------------------forMain1  \(forMain1)-----")
                forMain1 += 1
            }
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // 1
            // Return the number of sections.
            print("section count is = \(newTrip.count)")
            
            return newTrip.count
        }
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            print("row has been selected..........\(indexPath.row)")
            print("\(tableView.cellForRow(at: indexPath)?.tag)")
            // reset intermediat stops if it is already initialised
            
            if (intermediateStops.intermediateStops.count == 0){
                
                print("still intermediate stops is nil....in did select row at ind... in trip suggestionsT View Controller")
                
            }
            else {
                print("----about to reset INTERMEDIATE STOPS....")
                IntermediateStopsViewController.resetIntermediateStops(intermediateStopsFullObject: intermediateStops)
                
            }
            // let leg = legList.LegList[indexPath.row] as! Leg
            
            //        print("Leg Journey Detailed Ref: \()")
            
            
            let legList = newTrip[indexPath.section] as! Trip
            //let test = NSMutableArray()
            
            //test.addObject(legList.LegList[indexPath.row])
            //        let startingPoint = CGPoint(x: 35.0,y: 30.0)
            //        let startingSize = CGSize(width:20.0,height:20.0)
            //        let orientation = "x"  // x, y, or xy
            //        let innerSpacing = CGPoint(x:10,y:0)
            //        let innerLegSpacing = CGPoint(x:25,y:0)
            //        let sizeFactor = CGSize(width: 0.0,height: 0.0)
            //        // ------------setting Leg Images---------START
            print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
            var count = legList.LegList.count
            count = count - 1
            print("--Row = \(indexPath.row)----count = \(count)")
            let leg = legList.LegList[indexPath.row] as! Leg
            print("checking transport type........ when leg is being selected....\(leg.type)")
            // reset intermediate stops
            if (leg.type != "WALK"){
                setJourneyDetailedReference = leg.journeyDetailRef
                setOriginStop = Int(leg.origin.routeIdx)!
                setDestinationStop = Int(leg.destination.routeIdx)!
                
                // set the origin name & time
                setRootLegOriginTime = leg.origin.time
                setRootLegOriginStation = leg.origin.name
                // set the destination name & time
                setRootLegDestinationTime = leg.destination.time
                setRootLegDestinationStation = leg.destination.name
                print("current indexPath.row = \(indexPath.row)")
                print("Current journey detail reference is \(leg.journeyDetailRef)")
                print("passing det ref = \(selectedLegJourneyDetailedRef)")
                print("::::origin id. ...... \(setOriginStop)")
                print("Root Cell Selection : Origin : \(leg.origin.name)")
                print("::::dest id. ...... \(setDestinationStop)")
                print("::Root Cell Selection : Destination : \(leg.destination.name)")
                
                //cell.legImage.image = UIImage(named: leg.legImageName)
                
                
                print("SECTION SELECTED = ")
                print(indexPath.section)
                print("CELL SELECTED = ")
                print(indexPath.row)
                print("section  ?  SELECTED =  tableView.indexPathForSelectedRow = ")
                print(tableView.indexPathForSelectedRow)
                
                
            } else {
                
                transportTypeFlag = "WALK"
            }
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // return newTrip[section].legList.count
            let legList = newTrip[section] as! Trip
            print("----LegList Count is in number of rows in section=\(legList.LegList.count)")
            print("section show value in number of rows in section = \(sectionShow)")
            
            // extract value of section if not null
            // check if it is true then show
            // else return 0
            
            // check for null
            print("section # is \(section)")
            let section_null_or_not = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
            
            
            if (section_null_or_not.contains("null")){
                
                
                
                print("section null or not contains===== false = \(section_null_or_not)")
                
                
            } else if (section_null_or_not.contains("true")) {
                
                
                
                print("section null or not contains===== True = \(section_null_or_not)")
                
                print(" \(legList.LegList.count)")
                
                //MARK: NextDepartureCEll Count Return
                
                //            var departureCellCount = 0
                //----------------------------
                
                
                //  let key = String(currentCell.sectionInfo)  + String(currentCell.rowInfo)
                //                let nextDepartureShowFlag = RealTidMethods.checkIfKeyExists(objectToCheck: showNextDeparturesTripInfo, keyName: String(key))
                //                print("nextDepartureShowFlag= \(nextDepartureShowFlag)")
                //                print("showNextDeparturesTripInfo-------\(showNextDeparturesTripInfo.allKeys)")
                //                print("Checking for next departure cell show value....in number of rows in cell... in show next departure action....")
                //                if (nextDepartureShowFlag == true){
                //                    print("Key exists for show hide..in number of rows in cell....some one has checked before as well....")
                //                    // key found
                //                    // check for previous value
                //                    let value =  showNextDeparturesTripInfo.value(forKey: key) as! Bool
                //
                //                    print("value received is == \(value)")
                //                    if (value == true){
                //
                //                        // value is true , show cell
                //                        // increase count for departure cell to show
                //                        departureCellCount = 1
                //
                //                       print("Departure cell count new value is 1-SHOW. .... hide collection view.....")
                //
                //                    } else if (value == false ){
                //                    departureCellCount = 0
                //                        print("Departure cell count new value is 0-HIDE. .... hide collection view.....")
                //
                //
                //                    }
                //                }
                //
                
                //---------------------------
                
                
                // ------------temp of master dict on 9th nov 10am friday-----------start---------
                
                /*
                 var departureCellCount = 0
                 // Departure Master Creation ------
                 var sectionTripInfoDict = NSMutableDictionary()
                 // get count for currection section number of rows
                 // creat this only first time
                 // var currentSectionDepartureCells = 0
                 
                 var currentTripInfoDepartCount = 0
                 
                 var i = 0
                 
                 // check if master dict is empty or not ()
                 
                 let masterDepartDictFlag  = RealTidMethods.checkIfKeyExists(objectToCheck: nextDepartureMasterDict, keyName: String(section))
                 
                 if (masterDepartDictFlag == false){
                 
                 // add the section level key
                 
                 nextDepartureMasterDict.setValue(sectionTripInfoDict, forKey: String(section))
                 
                 // get object and update it
                 let currentTripInfoDepartDictObj = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                 
                 // add the trip info level keys
                 var i = 0
                 for index in legList.LegList {
                 
                 // set value as 0 for each tripinfo cell row index
                 currentTripInfoDepartDictObj.setValue(0, forKey: String(i))
                 
                 print("---------------------Section = \(section) && i = \(i) value = \(0)")
                 i += 1
                 }
                 
                 print("currentTripInfoDepartDictObj all keys = \(currentTripInfoDepartDictObj.allKeys)")
                 
                 print("currentTripInfoDepartDictObj.count = \(currentTripInfoDepartDictObj.count)")
                 print("leglist.leglist.count = \(legList.LegList.count)")
                 
                 // update it back to the main object
                 
                 nextDepartureMasterDict.setValue(currentTripInfoDepartDictObj, forKey: String(section))
                 
                 
                 
                 } else if (masterDepartDictFlag == true){
                 // extract current trip info level dict object
                 let currentTripInfoDepartDictObj = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                 print("currentTripInfo DepartDictObj === \(currentTripInfoDepartDictObj.allKeys)")
                 // iterate throught the object and
                 var i = 0
                 //  let tripInfoDepartDict =  currentTripInfoDepartDictObj.value(forKey: String(section)) as! NSMutableDictionary
                 
                 for (key,index) in currentTripInfoDepartDictObj {
                 let iStr = String(i)
                 if (iStr.contains(key as! String))
                 {
                 
                 currentTripInfoDepartCount += currentTripInfoDepartDictObj[iStr] as! Int
                 
                 }
                 
                 i += 1
                 }
                 
                 // add to main return number of cell counts
                 
                 
                 
                 
                 }
                 
                 
                 //                let currentMasterDepartDict = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                 //
                 //                if (currentMasterDepartDict.count == 0){
                 //                for index in legList.LegList.count {
                 //                    print("section ::: \(section) && i = \(i) Count = \(legList.LegList.count)")
                 //                  // resetting all departure values
                 //                    sectionTripInfoDict.setValue(0, forKey: String(i))
                 //                    }
                 //                } else {
                 //                // if the dict has keys more than 0 then update the return count based on
                 //                    var i = 0
                 //                    for index in legList.LegList.count {
                 //
                 //
                 //
                 //                    }
                 //
                 //                    currentSectionDepartureCells +=
                 //                }
                 
                 
                 //                print("sectionTripInfo All Keys = \(sectionTripInfoDict.allKeys)")
                 //                print("sectionTripInfo Dict Total Count = \(sectionTripInfoDict.count)")
                 //
                 // once created then iterate through current section values and add it to total current count
                 
                 
                 //  print("number of rows in Section: LegList= \(newTrip[section].)")
                 
                 //  print("s[section].Rows are = \(s[section].count)")
                 
                 
                 
                 
                 print("LegList.Leglist.Count = \(legList.LegList.count) && DepartureCellCount = \(currentTripInfoDepartCount)")
                 let totReturn = legList.LegList.count + currentTripInfoDepartCount
                 
                 return totReturn //legList.LegList.count + currentTripInfoDepartCount
                 */
                
                // ------------temp of master dict on 9th nov 10am friday-----------
                return legList.LegList.count
            }
            // if not null then check if true
            //            rip_detail_flag.contains("null")
            
            // if true then return leglist as below
            
            /*
             if (section == sectionShow){
             
             print(" \(legList.LegList.count)")
             return legList.LegList.count
             }
             */
            //-------------------------
            return 0
        }
        
        // MARk: Collection View Methods
        // MARK: checked: almost same 23rd dec
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            // triplegiconscollection view cell name is old but now it is being used for next departures collection view show
            
            //          tableView.backgroundColor = UIColor.white
            print("-------------Section = \(indexPath.section) & Row = \(indexPath.row)")
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuseIdentifier", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
            
            // MARK: border collection view
            
            
            // cell.from_time.layer.backgroundColor  = UIColor.red.cgColor
            //  cell.from_time.layer.cornerRadius = 5
            
            
            //headerCell.layer.borderColor = UIColor.gray.cgColor
            
            /*
             if (colorFlag == true){
             
             cell.backgroundColor = UIColor.lightGray
             cell.from_time.textColor = UIColor.white
             cell.to_time.textColor = UIColor.white
             
             colorFlag = false
             } else {
             
             cell.backgroundColor = UIColor.white
             cell.from_time.textColor = UIColor.black
             cell.to_time.textColor = UIColor.black
             
             colorFlag = true
             
             }
             */
            //        if(indexPath.row == 2){
            //
            //            cell.backgroundColor = UIColor.red
            //
            //        }
            
            
            
            var layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            
            //layout.scrollDirection = UICollectionViewScrollDirection.horizontal
            print("Custom Trip Next Departures\(custom_Trip_NextDepartures_Dict.allKeys)")
            if (custom_Trip_NextDepartures_Dict.count > 0 ){
                
                let currentSection = String(indexPath.section)
                let currentRow = String(indexPath.row)
                let view = collectionView.superview!
                // MARK: Collection view friday eve 9th nov temp off
                //
                //            let currentCell = view.superview as! LegListCells
                
                
                let currentCell = view.superview as! LegTripNextDeparturesTableViewCell
                let keyNameTemp = currentCell.keyName
                print("printing cells..keyname temp from current cell = \(keyNameTemp)")
                let keyName = currentSection + currentRow
                print("Collection ALL KEYS = \(custom_Trip_NextDepartures_Dict.allKeys)")
                print("generated current key via indexpth.section and row = \(keyNameTemp)")
                print("index path row values in collection cell for = \(indexPath.row)")
                if let collection_Values_flag = custom_Trip_NextDepartures_Dict[keyNameTemp]
                {
                    
                    //if (collection_Values_flag == true){
                    let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                    
                    print("customDepTripArray Count = \(customDepTripArray.count)")
                    
                    print("-----test 10989")
                    // MARK: temp wed 14 th dec changing
                    
                    //                let tripCustom = customDepTripArray[indexPath.row] as! Trip
                    let tripCustom = customDepTripArray[indexPath.section] as! Trip
                    print("Collection View Cell Section  =\(indexPath.section) && Row = \(indexPath.row)")
                    
                    //MARK: Temp 14th dec changes
                    //let leg = tripCustom.LegList.firstObject as! Leg
                    let leg = tripCustom.LegList[indexPath.row] as! Leg
                    
                    //   let leg = tripCustom.LegList[indexPath.row] as! Leg
                    // -----temp
                    print("tripCustom.LegList.count===\(tripCustom.LegList.count)")
                    
                    print("firstTripDep =\(tripCustom.originDetail.name) ")
                    //-------------collection view border ------------start
                    
                    // MARK: DepartureCells icon X Spacing
                    var middleLeg_x_spacing = CGFloat(8)
                    var firstLeg_x_spacing = CGFloat(10)
                    var lastLeg_x_spacing = CGFloat(7)
                    var onlyLeg_x_spacing = CGFloat(8)
                    var leg_x_spacing = CGFloat(0)
                    
                    // MARK: CollectionView Border
                    
                    
                    
                    print("Before IF old section value = \(oldSectionValue) & section = \(indexPath.section) & ROW = \(indexPath.row)")
                    if (oldSectionValue != indexPath.section){
                        print("JUST INSIDE IF -old section value = \(oldSectionValue) & section = \(indexPath.section)")
                        if (collectionCellColor == false)
                        {
                            collectionCellColor =  true
                        } else {
                            
                            collectionCellColor = false
                            
                        }
                        oldSectionValue = indexPath.section
                        
                    }
                    print("Collection CellColor = \(collectionCellColor)")
                    print("After if---old section value = \(oldSectionValue) & section = \(indexPath.section)")
                    
                    // following value will be true/false for each leg
                    
                    
                    
                    if (collectionCellColor == true){
                        //collectionCellColor = false
                        // cell.layer.masksToBounds = true
                        //   cell.layer.borderWidth = 2.0 // cellBorderWidth
                        //  cell.layer.cornerRadius = 10.0
                        //    cell.layer.borderColor = legColorFirst
                        
                        //UIColor.lightGray.cgColor
                        //tableView.backgroundColor = UIColor.lightGray
                        
                        print("collectionCellColor = FALSE section \(indexPath.section) & row \(indexPath.row)")
                    } else {
                        
                        //collectionCellColor = true
                        cell.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
                        //   cell.layer.masksToBounds = true
                        //  cell.layer.borderWidth = 2.0 // cellBorderWidth
                        //   cell.layer.cornerRadius = 10.0
                        //  cell.layer.borderColor = legColorSecond//UIColor.yellow.cgColor//UIColor.lightGray.cgColor
                        print("collectionCellColor = TRUE section \(indexPath.section) & row \(indexPath.row)")
                    }
                    print("Current Cell size = width =  \(cell.frame.size.width)")
                    print("Current Cell size = height =\(cell.frame.size.height)")
                    // -------------collection view border end
                    // MARK: origin and destination color----start
                    
                    let lastIndex = (tripCustom.LegList.count - 1)
                    
                    // MARK: TripInfo Departure Result Only Leg
                    if (tripCustom.LegList.count == 1){
                        
                        cell.duration.text = "Dur:" + tripCustom.dur
                        
                        leg_x_spacing = onlyLeg_x_spacing
                        
                        print("Only result is being printed: Image is = DepartureBorderOnly_1.png")
                        print("cell.frame.size.width= Dep:Cell:Size = \(cell.frame.size) ")
                        
                        cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "DepartureBorderOnly_1.png")!)
                        
                        // change origin and destination colors
                        print("COUNT FOR COLLECTION VIEW IS ONLY ONE.........")
                        
                        //                cell.from_time.backgroundColor = originColor
                        //                cell.to_time.backgroundColor = destinationColor
                        cell.from_time.textColor = originTextColor
                        cell.to_time.textColor = detinationTextColor
                        
                    }
                        // MARK: TripInfo Departure Result Multiple Legs
                        
                    else {
                        // Mark: Departure Cells  first leg: recurring departure
                        
                        if (indexPath.row == 0){
                            
                            cell.duration.text = ">---->"
                            leg_x_spacing = firstLeg_x_spacing
                            
                            cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "DepartureBorderFirst.png")!)
                            
                            
                            //  cell.from_time.backgroundColor = originColor
                            cell.from_time.textColor = originTextColor
                            print("count wasnt equal to 1, caught in first row...setting origin color")
                            
                        }
                            // Mark: Departure Cells  Middle Legs
                            
                        else if ((tripCustom.LegList.count > 2) && (indexPath.row < lastIndex)){
                            
                            cell.duration.text = ">---->"
                            leg_x_spacing = middleLeg_x_spacing
                            
                            cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "Middle.png")!)
                            
                            
                        }
                            //Mark: Departure Cells Last Leg
                        else if (lastIndex == indexPath.row){
                            cell.duration.text = "Dur:" +  tripCustom.dur
                            
                            
                            leg_x_spacing = lastLeg_x_spacing
                            
                            cell.backgroundColor =  UIColor.init(patternImage: UIImage(named: "DepartureBorderLast.png")!)
                            
                            //                   cell.to_time.backgroundColor = destinationColor
                            
                            cell.to_time.textColor = detinationTextColor
                            print("Collection view last index caught, now setting destination color.")
                        }
                    }
                    
                    //--------------origin and destination color end
                    //   let tripCustom = custom_Trip_NextDepartures_Dict[0] as! Trip
                    //     let legList = newTrip[indexPath.section] as! Trip
                    print("generated current key via indexpth.section and row = \(keyNameTemp)")
                    print("dddddd = \(tripCustom.originDetail.time)")
                    print("dddddd = \(tripCustom.destinationDetail.time)")
                    //              cell.to_time.setTitle(tripCustom.destinationDetail.time, for: .normal)
                    
                    //let legList = newTrip[indexPath.section] as! Trip
                    //print("From Station id = \(legList.originDetail)")
                    let testCollectionMArray = NSMutableArray()
                    
                    // MARK: Collection View Departure icon count
                    
                    testCollectionMArray.add(tripCustom.LegList[indexPath.row])
                    
                    print("testCollectionMArray Count = \(testCollectionMArray.count)")
                    //MARK: Collection View Cell Background Image
                    
                    //                let View=UIView()
                    //                View.backgroundColor=UIColor(patternImage:UIImage(named:"LegBorderStart.png")!)
                    //
                    //                cell.backgroundView = View
                    //print("cell size = \()")
                    
                    
                    // MARK: Collection view label rounds
                    
                    cell.from_time.layer.masksToBounds = true
                    cell.from_time.layer.cornerRadius = 5
                    cell.to_time.layer.masksToBounds = true
                    cell.to_time.layer.cornerRadius = 5
                    
                    //                cell.layer.masksToBounds = true
                    //                cell.layer.borderWidth = 4.0 // cellBorderWidth
                    //                cell.layer.cornerRadius = 10.0
                    //
                    print("Trip Info: Section : \(indexPath.section) Row:\(indexPath.row)")
                    
                    print("cell.from_time.frame.origin.x = \(cell.from_time.frame.origin.x)")
                    print("cell.from_time.frame.origin.x = \(leg_x_spacing)")
                    
                    let x = leg_x_spacing //.from_time.frame.origin.x + leg_x_spacing
                    let y = CGFloat(50.0) //cell.from_time.frame.size.height + 7
                    
                    let startingPoint = CGPoint(x: x,y: y)
                    // let startingPoint = CGPoint(x: 35.0,y: -130.0)
                    let startingSize = CGSize(width:27.0,height:27.0)//default_startingSize  //CGSize(width:20.0,height:20.0)
                    let orientation = "x"  // x, y, or xy
                    let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
                    let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
                    let sizeFactor = CGSize(width: 0.0,height: 0.0)
                    // line color and line number ?
                    // cell.line_number.text = tripCustom.chg
                    
                    print("-------------Section = \(indexPath.section) & Row = \(indexPath.row)")
                    
                    print("tripCustom.leglist.count = \(tripCustom.LegList.count)")
                    print("test 1")
                    
                    print("-Section = \(indexPath.section)--R=\(indexPath.row)--------key name is ==== \(keyNameTemp)")
                    
                    print("String(leg.line) = \(leg.line)")
                    print("------------key name is ==== \(keyNameTemp)")
                    
                    //let some = Int(cell.from_time.frame.size.width)
                    
                    cell.to_time.frame.origin.x = cell.from_time.frame.size.width + startingSize.width + startingSize.width
                    
                    
                    //  SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                    // MARK: temp friday draw 2 COLLECTION VIEW
                    
                    // MARK: Departure Cell Icon Printing
                    
                    print("Departure Cell: Collection View Sizes : Icon :Starting Point:\(startingPoint)------Section & Row = \(indexPath.section)-- \(indexPath.row)")
                    print("Departure Cell: Collection View Sizes : Icon :Starting Size: \(startingSize)")
                    print("Departure Cell: Collection View Sizes : Icon :Size Factor: \(startingSize)")
                    print(" Cell.fromTime.Startpoint = \(cell.from_time.frame.origin)")
                    
                    if (cell.viewWithTag(30) == nil) {
                        print("button is null........ ")
                        
                        
                    } else {
                        
                        let iconButton = cell.viewWithTag(30) as! UIButton
                        iconButton.isHidden = true
                        
                        let iconUILabel_button = cell.viewWithTag(35) as! UIButton
                        
                        iconUILabel_button.isHidden = true
                        
                    }
                    
                    SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: testCollectionMArray, collectionViewCell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                    print("Collection View cell tag is = \( cell.viewWithTag(30))")
                    //MARK: Departure Cell Info Filling
                    
                    
                    let width = 8
                    
                    cell.from_station.text = leg.origin.name
                    
                    
                    cell.to_station.text = leg.destination.name
                    
                    
                    
                    //cell.line_number.text = String(leg.line)
                    print("test 2")
                    cell.from_time.text = leg.origin.time
                    cell.to_time.text = leg.destination.time
                    
                    //cell.from_time.setTitle(leg.origin.time, for: .normal)
                    print("test 3")
                    //cell.to_time.setTitle(leg.destination.time, for: .normal)
                    print("test 4")
                    //                cell.from_time.setTitle(tripCustom.originDetail.time, for: .normal)
                }
                else {
                    
                    print("nothing.....in collection num itms")
                }
                
                
                print("-----end--------Section = \(indexPath.section) & Row = \(indexPath.row)")
                
                
            }
            
            
            //        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //
            //
            //
            //            // Use collectionViewFlowLayout
            //
            //        }
            
            collectionView.setNeedsLayout()
            
            //        collectionView.set
            
            print("---collectionView.collectionViewLayout.collectionViewContentSize.width\(collectionView.collectionViewLayout.collectionViewContentSize.width)")
            
            //  cell.legLineNo.setTitle("11", for: .normal)
            // cell.legImage.backgroundColor = UIColor.yellow
            // cell.contentView.frame.size.width = 10.0
            
            print("collectionView.frame.width = \(collectionView.frame.width)")
            
            
            print("collectionView.frame.width = \(collectionView.frame.width)")
            
            
            print("collectionView.intrinsicContentSize = \(collectionView.intrinsicContentSize)")
            
            
            print("collectionView.contentSize.width = \(collectionView.contentSize.width)")
            
            
            print("collectionView.contentSize.width = \(collectionView.contentSize.width)")
            
            
            print("in collection view number of items in section---cell--\(indexPath.row)--")
            
            
            
            return cell
            
        }
        
        
        /*
         func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
         
         cell.contentView.backgroundColor = UIColor.blue
         
         //   let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 120))
         
         
         //CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
         //        CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
         
         let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x:0,y:10), size: CGSize(width: self.view.frame.width,height: 120)))
         
         
         whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
         whiteRoundedView.layer.masksToBounds = false
         whiteRoundedView.layer.cornerRadius = 2.0
         
         // whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
         whiteRoundedView.layer.shadowOffset = CGSize(width:-1,height: 1)
         whiteRoundedView.layer.shadowOpacity = 0.2
         print("size of white rounder is = \(whiteRoundedView.frame.width) : \(whiteRoundedView.frame.height)")
         cell.contentView.addSubview(whiteRoundedView)
         cell.contentView.sendSubview(toBack: whiteRoundedView)
         }
         */
        
        
        @available(iOS 6.0, *)
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 5
            
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //        let tripCell = newTrip[section] as! Trip
            //
            //        print("Trip Cell (Number of items in section--\(tripCell.LegList.count)")
            //        return tripCell.LegList.count
            //
            
            var number = 0
            print("section number for collection view = \(section)")
            if (custom_Trip_NextDepartures_Dict.count > 0){
                let currentSection = String(section)
                //let currentRow = String(indexPath.row)
                let view = collectionView.superview!
                let currentCell = view.superview as! LegTripNextDeparturesTableViewCell
                //MARK: Collection View old till 9th nov 8pm
                // let currentCell = view.superview as! LegListCells
                
                let keyNameTemp = currentCell.keyName
                print("cell.tag current = \(currentCell.tag)")
                print("keyname temp from current cell = \(keyNameTemp)")
                // let keyName = currentSection + currentRow
                print("key name temp = \(keyNameTemp)")
                print("num sections customtrip next departures total count = \(custom_Trip_NextDepartures_Dict.count)")
                print("num sections -customtrip next departures total count = \(custom_Trip_NextDepartures_Dict.allKeys)")
                //           if let collection_Values_flag = RealTidMethods.checkIfKeyExists(objectToCheck: custom_Trip_NextDepartures_Dict, keyName: keyNameTemp)
                
                //  if (collection_Values_flag == true){
                if let customDepTrip = custom_Trip_NextDepartures_Dict[keyNameTemp]
                {
                    let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                    print("-----test 10989")
                    let tripInfoDepartureCount = customDepTripArray[section] as! Trip
                    //--------------- start
                    //if (collection_Values_flag == true){
                    //let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                    
                    print("customDepTripArray Count = \(customDepTripArray.count)")
                    
                    print("-----test 10989")
                    let tripCustom = customDepTripArray[section] as! Trip
                    print("tripCustom.LegList.count==number of items =\(tripCustom.LegList.count)")
                    var i = 0
                    print("Returning collection view item count = tripCustom.LegList.count ")
                    return tripCustom.LegList.count
                    
                    // MARK: Collection View item count latest
                    var itemCountComplete = 0
                    
                    for index in tripCustom.LegList {
                        
                        let leg = tripCustom.LegList[i] as! Leg
                        
                        print("----i = \(i)----------------------start-------------------")
                        print("leg.origin.name = \(leg.origin.name)")
                        print("leg.Destination.name = \(leg.destination.name)")
                        print("leg.dir = \(leg.dir)")
                        print("--------------------------end-------------------")
                        i += 1
                        
                    }
                    
                    //--------------- end
                    print("customDepTripArray Count= items in number of sections...... = \(tripCustom.LegList.count)")
                    number = customDepTripArray.count
                    // return customDepTripArray.count
                }
                
            }
            
            print("custom_Trip_NextDepartures_Dict = count = \(custom_Trip_NextDepartures_Dict.count)")
            print("Section for collection view count = \(section) ")
            print("Count for collection view count = \(number) ")
            return number
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // get current trip object
            print("current section in cell for row at\(indexPath.section) && \(indexPath.row)")
            
            let tripCurrentObj = newTrip[indexPath.section] as! Trip
            
            print("tripcurrentObject show hide value is = \(tripCurrentObj.showHideCell)")
            // current leglist object
            let legListTemp = tripCurrentObj.LegList as! NSMutableArray
            // get object at current row
            let legObjToCheck = legListTemp[indexPath.row] as! AnyObject
            // 1.0) check for the type of object
            if (RealTidMethods.checkIfDepartureObject(objectToCheck: legObjToCheck))
            {
                // if object is departure then return depart object
                // copy paste departure code......
                print("cell departure must be printed now.......1..")
                //    departureCounter += 1
                let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
                cellDeparture.keyName = String(indexPath.section) + String(indexPath.row)
                
                cellDeparture.tag = indexPath.row
                //MARK: CollectionView temp off
                
                cellDeparture.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                
                //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
                
                print("cell departure must be printed now......2...")
                
                showDeparture = false
                print("cell Departure Size = \(cellDeparture.frame.size.width) && height = \(cellDeparture.frame.size.height)")
                
                return cellDeparture
            }
            
            // if object is normal then return normal object
            // show normal cells......BECAUSE Show Departure should be false
            print("SHOW DEPARTURE IS FALSE = \(showDeparture)")
            
            print("in printing normal cells ,current indexpath.row = \(indexPath.row) && departureCounter = \(departureCounter)")
            
            let currentIndex = indexPath.row - departureCounter
            print("IndexPath.Row = \(indexPath.row)")
            print("Calculated Current Index = \(currentIndex)")
            
            // copy paste code for normal cell......
            
            // ----------------------------------NORMAL CELL......................-----------START------
            let legList = newTrip[indexPath.section] as! Trip
            
            
            let test = NSMutableArray()
            var count = legList.LegList.count
            print("indexPath.row = \(indexPath.row) && Total count is = \(count)")
            //
            //        if (indexPath.row <= count){
            //
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
            
            
            print("cellCurrent value is hidden or not =Before=\(cell.isHidden)" )
            print("tripCurrentObj.showHideCell  value is hidden or not =Before=\(tripCurrentObj.showHideCell )" )
            
            if (tripCurrentObj.showHideCell == false){
                cell.isHidden = false
                
            } else if (tripCurrentObj.showHideCell == true){
                
                cell.isHidden = true
                
            }
            
            print("cellCurrent value is hidden or not =After = \(cell.isHidden)" )
            //        tableView.headerView(forSection: <#T##Int#>)
            if (cell.showHideDepartureCell == true)
            {
                
                cell.nextDeparturesOutlet.isSelected = true
                
            } else {
                
                
                cell.nextDeparturesOutlet.isSelected = false
                
                
                
            }
            //MARK: Trip info Hidden views
            
            cell.backgroundColor = UIColor.white
            print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
            print("CELL INTERACTION STATUS = \(indexPath.section) && row = \(indexPath.row) = interaction = \(cell.isUserInteractionEnabled)")
            //MARK:BorderTripInfo
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = cellBorderWidth
            
            //headerCell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderColor = UIColor.lightGray.cgColor
            tableView.backgroundColor = UIColor.lightGray
            
            
            //        let border = CALayer()
            //        let width = CGFloat(15.0)
            //        border.borderColor = UIColor.darkGray.cgColor
            //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
            //
            //        border.borderWidth = width
            //        tableView.layer.addSublayer(border)
            //        tableView.layer.masksToBounds = true
            
            
            /*
             cell.layer.borderWidth = 10.0
             cell.layer.borderColor = UIColor.green.cgColor
             
             */
            
            cell.tag = indexPath.row
            cell.nextDeparturesOutlet.tag = indexPath.row
            
            cell.sectionInfo = String(indexPath.section)
            cell.rowInfo = String(indexPath.row)
            
            cell.keyName = cell.sectionInfo + cell.rowInfo
            
            print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
            cell.name.isHidden = true
            //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
            cell.towards_or_walk.isHidden = true
            
            // MARK# Collection View
            // MARK: cell
            
            //MARK: CollectionView temp off
            
            //   cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
            
            // 3
            // Configure the cell...
            // MARK: Move to collection 1
            
            print("From Station id = \(legList.originDetail)")
            // MARK: Trip info icon Printing
            
            test.add(legList.LegList[indexPath.row])
            
            
            let startingPoint = CGPoint(x: cell.to_time.frame.origin.x,y: cell.to_time.frame.size.height + 20)
            
            //        let startingPoint = CGPoint(x: 35.0,y: 30.0)
            //
            
            //let startingPoint = CGPoint(x: 35.0,y: 30.0)
            // let startingPoint = CGPoint(x: 35.0,y: -130.0)
            let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
            let orientation = "x"  // x, y, or xy
            let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
            let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
            let sizeFactor = CGSize(width: 0.0,height: 0.0)
            // MARK: Move to collection 1 ---end
            // ------------setting Leg Images---------START
            print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
            count = count - 1
            print("--Row = \(indexPath.row)----count = \(count)")
            let leg = legList.LegList[indexPath.row] as! Leg
            
            cell.legImage.image = UIImage(named: leg.legImageName)
            // MARK: Leg
            print("cell for row  at index ===\(indexPath)-------------------------")
            print("leg image name ==\(leg.legImageName)")
            print("leg.line ==\(leg.line)")
            print("leg.dir ==\(leg.dir)")
            print("leg.journeyType ==\(leg.journeyType)")
            print("leg.name ==\(leg.name)")
            print("leg.origin ==\(leg.origin)")
            // legList.originDetail.name
            //----#1-----#2------------------------ Origin Station....Leg
            cell.from_station.text = leg.origin.name
            print("cell.from_station.text::::\(cell.from_station.text)")
            // temp cell.from_time.text = legList.originDetail.time
            cell.from_time.text = leg.origin.time
            // MARK: RTU Message Cell Level
            if (leg.rtu_Message_Flag == true){
                print("cell:: RTU Message ::::")
                print(leg.rtu_Message)
                cell.rtuMessage.isHidden = false
                cell.rtuMessage.text = leg.rtu_Message
                cell.rtuMessage.textColor = UIColor.red
            } else {
                cell.rtuMessage.isHidden = true
            }
            // cell.transportTypeOutlet.text = leg.origin.type
            //        if (leg.dir != "Default"){
            //        cell.towards_or_walk.text = leg.dir
            //        }
            cell.towards_or_walk.text = ""
            print("cell.towards_or_walk.text  :\(leg.dir)")
            
            // set root map reference
            // set root map geometry reference
            
            print("------090--------- cell.from_time.text--989=")
            print(cell.to_time.text)
            
            print("printing indexpath.row = in cell Level \(indexPath.row)")
            print("current Geom Ref is = \(leg.geomRef)")
            
            print("current Geom Ref is journeyDetailRef...........= \(leg.journeyDetailRef)")
            
            //-----#3------Visual Leg
            
            print(test.count)
            // MARK: Move to collection 2
            // MARK: temp friday draw 3 cell view
            let tagValuesReceived = SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: indexPath.row,indexValueFromCurrentLeg: 0,iconTagIntValue: 0 ,lineNoIntValue: 0)
            
            print("startingPoint_101001----\(startingPoint)")
            //----#4------
            cell.name.text = ""//leg.name
            
            //----#4.5------
            //----#5------line/dist
            cell.transportTypeOutlet.text = leg.journeyType
            cell.transportTypeOutlet.isHidden = true
            
            
            print("--212----journey type is =\(leg.journeyType)")
            print("--dist---- =\(leg.dist)")
            print("--Line--- =\(leg.line)")
            
            print("-leg.dir--- =\(leg.dir)")
            var line_dist = String()
            var helpingWord = String()
            print("leg.journey Type..... = \(leg.journeyType)")
            if (leg.journeyType == "WALK"){
                
                print("switching off walk cell to be touched..........")
                cell.isUserInteractionEnabled = false
                
                //        cell.multipleTouchEnabled = false
                
                
            }
            else {
                cell.isUserInteractionEnabled = true
            }
            if (leg.journeyType == "WALK"){
                line_dist = leg.name + " "+leg.dist + " Meters"
                // helpingWord = "Meters"
            }
            else if (leg.journeyType != "WALK")
            {
                line_dist =  "Towards:\n" + leg.dir //leg.name + " Towards " + leg.dir
                //            helpingWord = "Towards"
                
            }
            else {
                line_dist = "--??---"
                helpingWord = "?????"
                
            }
            cell.line_dist.text = line_dist
            print("line_dist ::__:::\(line_dist)")
            //    cell.towards_or_walk.text = helpingWord
            
            //        cell.legImage.image = UIImage(named: "firstLeg.png")
            //        print("----image value is--\(cell.legImage)")
            //        cell.legImage.image = UIImage(named: "lastLeg.png")
            
            
            
            
            
            //-----#6-----#7------------------------ Destination Station....Leg
            cell.to_station.text = leg.destination.name
            cell.to_time.text = leg.destination.time
            // cell.transportTypeOutlet.text = leg.destination.type
            
            print("------090---------cell.to_time.text--989=")
            print(cell.to_time.text)
            
            
            print("------090---------cell.to_time.text--989=")
            print(cell.to_time.text)
            
            
            return cell
            
            //-----------------------------------------------------------------------------------------------------------Start
            // temp switch off
            // 9th nov friday 10 am--------------------start
            /*
             //-----------------------------------SECTION HANDLING--------------------------------------------start--------
             print("Start in cell for row at = \(indexPath)")
             // section handling
             var currentSection = 0
             
             if (currentSection == indexPath.section){
             
             print("Current Section is equal to indexpath.seection = \(currentSection) && \(indexPath.section)")
             
             }
             else if (currentSection != indexPath.section){
             
             // if session is new then counter reset
             // reset it for every new section.....
             print("New Section is being printed....Resetting all values....................")
             
             currentSection = indexPath.section
             departureCounter = 0
             showDeparture = false
             }
             // show departure reset
             
             //-----------------------------------SECTION HANDLING--------------------------------------------start--------
             
             ////MARK: Master Trip Dic--------------------Get Value Master Dict (For Current Section)-------------------start--------
             
             // get the value from master dict
             // Get value for current section
             // you will receive a dict of all values for rows within section
             
             let currentTripInfoDepartCellStatus = nextDepartureMasterDict.value(forKey: String(indexPath.section)) as! NSMutableDictionary
             
             // it should have values for all trip info cells
             // count of keys shuold be equal to trip info cells within current section
             print("currentTripInfoDepartureCell Status = allKeys =\(currentTripInfoDepartCellStatus.allKeys)")
             
             // get value for current Row
             print("indexPath Row = \(indexPath.row)")
             print("indexPath Section = \(indexPath.startIndex)")
             let valueDepartureCurrentRow = currentTripInfoDepartCellStatus.value(forKey: String(indexPath.row)) as! Int
             print("value departure current row = == \(valueDepartureCurrentRow)")
             
             // if value is 0 then show departure set true
             if (valueDepartureCurrentRow == 1){
             showDeparture = true
             departureCounter += 1
             
             print("Current Value Departure Counter === \(departureCounter)")
             print("Current Value of Departure Status == \(showDeparture)")
             }
             
             //-----------------------------------Get Value Master Dict (For Current Section)-------------------end--------
             
             //-----------------------------------show normal cell / show departure cel if true-----------start--------
             print("Show Departure Last Value ===== \(showDeparture)")
             if (showDeparture == true){
             
             // copy paste departure code......
             
             print("cell departure must be printed now.......1..")
             //    departureCounter += 1
             
             let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
             
             print("cell departure must be printed now......2...")
             
             showDeparture = false
             
             return cellDeparture
             
             
             }
             
             //if (showDeparture == false) {
             
             
             
             
             
             // show normal cells......BECAUSE Show Departure should be false
             print("SHOW DEPARTURE IS FALSE = \(showDeparture)")
             
             print("in printing normal cells ,current indexpath.row = \(indexPath.row) && departureCounter = \(departureCounter)")
             
             let currentIndex = indexPath.row - departureCounter
             print("IndexPath.Row = \(indexPath.row)")
             print("Calculated Current Index = \(currentIndex)")
             
             // copy paste code for normal cell......
             
             // ----------------------------------NORMAL CELL......................-----------START------
             let legList = newTrip[indexPath.section] as! Trip
             let test = NSMutableArray()
             var count = legList.LegList.count
             
             print("indexPath.row = \(indexPath.row) && Total count is = \(count)")
             //
             //        if (indexPath.row <= count){
             //
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
             cell.backgroundColor = UIColor.white
             print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
             
             //MARK:BorderTripInfo
             cell.layer.masksToBounds = true
             cell.layer.borderWidth = cellBorderWidth
             
             //headerCell.layer.borderColor = UIColor.gray.cgColor
             cell.layer.borderColor = UIColor.lightGray.cgColor
             tableView.backgroundColor = UIColor.lightGray
             //
             //
             //        let border = CALayer()
             //        let width = CGFloat(15.0)
             //        border.borderColor = UIColor.darkGray.cgColor
             //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
             //
             //        border.borderWidth = width
             //        tableView.layer.addSublayer(border)
             //        tableView.layer.masksToBounds = true
             
             
             /*
             cell.layer.borderWidth = 10.0
             cell.layer.borderColor = UIColor.green.cgColor
             
             */
             
             cell.tag = indexPath.row
             cell.nextDeparturesOutlet.tag = indexPath.row
             
             cell.sectionInfo = String(indexPath.section)
             cell.rowInfo = String(indexPath.row)
             
             cell.keyName = cell.sectionInfo + cell.rowInfo
             
             print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
             cell.name.isHidden = true
             //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
             cell.towards_or_walk.isHidden = true
             
             // MARK# Collection View
             // MARK: cell
             
             //MARK: CollectionView temp off
             
             //   cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
             
             //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
             
             // 3
             // Configure the cell...
             // MARK: Move to collection 1
             
             print("From Station id = \(legList.originDetail)")
             
             test.add(legList.LegList[indexPath.row])
             let startingPoint = CGPoint(x: 35.0,y: 30.0)
             // let startingPoint = CGPoint(x: 35.0,y: -130.0)
             let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
             let orientation = "x"  // x, y, or xy
             let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
             let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
             let sizeFactor = CGSize(width: 0.0,height: 0.0)
             // MARK: Move to collection 1 ---end
             // ------------setting Leg Images---------START
             print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
             count = count - 1
             print("--Row = \(indexPath.row)----count = \(count)")
             let leg = legList.LegList[indexPath.row] as! Leg
             
             cell.legImage.image = UIImage(named: leg.legImageName)
             // MARK: Leg
             print("cell for row  at index ===\(indexPath)-------------------------")
             print("leg image name ==\(leg.legImageName)")
             print("leg.line ==\(leg.line)")
             print("leg.dir ==\(leg.dir)")
             print("leg.journeyType ==\(leg.journeyType)")
             print("leg.name ==\(leg.name)")
             print("leg.origin ==\(leg.origin)")
             // legList.originDetail.name
             //----#1-----#2------------------------ Origin Station....Leg
             cell.from_station.text = leg.origin.name
             print("cell.from_station.text::::\(cell.from_station.text)")
             // temp cell.from_time.text = legList.originDetail.time
             cell.from_time.text = leg.origin.time
             // MARK: RTU Message Cell Level
             if (leg.rtu_Message_Flag == true){
             print("cell:: RTU Message ::::")
             print(leg.rtu_Message)
             cell.rtuMessage.isHidden = false
             cell.rtuMessage.text = leg.rtu_Message
             cell.rtuMessage.textColor = UIColor.red
             } else {
             cell.rtuMessage.isHidden = true
             }
             // cell.transportTypeOutlet.text = leg.origin.type
             //        if (leg.dir != "Default"){
             //        cell.towards_or_walk.text = leg.dir
             //        }
             cell.towards_or_walk.text = ""
             print("cell.towards_or_walk.text  :\(leg.dir)")
             
             // set root map reference
             // set root map geometry reference
             
             print("------090--------- cell.from_time.text--989=")
             print(cell.to_time.text)
             
             print("printing indexpath.row = in cell Level \(indexPath.row)")
             print("current Geom Ref is = \(leg.geomRef)")
             
             print("current Geom Ref is journeyDetailRef...........= \(leg.journeyDetailRef)")
             
             //-----#3------Visual Leg
             
             print(test.count)
             // MARK: Move to collection 2
             
             SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
             print("startingPoint_101001----\(startingPoint)")
             //----#4------
             cell.name.text = ""//leg.name
             
             //----#4.5------
             //----#5------line/dist
             cell.transportTypeOutlet.text = leg.journeyType
             cell.transportTypeOutlet.isHidden = true
             
             
             print("--212----journey type is =\(leg.journeyType)")
             print("--dist---- =\(leg.dist)")
             print("--Line--- =\(leg.line)")
             
             print("-leg.dir--- =\(leg.dir)")
             var line_dist = String()
             var helpingWord = String()
             print("leg.journey Type..... = \(leg.journeyType)")
             if (leg.journeyType == "WALK"){
             
             print("switching off walk cell to be touched..........")
             cell.isUserInteractionEnabled = false
             
             //        cell.multipleTouchEnabled = false
             
             
             }
             
             if (leg.journeyType == "WALK"){
             line_dist = leg.name + " "+leg.dist + " Meters"
             // helpingWord = "Meters"
             }
             else if (leg.journeyType != "WALK")
             {
             line_dist =   leg.name + " Towards " + leg.dir
             //            helpingWord = "Towards"
             
             }
             else {
             line_dist = "--??---"
             helpingWord = "?????"
             
             }
             cell.line_dist.text = line_dist
             print("line_dist ::__:::\(line_dist)")
             //    cell.towards_or_walk.text = helpingWord
             
             //        cell.legImage.image = UIImage(named: "firstLeg.png")
             //        print("----image value is--\(cell.legImage)")
             //        cell.legImage.image = UIImage(named: "lastLeg.png")
             
             
             
             
             
             //-----#6-----#7------------------------ Destination Station....Leg
             cell.to_station.text = leg.destination.name
             cell.to_time.text = leg.destination.time
             // cell.transportTypeOutlet.text = leg.destination.type
             
             print("------090---------cell.to_time.text--989=")
             print(cell.to_time.text)
             
             
             print("------090---------cell.to_time.text--989=")
             print(cell.to_time.text)
             
             
             return cell
             
             // ----------------------------------NORMAL CELL......................-----------END------
             // MASTer dict switching off on 9th nov for departure object insertion and deletion mecahnism
             // 9th nov friday 10 Am
             */
            
            
            
            //   }
            
            // if show departure == true
            
            // departure cell print
            
            // else if show departure is false
            // print normal cells
            
            //            }
            //        else {
            //
            //
            //
            //        }
        }
        //
        //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        <#code#>
        //    }
        
        //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        //
        //
        //        return 100
        //    }
        
        
        // MARK: Height of row
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let titleHeader = "SLife:" + String(section)
            return titleHeader
        }
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            //        let headerCellTemp = tableView.viewWithTag(section) as!TripSuggestionsCell_new
            //
            //        print("HeaderCellTemp tag value is = \(headerCellTemp.tag)")
            //
            //print("TableView Subview Counts = \(tableView.subviews.count)")
            
            //let headerCellTemp = tableView.subviews[section]. as! TripSuggestionsCell_new
            
            //              print("HeaderCellTemp tag value is = \(headerCellTemp.tag)")
            
            let tripCell = newTrip[section] as! Trip
            print("heightForHeaderInSection...........\(section).")
            print(legIconsLineCounter)
            print(tripCell.LegList.count)
            var lineCount = (tripCell.LegList.count*2) / legIconsLineTerminateCount
            
            let remainder = (tripCell.LegList.count*2) % legIconsLineTerminateCount
            //        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            //
            
            print("Line count is  = \(lineCount)")
            print("remainder is (header) \(remainder) ")
            if (remainder != 0){
                lineCount+=1
                print("total line count is =inside heighForHeader==for section \(section)==is=\(lineCount)")
                
            }
            
            let icon_Count_Total = tripCell.LegList.count
            let screenWidth = UIScreen.main.bounds.width
            
            print("heightForHeaderInSection-----section  = \(section)")
            let total_icon_lines = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(60.0 + 10.0))
            // print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
            
            
            //MARK: Header Height Section
            print("header height : : SECTION = \(section) total icon lines = \(total_icon_lines)")
            let headerCellTotalHeight = (Int(legIconsHeight) * total_icon_lines.lineCount) + headerCellHeight
            print("headerCellTotalHeight = \(headerCellTotalHeight)")
            print("legIconsHeight = \(legIconsHeight)")
            print("lineCount = \(lineCount)")
            print("CGFloat::\(headerCellTotalHeight)")
            
            //heightFixed = true
            // var icon_Count_Total = tripCell.LegList.count
            // var lineTest = SlifeMethods.lineCountsToDisplayIcons(availableWidth: UIScreen.main.bounds.width, iconsCount: icon_Count_Total, iconWidth: CGFloat(20.0))
            // print("line Test is = \(lineTest)")
            //        var icon_counts = SlifeMethods.iconCountsToDisplayIcons(availableWidth: UIScreen.main.bounds.width, iconsCount: icon_Count_Total, iconWidth: CGFloat(20.0))
            //  print("icon counts total = \(icon_counts)")
            
            
            print("headerHeightDict==== \(headerHeightDict.allKeys)")
            // -----------header height cell testing
            //        let defaultBottomSpaceLeave = 15.0
            //        let defaultTopSpaceLeave = 15.0
            //        let defaultStackViewBottomSpaceBeforeIconLeave = 10
            
            
            let headerHeightCalculation = headerCell_StackView_Height + (total_icon_lines.lineCount * Int(default_startingSize.height))
            
            // -----------header height cell testing end
            
            print(".---------------------------------------------------Height Calculation HeaderCEll---.")
            print("total ICon Lines = \(total_icon_lines)")
            print("DefaultBottomSpace Leave = \(defaultBottomSpaceLeave)")
            print("(total_icon_lines * defaultBottomSpaceLeave) = \(defaultBottomSpaceLeave)")
            print("HeaderCell_StackViewHeight = \(headerCell_StackView_Height)")
            
            print("Returning with HeaderCell Trip Suggestion Height = \(headerHeightCalculation)")
            print(".-----------------------------------------------------.")
            return CGFloat(headerHeightCalculation)
            
            // temp check on above headerheightcalculation return CGFloat(headerCellTotalHeight)
            
        }
        
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCells") as! TripSuggestionsCell_new
            
            let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
            //let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
            if (trip_detail_flag.contains("true")){
                
                print("trip detail flag = True?= \(trip_detail_flag)")
                
                headerCell.sectionSelected.isSelected = true
            } else {
                
                print("trip detail flag = False?= \(trip_detail_flag)")
                
                headerCell.sectionSelected.isSelected = false
                
                
            }
            
            
            headerCell.showTripRouteOnMapOutlet.isHidden = true
            headerCell.tag = section
            print("header cell tag = \(headerCell.tag)")
            headerCell.sectionSelected.tag = 100 + section
            print("header cell section selected tag = \(headerCell.sectionSelected.tag)")
            let stackView = headerCell.viewWithTag(10)
            print("stackView?.frame.height StackView Height = \(stackView?.frame.height)")
            //MARK: Header Cell Selected Check
            
            //    check for count of dict
            //        check for null value if value not found then ?
            //        if null then set value as false ?
            //        or just if null  or false returned then set white
            
            
            let headerSelectionFlagNull = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
            print("header selection flag null = \(headerSelectionFlagNull)")
            if (headerSelectionFlagNull.contains("null") || headerSelectionFlagNull.contains("false")){
                headerCell.backgroundColor = headerRowDefaultColor
                print("null or false is here .... \(headerSelectionFlagNull)")
            }
            else if (headerSelectionFlagNull.contains("true")){
                headerCell.backgroundColor = headerRowSelectedColor
                print("True is here .... \(headerSelectionFlagNull)")
            }
            //MARK: TripSuggestionBorder
            //MARK: Corner Radius
            /*
             headerCell.layer.cornerRadius = 6 //set corner radius here
             headerCell.layer.borderColor = UIColor.lightGray.cgColor  // set cell border color here
             headerCell.layer.borderWidth = 2 // set border width here
             */
            //MARK: HeaderRowColor
            //   headerCell.backgroundColor = headerRowSelectedColor
            //___________________________
            headerCell.layer.masksToBounds = true
            headerCell.layer.borderWidth = headerBorderWidth
            //        headerCell.layer.borderColor = UIColor.gray.cgColor
            headerCell.layer.borderColor = UIColor.lightGray.cgColor
            
            
            //        let border = CALayer()
            //        let width = CGFloat(2.0)
            //        border.borderColor = UIColor.darkGray.cgColor
            //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
            
            
            print(tableView.rowHeight)
            headerCell.sectionSelected.tag = section
            // MARK: ShowTripDetail_Dict
            
            //        print("before setting dict values..................")
            //        showTripDetail_Dict.setValue(false, forKey: String(section))
            
            print("tableView.frame.size.height ........")
            print(tableView.frame.size.height)
            print("headerCell.frame.size.height ........")
            print(headerCell.frame.size.height)
            print("--heADER CELL BUTTON ID-")
            print(headerCell.sectionSelected)
            //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
            // headerCell.backgroundColor = UIColor.blue
            print("cell-header cell---\(headerCell)")
            
            let head = newTrip[section] as! Trip
            
            print("-In Sections--[Sections]=\(section)--)")
            print(".....head.count is \(head.dur)")
            
            //print(".....head.count is \()")
            print("-----section # \(section)")
            
            //      label.text = data[indexPath.row]
            
            // function getLabel(cell: dequeReusable as ! tripSugg,current index: int, legListPictorialSummary: some array)
            
            //        drawLeg()
            // try to run a for loop as all info is inside tripcell.
            
            let xy = CGPoint(x: 10.0,y: 0.0)
            let size = CGSize(width:10,height:10)
            
            let spacingFloat = CGPoint(x: size.width,y: size.height )
            
            
            //  let tripCell = trips[indexPath.row]
            //let tripCell = newTrip[indexPath.row]
            
            let tripCell = newTrip[section] as! Trip
            
            //drawLeg(xy, size: size, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, indexPath: <#T##NSIndexPath#>, orientation: <#T##Character#>, spacingFactor: <#T##Float#>)
            //  let startingPoint = CGPoint(x: 5.0,y: 2.0)
            
            let legIcons_y = headerCell.viewWithTag(10)?.frame.size.height
            
            // old starting vlaue of y is = 100
            
            print("y positions is ==== \(legIcons_y)")
            var startingPoint = CGPoint(x: 5.0,y: (legIcons_y! + 20.0))
            let startingSize = default_startingSize // CGSize(width:30.0,height:30.0)
            let orientation = "x"  // x, y, or xy
            let innerSpacing = CGPoint(x:-1,y:0)
            let innerLegSpacing = CGPoint(x:10,y:0)
            let sizeFactor = CGSize(width: 0.0,height: 0.0)
            // MARK: Draw Leg Icons
            print("tripCell.LegList.Count ==== \(tripCell.LegList.count)")
            print("headerCell.contentView.Frame:::::\(headerCell.contentView.frame)")
            var iconLegLine = 0
            legIconsLineCounter = 0
            var y = 0
            var line = 1
            var column = 1
            var icon_Count_Total = tripCell.LegList.count
            var screenWidth = UIScreen.main.bounds.width
            // MARK: Leg Image width required
            let iconLimits = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(70.0))
            print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
            // MARK: Line Termination
            
            var iconLiveCount = 1
            var iconLineLiveCount = 0
            var increment = 0
            // move this to above
            let legIconTopSpace = 10.0
            var defaultPositionToStart =  CGPoint(x: 5.0,y: (legIcons_y! + 10.0))
            let iconVerticalSpaceFactor = 2.0
            
            let iconHorizontalSpaceFactor = 2.0
            
            for index in tripCell.LegList {
                print("tripcell:LegList Value is here ::::\(tripCell.LegList)")
                let someObject = tripCell.LegList[increment] as! AnyObject
                print("someObject............ \(someObject)")
                if (RealTidMethods.checkIfDepartureObject(objectToCheck: someObject)){
                    
                    print("Departure Cell has been found = at increment value = \(increment)")
                    
                }
                else {
                    print("Top:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                    
                    // change to next line if icon printing limit has reached
                    if (iconLiveCount == iconLimits.iconCount){
                        print("if:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                        
                        iconLiveCount = 1
                        iconLineLiveCount += 1
                        startingPoint.x = defaultPositionToStart.x
                        startingPoint.y += startingSize.height //+ iconVerticalSpaceFactor
                        
                    }
                        
                    else if (increment != 0) {
                        print("Else:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                        
                        startingPoint.x += startingSize.width +  startingSize.width //+ iconHorizontalSpaceFactor
                        iconLiveCount += 1
                    }
                    // keep printing icons
                    let ns = NSMutableArray()
                    var t = 0
                    for index in tripCell.LegList {
                        print(" current index counter t = \(t)")
                        
                        let obj2check = tripCell.LegList[t] as! AnyObject
                        print("obj2check = \(obj2check)")
                        if (RealTidMethods.checkIfDepartureObject(objectToCheck: obj2check)){
                            
                            print("Obj2Check = Departure Cell found")
                            
                        } else {
                            
                            print("LegIcon  found .......")
                        }
                        
                        t += 1
                    }
                    
                    //                let t = tripCell.LegList[0] as! Leg
                    
                    
                    
                    print("tripCell.LegList.count = \(tripCell.LegList.count)")
                    ns.add(tripCell.LegList[increment])
                    print("leglist to print = \(ns.count)")
                    
                    // MARK: temp friday draw 1
                    print("increment.........value is = \(increment)")
                    print("Count of leglists === \(tripCell.LegList.count)")
                    //MARK: Temp friday 9th of drawLegs
                    //MARK: Header Cell Leg Icon Printing
                    // creating tag
                    // get section
                    // get leg current indexPath
                    // join them together
                    // merge 0 or 1 accordingly
                    let tagSeriesStart = "6"
                    let sectionIndexString = String(section)
                    let legIndexString = String(increment)
                    let sectionLegIndexUnion = tagSeriesStart + sectionIndexString + legIndexString
                    
                    let iconTagString = sectionLegIndexUnion + "0"
                    let lineNoTagString = sectionLegIndexUnion + "1"
                    let iconTagInt = Int(iconTagString)
                    let lineNoInt = Int(lineNoTagString)
                    
                    print("Creating Tag for icon Legs:::::----------")
                    print("Current Section:\(section)")
                    print("Current Leg-Index:\(increment) & TotalLegs=\(tripCell.LegList.count)")
                    
                    print("---------Do we have same tag values Test 1----packagin---")
                    print("----------String---------------")
                    print("iConTagString: \(iconTagString)")
                    print("lineNoTagString: \(lineNoTagString)")
                    print("----------Int---------------")
                    print("iconTagInt: \(iconTagString)")
                    print("lineNoTagString: \(lineNoTagString)")
                    
                    print("---------Do we have same tag values Test 1---Values Sent----")
                    
                    let tagValueReceives = SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: default_startingSize, legs: ns , cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: section,indexValueFromCurrentLeg: increment, iconTagIntValue: iconTagInt!, lineNoIntValue: lineNoInt!)
                    // Extract buttons which have been added
                    
                    print("---------Do we have same tag values Test 1-----Values Received--")
                    print("Current Section:\(section)")
                    print(" tagValueReceives.iconTagIntReturned = \(tagValueReceives.iconTagIntReturned)")
                    print(" tagValueReceives.lineNoIntReturned = \(tagValueReceives.lineNoIntReturned)")
                    
                    
                    //                let iconButton = headerCell.contentView.v
                    
                    //                print("iconButton:::::: \(iconButton)")
                    
                    
                    
                    
                    let iconNumberButton = headerCell.contentView.viewWithTag(tagValueReceives.iconTagIntReturned) as! UIButton
                    
                    print("iconButton Accessibility identifier: \(iconNumberButton.accessibilityIdentifier)")
                    
                    
                    let lineNumberButton = headerCell.contentView.viewWithTag(tagValueReceives.iconTagIntReturned) as! UIButton
                    
                    
                    if (tripCell.showHideCell == true){
                        
                        iconNumberButton.backgroundColor = UIColor.green
                    }
                    else {
                        
                        iconNumberButton.backgroundColor = UIColor.red
                        
                        
                    }
                    print("lineNumberButton Accessibility identifier: \(lineNumberButton.accessibilityIdentifier)")
                    
                    
                    print("legicon:::::::")
                    
                    lineNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.Clicked), for: UIControlEvents.touchUpInside)
                    
                    
                    iconNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.Clicked), for: UIControlEvents.touchUpInside)
                    
                }
                increment += 1
                //  }
                
                
                // temp skip departure cell end here------------------------
            }
            
            
            
            
            
            // create header cell height dict bank
            
            // add section as key
            
            // calculate height by
            
            var heightHeaderCalculation = 20 + Int((headerCell.viewWithTag(10)?.frame.height)!) + (line * 30)
            headerHeightDict.setValue(heightHeaderCalculation, forKey: String(section))
            print("headerheight5dict has value of header cell = \(heightHeaderCalculation)")
            //MARK: header cell section line column
            print("HeaderCell:View: Section = \(section) Line : \(line) Column: \(column)")
            print("------from station = \(tripCell.originDetail.name)")
            print("------from time = \(tripCell.originDetail.time)")
            
            print("------to station = \(tripCell.destinationDetail.name)")
            print("---12341---to time = \(tripCell.destinationDetail.time)")
            
            headerCell.from_station.text = tripCell.originDetail.name
            headerCell.from_time.text = tripCell.originDetail.time
            headerCell.to_station.text = tripCell.destinationDetail.name
            headerCell.to_time.text = tripCell.destinationDetail.time
            headerCell.duration.text = tripCell.dur
            print(tripCell.originDetail.name)
            print(tripCell.originDetail.type)
            print(tripCell.originDetail.id)
            // MARK: Zone & Price Info
            
            var tariffZones_text = String()
            var tariffRemarks_price = String()
            
            if (tripCell.tariffZones.contains("Not")){
                tariffZones_text = "SL"
                
                
            } else {
                
                tariffZones_text = tripCell.tariffZones
                
            }
            if (tripCell.tariffRemark.contains("remarks")){
                
                tariffRemarks_price = "SL"
                
            } else {
                
                tariffRemarks_price = tripCell.tariffRemark
            }
            
            headerCell.ZoneInfo.text = tariffZones_text
            headerCell.PriceInfo.text = tariffRemarks_price
            // MARK: ZoneInfo Hide
            //MARK: TariffiInfo Hide
            headerCell.ZoneInfo.isHidden = true
            headerCell.PriceInfo.isHidden = true
            
            print("tripcell.duration is =)")
            // MARK: MapReference temp friday off
            
            /*
             let leg =  tripCell.LegList[0] as! Leg
             headerCell.mapReference.tag = section + 1
             headerCell.mapReference.accessibilityIdentifier = leg.journeyDetailRef
             headerCell.mapReference.isHidden = true
             headerCell.showTripRouteOnMapOutlet.tag = section + 1
             headerCell.showTripRouteOnMapOutlet.accessibilityIdentifier = leg.journeyDetailRef
             let mapReferenceKey = section + 1
             rootMap_Ref_Dict.setValue(leg.journeyDetailRef, forKey: String(mapReferenceKey))
             // MARK: AutoLayout
             */
            let evenOrNot = even(number: section)
            
            if (evenOrNot){
                
                // headerCell.backgroundColor = UIColor.lightGray
            }
            
            print("section::::::header:::\(section)")
            
            
            
            return headerCell
        }
        
        func even(number: Int) -> Bool {
            // Return true if number is evenly divisible by 2.
            return number % 2 == 0
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //        <#code#>
            //    }
            //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            
            if (segue.identifier == "intermediateStops"){
                
                let selectedLegCell = sender as! LegListCells
                print("selected Leg Cell ===== \(selectedLegCell.transportTypeOutlet.text)")
                print("transportType Flag in prepare for segue == \(transportTypeFlag)")
                
                if (selectedLegCell.transportTypeOutlet.text != "WALK"){
                    let vc = segue.destination as! IntermediateStopsViewController
                    
                    //  vc.setValue(selectedLegJourneyDetailedRef, forKey: "JourneyDetailedReference")
                    print("selectedLegJourneyDetailedRef = \(setJourneyDetailedReference)")
                    //segue.destinationViewController.setValue(selectedLegJourneyDetailedRef, forKey: "JourneyDetailedReference")
                    
                } else {
                    
                    setJourneyDetailedReference = ""
                    transportTypeFlag = "WALK"
                    
                }
                
                
            }
            else if (segue.identifier == "TripMap")
            {
                
                tripRootMapFlag = true
                
                
            }
            
            
        }
        
        //
        //    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCells") as! HeaderCells
        //        headerCell.backgroundColor = UIColor.cyanColor()
        //
        //        let head = newTrip[section] as! Trip
        //
        //
        //
        //         print("-In Sections--[Sections]=\(section)--)")
        //        print(".....head.count is \(head.dur)")
        //        print("-----section # \(section)")
        ////        headerCell.from_time.text = head[section] as! String
        //        headerCell.from_time.text = head.destinationDetail.name
        //     //   switch (section) {
        //
        //
        //
        ////        case 0:
        ////            headerCell.from_time.text = head[section] as! String//"Europe";
        ////        //return sectionHeaderView
        ////        case 1:
        ////            headerCell.from_time.text = head[section] as! String //"Asia";
        ////        //return sectionHeaderView
        ////        case 2:
        ////            headerCell.from_time.text = head[section] as! String //"South America";
        ////        case 3:
        ////            headerCell.from_time.text = head[section] as! String //"South America";
        ////        case 4:
        ////            headerCell.from_time.text = head[section] as! String //"South America";
        ////        //return sectionHeaderView
        ////        default:
        ////            headerCell.from_time.text = "Other";
        ////        }
        //
        //        return headerCell
        //    }
        //
        //
        //    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        //        footerView.backgroundColor = UIColor.blackColor()
        //
        //        return footerView
        //    }
        //
        //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //        return 40.0
        //    }
        //
        
        
        
}




// MARK: Possible problem start on 22nd december///---------end-----23rd dec 0700

//-------------
/*
 //
 //  TableViewController.swift
 //  headerSectionTableView
 //
 //  Created by syed farrukh Qamar on 25/04/16.
 //  Copyright © 2016 Be My Competence AB. All rights reserved.
 //
 
 import UIKit
 
 class TripSuggestionsTViewController: UITableViewController {
 
 
 // DataSource for Trips
 
 var countriesinEurope = ["Trip[0]","Trip[1]","Trip[3]","Trip[4]","Trip[5]"]
 var countriesinAsia = ["LL-0-1","LL-0-2","India","fourth","fifth","sixth"]
 var countriesInSouthAmerica = ["Argentia","Brasil","Chile"]
 var fourthRow = ["4th-Argentia","4th-Brasil","4th-Chile"]
 var fifthRow = ["5th---Argentia","5th---Brasil","5th---Chile"]
 
 //    var countriesinEurope = ["France","Spain","Germany"]
 //    var countriesinAsia = ["Japan","China","India"]
 //    var countriesInSouthAmerica = ["Argentia","Brasil","Chile","Chile","Chile","Chile","Chile","Chile","ninth"]
 //    var fourthRow = ["4th-Argentia","4th-Brasil","4th-Chile"]
 //    var fifthRow = ["5th---Argentia","5th---Brasil","5th---Chile"]
 //
 
 
 var s = NSMutableArray()
 
 override func viewDidLoad() {
 super.viewDidLoad()
 s.addObject(countriesinEurope)
 s.addObject(countriesinAsia)
 s.addObject(countriesInSouthAmerica)
 s.addObject(fourthRow)
 s.addObject(fifthRow)
 
 
 print("first objecty is = \(s[0].firstIndex))")
 
 for objects in s {
 
 let o = objects as! NSArray
 print("test=  \(o[0])")
 tableView.reloadData()
 }
 
 }
 
 override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 // 1
 // Return the number of sections.
 print("section count is = \(s.count)")
 return s.count
 }
 
 override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // 2
 print("Section # Is = \(section)")
 
 print("s[section].Rows are = \(s[section].count)")
 return s[section].count
 }
 
 
 override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TripSuggestionsCell_new
 
 print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
 print("s[section].Rows are = \(s[indexPath.section].count)")
 // 3
 // Configure the cell...
 let cellValue = s[indexPath.section] as! NSArray
 //        cell.from_time.text = cellValue[indexPath.row] as! String
 
 cell.from_time.text = String(indexPath.row)
 
 //        switch (indexPath.section) {
 //        case 0:
 //            cell.from_time?.text = countriesinEurope[indexPath.row]
 //        case 1:
 //            cell.from_time?.text = countriesinAsia[indexPath.row]
 //        case 2:
 //            cell.from_time?.text = countriesInSouthAmerica[indexPath.row]
 //        case 3:
 //            cell.from_time?.text = fourthRow[indexPath.row]
 //        case 4:
 //            cell.from_time?.text = fifthRow[indexPath.row]
 //        //return sectionHeaderView
 //        default:
 //            cell.textLabel?.text = "Other"
 //        }
 
 return cell
 }
 
 
 
 override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCells") as! HeaderCells
 headerCell.backgroundColor = UIColor.cyanColor()
 
 let head = s[0] as! NSArray
 print("-In Sections--[Sections]=\(section)--)")
 print(".....head.count is \(head.count)")
 print("-----section # \(section)")
 //        headerCell.from_time.text = head[section] as! String
 headerCell.from_time.text = String(section)
 
 //   switch (section) {
 
 
 
 //        case 0:
 //            headerCell.from_time.text = head[section] as! String//"Europe";
 //        //return sectionHeaderView
 //        case 1:
 //            headerCell.from_time.text = head[section] as! String //"Asia";
 //        //return sectionHeaderView
 //        case 2:
 //            headerCell.from_time.text = head[section] as! String //"South America";
 //        case 3:
 //            headerCell.from_time.text = head[section] as! String //"South America";
 //        case 4:
 //            headerCell.from_time.text = head[section] as! String //"South America";
 //        //return sectionHeaderView
 //        default:
 //            headerCell.from_time.text = "Other";
 //        }
 
 return headerCell
 }
 
 
 //    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
 //        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
 //        footerView.backgroundColor = UIColor.blackColor()
 //
 //        return footerView
 //    }
 //
 //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
 //        return 40.0
 //    }
 //
 
 
 
 }
 */







/* temp comment start 9th nov 2016
//  TableViewController.swift
//  headerSectionTableView
//
//  Created by syed farrukh Qamar on 25/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.

import UIKit
var convertedJsonIntoNSDict1 = NSDictionary()
var selectedLegJourneyDetailedRef = String()
var tripRootMapFlag = false
var rootMap_Geom_Ref = String()
var rootMap_Ref = String()
var rootMap_Ref_Dict = NSMutableDictionary()
var colorFlag = true
// Being used in custom trips for next departures in trip info
 let headerBorderWidth = CGFloat(4.0)
let cellBorderWidth = CGFloat(4.0)

// icon & row sizes
var headerHeightDict = NSMutableDictionary()
// stack view height is 68
let headerCell_StackView_Height = 15 + 70 + 15

//let default_startingPoint = CGPoint(x: 5.0,y: legIcons_y!)
let defaultBottomSpaceLeave = 15.0
let defaultTopSpaceLeave = 15.0
let defaultStackViewBottomSpaceBeforeIconLeave = 10

let default_startingSize = CGSize(width:30.0,height:30.0)
let default_orientation = "x"  // x, y, or xy
let default_innerSpacing = CGPoint(x:-1,y:0)
let default_innerLegSpacing = CGPoint(x:10,y:0)
let default_sizeFactor = CGSize(width: 0.0,height: 0.0)

let cellBackgroundColor = UIColor(red: (235/255), green: (236/255), blue: (237/255), alpha: 1.0)
let headerRowSelectedColor =  UIColor(red: (206/255), green: (229/255), blue: (242/255), alpha: 1.0)
let headerRowDefaultColor =  UIColor.white

var custom_Trip_NextDepartures_Dict = NSMutableDictionary()


let studentName = ["Stockholm","London","Paris","Oslo","Stockholm","London","Paris","Oslo","Stockholm","London","Paris","Oslo"]


let firstLegImage   = "firstLeg.png"
let middleLegImage  = "middleLeg.png"
let lastLegImage    = "lastLeg.png"
let onlyLegImage    = "onlyLeg.png"

class TripSuggestionsTViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {

  //  @IBOutlet weak var showNextDeparturesIn_TripInfoAction: UIButton!
    var showTripDetail_Dict = NSMutableDictionary()
    var showNextDeparturesTripInfo = NSMutableDictionary()
    var nextDepartureMasterDict = NSMutableDictionary()
    var showDeparture = false
    var departureCounter = 0
    
    var transportTypeFlag = String()
    
   // show hide trip info
    var showTripInfo = false
    var sectionShow = 10
    var showHideArray = [Bool]()

    //Mark: Autolayout Variables
    var legIconsLineCounter = 0
    let legIconsHeight = default_startingSize.height
    let headerCellHeight = 90 //100 //80 //60
    var legIconsLineTerminateCount = 1
    
  //  @IBOutlet weak var mapReferenceAction: UIButton!
//    MARK:- showTripOnMapAction
    var addToFav_flag = false
    @IBAction func addToFavourite(sender: UIBarButtonItem) {
        
        print("--------from-------------")
        print(sr_fromStation_name)
        print(sr_fromStation_id)
         print("--------To-------------")
        print(sr_toStation_name)
        print(sr_toStation_ID)
       
        if (addToFav_flag == false){
            print("--------from---inside add to fav----------")
            
        SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: FAVOURITES)
        addToFav_flag = true
        }
        else {
            
            print("Already added......")
        
        }
    }
    
    @IBAction func showTripOnMapAction(sender: UIButton) {
          print("showTripOnMapAction .......")
        
        print("newTrip.count = \(newTrip.count)")
        print("sender.tag\(sender.tag)")
        
        let tripCell = newTrip[sender.tag - 1] as! Trip
     
         print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
        selectedRootTripForMap = tripCell.LegList
        //
        print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
        //
        //        print("\()")
        rootMap_Ref =   rootMap_Ref_Dict.value(forKey: String(sender.tag)) as! String
        
        tripRootMapFlag = true
        print("map Referrence Action = \(rootMap_Ref)")
    }
    
    @IBAction func mapReferenceAction(sender: UIButton) {
        
        let tripCell = newTrip[sender.tag - 1] as! Trip
        selectedRootTripForMap = tripCell.LegList
//        
        print("trip cell.Leglist.Count = \(tripCell.LegList.count)")
//        
//        print("\()")
    rootMap_Ref =   rootMap_Ref_Dict.value(forKey: String(sender.tag)) as! String
    
        tripRootMapFlag = true
        print("map Referrence Action = \(rootMap_Ref)")
     }
    
    @IBAction func showNextDepartures_InTripInfo(_ sender: UIButton) {
        
       
//     let currentCell = sender.superview as! LegListCells

        let button = sender as! UIButton
        let view = button.superview!
        let currentCell = view.superview as! LegListCells
        
        
//        let key = String(currentCell.sectionInfo) //+ String(currentCell.rowInfo)
//        let nextDepartureShowFlag = RealTidMethods.checkIfKeyExists(objectToCheck: showNextDeparturesTripInfo, keyName: key!)
//
//        print("Checking for next departure cell show value....... in show next departure action....")
//        
        //---------------------------Start departure collection view old
        /*
        if (nextDepartureShowFlag == true){
        print("Key exists for show hide......some one has checked before as well....")
            // key found
            // check for previous value
             let value =  showNextDeparturesTripInfo.value(forKey: key!) as! Bool
                if (value == true){
                print("previous next departure show value was true....")

                print("setting new value to false... now the next departure cell must be hidden....")
                showNextDeparturesTripInfo.setValue(false, forKey: key!)

            
            }
            
        
        } else {
            print("no value value found. thus setting value to show i.e. true......means it should be visible.....")
        // key wasnt available
            // user has pressed it to show next departures
            
            print("Before::shownextdepartureTripInfo ==== \(showNextDeparturesTripInfo.allKeys)")
            
            showNextDeparturesTripInfo.setValue(true, forKey: key!)
            
            print("After:::::shownextdepartureTripInfo ==== \(showNextDeparturesTripInfo.allKeys)")
            
        
        }
         */
        
        //---------------------------end departure collection view old
        let customTripClass = CustomTripMethods()
        customTripClass.get_data_from_url(from: currentCell.from_station.text!, to: currentCell.to_station.text!, tableView: tableView, headerSectionId: currentCell.sectionInfo, legRow_id: currentCell.rowInfo)
        
        
        //----------------------------------------------
        
        
        // Update Master Departure
        var currentSectionDict = nextDepartureMasterDict.value(forKey: String(currentCell.sectionInfo)) as! NSMutableDictionary
        print("All keys in next departureMasterDict = \(nextDepartureMasterDict.allKeys)")
        print("All keys in current section dict = Trip Info Level = \(currentSectionDict)")
        
        // get section and row as key
        let currentTripInfoCellValue = currentSectionDict.value(forKey: String(currentCell.rowInfo)) as! Int
        print("Current Cell Section = \(currentCell.sectionInfo) && Row = \(currentCell.rowInfo)")
        
        print("current Trip info CEll Value = \(currentTripInfoCellValue)")
        if (currentTripInfoCellValue == 0){
    
        currentSectionDict.setValue(1, forKey: String(currentCell.rowInfo))
            
            print("old=0new value for the current row = \(currentCell.rowInfo) = 1)")
            
            
        } else if (currentTripInfoCellValue == 1){
        
            
            currentSectionDict.setValue(0, forKey: String(currentCell.rowInfo))
            
            print("old=1 new value for the current row = \(currentCell.rowInfo) = 0)")
            
        }
        
        // update the tripinfo value against respective section
        
        nextDepartureMasterDict.setValue(currentSectionDict, forKey: String(currentCell.sectionInfo))
            
            
        
        // get section as key
        
        // receive dict and then receive value from index.row as key
        
        
        //----------------------------------------------
        print("current button tag =  \(sender.tag)" )
        
       // let indexPath = itemTable.indexPathForCell(currentCell)
        
        print("currentcell.sectioninfo & row = \(currentCell.sectionInfo) & \(currentCell.rowInfo)")
        
        print("currentCell.from_station.text station= \(currentCell.from_station.text)")
        
        print("current cell values  to station = \(currentCell.to_station.text)")
        
        tableView.reloadData()
    }
    // Leg Image Names
    //MARK: Show Trip Details
    @IBAction func sectionAction(sender: UIButton) {
        print("section button is pressed with : ")
        print(sender.tag)
        sectionShow = sender.tag
    
        
//        let button = sender as! UIButton
//        let view = button.superview
// 
//        print("table view total count::::\(tableView.visibleCells.count)")
//        let someCell = tableView.visibleCells[0] as! TripSuggestionsCell_new
//        someCell.backgroundColor = UIColor.green
//        let stackView = (((((((((((((((((((view?.superview as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView) as! UIStackView)
//        
//        let currentCell = view?.superview as! TripSuggestionsCell_new
//        currentCell.backgroundColor = UIColor.red
//        
        
        //let showFlag = showTripDetail_Dict.value(forKey: String(sender.tag)) as! Bool
        // MARK: toggle trip detail
        // Check Null
      //  RealTidMethods
//        let trip_detail_flag = RealTidMethods.checkIfKeyExists(objectToCheck: showTripDetail_Dict, keyName: String(sectionShow))
//        
        // check for null
        
        // null found , set the value to true
        
        let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(sectionShow))
        print("---------show more pressed............trip_detail_flag=\(trip_detail_flag)")
        
        /*
        if (trip_detail_flag == false){
            
            print("inside else ............. and null found....")
            // add the value
             showTripDetail_Dict.setValue(true, forKey: String(sectionShow))
            
        }
        
        // if not null then
        else {
            
            
            let value_showMore_flag = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            
            // extract the value
            print("inside else ............. and not null found....")
            //  check existing value
            
            if (value_showMore_flag == true){
                //  if true then set for false
                showTripDetail_Dict.setValue(true, forKey: String(sectionShow))
                let flagValue = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
                
                print("trip detail flag contained : true now value = \(flagValue)")
            }
            else {
                //  vice versa if false then set for true
                showTripDetail_Dict.setValue(false, forKey: String(sectionShow))
                let flagValue = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
                
                print("trip detail flag contained : false now value = \(flagValue)")

            }
            
            //  next step is to run and see output
            
            //  after that apply these values on section header level to switch on and off
        
        }
        */
        print("---------show more pressed............end")
        
//        let testing = sender.superview as! HeaderCells
//        testing.backgroundColor = UIColor.red
//        
        if (trip_detail_flag.contains("null"))
        {
//             let valueNowb4 = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
//            
            print("-------null caught on section === \(sectionShow))")
         
            
            showTripDetail_Dict.setValue(true, forKey: String(
            sectionShow))
            let valueNow = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            
            print("now = in null \(valueNow)")
            
        }
            else
            {
            
            
            let  valueNowb4_true = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            
                
                print("-------NOT null caught on section === \(sectionShow))")
                
                if (valueNowb4_true == true){
                    print("value was true ........")
                    showTripDetail_Dict.setValue(false, forKey: String(
                        sectionShow))
                    
                
                }
                else if (valueNowb4_true == false) {
                    
                    print("value was false ........")
                
                    showTripDetail_Dict.setValue(true, forKey: String(
                        sectionShow))
                    
                
                }
         //   print("current value of flag is=b4=true = \(valueNowb4_true)")
            let valueNow = showTripDetail_Dict.value(forKey: String(sectionShow)) as! Bool
            print("-------------section #  \(sectionShow)")
                
            print("--------------------------------------now = \(valueNow)")
                print("Total keys in showtripDetail Dict = \(showTripDetail_Dict.allKeys)")
                print("key count is = \(showTripDetail_Dict.count)")
                
            
        }
        
        tableView.reloadData()
     
    }
    
    //MARK: Old Leg Image Constant Place
    
    // Header Data Source--( Sections
    var newTrip = NSMutableArray()
    
    // Rows Data Source
    
    //    var newTrip = [Trip]()
      let legList = ["test-0","test-1","test-2"]
    //    var trips = [Trips]()
    
    var from = String()
    var to = String()
    var searchForArrivals = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: AutoRowHeight
         // tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 150.0
         tableView.rowHeight = UITableViewAutomaticDimension
       
//        tableView.estimatedSectionHeaderHeight = 100
//        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
         tripRootMapFlag = false
        
       // print("-selected index path---------\(self.tableView.indexPathForSelectedRow)")
        let searchTrips = WebServiceHandler()
       var url = String()
        
        print("from = = = = = \(from)")
        print("to = = = = = \(to)")
        
        // recent trips addition
        // MARK: Recent Trips Adding
        
        
       print(" sr_fromStation_id \(sr_fromStation_id) && count is \(sr_fromStation_id.characters.count)")
        print(" sr_fromStation_id \(sr_toStation_ID) && count is \(sr_toStation_ID.characters.count)")
        
           SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
//        
//        if (advancedOptionsFlag == false){
//         url = searchTrips.constructURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
         if (advancedOptionsFlag == false){
            // coming from simple screen
            
            self.title = simple_expectedTripDate + "-" + simple_expectedTripTime
            
            url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
            // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
//             from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
        } else if (advancedOptionsFlag == true){
            
        self.title = expectedTripDate + "-" + expectedTripTime
            
//        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
        }
        
        print("-------------------url----\(url)")
        
        get_data_from_url(url: url)
        print("-----------------------ended--090")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
//        tableView.backgroundColor = UIColor.white
        
        print("view will current real_time_flag value is ==== \(real_time_flag)")

        
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-----webservice start
    func get_data_from_url(url:String)
    {
        
        
        print("Trip Suggestions inside url : \(url)")
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
    //    let testurl = NSURLConnection(request: request, delegate: request)
    
        request.httpMethod = "GET"
       
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("---json step 1------")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error- has been caught")
                return
            }
            print("---json step 2------")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("-trip--7.1--about to return after parsing")

          //          let tripFlag = RealTidMethods.checkIfArray(convertedJsonIntoNSDict1["TripList"]!["Trip"])
                // MARK: Nil check
                
                // call method to check if nil has encountered
                // check if the nsdict has error message
                // check if
                
                print("about to check the generic error---------")
                // Mark: Release check error
                // in slife method, produce error out of nil some how and see what happens
                // check for null
                // if null then go back with error message
                // else if not null then go below
                print("about to check ErrorCheckFlag....inside..errorCheckFlag =....before.....")
                
                
               // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
              let nullCheck = RealTidMethods.checkIfKeyExists(objectToCheck: convertedJsonIntoNSDict1, keyName: "TripList")
                
                if (nullCheck == false){
                
                    self.navigationController?.popViewController(animated: true)
                    print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED......null........")
                    
                } else {
                    
                    let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
             
                    if (errorCheckFlag == true){
                print("errorCheckFlag....inside.......")
                    //MARK: release nil found
                    self.navigationController?.popViewController(animated: true)
                    print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED.......error.......")
                   
                }
                else if (errorCheckFlag == false){
                let tripArray = (convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
                print("-trip--7.1---A--")
                
                self.getTrips(json: convertedJsonIntoNSDict1)
                print("-trip--7.1---B--")
                //--for-1--------------------------------------------------------------------------------------------------
                 print("-trip--7.2--about to return after parsing")
                // reload the table here
                self.tableView.reloadData()
                }
                }
     // dispatch_async(dispatch_get_main_queue(), {
                print("before return....")
                return
            })
        }
        task.resume()
    }
    
    func extract_json(jsonData:NSData)
    {
        print("---json step 3------")
        let json: AnyObject?
        do {
            print("json downloading in progres........4........")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject?
            print("json just downloaded.......5........\(json?.allKeys)")
            //MARK: Nil
            //print("json just downloaded.......5........\((json?["TripList"]!! as AnyObject).description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            // NIL json check
            
            json = nil
            
            
            return
        }
        
        convertedJsonIntoNSDict1 = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---6-----convertedJSON is being printed = \(convertedJsonIntoNSDict1.allKeys)")
    }
    
    func getTrips(json: NSDictionary){
        let tripArray = (convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
        //--for-1-------------------------------------------------------------------------------for 1---
        var forMain1 = 0
        for tripArray in tripArray {
            //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
            print("--------------------------------------------------------------------------------forMain1 \(forMain1)-----")
            
            //    var tripOneByOne = Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: tripArray.valueForKey("dur") as! String)
            //                         print("--tripArray is \(tripArray.allKeys)")
            //                     print("--tripArray.leglist is \(tripArray["LegList"])")
            //                    print("--tripArray.leglist is \(tripArray["LegList"])")
            //
            //---1720---15th of may
            //trips.append()
            
            
            
            // print("---LegList.allKeys--LegList is \(LegList.allKeys)")
            
            
            
            // var dur = ""
            let origin = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
            let destination = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
            
            var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: origin , destinationDetail: destination)
            let dur = (tripArray as! NSDictionary).value(forKeyPath: "dur")! as! String
            
            
            print("duration in trip suggestionsTViewController......\(dur)")
          //  print("tripArray----all Keys \(tripArray.allKeys)")
            
            var chg = ""
            var co2 = ""
            
            var tariffRemark = ""
            var tariffZones = ""
            // var LegList = [Leg]()
            // some variables which will be populated by external functions
            
            var from_time = ""
            var from_station = ""
            var to_Station = ""
            var to_time = ""
            print("----1A------------")
            trip.dur = (tripArray as! NSDictionary).value(forKey: "dur")! as! String
            trip.chg = (tripArray as! NSDictionary).value(forKey: "chg")! as! String
            trip.co2 = (tripArray as! NSDictionary).value(forKey: "co2")! as! String
            let change = trip.chg
            print("----2A------------")
             // <Trip><LegList><PriceInformation>----------------------------------------<PriceInformation>
          //<Trip><LegList><Leg>----------------------------------------------<Leg>
            
            // <Trip><LegList><Leg><Origin>---------------------------------<Origin>
            // move below lines inside origin to extract the value
            
            //            trip.from_time = tripArray.valueForKey("dur")! as! String
            //            trip.from_station = tripArray.valueForKey("dur")! as! String
            // <Trip><LegList><Leg><Destination>---------------------------------<Destination>
            //            trip.to_Station = tripArray.valueForKey("dur")! as! String
            //            trip.to_time = tripArray.valueForKey("dur")! as! String
            //
            
            //--Priceinfo--Start--------gather legs inside LegList-----start
            
            
            //  let priceInfo = tripArray.valueForKey("LegList")!["PriceInfo"] as! NSDictionary
            
            
            
            
            if let priceInfo = (tripArray as! NSDictionary).value(forKey: "PriceInfo") {
                print("------price info found---yes--")
//                print("Price Info -----\(priceInfo.allKeys)")
                
                trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
               print("trip suggestions 1...test")
                trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
               print("trip suggestions 2...test")
                
                //print("Price Info -----\(priceInfo.allKeys)")
            
            } else {
                
                
                trip.tariffRemark = "Tariff Remarks N/A"
                trip.tariffZones = "Zones Not Available"
                
            print("------price info not found-----")
            
            }
          //  let priceInfo = tripArray.valueForKey("PriceInfo")! as! NSDictionary
            
            
//            print("Price Info -----\(priceInfo.allKeys)")
//            
//            trip.tariffRemark = (priceInfo["TariffRemark"] as! NSDictionary)["$"] as! String
//            trip.tariffZones = (priceInfo["TariffZones"] as! NSDictionary)["$"] as! String
//            
            // trip.tariffZones =  priceInfo["TariffZones"] as! NSDictionary
            
            //--Priceinfo--End--------gather legs inside LegList-----start
            
            var forMain11 = 0
            // create a leglist as an array to add the legs in the leglist
            var leglist = NSMutableArray()
            if (change == "0") {
// MARK: Swift 3 doubtful
//                leglist.addObject(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                
                print("trip suggestions 4...\((tripArray as! NSDictionary).value(forKey: "LegList"))")
                print("change is 0 in trip suggestions tv")
                
                //leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
                
                
                let triparrayTest = tripArray as! NSDictionary
                print("trip array test.....\(triparrayTest.allKeys)")
                
                print(triparrayTest.count)
                
                
                let tripDicTest = triparrayTest.value(forKey: "LegList") as!NSDictionary
                
                print("tripDicTest----890----------\(tripDicTest.allKeys)")
                let legTestDict = tripDicTest.value(forKey: "Leg") as! NSDictionary
                
                print("legTestDict::::::\(legTestDict.allKeys)")
                
                
                leglist.add(legTestDict)
                
             //   print("trip.value.leglist............\(tripDicTest.allKeys)")
        
                
// MARK: SWIFT 3 Commenting
                
//                let leglistDictTest = (trip.value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
//                
//                print("leglistDictTest test.....\(leglistDictTest.allKeys)")
//                
//                print(leglistDictTest.count)
//                
//                let legDictTest = trip.value(forKey: "Leg") as! NSDictionary
//                
//                print("legDictTest test.....\(legDictTest.allKeys)")
//                
//                print(legDictTest.count)
//                
//                
//                
// 
//                leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
          //      )
                
                
                
                // leglist.append(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                //print("tripArray.valueForKey('LegList')--- \(tripArray.valueForKey("LegList")?.count)")
            }
            else {
                let tempLegList = ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSArray
                var i = 0
                print("forMain1---- \(forMain1)")
                print("forMain11---- \(forMain11)")
                for (tempLegList) in tempLegList {
                    
                    
                    let legCheck = tempLegList as! NSDictionary
                    
                    let orgCheck = legCheck.value(forKey: "Origin")
                    
                    print("legCheck all keys......\(legCheck.allKeys)")
                    print("orgCheck all keys......\(orgCheck)")
                    
                    
                  //  print("legCheck::::::tempLegList \(legCheck.journeyType)")
                    leglist.add(tempLegList)
                    print("tempLegList.count is---- \((tempLegList as AnyObject).count)")
                    print("i---- \(i)")
                    i += 1
                }
            }
            var legs = NSMutableArray()
            let legListCount = leglist.count
            
            print("leglist.count-b4---999\(leglist.count)")
            //--for-1------------------------------------------------------------------------------from 11
            for leglist in leglist {
            let someValue = leglist as! NSDictionary
                
                // type could be "METRO" or "WALK"
              //  let legCount = leglist["Leg"]!
              
                print("test first inside lieglist......\(someValue.allKeys)")
                print("test first inside lieglist......\((leglist as! NSDictionary).value(forKey: "Leg"))")
                
             //  here you are receiving leglist as dictionary, now iterate through the keys and use the result
                
                //let legCount = (leglist as! NSDictionary).value(forKey: "Leg") as! NSArray
                
                print("leglist.count---- \((leglist as AnyObject).count)")
                print("forMain 1---- \(forMain11)")
                print("forMain 2---- \(forMain11)")
                
                let journeyType = (leglist as! NSDictionary)["type"]! as! String
                // if leg type is WALK then create a legwalk object populate it and then add it to trip
                var destinDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
                var originDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
                print("-----journey type = \(journeyType)")
                //-----------------if condition walk and travel---------start
                
                //                if (journeyType == "WALK"){
                
                // common variable extraction
                // extract ---------------------------------name-, type, idx
                let nameValue = (leglist as! NSDictionary)["name"]! as! String
                let idxValue = (leglist as! NSDictionary)["idx"]! as! String
                let typeValue = (leglist as! NSDictionary)["type"]! as! String
                
                // extract ---------------------------------Geometry Reference
                let geomRef = (leglist as! NSDictionary)["GeometryRef"]
                let geometryReference = (geomRef as! NSDictionary)["ref"] as! String
                print("leglist.allKeys......... in trip suggestion checking")
               // print(leglist.allKeys)
                

                // MARK: Geometry Reference
                // MARK: RTU Message Check
//                if (leglist["RTUMessages"] is NSNull){
//                
//                print("NS NULL FOR RTU MESSAGES.....")
//                
//                } else if (leglist["RTUMessages"] == nil){
//                    print("NS NULL FOR RTU MESSAGES.....")
//                    
//                
//                } else
//                {
//                
//                    let rtuMessages = leglist["RTUMessages"] as! NSDictionary
//                    print("rtuMessages.allKeys")
//                    
//                    print(rtuMessages.allKeys)
//                
//                }
               // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
               
                print("GEOMETRY REFERENCE VALUE IS .......\(geometryReference)")
                // --------------------------dist, hide---------------walk related variable extraction
                //------variables for walk
                var hideValue = "FALSE"
                var distValue = DEFAULT
                // -----variables for travel -
                var dirValue = DEFAULT
                var journeyDetailRefValue = DEFAULT
                var lineValue = DEFAULT
                print("journey type is : \(journeyType)")
                if(journeyType == "WALK"){
                    
                    distValue = (leglist as! NSDictionary)["dist"]! as! String
                    print("--distValue is -----\(distValue)")
                    //var hideValue = ""
                    if let hide = (leglist as! NSDictionary)["hide"] as? String {
                     print(".......1.0")
                        hideValue = hide
                    }
                        
                    else {
                         print(".......1.1")
                        hideValue = "False"
                    }
                }
                    // travel related variable extraction
                    // --------------------------dir, line, JourneyDetailReference
                    
                else if (journeyType != "WALK"){
                    print("---inside not walk---stuck")
                    dirValue = (leglist as! NSDictionary)["dir"]! as! String
                  
                    print("---dir----\(dirValue)")

                    let journeyDetailRef_Key = (leglist as! NSDictionary)["JourneyDetailRef"] as! NSDictionary
                    journeyDetailRefValue = journeyDetailRef_Key["ref"] as! String
                    lineValue = (leglist as! NSDictionary)["line"]! as! String
                    
                }
                
                print("Journey Type = \(journeyType)")
                let origin = (leglist as! NSDictionary)["Origin"] as! NSDictionary
                //trip.from_time = origin["time"]! as! String
                let originNameVal = origin["name"]! as! String
                let originTypeVal = origin["type"]! as! String
                let originIdVal = origin["id"]! as! String
                let originLonVal = origin["lon"]! as! String
                let originLatVal = origin["lat"]! as! String
                let originTimeVal = origin["time"]! as! String
                let originDateVal = origin["date"]! as! String
                print("---check point temp")
                var originRouteIdx = String()
                if (journeyType == "WALK"){
                
                originRouteIdx = "WALK"
                
                }
                else {
                    
                 originRouteIdx = origin["routeIdx"] as! String
                
                }
                    // let originRouteIdx = "routeIdx"
           //     print("-12----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                
          //  Address(name: <#T##String#>, type: <#T##String#>, id: <#T##String#>, lon: <#T##String#>, lat: <#T##String#>, time: <#T##String#>, date: <#T##String#>, routeIdx: <#T##String#>)
                originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal,routeIdx: originRouteIdx)
                
                //                    print("---12--originNameVal-\(originNameVal)")
                //                    print("--12---originDetail.name-\(originDetail.name)")
                //
                //                    print("---12--Origin- originNameVal-\(originNameVal)")
                //
                //
                //                    print("-12----Origin- originNameVal-\(originNameVal)")
                
                //                    let destination = leglist["Destination"] as! NSDictionary
                //    print("nested loop current index \(forMain11)")
                print("test 1.1")
                let destination = (leglist as! NSDictionary)["Destination"] as! NSDictionary
                // trip.from_time = origin["time"]! as! String
                let destinNameVal = destination["name"]! as! String
                let destinTypeVal = destination["type"]! as! String
                print("test 1.2")
                let destinIdVal = destination["id"]! as! String
                let destinLonVal = destination["lon"]! as! String
                 print("test 1.3")
                let destinLatVal = destination["lat"]! as! String
                let destinTimeVal = destination["time"]! as! String
                let destinDateVal = destination["date"]! as! String
                
                var destRoutIdx = String()
                
                if (journeyType == "WALK"){
                
                destRoutIdx = "WALK"
                } else {
                destRoutIdx = destination["routeIdx"]! as! String
                }
                print("test 1")
                print("------destination.allkeys = \(destination.allKeys)")
                destinDetail = Address(name: destinNameVal, type: destinTypeVal, id: destinIdVal, lon: destinLonVal, lat: destinLatVal, time: destinTimeVal, date: destinDateVal, routeIdx: destRoutIdx)
               print("test 2")
                // DECIDED TO KEEP WALK AS IT IS , before it was being saved with key but there is no use of having key and saving it because then it is hard to access as well as below you can see it is being saved as LEGWALK
                // let legWalkDict = ["WALK": legwalkDict] as NSDictionary
                //    var legWalk = LegWalk(journeyType: journeyType, legWalk: legWalkDict as! Dictionary<String, Walk, originValue: originDetail , destinationValue: destinDetail)
                
                //                    var legWalk = LegWalk(journeyType: journeyType, legWalk: legwalkDict, originValue: originDetail , destinationValue: destinDetail)
                
              print("test 3")  
        
                print("--End--------------End------------------forMain11  \(forMain11)-----")
                print("leglist count is---head--=\(legListCount)")
                print("--logic main---forMain11  is = \(forMain11 + 1)-----Leglist count is =\(legListCount)")
                // check the value of count
                print("()---originDetail.name= \(originDetail.name)")
                print("()---destinDetail.name= \(destinDetail.name)")
                
                // extracting origin and destination for Trip (complete journey)
                // extracting origin and destination for trip each leg
                // case A   --onlyLeg
                if (legListCount == 1){
                    print("leglist count is-----=\(legListCount)")
                    trip.originDetail = originDetail.mutableCopy() as! Address
                    trip.destinationDetail = destinDetail.mutableCopy() as! Address
                    print("---A------------------originDetail= \(originDetail.name)")
                    print("----A-----------------originDetail= \(trip.originDetail.name)")
                }
                    // CASE B -First----first leg
                else if (legListCount > 1 && forMain11 == 0)
                {
                    print("leglist count is-88-origin--=\(legListCount)")
                    trip.originDetail = originDetail.mutableCopy() as! Address
                    print("----B-----------------originDetail= \(originDetail.name)")
                    print("----B-----------------originDetail= \(originDetail.name)")
                    print("-----B----------------originDetail= \(trip.originDetail.name)")
                    
                }
                else if (legListCount > 1 && ((forMain11 + 1) == legListCount))
                {
                    print("leglist count is-88-destin--\(legListCount)")
                    
                    trip.destinationDetail = destinDetail.mutableCopy() as! Address
                    print("---C------------------destinationDetail= \(destinDetail.name)")
                    print("---C------------------destinationDetail= \(trip.destinationDetail.name)")
                    
                    print("legListCount > 1 && ((forMain11) == count ---------")
                }
                var legImageName = String(DEFAULT)
                let i  = forMain11 + 1
                
                if (legListCount == 1) {
                // onlyLegImage
                legImageName = onlyLegImage
                
                } else if (legListCount == 2 ){
                
                      // firstImage
                          if (i == 1){
                        legImageName = firstLegImage
                    
                         }
                    // lastImage
                    
                         else if (i == 2){
                            legImageName = lastLegImage

                    }
                
                }
                // firstLeg, middle, lastLeg
                else if (legListCount > 2) && (i == 1) {
                // firstLegImage
                    legImageName = firstLegImage

                }
                // middleLegImage
                else if (legListCount > 2) && (i != legListCount) {
                
                    legImageName = middleLegImage
    
                }
                // lastLegImage
                
                else if (legListCount > 2) && (i == legListCount) {
                
                    legImageName = lastLegImage
                }
                
                print("dist value is going to the final= \(distValue)")
                //    let rtuMessages_Exists = leglist["RTUMessag"] != nil
                let checkKeyExist = RealTidMethods.checkIfKeyExists(objectToCheck: leglist as AnyObject, keyName: "RTUMessages")
                var rtuMessageString = String()
                if (checkKeyExist == true) {
                    let leglistRTUMessage = (leglist as! NSDictionary)["RTUMessages"] as! NSDictionary
                    // MARK: Rtu Message Get
                    var rtuMessage = RealTidMethods.checkIfKeyExists(objectToCheck: leglistRTUMessage, keyName: "RTUMessage")
                    if (rtuMessage == true){
                        
                        print("--------rtu Message.....status................\(leglistRTUMessage.allKeys).")
                        print(rtuMessage)
                    //    print(leglistRTUMessage["RTUMessage"]!["$"] as! String)
                        rtuMessageString = (leglistRTUMessage["RTUMessage"]! as! NSDictionary)["$"] as! String
                    }
                    
                    
                }
                print("check if Key Exist or not ======== \(checkKeyExist)")
                // MARK: Leg Population
                let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString)
                 print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                print("rtu message status from leg = message = \(leg.rtu_Message)")
                trip.LegList.add(leg)
                 forMain11 += 1
                 //----------------if condition walk & travel----------end
             }
            print("---LegList.allKeys----duration being entered is :\(dur)")
            self.newTrip.add(trip)
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1 += 1
        }
     }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        print("section count is = \(newTrip.count)")
        
        return newTrip.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("row has been selected..........\(indexPath.row)")
        print("\(tableView.cellForRow(at: indexPath)?.tag)")
        // reset intermediat stops if it is already initialised
        
        if (intermediateStops.intermediateStops.count == 0){
        
        print("still intermediate stops is nil....in did select row at ind... in trip suggestionsT View Controller")
            
        }
        else {
        print("----about to reset INTERMEDIATE STOPS....")
        IntermediateStopsViewController.resetIntermediateStops(intermediateStopsFullObject: intermediateStops)
            
        }
        // let leg = legList.LegList[indexPath.row] as! Leg
        
//        print("Leg Journey Detailed Ref: \()")
        
        
        let legList = newTrip[indexPath.section] as! Trip
        //let test = NSMutableArray()
        
        //test.addObject(legList.LegList[indexPath.row])
//        let startingPoint = CGPoint(x: 35.0,y: 30.0)
//        let startingSize = CGSize(width:20.0,height:20.0)
//        let orientation = "x"  // x, y, or xy
//        let innerSpacing = CGPoint(x:10,y:0)
//        let innerLegSpacing = CGPoint(x:25,y:0)
//        let sizeFactor = CGSize(width: 0.0,height: 0.0)
//        // ------------setting Leg Images---------START
        print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
        var count = legList.LegList.count
        count = count - 1
        print("--Row = \(indexPath.row)----count = \(count)")
        let leg = legList.LegList[indexPath.row] as! Leg
        print("checking transport type........ when leg is being selected....\(leg.type)")
        // reset intermediate stops
        if (leg.type != "WALK"){
            setJourneyDetailedReference = leg.journeyDetailRef
            setOriginStop = Int(leg.origin.routeIdx)!
            setDestinationStop = Int(leg.destination.routeIdx)!
            
            // set the origin name & time
            setRootLegOriginTime = leg.origin.time
            setRootLegOriginStation = leg.origin.name
            // set the destination name & time
            setRootLegDestinationTime = leg.destination.time
            setRootLegDestinationStation = leg.destination.name
            print("current indexPath.row = \(indexPath.row)")
            print("Current journey detail reference is \(leg.journeyDetailRef)")
            print("passing det ref = \(selectedLegJourneyDetailedRef)")
            print("::::origin id. ...... \(setOriginStop)")
            print("Root Cell Selection : Origin : \(leg.origin.name)")
            print("::::dest id. ...... \(setDestinationStop)")
            print("::Root Cell Selection : Destination : \(leg.destination.name)")
            
            //cell.legImage.image = UIImage(named: leg.legImageName)
            
            
            print("SECTION SELECTED = ")
            print(indexPath.section)
            print("CELL SELECTED = ")
            print(indexPath.row)
            print("section  ?  SELECTED =  tableView.indexPathForSelectedRow = ")
            print(tableView.indexPathForSelectedRow)
            

        } else {
        
             transportTypeFlag = "WALK"
        }
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               // return newTrip[section].legList.count
        let legList = newTrip[section] as! Trip
        print("----LegList Count is in number of rows in section=\(legList.LegList.count)")
        print("section show value in number of rows in section = \(sectionShow)")
      
        // extract value of section if not null
        // check if it is true then show
        // else return 0
        
        // check for null
        print("section # is \(section)")
        let section_null_or_not = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        
            
            if (section_null_or_not.contains("null")){
            
            
            
            print("section null or not contains===== false = \(section_null_or_not)")

            
            } else if (section_null_or_not.contains("true")) {
            
                
                
                print("section null or not contains===== True = \(section_null_or_not)")
                
                print(" \(legList.LegList.count)")
                
                //MARK: NextDepartureCEll Count Return
                
                var departureCellCount = 0
                //----------------------------
                
                
              //  let key = String(currentCell.sectionInfo)  + String(currentCell.rowInfo)
//                let nextDepartureShowFlag = RealTidMethods.checkIfKeyExists(objectToCheck: showNextDeparturesTripInfo, keyName: String(key))
//                print("nextDepartureShowFlag= \(nextDepartureShowFlag)")
//                print("showNextDeparturesTripInfo-------\(showNextDeparturesTripInfo.allKeys)")
//                print("Checking for next departure cell show value....in number of rows in cell... in show next departure action....")
//                if (nextDepartureShowFlag == true){
//                    print("Key exists for show hide..in number of rows in cell....some one has checked before as well....")
//                    // key found
//                    // check for previous value
//                    let value =  showNextDeparturesTripInfo.value(forKey: key) as! Bool
//                    
//                    print("value received is == \(value)")
//                    if (value == true){
//                    
//                        // value is true , show cell 
//                        // increase count for departure cell to show
//                        departureCellCount = 1
//                    
//                       print("Departure cell count new value is 1-SHOW. .... hide collection view.....")
//                        
//                    } else if (value == false ){
//                    departureCellCount = 0
//                        print("Departure cell count new value is 0-HIDE. .... hide collection view.....")
//                    
//                    
//                    }
//                }
//                
                
                //---------------------------
                
                // Departure Master Creation ------
                var sectionTripInfoDict = NSMutableDictionary()
                // get count for currection section number of rows
                // creat this only first time
                // var currentSectionDepartureCells = 0
                
                var currentTripInfoDepartCount = 0
                
                var i = 0
                
                // check if master dict is empty or not ()
                
                let masterDepartDictFlag  = RealTidMethods.checkIfKeyExists(objectToCheck: nextDepartureMasterDict, keyName: String(section))
               
                if (masterDepartDictFlag == false){
                
                // add the section level key
                    
                    nextDepartureMasterDict.setValue(sectionTripInfoDict, forKey: String(section))
                    
                    // get object and update it 
                    let currentTripInfoDepartDictObj = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                    
                    // add the trip info level keys
                    var i = 0
                    for index in legList.LegList {
                    
                    // set value as 0 for each tripinfo cell row index
                        currentTripInfoDepartDictObj.setValue(0, forKey: String(i))
                        
                    print("---------------------Section = \(section) && i = \(i) value = \(0)")
                    i += 1
                    }
                    
                    print("currentTripInfoDepartDictObj all keys = \(currentTripInfoDepartDictObj.allKeys)")

                    print("currentTripInfoDepartDictObj.count = \(currentTripInfoDepartDictObj.count)")
                    print("leglist.leglist.count = \(legList.LegList.count)")
                    
                    // update it back to the main object
                    
                    nextDepartureMasterDict.setValue(currentTripInfoDepartDictObj, forKey: String(section))
                    
                    
                
                } else if (masterDepartDictFlag == true){
                // extract current trip info level dict object
                    let currentTripInfoDepartDictObj = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
                    print("currentTripInfo DepartDictObj === \(currentTripInfoDepartDictObj.allKeys)")
                    // iterate throught the object and
                    var i = 0
                  //  let tripInfoDepartDict =  currentTripInfoDepartDictObj.value(forKey: String(section)) as! NSMutableDictionary
                    
                    for (key,index) in currentTripInfoDepartDictObj {
                        let iStr = String(i)
                        if (iStr.contains(key as! String))
                        {
                            
                            currentTripInfoDepartCount += currentTripInfoDepartDictObj[iStr] as! Int
                            
                        }
                        
                        i += 1
                    }
                    
                    // add to main return number of cell counts
                    
                    
                
                
                }
                
                
//                let currentMasterDepartDict = nextDepartureMasterDict.value(forKey: String(section)) as! NSMutableDictionary
//                
//                if (currentMasterDepartDict.count == 0){
//                for index in legList.LegList.count {
//                    print("section ::: \(section) && i = \(i) Count = \(legList.LegList.count)")
//                  // resetting all departure values
//                    sectionTripInfoDict.setValue(0, forKey: String(i))
//                    }
//                } else {
//                // if the dict has keys more than 0 then update the return count based on
//                    var i = 0
//                    for index in legList.LegList.count {
//                    
//                    
//                    
//                    }
//                    
//                    currentSectionDepartureCells +=
//                }
              
                
//                print("sectionTripInfo All Keys = \(sectionTripInfoDict.allKeys)")
//                print("sectionTripInfo Dict Total Count = \(sectionTripInfoDict.count)")
//                
                // once created then iterate through current section values and add it to total current count
                
                
                //  print("number of rows in Section: LegList= \(newTrip[section].)")
                
                //  print("s[section].Rows are = \(s[section].count)")

                
                
                
                print("LegList.Leglist.Count = \(legList.LegList.count) && DepartureCellCount = \(currentTripInfoDepartCount)")
                let totReturn = legList.LegList.count + currentTripInfoDepartCount
                
                return totReturn //legList.LegList.count + currentTripInfoDepartCount
                
            
            }
        // if not null then check if true
//            rip_detail_flag.contains("null")
            
        // if true then return leglist as below
        
        /*
        if (section == sectionShow){
        
        print(" \(legList.LegList.count)")
        return legList.LegList.count
            }
        */
        //-------------------------
        return 0
    }
    
    // MARk: Collection View Methods
    //MARK: checked: 23rd dec. this is old
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        // triplegiconscollection view cell name is old but now it is being used for next departures collection view show

//          tableView.backgroundColor = UIColor.white
        print("-------------Section = \(indexPath.section) & Row = \(indexPath.row)")
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuseIdentifier", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
        if (colorFlag == true){
            
            cell.backgroundColor = UIColor.lightGray
            cell.from_time.textColor = UIColor.white
            cell.to_time.textColor = UIColor.white
            
            colorFlag = false
        } else {
            
            cell.backgroundColor = UIColor.white
            cell.from_time.textColor = UIColor.black
            cell.to_time.textColor = UIColor.black
            
            colorFlag = true
        
        }
        
//        if(indexPath.row == 2){
//            
//            cell.backgroundColor = UIColor.red
//            
//        }
        
        
        
        var layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        //layout.scrollDirection = UICollectionViewScrollDirection.horizontal
    
        if (custom_Trip_NextDepartures_Dict.count > 0 ){
        
            let currentSection = String(indexPath.section)
            let currentRow = String(indexPath.row)
            let view = collectionView.superview!
            let currentCell = view.superview as! LegListCells
            let keyNameTemp = currentCell.keyName
            print("printing cells..keyname temp from current cell = \(keyNameTemp)")
            let keyName = currentSection + currentRow
            print("Collection ALL KEYS = \(custom_Trip_NextDepartures_Dict.allKeys)")
            print("generated current key via indexpth.section and row = \(keyNameTemp)")
            print("index path row values in collection cell for = \(indexPath.row)")
            
             if let collection_Values_flag = custom_Trip_NextDepartures_Dict[keyNameTemp]
            {
            
            //if (collection_Values_flag == true){
                let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                
                print("customDepTripArray Count = \(customDepTripArray.count)")
                
                print("-----test 10989")
                let tripCustom = customDepTripArray[indexPath.row] as! Trip
                
               
                
                
                print("firstTripDep =\(tripCustom.originDetail.name) ")
                //   let tripCustom = custom_Trip_NextDepartures_Dict[0] as! Trip
                
           //     let legList = newTrip[indexPath.section] as! Trip
                print("generated current key via indexpth.section and row = \(keyNameTemp)")
                
                print("dddddd = \(tripCustom.originDetail.time)")
                print("dddddd = \(tripCustom.destinationDetail.time)")
                
                
//              cell.to_time.setTitle(tripCustom.destinationDetail.time, for: .normal)
                
                //let legList = newTrip[indexPath.section] as! Trip
                //print("From Station id = \(legList.originDetail)")
                let testCollectionMArray = NSMutableArray()
                
                testCollectionMArray.add(tripCustom.LegList.firstObject)

                //MARK: Collection View Cell Background Image
                
//                let View=UIView()
//                View.backgroundColor=UIColor(patternImage:UIImage(named:"LegBorderStart.png")!)
//        
//                cell.backgroundView = View
        //print("cell size = \()")
                
                let x = cell.from_time.frame.size.width
                let y = cell.from_time.frame.origin.y
                
                let startingPoint = CGPoint(x: x,y: y)
                // let startingPoint = CGPoint(x: 35.0,y: -130.0)
                let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
                let orientation = "x"  // x, y, or xy
                let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
                let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
                let sizeFactor = CGSize(width: 0.0,height: 0.0)
                   // line color and line number ?
               // cell.line_number.text = tripCustom.chg
                
                print("-------------Section = \(indexPath.section) & Row = \(indexPath.row)")

                print("tripCustom.leglist.count = \(tripCustom.LegList.count)")
                let leg = tripCustom.LegList.firstObject as! Leg
                print("test 1")
               
                print("-Section = \(indexPath.section)--R=\(indexPath.row)--------key name is ==== \(keyNameTemp)")
                
                print("String(leg.line) = \(leg.line)")
                print("------------key name is ==== \(keyNameTemp)")
                
                //let some = Int(cell.from_time.frame.size.width)
                
                cell.to_time.frame.origin.x = cell.from_time.frame.size.width + startingSize.width + startingSize.width
                
                
              //  SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                
                SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: testCollectionMArray, collectionViewCell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                
                
                //cell.line_number.text = String(leg.line)
                print("test 2")
                cell.from_time.text = leg.origin.time
                cell.to_time.text = leg.destination.time
                
                //cell.from_time.setTitle(leg.origin.time, for: .normal)
                print("test 3")
                //cell.to_time.setTitle(leg.destination.time, for: .normal)
                print("test 4")
//                cell.from_time.setTitle(tripCustom.originDetail.time, for: .normal)
      }
            else {
            
            print("nothing.....in collection num itms")
            }
        
            
            print("-----end--------Section = \(indexPath.section) & Row = \(indexPath.row)")
    
            
        }
        
        
//        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            
//            
//    
//            // Use collectionViewFlowLayout
//            
//        }
        
        collectionView.setNeedsLayout()
        
//        collectionView.set
        
        print("---collectionView.collectionViewLayout.collectionViewContentSize.width\(collectionView.collectionViewLayout.collectionViewContentSize.width)")
        
      //  cell.legLineNo.setTitle("11", for: .normal)
      // cell.legImage.backgroundColor = UIColor.yellow
       // cell.contentView.frame.size.width = 10.0
        
        print("collectionView.frame.width = \(collectionView.frame.width)")
        
        
        print("collectionView.frame.width = \(collectionView.frame.width)")
        

        print("collectionView.intrinsicContentSize = \(collectionView.intrinsicContentSize)")
        
        
        print("collectionView.contentSize.width = \(collectionView.contentSize.width)")
        
        
        print("collectionView.contentSize.width = \(collectionView.contentSize.width)")
        
        
        print("in collection view number of items in section---cell--\(indexPath.row)--")
        return cell
        
    }
    
    
    /*
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.contentView.backgroundColor = UIColor.blue
        
     //   let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 120))
        
        
        //CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
//        CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(origin: CGPoint(x:0,y:10), size: CGSize(width: self.view.frame.width,height: 120)))
       
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
            
       // whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOffset = CGSize(width:-1,height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        print("size of white rounder is = \(whiteRoundedView.frame.width) : \(whiteRoundedView.frame.height)")
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    */

    
    @available(iOS 6.0, *)
    
 
 
 //MARK: Seems to be OLD 23rd dec: file compare checked.-----SWITCH OFF IT
 
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
//        let tripCell = newTrip[section] as! Trip
//        
//        print("Trip Cell (Number of items in section--\(tripCell.LegList.count)")
//        return tripCell.LegList.count
//    

        var number = 0
        
        if (custom_Trip_NextDepartures_Dict.count > 0){
        
            
            let currentSection = String(section)
            
            //let currentRow = String(indexPath.row)
            
            let view = collectionView.superview!
            let currentCell = view.superview as! LegListCells
            let keyNameTemp = currentCell.keyName
           print("cell.tag current = \(currentCell.tag)")
            print("keyname temp from current cell = \(keyNameTemp)")
            
           // let keyName = currentSection + currentRow
            print("key name temp = \(keyNameTemp)")
            print("num sections customtrip next departures total count = \(custom_Trip_NextDepartures_Dict.count)")
            
            print("num sections -customtrip next departures total count = \(custom_Trip_NextDepartures_Dict.allKeys)")
            
//           if let collection_Values_flag = RealTidMethods.checkIfKeyExists(objectToCheck: custom_Trip_NextDepartures_Dict, keyName: keyNameTemp)
//            
          //  if (collection_Values_flag == true){
            if let customDepTrip = custom_Trip_NextDepartures_Dict[keyNameTemp] {
                let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                print("customDepTripArray Count = \(customDepTripArray.count)")
                
              number = customDepTripArray.count
                
                //  return customDepTripArray.count
            }
            
        }
        
        print("custom_Trip_NextDepartures_Dict = count = \(custom_Trip_NextDepartures_Dict.count)")
        print("Section for collection view count = \(section) ")
        print("Count for collection view count = \(number) ")
        
        return number
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //-----------------------------------SECTION HANDLING--------------------------------------------start--------
        print("Start in cell for row at = \(indexPath)")
        // section handling
        var currentSection = 0
        
        if (currentSection == indexPath.section){
        
    print("Current Section is equal to indexpath.seection = \(currentSection) && \(indexPath.section)")
            
        }
        else if (currentSection != indexPath.section){
            
            // if session is new then counter reset
            // reset it for every new section.....
            print("New Section is being printed....Resetting all values....................")
            
        currentSection = indexPath.section
            departureCounter = 0
            showDeparture = false
          }
                // show departure reset
        
        //-----------------------------------SECTION HANDLING--------------------------------------------start--------
        
        ////MARK: Master Trip Dic--------------------Get Value Master Dict (For Current Section)-------------------start--------
        
        // get the value from master dict
        // Get value for current section
        // you will receive a dict of all values for rows within section
        
        let currentTripInfoDepartCellStatus = nextDepartureMasterDict.value(forKey: String(indexPath.section)) as! NSMutableDictionary
        
        // it should have values for all trip info cells 
        // count of keys shuold be equal to trip info cells within current section
        print("currentTripInfoDepartureCell Status = allKeys =\(currentTripInfoDepartCellStatus.allKeys)")
        
        // get value for current Row
        print("indexPath Row = \(indexPath.row)")
        print("indexPath Section = \(indexPath.startIndex)")
        let valueDepartureCurrentRow = currentTripInfoDepartCellStatus.value(forKey: String(indexPath.row)) as! Int
        print("value departure current row = == \(valueDepartureCurrentRow)")
        
        // if value is 0 then show departure set true
        if (valueDepartureCurrentRow == 1){
            showDeparture = true
            departureCounter += 1
            
            print("Current Value Departure Counter === \(departureCounter)")
            print("Current Value of Departure Status == \(showDeparture)")
        }
        
        //-----------------------------------Get Value Master Dict (For Current Section)-------------------end--------
        
        //-----------------------------------show normal cell / show departure cel if true-----------start--------
      print("Show Departure Last Value ===== \(showDeparture)")
        if (showDeparture == true){
            
            // copy paste departure code......
            
             print("cell departure must be printed now.......1..")
        //    departureCounter += 1
            
            let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
            
            print("cell departure must be printed now......2...")
            
            showDeparture = false
            
            return cellDeparture
            
            
        }
        
        //if (showDeparture == false) {
        
            
        
            
            
        // show normal cells......BECAUSE Show Departure should be false
        print("SHOW DEPARTURE IS FALSE = \(showDeparture)")
            
        print("in printing normal cells ,current indexpath.row = \(indexPath.row) && departureCounter = \(departureCounter)")
        
        let currentIndex = indexPath.row - departureCounter
        print("IndexPath.Row = \(indexPath.row)")
        print("Calculated Current Index = \(currentIndex)")
        
            // copy paste code for normal cell......
            
            // ----------------------------------NORMAL CELL......................-----------START------
            let legList = newTrip[indexPath.section] as! Trip
            let test = NSMutableArray()
            var count = legList.LegList.count
            
            print("indexPath.row = \(indexPath.row) && Total count is = \(count)")
            //
            //        if (indexPath.row <= count){
            //
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
            cell.backgroundColor = UIColor.white
            print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
            
            //MARK:BorderTripInfo
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = cellBorderWidth
            
            //headerCell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderColor = UIColor.lightGray.cgColor
            tableView.backgroundColor = UIColor.lightGray
            //
            //
            //        let border = CALayer()
            //        let width = CGFloat(15.0)
            //        border.borderColor = UIColor.darkGray.cgColor
            //        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
            //
            //        border.borderWidth = width
            //        tableView.layer.addSublayer(border)
            //        tableView.layer.masksToBounds = true
            
            
            /*
             cell.layer.borderWidth = 10.0
             cell.layer.borderColor = UIColor.green.cgColor
             
             */
            
            cell.tag = indexPath.row
            cell.nextDeparturesOutlet.tag = indexPath.row
            
            cell.sectionInfo = String(indexPath.section)
            cell.rowInfo = String(indexPath.row)
            
            cell.keyName = cell.sectionInfo + cell.rowInfo
            
            print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
            cell.name.isHidden = true
            //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
            cell.towards_or_walk.isHidden = true
            
            // MARK# Collection View
            // MARK: cell
            
            //MARK: CollectionView temp off
        
         //   cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
            
            // 3
            // Configure the cell...
            // MARK: Move to collection 1
            
            print("From Station id = \(legList.originDetail)")
            
            test.add(legList.LegList[indexPath.row])
            let startingPoint = CGPoint(x: 35.0,y: 30.0)
            // let startingPoint = CGPoint(x: 35.0,y: -130.0)
            let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
            let orientation = "x"  // x, y, or xy
            let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
            let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
            let sizeFactor = CGSize(width: 0.0,height: 0.0)
            // MARK: Move to collection 1 ---end
            // ------------setting Leg Images---------START
            print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
            count = count - 1
            print("--Row = \(indexPath.row)----count = \(count)")
            let leg = legList.LegList[indexPath.row] as! Leg
            
            cell.legImage.image = UIImage(named: leg.legImageName)
            // MARK: Leg
            print("cell for row  at index ===\(indexPath)-------------------------")
            print("leg image name ==\(leg.legImageName)")
            print("leg.line ==\(leg.line)")
            print("leg.dir ==\(leg.dir)")
            print("leg.journeyType ==\(leg.journeyType)")
            print("leg.name ==\(leg.name)")
            print("leg.origin ==\(leg.origin)")
            // legList.originDetail.name
            //----#1-----#2------------------------ Origin Station....Leg
            cell.from_station.text = leg.origin.name
            print("cell.from_station.text::::\(cell.from_station.text)")
            // temp cell.from_time.text = legList.originDetail.time
            cell.from_time.text = leg.origin.time
            // MARK: RTU Message Cell Level
            if (leg.rtu_Message_Flag == true){
                print("cell:: RTU Message ::::")
                print(leg.rtu_Message)
                cell.rtuMessage.isHidden = false
                cell.rtuMessage.text = leg.rtu_Message
                cell.rtuMessage.textColor = UIColor.red
            } else {
                cell.rtuMessage.isHidden = true
            }
            // cell.transportTypeOutlet.text = leg.origin.type
            //        if (leg.dir != "Default"){
            //        cell.towards_or_walk.text = leg.dir
            //        }
            cell.towards_or_walk.text = ""
            print("cell.towards_or_walk.text  :\(leg.dir)")
            
            // set root map reference
            // set root map geometry reference
            
            print("------090--------- cell.from_time.text--989=")
            print(cell.to_time.text)
            
            print("printing indexpath.row = in cell Level \(indexPath.row)")
            print("current Geom Ref is = \(leg.geomRef)")
            
            print("current Geom Ref is journeyDetailRef...........= \(leg.journeyDetailRef)")
            
            //-----#3------Visual Leg
            
            print(test.count)
            // MARK: Move to collection 2
            
            SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
            print("startingPoint_101001----\(startingPoint)")
            //----#4------
            cell.name.text = ""//leg.name
            
            //----#4.5------
            //----#5------line/dist
            cell.transportTypeOutlet.text = leg.journeyType
            cell.transportTypeOutlet.isHidden = true
            
            
            print("--212----journey type is =\(leg.journeyType)")
            print("--dist---- =\(leg.dist)")
            print("--Line--- =\(leg.line)")
            
            print("-leg.dir--- =\(leg.dir)")
            var line_dist = String()
            var helpingWord = String()
            print("leg.journey Type..... = \(leg.journeyType)")
            if (leg.journeyType == "WALK"){
                
                print("switching off walk cell to be touched..........")
                cell.isUserInteractionEnabled = false
                
                //        cell.multipleTouchEnabled = false
                
                
            }
            
            if (leg.journeyType == "WALK"){
                line_dist = leg.name + " "+leg.dist + " Meters"
                // helpingWord = "Meters"
            }
            else if (leg.journeyType != "WALK")
            {
                line_dist =   leg.name + " Towards " + leg.dir
                //            helpingWord = "Towards"
                
            }
            else {
                line_dist = "--??---"
                helpingWord = "?????"
                
            }
            cell.line_dist.text = line_dist
            print("line_dist ::__:::\(line_dist)")
            //    cell.towards_or_walk.text = helpingWord
            
            //        cell.legImage.image = UIImage(named: "firstLeg.png")
            //        print("----image value is--\(cell.legImage)")
            //        cell.legImage.image = UIImage(named: "lastLeg.png")
            
            
            
            
            
            //-----#6-----#7------------------------ Destination Station....Leg
            cell.to_station.text = leg.destination.name
            cell.to_time.text = leg.destination.time
            // cell.transportTypeOutlet.text = leg.destination.type
            
            print("------090---------cell.to_time.text--989=")
            print(cell.to_time.text)
            
            
            print("------090---------cell.to_time.text--989=")
            print(cell.to_time.text)
            
            
            return cell
            
            // ----------------------------------NORMAL CELL......................-----------END------
            
            

            
     //   }
        
        // if show departure == true
        
            // departure cell print
        
        // else if show departure is false 
                // print normal cells
 
   //            }
//        else {
//        
//
//        
//        }
    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    // MARK: Height of row
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleHeader = "SLife:" + String(section)
        return titleHeader
    }
    
     override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let headerCellTemp = tableView.viewWithTag(section) as!TripSuggestionsCell_new
//        
//        print("HeaderCellTemp tag value is = \(headerCellTemp.tag)")
//        
//print("TableView Subview Counts = \(tableView.subviews.count)")
        
        //let headerCellTemp = tableView.subviews[section]. as! TripSuggestionsCell_new
        
  //              print("HeaderCellTemp tag value is = \(headerCellTemp.tag)")
        
            let tripCell = newTrip[section] as! Trip
            print("heightForHeaderInSection...........\(section).")
            print(legIconsLineCounter)
            print(tripCell.LegList.count)
            var lineCount = (tripCell.LegList.count*2) / legIconsLineTerminateCount
        
        let remainder = (tripCell.LegList.count*2) % legIconsLineTerminateCount
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        
        
        print("Line count is  = \(lineCount)")
        print("remainder is (header) \(remainder) ")
        if (remainder != 0){
            lineCount+=1
                print("total line count is =inside heighForHeader==for section \(section)==is=\(lineCount)")
            
        }
        
        let icon_Count_Total = tripCell.LegList.count
        let screenWidth = UIScreen.main.bounds.width
       
        print("heightForHeaderInSection-----section  = \(section)")
        let total_icon_lines = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(60.0 + 10.0))
       // print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
       
        
        //MARK: Header Height Section
        print("header height : : SECTION = \(section) total icon lines = \(total_icon_lines)")
        let headerCellTotalHeight = (Int(legIconsHeight) * total_icon_lines.lineCount) + headerCellHeight
        print("headerCellTotalHeight = \(headerCellTotalHeight)")
        print("legIconsHeight = \(legIconsHeight)")
        print("lineCount = \(lineCount)")
        print("CGFloat::\(headerCellTotalHeight)")
        
        //heightFixed = true
       // var icon_Count_Total = tripCell.LegList.count
       // var lineTest = SlifeMethods.lineCountsToDisplayIcons(availableWidth: UIScreen.main.bounds.width, iconsCount: icon_Count_Total, iconWidth: CGFloat(20.0))
       // print("line Test is = \(lineTest)")
//        var icon_counts = SlifeMethods.iconCountsToDisplayIcons(availableWidth: UIScreen.main.bounds.width, iconsCount: icon_Count_Total, iconWidth: CGFloat(20.0))
      //  print("icon counts total = \(icon_counts)")
        
        
        print("headerHeightDict==== \(headerHeightDict.allKeys)")
        // -----------header height cell testing
//        let defaultBottomSpaceLeave = 15.0
//        let defaultTopSpaceLeave = 15.0
//        let defaultStackViewBottomSpaceBeforeIconLeave = 10

        
        let headerHeightCalculation = headerCell_StackView_Height + (total_icon_lines.lineCount * Int(default_startingSize.height))
        
        // -----------header height cell testing end
        
        print(".---------------------------------------------------Height Calculation HeaderCEll---.")
        print("total ICon Lines = \(total_icon_lines)")
        print("DefaultBottomSpace Leave = \(defaultBottomSpaceLeave)")
        print("(total_icon_lines * defaultBottomSpaceLeave) = \(defaultBottomSpaceLeave)")
        print("HeaderCell_StackViewHeight = \(headerCell_StackView_Height)")
        
        print("Returning with HeaderCell Trip Suggestion Height = \(headerHeightCalculation)")
        print(".-----------------------------------------------------.")
        return CGFloat(headerHeightCalculation)
        
       // temp check on above headerheightcalculation return CGFloat(headerCellTotalHeight)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCells") as! TripSuggestionsCell_new
   
        headerCell.tag = section
        print("header cell tag = \(headerCell.tag)")
        let stackView = headerCell.viewWithTag(10)
        print("stackView?.frame.height StackView Height = \(stackView?.frame.height)")
        //MARK: Header Cell Selected Check
        
//    check for count of dict
//        check for null value if value not found then ?
//        if null then set value as false ?
//        or just if null  or false returned then set white

        
        let headerSelectionFlagNull = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        
        
        print("header selection flag null = \(headerSelectionFlagNull)")
        
        
        if (headerSelectionFlagNull.contains("null") || headerSelectionFlagNull.contains("false")){
            headerCell.backgroundColor = headerRowDefaultColor
        print("null or false is here .... \(headerSelectionFlagNull)")
        
        }
        else if (headerSelectionFlagNull.contains("true")){
        headerCell.backgroundColor = headerRowSelectedColor
            
            print("True is here .... \(headerSelectionFlagNull)")
        }
        
        
        //MARK: TripSuggestionBorder 
        //MARK: Corner Radius
        /*
        headerCell.layer.cornerRadius = 6 //set corner radius here
        headerCell.layer.borderColor = UIColor.lightGray.cgColor  // set cell border color here
        headerCell.layer.borderWidth = 2 // set border width here
        */
        //MARK: HeaderRowColor
     //   headerCell.backgroundColor = headerRowSelectedColor
        //___________________________
        headerCell.layer.masksToBounds = true
        headerCell.layer.borderWidth = headerBorderWidth
//        headerCell.layer.borderColor = UIColor.gray.cgColor
        headerCell.layer.borderColor = UIColor.lightGray.cgColor
        

//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)

        
        print(tableView.rowHeight)
        headerCell.sectionSelected.tag = section
        // MARK: ShowTripDetail_Dict
        
//        print("before setting dict values..................")
//        showTripDetail_Dict.setValue(false, forKey: String(section))
        
        print("tableView.frame.size.height ........")
        print(tableView.frame.size.height)
        print("headerCell.frame.size.height ........")
        print(headerCell.frame.size.height)
        print("--heADER CELL BUTTON ID-")
        print(headerCell.sectionSelected)
        //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
       // headerCell.backgroundColor = UIColor.blue
        print("cell-header cell---\(headerCell)")
        
        let head = newTrip[section] as! Trip
    
        print("-In Sections--[Sections]=\(section)--)")
        print(".....head.count is \(head.dur)")

         //print(".....head.count is \()")
        print("-----section # \(section)")
        
        //      label.text = data[indexPath.row]
        
        // function getLabel(cell: dequeReusable as ! tripSugg,current index: int, legListPictorialSummary: some array)
        
        //        drawLeg()
        // try to run a for loop as all info is inside tripcell.
        
        let xy = CGPoint(x: 10.0,y: 0.0)
        let size = CGSize(width:10,height:10)
        
        let spacingFloat = CGPoint(x: size.width,y: size.height )
        
        
        //  let tripCell = trips[indexPath.row]
        //let tripCell = newTrip[indexPath.row]
        
        let tripCell = newTrip[section] as! Trip
        
        //drawLeg(xy, size: size, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, indexPath: <#T##NSIndexPath#>, orientation: <#T##Character#>, spacingFactor: <#T##Float#>)
         //  let startingPoint = CGPoint(x: 5.0,y: 2.0)
        
        let legIcons_y = headerCell.viewWithTag(10)?.frame.size.height
        
        // old starting vlaue of y is = 100
        
        print("y positions is ==== \(legIcons_y)")
        var startingPoint = CGPoint(x: 5.0,y: (legIcons_y! + 20.0))
        let startingSize = default_startingSize // CGSize(width:30.0,height:30.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = CGPoint(x:-1,y:0)
        let innerLegSpacing = CGPoint(x:10,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        // MARK: Draw Leg Icons
        print("tripCell.LegList.Count ==== \(tripCell.LegList.count)")
        print("headerCell.contentView.Frame:::::\(headerCell.contentView.frame)")
        var iconLegLine = 0
        legIconsLineCounter = 0
        var y = 0
        var line = 1
        var column = 1
        var icon_Count_Total = tripCell.LegList.count
        var screenWidth = UIScreen.main.bounds.width
        // MARK: Leg Image width required
        let iconLimits = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(70.0))
        print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
         // MARK: Line Termination
        /*
        for index in tripCell.LegList {
            
            iconLegLine += 1
            
                if(iconLegLine == iconLimits.iconCount){
                    
                    // if(iconLegLine == legIconsLineTerminateCount){
                    legIconsLineCounter += 1
                    print("legIconsLineCounter = \(legIconsLineCounter) for section : \(section)")
                    startingPoint.x = 5.0
                    startingPoint.y += 30.0
                    iconLegLine = 0
                    print("Update ::: New Line:::: Line = \(line) column = \(column)")
                    line += 1
                    column = 1
                    
                    //tableView.reloadData()
                }
                    
                else if (y != 0){
                    
                    
                    print("Update ::: New Column::Line = \(line) column = \(column)")
                    startingPoint.x+=60.0
                    column += 1
                }
            
            let ns = NSMutableArray()
            ns.add(tripCell.LegList[y])
            print("leglist to print = \(ns.count)")
            SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: default_startingSize, legs: ns , cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
            y += 1
            
        }
        */
        
        var iconLiveCount = 1
        var iconLineLiveCount = 0
        var increment = 0
        // move this to above
        let legIconTopSpace = 10.0
        var defaultPositionToStart =  CGPoint(x: 5.0,y: (legIcons_y! + 10.0))
        let iconVerticalSpaceFactor = 2.0
        
        let iconHorizontalSpaceFactor = 2.0
        
        for index in tripCell.LegList {
        print("Top:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
            
        // change to next line if icon printing limit has reached
            if (iconLiveCount == iconLimits.iconCount){
                print("if:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                
            iconLiveCount = 1
            iconLineLiveCount += 1
            startingPoint.x = defaultPositionToStart.x
            startingPoint.y += startingSize.height //+ iconVerticalSpaceFactor
            
            
            }
            
            else if (increment != 0) {
                print("Else:iconLiveCount= \(iconLiveCount) && iconLimits.IconCount = \(iconLimits.iconCount)")
                
            startingPoint.x += startingSize.width +  startingSize.width //+ iconHorizontalSpaceFactor
            iconLiveCount += 1
            
            
            }
            // keep printing icons
            
            
            let ns = NSMutableArray()
            ns.add(tripCell.LegList[increment])
            print("leglist to print = \(ns.count)")
            SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: default_startingSize, legs: ns , cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
            increment += 1

        
        
        }
        
        
        
        // create header cell height dict bank
        
        // add section as key
        
        // calculate height by 
     
        var heightHeaderCalculation = 20 + Int((headerCell.viewWithTag(10)?.frame.height)!) + (line * 30)
        headerHeightDict.setValue(heightHeaderCalculation, forKey: String(section))
        print("headerheight5dict has value of header cell = \(heightHeaderCalculation)")
        //MARK: header cell section line column
        print("HeaderCell:View: Section = \(section) Line : \(line) Column: \(column)")
        print("------from station = \(tripCell.originDetail.name)")
        print("------from time = \(tripCell.originDetail.time)")
        
        print("------to station = \(tripCell.destinationDetail.name)")
        print("---12341---to time = \(tripCell.destinationDetail.time)")
        
        headerCell.from_station.text = tripCell.originDetail.name
        headerCell.from_time.text = tripCell.originDetail.time
        headerCell.to_station.text = tripCell.destinationDetail.name
        headerCell.to_time.text = tripCell.destinationDetail.time
        headerCell.duration.text = tripCell.dur
        print(tripCell.originDetail.name)
        print(tripCell.originDetail.type)
        print(tripCell.originDetail.id)
        // MARK: Zone & Price Info
        
        var tariffZones_text = String()
        var tariffRemarks_price = String()
        
        if (tripCell.tariffZones.contains("Not")){
        tariffZones_text = "SL"
        
        
        } else {
        
        tariffZones_text = tripCell.tariffZones
            
        }
        if (tripCell.tariffRemark.contains("remarks")){
            
            tariffRemarks_price = "SL"
            
        } else {
            
            tariffRemarks_price = tripCell.tariffRemark
        }
        
        headerCell.ZoneInfo.text = tariffZones_text
        headerCell.PriceInfo.text = tariffRemarks_price
        // MARK: ZoneInfo Hide
        //MARK: TariffiInfo Hide
        headerCell.ZoneInfo.isHidden = true
        headerCell.PriceInfo.isHidden = true
        
        print("tripcell.duration is =)")
        // MARK: MapReference
        let leg =  tripCell.LegList[0] as! Leg
        headerCell.mapReference.tag = section + 1
        headerCell.mapReference.accessibilityIdentifier = leg.journeyDetailRef
        headerCell.mapReference.isHidden = true
        headerCell.showTripRouteOnMapOutlet.tag = section + 1
        headerCell.showTripRouteOnMapOutlet.accessibilityIdentifier = leg.journeyDetailRef
        let mapReferenceKey = section + 1
        rootMap_Ref_Dict.setValue(leg.journeyDetailRef, forKey: String(mapReferenceKey))
        // MARK: AutoLayout
        
        let evenOrNot = even(number: section)
        
        if (evenOrNot){
            
        // headerCell.backgroundColor = UIColor.lightGray
        }
        
        print("section::::::header:::\(section)")
        
        
        
        return headerCell
    }
    
    func even(number: Int) -> Bool {
        // Return true if number is evenly divisible by 2.
        return number % 2 == 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

               if (segue.identifier == "intermediateStops"){
            
                let selectedLegCell = sender as! LegListCells
                print("selected Leg Cell ===== \(selectedLegCell.transportTypeOutlet.text)")
            print("transportType Flag in prepare for segue == \(transportTypeFlag)")
            
            if (selectedLegCell.transportTypeOutlet.text != "WALK"){
            let vc = segue.destination as! IntermediateStopsViewController
        
           //  vc.setValue(selectedLegJourneyDetailedRef, forKey: "JourneyDetailedReference")
          print("selectedLegJourneyDetailedRef = \(setJourneyDetailedReference)")
            //segue.destinationViewController.setValue(selectedLegJourneyDetailedRef, forKey: "JourneyDetailedReference")
            
            } else {
            
                setJourneyDetailedReference = ""
            transportTypeFlag = "WALK"
            
            }
        
        
        }
        else if (segue.identifier == "TripMap")
        {
            
            tripRootMapFlag = true
        
            
        }
    }

//    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCells") as! HeaderCells
//        headerCell.backgroundColor = UIColor.cyanColor()
//        
//        let head = newTrip[section] as! Trip
//        
//        
//        
//         print("-In Sections--[Sections]=\(section)--)")
//        print(".....head.count is \(head.dur)")
//        print("-----section # \(section)")
////        headerCell.from_time.text = head[section] as! String
//        headerCell.from_time.text = head.destinationDetail.name
//     //   switch (section) {
//        
//            
//            
////        case 0:
////            headerCell.from_time.text = head[section] as! String//"Europe";
////        //return sectionHeaderView
////        case 1:
////            headerCell.from_time.text = head[section] as! String //"Asia";
////        //return sectionHeaderView
////        case 2:
////            headerCell.from_time.text = head[section] as! String //"South America";
////        case 3:
////            headerCell.from_time.text = head[section] as! String //"South America";
////        case 4:
////            headerCell.from_time.text = head[section] as! String //"South America";
////        //return sectionHeaderView
////        default:
////            headerCell.from_time.text = "Other";
////        }
//        
//        return headerCell
//    }
//    
//    
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
//        footerView.backgroundColor = UIColor.blackColor()
//        
//        return footerView
//    }
//    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//    
    
    
    
}



//-------------
/*
 //
 //  TableViewController.swift
 //  headerSectionTableView
 //
 //  Created by syed farrukh Qamar on 25/04/16.
 //  Copyright © 2016 Be My Competence AB. All rights reserved.
 //
 
 import UIKit
 
 class TripSuggestionsTViewController: UITableViewController {
 
 
 // DataSource for Trips
 
 var countriesinEurope = ["Trip[0]","Trip[1]","Trip[3]","Trip[4]","Trip[5]"]
 var countriesinAsia = ["LL-0-1","LL-0-2","India","fourth","fifth","sixth"]
 var countriesInSouthAmerica = ["Argentia","Brasil","Chile"]
 var fourthRow = ["4th-Argentia","4th-Brasil","4th-Chile"]
 var fifthRow = ["5th---Argentia","5th---Brasil","5th---Chile"]
 
 //    var countriesinEurope = ["France","Spain","Germany"]
 //    var countriesinAsia = ["Japan","China","India"]
 //    var countriesInSouthAmerica = ["Argentia","Brasil","Chile","Chile","Chile","Chile","Chile","Chile","ninth"]
 //    var fourthRow = ["4th-Argentia","4th-Brasil","4th-Chile"]
 //    var fifthRow = ["5th---Argentia","5th---Brasil","5th---Chile"]
 //
 
 
 var s = NSMutableArray()
 
 override func viewDidLoad() {
 super.viewDidLoad()
 s.addObject(countriesinEurope)
 s.addObject(countriesinAsia)
 s.addObject(countriesInSouthAmerica)
 s.addObject(fourthRow)
 s.addObject(fifthRow)
 
 
 print("first objecty is = \(s[0].firstIndex))")
 
 for objects in s {
 
 let o = objects as! NSArray
 print("test=  \(o[0])")
 tableView.reloadData()
 }
 
 }
 
 override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 // 1
 // Return the number of sections.
 print("section count is = \(s.count)")
 return s.count
 }
 
 override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // 2
 print("Section # Is = \(section)")
 
 print("s[section].Rows are = \(s[section].count)")
 return s[section].count
 }
 
 
 override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TripSuggestionsCell_new
 
 print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
 print("s[section].Rows are = \(s[indexPath.section].count)")
 // 3
 // Configure the cell...
 let cellValue = s[indexPath.section] as! NSArray
 //        cell.from_time.text = cellValue[indexPath.row] as! String
 
 cell.from_time.text = String(indexPath.row)
 
 //        switch (indexPath.section) {
 //        case 0:
 //            cell.from_time?.text = countriesinEurope[indexPath.row]
 //        case 1:
 //            cell.from_time?.text = countriesinAsia[indexPath.row]
 //        case 2:
 //            cell.from_time?.text = countriesInSouthAmerica[indexPath.row]
 //        case 3:
 //            cell.from_time?.text = fourthRow[indexPath.row]
 //        case 4:
 //            cell.from_time?.text = fifthRow[indexPath.row]
 //        //return sectionHeaderView
 //        default:
 //            cell.textLabel?.text = "Other"
 //        }
 
 return cell
 }
 
 
 
 override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCells") as! HeaderCells
 headerCell.backgroundColor = UIColor.cyanColor()
 
 let head = s[0] as! NSArray
 print("-In Sections--[Sections]=\(section)--)")
 print(".....head.count is \(head.count)")
 print("-----section # \(section)")
 //        headerCell.from_time.text = head[section] as! String
 headerCell.from_time.text = String(section)
 
 //   switch (section) {
 
 
 
 //        case 0:
 //            headerCell.from_time.text = head[section] as! String//"Europe";
 //        //return sectionHeaderView
 //        case 1:
 //            headerCell.from_time.text = head[section] as! String //"Asia";
 //        //return sectionHeaderView
 //        case 2:
 //            headerCell.from_time.text = head[section] as! String //"South America";
 //        case 3:
 //            headerCell.from_time.text = head[section] as! String //"South America";
 //        case 4:
 //            headerCell.from_time.text = head[section] as! String //"South America";
 //        //return sectionHeaderView
 //        default:
 //            headerCell.from_time.text = "Other";
 //        }
 
 return headerCell
 }
 
 
 //    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
 //        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
 //        footerView.backgroundColor = UIColor.blackColor()
 //
 //        return footerView
 //    }
 //
 //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
 //        return 40.0
 //    }
 //
 
 
 
 }
*/
 */ // temp commented end 9th nov 2016 end

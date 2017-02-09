//
//  TripInfoTableViewController.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-19.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit
//
//  TableViewController.swift
//  headerSectionTableView
//
//  Created by syed farrukh Qamar on 25/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.

import UIKit
import QuartzCore
/*
var watchIcons = false
// MARK: variables for trip info departures
let NEXT = "NEXT"
let PREVIOUS = "PREVIOUS"
var navigationDeparturesTripInfo = ""
var TRIP = "TRIP"
let TRIPINFO = "TRIPINFO"
var lastCountTripsHeaderCells = 0
var lastCountTripInfoDepartureCells = 0
// current section index calculation for cells at section , because header 0 & last cell is for navigation
 // var currentSectionIndex = 0
var  previousTripClickedFlag = false
var nextTripClickedFlag = false

var bounce = 0
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
let cellBorderWidth = CGFloat(1)
let collectionBorderWidth = CGFloat(0.5)

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
let iconSelectedColor = UIColor(red: (191/255), green: (239/255), blue: (191/255), alpha: 1.0)
let cellBackgroundColor = UIColor(red: (235/255), green: (236/255), blue: (237/255), alpha: 1.0)
// MARK: Color Enabled/Disabled
let enabledColor = UIColor(red: (218/255), green: (242/255), blue: (218/255), alpha: 1.0)
let  defaultColor = UIColor(red: (244/255), green: (157/255), blue: (164/255), alpha: 1.0)
//let disabledColor = UIColor(red: (203/255), green: (247/255), blue: (203/255), alpha: 1.0)
let disabledColor = UIColor(red: (244/255), green: (206/255), blue: (211/255), alpha: 1.0)

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
REDECLARED   */
// Switching off 23rd dec 0835 HRS Morning-------------START

// Switching off 23rd dec 0700 HRS Morning-------------START
var showTripIndexOnTripInfo = Int()
var tripselected = String()
 class TripInfoTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var toolHeaderCellCount = 1
    var showHideDepartureToolBar = true
    var depValueUpdated = false // reset it when the grabDepartureButton is Clicked.
    
    var fromLegIndex_clicked = Int()
    var toLegIndex_clicked = Int()  // for one leg, both values shuold be same
    var tripToShow = Trip()
    var tripSection = Int()
    var genericTripFlag = false
    var currentTripScope = NSMutableArray()
    var nextDepartureRemainingLegStatusDict = NSMutableDictionary()
    @IBAction func backToTripInfo(_ sender: UIButton) {
        
        
        if (genericTripFlag == false ){
       print("Line 116:False: Button Back Pressed:\(genericTripFlag)")
        // current index=?
        let currentLegRow = sender.superview?.superview as! LegTripNextDeparturesTableViewCell
        // change status to true within the range
        let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        var i = 0
        for index in currentLeg.nextDeparturesTrip {
        
            // for single leg
            // Revert Back
            if (currentLeg.departureAvailable == true && currentLeg.legIndex == i){
            
            currentLeg.nextDeparturesTrip.removeAll()
                currentLeg.departureAvailable = false

                currentLeg.depScope_fromLegIndex = 0
                currentLeg.depScope_toLegIndex = 0
                currentLegRow.nextDeparturesCollectionView.reloadData()
            }
         i += 1
        }
        }
        else if (genericTripFlag == true){
        print("Line 139: Button Back Pressed:\(genericTripFlag)")
            UIView.animate(withDuration: 0.25, animations: {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
            });
        }
    }
    func getNextDeparturesTripInfo(sender: UIButton,tableViewCurrent: UITableView){
        
        print("NEXT:getNext Dep Pressed: Line 2991")
        print("NEXT:Get PreviousDeparturesTripInfo..........")
        print("NEXT:nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview)")
        print("NEXT:nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview?.superview)")
        
        // let currentCollectionCell = sender.superview?.superview as! TripInfoCollectionViewCell
        // let currentCollectionView = currentCollectionCell.superview as! UICollectionView
        //        let currentLegRow = sender.superview?.superview?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell
        let currentLegRow = sender.superview?.superview as!
        LegTripNextDeparturesTableViewCell
        print("\(currentLegRow.indexPathSelected.row)")
        //  let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        
        // currentLegRow.backgroundColor = UIColor.red
        //  currentCollectionCell.from_station.text = currentCollectionCell.sectionInfo + currentCollectionCell.rowInfo
        // Step 1: get All the Values
        // 1-section info, 2 - row Info
        
        // Step 2: call the function and send values
        let customTripClass = CustomTripMethods()
        
        // get the last trip from departures and get it's time
         print("NEXT:about to call webservice ..before...tripSection=\(tripSection).\(currentLegRow.currentIndexPathSection) & \(currentLegRow.tag):\(currentLegRow.keyName):\(currentLegRow.legIndexForDepartureShow) & IP=\(currentLegRow.indexPathSelected)")
        let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
      
        
        currentLeg.depScope_fromLegIndex = currentLegRow.indexPathSelected.row
        currentLeg.depScope_toLegIndex = currentLegRow.indexPathSelected.row
        let lastTripOfDepartures = currentLeg.nextDeparturesTrip.last
        let tripFromTime_Dep = lastTripOfDepartures?.originDetail.time
        print("Line144:tripFromTime_Dep:\(tripFromTime_Dep)")
        
        simple_earliestDepartLatestArrival_flag = true
        // value 1 is bringing based on arrival
        simple_earliestDepartLatestArrival_Value = 0
        
        //let lastObjectIndex = collectionTripObject.count - 1
        
        //  let lastObject = collectionTripObject[lastObjectIndex] as! Trip
        simple_expectedTripDate = (lastTripOfDepartures?.originDetail.date)!
        simple_expectedTripTime = (lastTripOfDepartures?.originDetail.time)!
        
        customTripClass.get_data_from_url(currentCollectionView: currentLegRow.nextDeparturesCollectionView, from: currentLeg.origin.name, to: currentLeg.destination.name, tableView: tableView, headerSectionId: String(tripSection), legRow_id_from: String(currentLegRow.indexPathSelected.row),fromTime: tripFromTime_Dep!,legRowID_To: String(currentLegRow.indexPathSelected.row),previousOrNextFlag: NEXT_DEP,fromDate_Dep: currentLeg.origin.date,fromTime_Dep: currentLeg.origin.time)
        
        print("about to call webservice ..after....NEXT:")
        

        /*
         let currentDepartureCell = sender.superview?.superview as! LegTripNextDeparturesTableViewCell
         print("Current DepartureCell : \(currentDepartureCell)")
         
         //scrollView.viewWithTag(55)?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell //LegTripNextDeparturesTableViewCell
         print("previous::Cell.Current:Cell.....987::\(currentDepartureCell.currentIndexPathSection) ---- \(currentDepartureCell.currentIndexPathRow)")
         let keyName = String(currentDepartureCell.currentIndexPathSection) + String(currentDepartureCell.currentIndexPathRow)
         
         let collectionTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
         print("collection trip object count = \(collectionTripObject.count)")
         
         print("previous::Cell.Current Key Name = \(currentDepartureCell.keyName)")
         print("previous::custom trip object count = \(custom_Trip_NextDepartures_Dict.allKeys) && keyname = \(keyName)")
         print("previous::current Departure Cell = \(currentDepartureCell.keyName)")
         navigationDeparturesTripInfo = NEXT
         if ( custom_Trip_NextDepartures_Dict.value(forKey: keyName) != nil ){
         lastCountTripInfoDepartureCells = collectionTripObject.count
         let firstObject = collectionTripObject.firstObject as! Trip
         // arrive latest by first object's origin.time
         simple_earliestDepartLatestArrival_flag = true
         // value 1 is bringing based on arrival
         simple_earliestDepartLatestArrival_Value = 0
         
         let lastObjectIndex = collectionTripObject.count - 1
         
         let lastObject = collectionTripObject[lastObjectIndex] as! Trip
         simple_expectedTripDate = lastObject.originDetail.date
         simple_expectedTripTime = lastObject.originDetail.time
         
         print("next From station = \(lastObject.originDetail.name)")
         print("next time = \(lastObject.originDetail.time)")
         print("next to station = \(lastObject.destinationDetail.name)")
         print("next From Station :: To Station:: = \(keyName)")
         getNextDeparturesForCollection(fromStation: lastObject.originDetail.name,toStation: lastObject.destinationDetail.name, fromTime: lastObject.originDetail.time, tableView: tableViewCurrent, keyName: keyName,navigationType: navigationDeparturesTripInfo)
         }
         */
    }
    
    func getPreviousDeparturesTripInfo(sender: UIButton,tableViewCurrent: UITableView){
        
        print("PREVIOUS:Get PreviousDeparturesTripInfo..........")
        print("PREVIOUS:nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview)")
        print("PREVIOUS:nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview?.superview)")
        
       // let currentCollectionCell = sender.superview?.superview as! TripInfoCollectionViewCell
       // let currentCollectionView = currentCollectionCell.superview as! UICollectionView
//        let currentLegRow = sender.superview?.superview?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell
        let currentLegRow = sender.superview?.superview as!
        LegTripNextDeparturesTableViewCell
        print("\(currentLegRow.indexPathSelected.row)")
      //  let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        
        // currentLegRow.backgroundColor = UIColor.red
        //  currentCollectionCell.from_station.text = currentCollectionCell.sectionInfo + currentCollectionCell.rowInfo
        // Step 1: get All the Values
        // 1-section info, 2 - row Info
        
        // Step 2: call the function and send values
        let customTripClass = CustomTripMethods()
      
        print("PREVIOUS:about to call webservice ..before...tripSection=\(tripSection).\(currentLegRow.currentIndexPathSection) & \(currentLegRow.tag):\(currentLegRow.keyName):\(currentLegRow.legIndexForDepartureShow) & IP=\(currentLegRow.indexPathSelected)")
        let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        currentLeg.depScope_fromLegIndex = currentLegRow.indexPathSelected.row
        currentLeg.depScope_toLegIndex = currentLegRow.indexPathSelected.row
        
        customTripClass.get_data_from_url(currentCollectionView: currentLegRow.nextDeparturesCollectionView, from: currentLeg.origin.name, to: currentLeg.destination.name, tableView: tableView, headerSectionId: String(tripSection), legRow_id_from: String(currentLegRow.indexPathSelected.row),fromTime: currentLeg.origin.time,legRowID_To: String(currentLegRow.indexPathSelected.row),previousOrNextFlag: PREVIOUS_DEP,fromDate_Dep: currentLeg.origin.date,fromTime_Dep:  currentLeg.origin.date)
        
        print("PREVIOUS:about to call webservice ..after....")
        
        /*
         let currentDepartureCell = sender.superview?.superview as! LegTripNextDeparturesTableViewCell
         print("Current DepartureCell : \(currentDepartureCell)")
         
         //scrollView.viewWithTag(55)?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell //LegTripNextDeparturesTableViewCell
         print("previous::Cell.Current:Cell.....987::\(currentDepartureCell.currentIndexPathSection) ---- \(currentDepartureCell.currentIndexPathRow)")
         let keyName = String(currentDepartureCell.currentIndexPathSection) + String(currentDepartureCell.currentIndexPathRow)
         
         let collectionTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
         print("collection trip object count = \(collectionTripObject.count)")
         
         print("previous::Cell.Current Key Name = \(currentDepartureCell.keyName)")
         print("previous::custom trip object count = \(custom_Trip_NextDepartures_Dict.allKeys) && keyname = \(keyName)")
         print("previous::current Departure Cell = \(currentDepartureCell.keyName)")
         navigationDeparturesTripInfo = PREVIOUS
         
         if ( custom_Trip_NextDepartures_Dict.value(forKey: keyName) != nil ){
         lastCountTripInfoDepartureCells = collectionTripObject.count
         let firstObject = collectionTripObject.firstObject as! Trip
         // arrive latest by first object's origin.time
         simple_earliestDepartLatestArrival_flag = true
         // value 1 is bringing based on arrival
         simple_earliestDepartLatestArrival_Value = 1
         simple_expectedTripDate = firstObject.originDetail.date
         simple_expectedTripTime = firstObject.originDetail.time
         print("PREVIOUS:From station = \(firstObject.originDetail.name)")
         print("PREVIOUS:from time = \(firstObject.originDetail.time)")
         print("PREVIOUS:to station = \(firstObject.destinationDetail.name)")
         print("PREVIOUS:From Station :: To Station:: = \(keyName)")
         getNextDeparturesForCollection(fromStation: firstObject.originDetail.name,toStation: firstObject.destinationDetail.name, fromTime: firstObject.originDetail.time, tableView: tableViewCurrent, keyName: keyName,navigationType: navigationDeparturesTripInfo)
         
         }
         */
        /*
         if ( custom_Trip_NextDepartures_Dict.value(forKey: keyName) != nil ){
         
         let collectionTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
         
         print("collection trip object count = \(collectionTripObject.count)")
         
         if (xMovement > 0){
         navigationDeparturesTripInfo = PREVIOUS
         
         if (navigationDeparturesTripInfo.contains(PREVIOUS))
         {
         
         
         let firstObject = collectionTripObject.firstObject as! Trip
         // arrive latest by first object's origin.time
         simple_earliestDepartLatestArrival_flag = true
         // value 1 is bringing based on arrival
         simple_earliestDepartLatestArrival_Value = 1
         simple_expectedTripDate = firstObject.originDetail.date
         simple_expectedTripTime = firstObject.originDetail.time
         print("PREVIOUS:From station = \(firstObject.originDetail.name)")
         print("PREVIOUS:from time = \(firstObject.originDetail.time)")
         print("PREVIOUS:to station = \(firstObject.destinationDetail.name)")
         print("PREVIOUS:From Station :: To Station:: = \(keyName)")
         getNextDeparturesForCollection(fromStation: firstObject.originDetail.name,toStation: firstObject.destinationDetail.name, fromTime: firstObject.originDetail.time, tableView: tableView, keyName: keyName,navigationType: navigationDeparturesTripInfo)
         }
         } else {
         //   navigation = PREVIOUS
         // ONCE NEXT IS WORKING THEN WORK ON THIS
         
         }*/
        
        
        
    }
    @IBAction func nextDepartureTillDestination_Action(_ sender: UIButton) {
        
        print("nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview)")
        print("nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview?.superview)")
        
        let currentCollectionCell = sender.superview?.superview as! TripInfoCollectionViewCell
        let currentCollectionView = currentCollectionCell.superview as! UICollectionView
        let currentLegRow = sender.superview?.superview?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell
        let clickedLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        let lastLeg = (newTrip[tripSection] as! Trip).LegList.lastObject as! Leg
        let legList = (newTrip[tripSection] as! Trip).LegList as! NSMutableArray
       print("Line326:\(currentLegRow.indexPathSelected.row)")
        print("Line326:\(legList.count)")
        let lastLegIndex = legList.count - 1
        clickedLeg.depScope_fromLegIndex = clickedLeg.legIndex  //currentLegRow.indexPathSelected.row
        clickedLeg.depScope_toLegIndex = lastLeg.legIndex       //lastLeg.legIndex
        print("Line331: ClickedLeg:DepScope_FromLegInd:\( clickedLeg.depScope_fromLegIndex)")
        print("Line331: ClickedLeg:DepScope_ToLegInd:\( clickedLeg.depScope_toLegIndex)")
        
        var i = 0
        // Switch off all legs if they fall between next dep from and to index scope.
        
        for index in legList {
        var currentLeg = (newTrip[tripSection] as! Trip).LegList[i] as! Leg
            // Default value is True: Means show
            // false means hide them.
            //------
            if (currentLeg.legIndex == i){
            
            
            }
            
            
            //---
            if (clickedLeg.depScope_fromLegIndex == i){
                // The First Leg should nt be hidden
            //currentLeg.showHideLeg = true
          //  currentLeg.depScope_fromLegIndex = i
            } else if ((currentLeg.legIndex > clickedLeg.depScope_fromLegIndex ) && (currentLeg.legIndex < clickedLeg.depScope_toLegIndex))
            {
                currentLeg.showHideLeg = true
 
            } else if (clickedLeg.depScope_toLegIndex == i){
            
                currentLeg.showHideLeg = true
                
            //    currentLeg.depScope_toLegIndex = i
            
            }
            print("Line356: CL:Leg Ind:\(currentLeg.legIndex): i = \(i)")
            
            print("Line356:CL:SH=i=:From_id:\(currentLeg.depScope_fromLegIndex):TO:\(currentLeg.depScope_toLegIndex):\(i):\(currentLeg.showHideLeg) ")
        i+=1
        }
        print("Line111:CurrentLegRow:\(clickedLeg.origin.name)")
        print("Line111:CurrentLegRow:\(lastLeg.destination.name)")
        
        //let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        

        
        //  currentCollectionCell.from_station.text = currentCollectionCell.sectionInfo + currentCollectionCell.rowInfo
        // Step 1: get All the Values
        // 1-section info, 2 - row Info
        
        // Step 2: call the function and send values
        let customTripClass = CustomTripMethods()
        print("about to call webservice ..before...tripSection=\(tripSection).\(currentLegRow.currentIndexPathSection) & \(currentLegRow.tag):\(currentLegRow.keyName):\(currentLegRow.legIndexForDepartureShow) & IP=\(currentLegRow.indexPathSelected)")
        
        customTripClass.get_data_from_url(currentCollectionView:currentCollectionView, from: clickedLeg.origin.name, to: lastLeg.destination.name, tableView: tableView, headerSectionId: String(tripSection), legRow_id_from: String(currentLegRow.indexPathSelected.row),fromTime: clickedLeg.origin.time,legRowID_To: String(clickedLeg.depScope_toLegIndex),previousOrNextFlag: NEXT_DEP,fromDate_Dep: clickedLeg.origin.date,fromTime_Dep: clickedLeg.origin.time)
        
        print("about to call webservice ..after....")
    }
    
    @IBAction func nextDepartureCL_Action(_ sender: UIButton) {
        print("nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview)")
        print("nextDepartureCL_Action:PRESSED: \(sender.superview?.superview?.superview?.superview?.superview)")
        
        let currentCollectionCell = sender.superview?.superview as! TripInfoCollectionViewCell
       let currentCollectionView = currentCollectionCell.superview as! UICollectionView
        let currentLegRow = sender.superview?.superview?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell
       // currentLegRow.backgroundColor = UIColor.red
      //  currentCollectionCell.from_station.text = currentCollectionCell.sectionInfo + currentCollectionCell.rowInfo
        // Step 1: get All the Values
            // 1-section info, 2 - row Info
        
        // Step 2: call the function and send values
        let customTripClass = CustomTripMethods()
        print("about to call webservice ..before...tripSection=\(tripSection).\(currentLegRow.currentIndexPathSection) & \(currentLegRow.tag):\(currentLegRow.keyName):\(currentLegRow.legIndexForDepartureShow) & IP=\(currentLegRow.indexPathSelected)")
        let currentLeg = (newTrip[tripSection] as! Trip).LegList[currentLegRow.indexPathSelected.row] as! Leg
        currentLeg.depScope_fromLegIndex = currentLegRow.indexPathSelected.row
        currentLeg.depScope_toLegIndex = currentLegRow.indexPathSelected.row
        
        customTripClass.get_data_from_url(currentCollectionView:currentCollectionView, from: currentCollectionCell.from_station.text!, to: currentCollectionCell.to_station.text!, tableView: tableView, headerSectionId: String(tripSection), legRow_id_from: String(currentLegRow.indexPathSelected.row),fromTime: currentCollectionCell.from_time.text!,legRowID_To: String(currentLegRow.indexPathSelected.row),previousOrNextFlag: CURRENTLEG_DEP,fromDate_Dep: "" ,fromTime_Dep: "" )
        
        print("about to call webservice ..after....")
    }
    
    @IBAction func currentLegDeparturesAction(_ sender: UIButton)
        {
            /*
 if(watchIcons == false){
                
                //    watchIcons = true
                
            }
 */
            
       print("Clicked................")
            var clicked = false
                 let button = sender as! UIButton
            let view = button.superview!
            //  button.backgroundColor = UIColor.yellow
            //MARK: Departure temp off 9th nov 8pm
            // get values from the departure button clicked (from its super view)
            
            let currentCell = view.superview as! TripInfoTableViewCell
            let departureCellIndex = Int(currentCell.rowInfo)! + 1
            // check if the key exist to check if the cell is opened or not
            print("Button Tag = \(sender.tag)")
            print("Line:1046:BeforenextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
            
            if let valueExistDepartCellStatus = nextDepartureRemainingLegStatusDict.value(forKey: currentCell.keyName) as? Bool
            {
                // just  change status to show for the current cell
                print("valueExistDepartCellStatus: \(valueExistDepartCellStatus)")
                // if value is false: then it is not funcitonal for now
                if (valueExistDepartCellStatus == false){
                  //  currentCell.showHideDepartureCell_Master = true
                    // MARK: Next Departure isSelected
                    //                  currentCell.nextDeparturesOutlet.isSelected = true
                    // already shown now hide it
                    print("ValueExistDepartCellStatus:False....")
                    currentCell.showHideDepartureCell_Master = true
                    //   currentCell.showHide_Departures = true
                } else if (valueExistDepartCellStatus == true){
                    // currentCell.showHide_Departures = false
                  currentCell.showHideDepartureCell_Master = false
                    //                currentCell.nextDeparturesOutlet.isSelected = false
                    //
                    //                currentCell.nextDeparturesOutlet.setTitle("N", for: UIControlState.normal)
                    //                  currentCell.nextDeparturesOutlet.isSelected = false
                    print("ValueExistDepartCellStatus:True....")
                    // remove the departure cell values as well as the dict key
                    
                    print("Line:1072:BeforenextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
                    print("Line:1072:Before:newTrip.Leglist Count:\((newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.count)")
                    
                    nextDepartureRemainingLegStatusDict.removeObject(forKey: currentCell.keyName)
                    (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.removeObject(at: departureCellIndex)
                    print("Line:1072:After:newTrip.Leglist Count:\((newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.count)")
                    
                    print("Line:1072:After:nextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
                    
                }
                
            } else {
                // load values and add key as true
                print("Not Loaded Before: about to load now:")
                //    currentCell.nextDeparturesOutlet.isSelected = true
             currentCell.showHideDepartureCell_Master = true
                //            currentCell.nextDeparturesOutlet.isSelected = true
                //
                //            currentCell.nextDeparturesOutlet.setTitle("S", for: UIControlState.selected)
                //
                //currentCell.showHide_Departures = true
                nextDepartureRemainingLegStatusDict.setValue(true, forKey: currentCell.keyName)
                let customTripClass = CustomTripMethods()
                print("about to call webservice ......")
                
                customTripClass.get_data_from_url(currentCollectionView: UICollectionView() ,from: currentCell.from_station.text!, to: currentCell.to_station.text!, tableView: tableView, headerSectionId: currentCell.sectionInfo, legRow_id_from: String((Int(currentCell.rowInfo)! + 1)),fromTime: currentCell.from_time.text!,legRowID_To:  String((Int(currentCell.rowInfo)! + 1)),previousOrNextFlag: CURRENTLEG_DEP,fromDate_Dep: "", fromTime_Dep: "")
                //MARK: EXTRA
                // insert into newtrip
                print("Custom Trip Next Departure dict status = \(custom_Trip_NextDepartures_Dict.count)")
                //            if (custom_Trip_NextDepartures_Dict.count != 0)
                //            {
                // MARK: replace it later with collection dict
                
                let newDepartureObject = TripInfoDepartures()
                print("Adding in new trip ........")
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(newDepartureObject, at: departureCellIndex)
            }
            
            print("All keys in:nextDepartureRemainingLegStatusDict:S:\(currentCell.sectionInfo):R:\(currentCell.rowInfo):\(nextDepartureRemainingLegStatusDict) ")
            
            tableView.reloadData()
            
        }
        
    
    //@IBOutlet weak var currentLegDepartures: UIButton!

    //--------All Global Variables have been moved to class level.-----start here 20th jan 0830
    
    
    //--------All Global Variables have been moved to class level.-----start here 20th jan 0830
    
    func tripHeaderSelector(gestureRecognizer: UIGestureRecognizer) {
        let selectedTripHeaderCell = gestureRecognizer.view as! TripSuggestionsCell_new
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "TripDetailsWithNextDeparture", bundle:nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        print("------S2--------")
        
        print("-Trip Header Cell Clicked-----S2--------")
        let vc = storyboard?.instantiateViewController(withIdentifier: "TripDetailsWithNextDeparture")
        
        print("--Trip Header Cell Clicked-----S3--------")
        
//    vc?.setValue(0, forKey: "currentSelectedTripIndex")
        let currentTrip = newTrip[0] as! Trip

      //  vc?.setValue(currentTrip, forKey: "selectedTrip")
        self.present(vc!, animated: true, completion: nil)
        
        
      //  print("Trip Header clicked & values have been sent \(gestureRecognizer.view)")
        //do your stuff here
    }
    
  /* Temp 20th Jan
    @IBAction func getNextTrips(_ sender: UIBarButtonItem) {
        print("BRING NEXT TRIPS........lastCountTripHeader=\(newTrip.count)..")
        nextTripClickedFlag = true
        lastCountTripsHeaderCells = newTrip.count
    //masterNextTripGrabberFromSL()
    }

    @IBAction func getPreviousTrips(_ sender: UIBarButtonItem) {
       // remove the previous trips before loading?
        // check previous trips
        // check net trips......
        
        lastCountTripsHeaderCells = newTrip.count
        
        print("BRING PREVIOUS TRIPS.......lastCountTripHeader=\(newTrip.count)..")

      // MARK: 20th jan temp  masterPreviousTripGrabberFromSL()
    }
    // Mark: 23rd dec 1800-changed clicked to  showClickedTransportType
    @IBAction func refresh_previous_trips(_ sender: UIButton) {
        print("Refresh Previous Trips::::::Has been CLiecked")
    }
    //MARK: Old?
    @IBAction func refresh_next_trips(_ sender: Any) {
    print("Refresh next trips have been cliecked...depriciated.")
    }
*/
    //                showClickedLine
    
   // MArk:  Trip Suggestion (Icon Filters Towards Trip Info
    func showClickedTransportType(sender: UIButton) {
        
    let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
    let legIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 3)
    //currentCell.setNeedsDisplay()
    // breakdown clicked icon's tag into current section,Current Row(i.e. leg index.
    let clickedButtonStringTag = String(sender.tag)
        let transpTypeIconButton = sender
        let transportTypeToFilter = transpTypeIconButton.accessibilityIdentifier
        
   // let lineIcon = currentCell.viewWithTag(sender.tag + 1)
  //  print("Line Icon accessibility identifier = \(lineIcon?.accessibilityIdentifier)")
    
//    let indexInChar = clickedButtonStringTag.characters
    
    let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
    
    print("Clicked.  Sender Tag = \(sender.tag) & Section = \(currentCell.tag) & Curremnt Leg = \(legIndex)")
    print("Current Accessibility identifier = \(sender.accessibilityIdentifier)")
    
    let currentLeg = currentHeaderTrip.LegList[Int(String(legIndex))!]  as! Leg
    // check if leg.show is true then change to false
   
    // check if icon was clicked before 
    
    if (currentLeg.enabled_TransportType == false){
    currentLeg.enabled_TransportType = true
    currentLeg.showHideLeg = true
        
        let leglists = currentHeaderTrip.LegList as! NSMutableArray
        var i = 0
        let legIndexInt = Int(String(legIndex))
        
        print("---clicked icon-----------if -----------------------------start = \(leglists.count)")
        for index in leglists {
           // check if the leg is trip departure or a leg
            // when the trip departures next are clicked then they are being added at the end of the current leglist as trip info departures
            if let legIteratingLeg = leglists[i] as? Leg {
            // if (currentLeg.type == legIterating.type)
            let legIterating = leglists[i] as! Leg
            print("if---current index -incrementing-----i \(i)::::Clicked Index = \(legIndex)")
            print("CURRENTLEG.enabled_TransportType \(currentLeg.enabled_TransportType)::::Clicked Index Current Leg = \(currentLeg.showHideLeg)")
            print("Before:::LEGITERATING \(legIterating.enabled_TransportType)=legIterating.showHideLeg = \(legIterating.showHideLeg)")
            print("LEGITERATING.line \(legIterating.line)")
            if (legIterating.enabled_TransportType == true){
                //legIterating.showHideLeg = true
            }
            else {
                legIterating.showHideLeg = false
            }
                if (legIteratingLeg.type.contains(transportTypeToFilter!) || (legIteratingLeg.line.contains(transportTypeToFilter!)))
                {
                
                    legIterating.showHideLeg = true
                    
                
                
                } else {
                
                    legIterating.showHideLeg = false
                    
                
                
                }
                
            print("if AFTER:::LEGITERATING \(legIterating.enabled_TransportType)=legIterating.showHideLeg = \(legIterating.showHideLeg)-----i\(i)")
                  i += 1
            } else {
            
            print("Trip departures or other obje found in function icon clicked trip info")
            }
        }
    }
        // false means not enabled before thus show only current or same and hide rest
    else if (currentLeg.enabled_TransportType == true) {
        currentLeg.enabled_TransportType = false
       
        
        
        
       // currentLeg.showHideLeg = true
        
        let leglists = currentHeaderTrip.LegList as! NSMutableArray
        var i = 0
        print("--------------else if -----------------------------start")
        var checkEnabledCountTypeIcon = 0
        for index in leglists {
            
            if let legIteratingLeg = leglists[i] as? Leg {
            let legIterating = leglists[i] as! Leg
            // if (currentLeg.type == legIterating.type)
            print("Else---current index -incrementing-----i \(i)::::Clicked Index = \(legIndex)")
            
            print("Else CURRENTLEG.enabled_TransportType \(currentLeg.enabled_TransportType)::::Clicked Index Current Leg = \(currentLeg.showHideLeg)")
            
            print("Else Before:::LEGITERATING \(legIterating.enabled_TransportType)=legIterating.showHideLeg = \(legIterating.showHideLeg)")
            
            print("Else LEGITERATING.line \(legIterating.line)")
            
            
            if (legIterating.enabled_TransportType == true){
                //legIterating.showHideLeg = true
                checkEnabledCountTypeIcon += 1
                
                print("Enabled count type icon === \(checkEnabledCountTypeIcon)")
            }
                /* 1230 24th dec
            else {
                legIterating.showHideLeg = true
            } */
            
            print("else AFTER:::LEGITERATING \(legIterating.enabled_TransportType)=legIterating.showHideLeg = \(legIterating.showHideLeg)-----i\(i)")
            
           i += 1
            } else {
            
            print("Trip Departures have been found or other object in else , clicked function icon ")
            }
        }
        
        // if enabled count is 0 then show all
        if (checkEnabledCountTypeIcon != 0){
        
        currentLeg.showHideLeg = false
        
        } else if (checkEnabledCountTypeIcon == 0){
            
       // enable all iterate and enable
            // -------------enable all 24th dec 1230---------------start
         // reset i 
            i = 0
            for index in leglists {
                if let legIteratingLeg = leglists[i] as? Leg {
                let legIterating = leglists[i] as! Leg
                // if (currentLeg.type == legIterating.type)
              legIterating.showHideLeg = true 
                i += 1
                } else {
                
                
                print("Leg not found , other object . TripInfoDepartures may be found")
                }
            }
            
            // ------------------enable show cells all ---------------end
        }
        
        // if enabled count is 1 then hide current
        
        print("--------------else if -----------------------------end")
        
        }
    print("Current Leg Show Hide Bool Value  == in icon clicked function = \(currentLeg.showHideLeg)")
    
    print("-----legCounts = \(currentHeaderTrip.LegList.count)")
    print("-----Leg at index 0  =LINE:  \(currentLeg.line)")
    print("---Leg At index 0 = Tye: \(currentLeg.type)")
    // set value for show hide cell
    print("Sender's tag is = \(sender.tag)")
    print("Current tag of header cell when button clicked s = \(currentCell.tag)")
    print("showClickedTransportType:Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
    
    tableView.reloadData()
    
      }
    // MArk:  Trip Suggestion (Icon Filters Towards Trip Info
    func showClickedLegOrLineFilter(sender: UIButton) {
        let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
        let legIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 3)
        let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
        let currentLeg = currentHeaderTrip.LegList[Int(String(legIndex))!]  as! Leg
        let buttonIdentifierIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 4)
        let clickedButton = sender
        let centralAccessibilityIdenitifier = clickedButton.accessibilityIdentifier
    
        // check if the clicked button is enabled 
        // first check if button is leg icon , then check enabled or disabled, and chaneg the values accordingly
        // then check if it is line button
        if (String(buttonIdentifierIndex).contains("0")){
        // Button is Type Icon
        // check if enabled , if yes then  disable it
            
            if (currentLeg.enabled_TransportType == true){
            currentLeg.enabled_TransportType = false
            
           
            } else {
            currentLeg.enabled_TransportType = true
            currentLeg.enabled_LineNumber = false
                
                currentLeg.clickLevel = TRIP
            }
            // check if enabled , if yes then  disable it
        } else if (String(buttonIdentifierIndex).contains("1")){
        // Button is Line Icon
            
            
            if (currentLeg.enabled_LineNumber == true){
                currentLeg.enabled_LineNumber = false
               
                
            } else {
                currentLeg.enabled_LineNumber = true
                currentLeg.enabled_TransportType = false
                 currentLeg.clickLevel = TRIP
            }
        
        
        }
        print("checking :... sender tag = \(sender.tag)")
        print("button identier = \(buttonIdentifierIndex)")
        
        
        // iterate through current leglist and change the values accordingly 
        
        let leglists = currentHeaderTrip.LegList as! NSMutableArray
        var i = 0
        let legIndexInt = Int(String(legIndex))
        
        print("currentLeg.enabled_TransportType-----\(currentLeg.enabled_TransportType) & \(currentLeg.enabled_LineNumber)")
        if ((currentLeg.enabled_LineNumber == true || currentLeg.enabled_TransportType == true)){
            
            print("inside main check \(currentLeg.enabled_TransportType) && \(currentLeg.enabled_LineNumber) & current count leglist = \(currentHeaderTrip.LegList.count)")
            // value is being changed above
            // now check against central accessibility identifier
            
            print("---clicked icon-----------if -----------------------------start = \(leglists.count)")
            for index in currentHeaderTrip.LegList {
                
                
                // check if the leg is trip departure or a leg
                // when the trip departures next are clicked then they are being added at the end of the current leglist as trip info departures
             print("current index inside is = \(i)")
                if let legIteratingLeg = currentHeaderTrip.LegList[i] as? Leg {
                
                    print("LegIterating ---type = \(legIteratingLeg.type) Line = \(legIteratingLeg.line) ")
                    print("Before Current Show Hide value = \(legIteratingLeg.showHideLeg)")
                    if (legIteratingLeg.type.contains(centralAccessibilityIdenitifier!) || legIteratingLeg.line.contains(centralAccessibilityIdenitifier!)){
                    // show this filtered cel
                        print("True : setting show hide true for legiteratingLeg.type = \(legIteratingLeg.type) & LegIteratingLeg.Line = \(legIteratingLeg.line)")
                    legIteratingLeg.showHideLeg = true
                    legIteratingLeg.clickLevel = TRIP
                    } else {
                        
                        print("False: setting show hide true for legiteratingLeg.type = \(legIteratingLeg.type) & LegIteratingLeg.Line = \(legIteratingLeg.line)")
                        
                    // hide this filtered cell
                    
                        legIteratingLeg.showHideLeg  = false
                    }
                    
                    print("After Current Show Hide value = \(legIteratingLeg.showHideLeg)")
                    
                }
            i += 1
            }
           
        } else {
        
        // show all of the cells
            i = 0
            for index in leglists {
                
                // check if the leg is trip departure or a leg
                // when the trip departures next are clicked then they are being added at the end of the current leglist as trip info departures
                if let legIteratingLeg = leglists[i] as? Leg {
                    legIteratingLeg.showHideLeg = true
                    legIteratingLeg.clickLevel = ""
                }
             i += 1
            }
            
        }
        //currentCell.setNeedsDisplay()
        
        // breakdown clicked icon's tag into current section,Current Row(i.e. leg index.
        let clickedButtonStringTag = String(sender.tag)
        let lineIcon = currentCell.viewWithTag(sender.tag + 1)
        print("Line Icon accessibility identifier = \(lineIcon?.accessibilityIdentifier)")
        
        //    let indexInChar = clickedButtonStringTag.characters
        
       
        print("Clicked.  Sender Tag = \(sender.tag) & Section = \(currentCell.tag) & Curremnt Leg = \(legIndex)")
        print("Current Accessibility identifier = \(sender.accessibilityIdentifier)")
        // check if leg.show is true then change to false
        
        // check if icon was clicked before
        /* 28TH DEC 0952 OFF
        if (currentLeg.enabled_LineNumber == false){
            currentLeg.enabled_LineNumber = true
            currentLeg.showHideLeg = true
            
            let leglists = currentHeaderTrip.LegList as! NSMutableArray
            var i = 0
            let legIndexInt = Int(String(legIndex))
            
            print("---clicked icon-----------if -----------------------------start = \(leglists.count)")
            for index in leglists {
                
                
                // check if the leg is trip departure or a leg
                // when the trip departures next are clicked then they are being added at the end of the current leglist as trip info departures
                if let legIteratingLeg = leglists[i] as? Leg {
                    // if (currentLeg.type == legIterating.type)
                    let legIterating = leglists[i] as! Leg
                    
                    print("if---current index -incrementing-----i \(i)::::Clicked Index = \(legIndex)")
                    
                    print("CURRENTLEG.enabled_TransportType \(currentLeg.enabled_LineNumber)::::Clicked Index Current Leg = \(currentLeg.showHideLeg)")
                    
                    print("Before:::LEGITERATING \(legIterating.enabled_LineNumber)=legIterating.showHideLeg = \(legIterating.showHideLeg)")
                    
                    print("LEGITERATING.line \(legIterating.line)")
                    if (legIterating.enabled_LineNumber == true){
                        //legIterating.showHideLeg = true
                        
                    }
                    else {
                        legIterating.showHideLeg = false
                    }
                    
                    print("if AFTER:::LEGITERATING \(legIterating.enabled_LineNumber)=legIterating.showHideLeg = \(legIterating.showHideLeg)-----i\(i)")
                    i += 1
                } else {
                    
                    print("Trip departures or other obje found in function icon clicked trip info")
                }
            }
        }
 
            // false means not enabled before thus show only current or same and hide rest
        else if (currentLeg.enabled_LineNumber == true) {
            currentLeg.enabled_LineNumber = false
            
            
            
            
            // currentLeg.showHideLeg = true
            
            let leglists = currentHeaderTrip.LegList as! NSMutableArray
            var i = 0
            print("--------------else if -----------------------------start")
            var checkEnabledCountLine = 0
            for index in leglists {
                
                if let legIteratingLeg = leglists[i] as? Leg {
                    let legIterating = leglists[i] as! Leg
                    // if (currentLeg.type == legIterating.type)
                    print("Else---current index -incrementing-----i \(i)::::Clicked Index = \(legIndex)")
                    
                    print("Else CURRENTLEG.enabled_TransportType \(currentLeg.enabled_LineNumber)::::Clicked Index Current Leg = \(currentLeg.showHideLeg)")
                    
                    print("Else Before:::LEGITERATING \(legIterating.enabled_LineNumber)=legIterating.showHideLeg = \(legIterating.showHideLeg)")
                    
                    print("Else LEGITERATING.line \(legIterating.line)")
                    
                    
                    if (legIterating.enabled_LineNumber == true){
                        //legIterating.showHideLeg = true
                        checkEnabledCountLine += 1
                        
                        print("Enabled count type icon === \(checkEnabledCountLine)")
                    }
                    /* 1230 24th dec
                     else {
                     legIterating.showHideLeg = true
                     } */
                    
                    print("else AFTER:::LEGITERATING \(legIterating.enabled_LineNumber)=legIterating.showHideLeg = \(legIterating.showHideLeg)-----i\(i)")
                    
                    i += 1
                } else {
                    
                    print("Trip Departures have been found or other object in else , clicked function icon ")
                }
            }
            
            // if enabled count is 0 then show all
            if (checkEnabledCountLine != 0){
                
                currentLeg.showHideLeg = false
                
            } else if (checkEnabledCountLine == 0){
                
                // enable all iterate and enable
                // -------------enable all 24th dec 1230---------------start
                // reset i
                i = 0
                for index in leglists {
                    if let legIteratingLeg = leglists[i] as? Leg {
                        let legIterating = leglists[i] as! Leg
                        // if (currentLeg.type == legIterating.type)
                        legIterating.showHideLeg = true
                        i += 1
                    } else {
                        
                        
                        print("Leg not found , other object . TripInfoDepartures may be found")
                    }
                }
                
                // ------------------enable show cells all ---------------end
            }
            
            // if enabled count is 1 then hide current
            
            print("--------------else if -----------------------------end")
            
        }
    28TH DEC 0952
          */
        print("Current Leg Show Hide Bool Value  == in icon clicked function = \(currentLeg.showHideLeg)")
        
        print("-----legCounts = \(currentHeaderTrip.LegList.count)")
        print("-----Leg at index 0  =LINE:  \(currentLeg.line)")
        print("---Leg At index 0 = Tye: \(currentLeg.type)")
        // set value for show hide cell
        print("Sender's tag is = \(sender.tag)")
        print("Current tag of header cell when button clicked s = \(currentCell.tag)")
        print("showClickedTransportType:Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
        
        tableView.reloadData()
        
    }
   
    func showClickedTransportTypeOrLineInNextDepartures(sender: UIButton) {
        print("TripInfo Button Clicked -.......\(sender.tag).....")
        
        
        
        let currentCell = (sender.superview)?.superview as! TripInfoTableViewCell
        let legSectionIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 2)
        
        let legIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 3)
        print("Clicked button section & Row = \(legSectionIndex) && \(legIndex)")
        
        let legList = newTrip[Int(String(legSectionIndex))!] as! Trip
        
        let leg = legList.LegList[Int(String(legIndex))!] as! Leg
        
        // extract the last index of the tag
        // always check that the tag must be 4 digits
        let iconTypeIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 4)
        let clickedButton = sender
        let centralAccessibilityIdentier = clickedButton.accessibilityIdentifier
        
        // check if pressed button is transport type or line
        // if 0 then type and if line then it must be 1
        
        print("Before :: Current Value for icon clicked = Enabled TransportType = \(leg.enabled_TransportType) & LineEnabled  = \(leg.enabled_LineNumber) & last index = \(String(iconTypeIndex))")
        print("Accessbility Identier pressed value = \(centralAccessibilityIdentier) & \(String(iconTypeIndex))")
        if (String(iconTypeIndex).contains("0")){
        // leg icon is pressed
            print("Transport type icon is pressed........")
            // now check if it is already enabled or not
            if (leg.enabled_TransportType == true){
            leg.enabled_TransportType = false
            
          
                
            } else {
                leg.enabled_TransportType = true
                leg.enabled_LineNumber = false
                leg.clickLevel = TRIPINFO
            }
            
            
        
        
        } else if (String(iconTypeIndex).contains("1")){
        // line number found
            
            print("Line type icon is pressed........")
            
            
            // now check if it is already enabled or not
            if (leg.enabled_LineNumber == true){
                leg.enabled_LineNumber = false
                
                

                
            } else {
                leg.enabled_LineNumber = true
                leg.enabled_TransportType = false
                leg.clickLevel = TRIPINFO

            }
            
        
        }
        
        print("After:: Current Value for icon clicked = Enabled TransportType = \(leg.enabled_TransportType) & LineEnabled  = \(leg.enabled_LineNumber)")
        // if type is pressed then enable disable accoringly
    
        
        
        /* 28th dec 1215
        if (leg.filterDepartures == false){
            leg.filterDepartures = true
            print("Leg.filter Departures == TRUE NOW....")
        } else {
            leg.filterDepartures = false
            
            print("Leg.filter Departures == FALSE NOW....")
            
            
            
        } */
        
        tableView.reloadData()
        
    }
     
    func showClickedTransportTypeInNextDepartures(sender: UIButton) {
        print("Trip Info Button Clicked -............")
        
        
        
        let currentCell = (sender.superview)?.superview as! TripInfoTableViewCell
        let legSectionIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 2)
        
        let legIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 3)
        print("Clicked button section & Row = \(legSectionIndex) && \(legIndex)")
        
        
        
        
        let legList = newTrip[Int(String(legSectionIndex))!] as! Trip
        
        let leg = legList.LegList[Int(String(legIndex))!] as! Leg
        
        if (leg.filterDepartures == false){
        leg.filterDepartures = true
        print("Leg.filter Departures == TRUE NOW....")
        } else {
            leg.filterDepartures = false
            
            print("Leg.filter Departures == FALSE NOW....")
            
        
        
        }
   
        tableView.reloadData()
        
           }
    /* 24th dec 1100
    func showClickedLine(sender: UIButton) {
        
        print("SHOW CLICKED Line....tag pressed = \(sender.tag).")
        
        
        let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
        let legIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 3)
        print("Returned leg index is = \(legIndex)")
        // breakdown clicked icon's tag into current section,Current Row(i.e. leg index.
        let clickedButtonStringTag = String(sender.tag)
        //    let indexInChar = clickedButtonStringTag.characters
        
        let currentLegTripInfo = newTrip[currentCell.tag] as! Trip
        
        print("Clicked.  Sender Tag = \(sender.tag) & Section = \(currentCell.tag) & Curremnt Leg = \(legIndex)")
        print("Current Accessibility identifier = \(sender.accessibilityIdentifier)")
        
        let currentLeg = currentLegTripInfo.LegList[Int(String(legIndex))!]  as! Leg
        // check if leg.show is true then change to false
        print("Current Leg values  = \(currentLeg.line)")
        print("Current Leg values  = \(currentLeg.journeyType)")
        // check if icon was clicked before
        print("Current Enabled Line Number   = \(currentLeg.enabled_LineNumber)")
        if (currentLeg.enabled_LineNumber == false){
            currentLeg.enabled_LineNumber = true
            currentLeg.showHideLeg = true
            currentLeg.filterLine = sender.accessibilityIdentifier!
            
            let leglists = currentLegTripInfo.LegList as! NSMutableArray
            var i = 0
            for index in leglists {
                
                
                
                let legIterating = leglists[i] as! Leg
                print("Else Leg Iterating status index = \(i)")
                print("legIterating.enabled_TransportTypeIterating status index = \(legIterating.enabled_TransportType)")
                print("Leg Iterating status index = \(i)")
                
                
                if (legIterating.enabled_TransportType == true)
                {
//                    legIterating.showHideLeg = true 
                    // do nothing it should be already enabled
                } else {
                    
                    legIterating.showHideLeg = false
                    
                    
                }
                i += 1
                
            }
        }
            // false means not enabled before thus show only current or same and hide rest
        else if (currentLeg.enabled_TransportType == true) {
            currentLeg.enabled_TransportType = false
            currentLeg.showHideLeg = true
            
            let leglists = currentLegTripInfo.LegList as! NSMutableArray
            var i = 0
            for index in leglists {
                let legIterating = leglists[i] as! Leg
                legIterating.showHideLeg  = true
                /* 0930 24th dec
                 if (currentLeg.type == legIterating.type)
                 {
                 legIterating.showHideLeg = true
                 } else {
                 
                 
                 if (currentLeg.enabled_TransportType == true){
                 
                 // do nothing let it be like that
                 legIterating.showHideLeg = false
                 }
                 else if (currentLeg.enabled_TransportType == false){
                 // if not enabled transport type icon then show it again
                 // do nothing let it be like that
                 legIterating.showHideLeg  = true
                 
                 
                 }
                 
                 }
                 */
                i += 1
                
            }
           
            
        }
         tableView.reloadData()
        //---------------------------START
        /* 24th dec 0930
        let currentCell = (sender.superview)?.superview as! TripSuggestionsCell_new
        let legIndex = SlifeMethods.extractCharFromStringAtIndex(inputString: String(sender.tag), lookIndex: 3)
        
        // breakdown clicked icon's tag into current section,Current Row(i.e. leg index.
        let clickedButtonStringTag = String(sender.tag)
        //    let indexInChar = clickedButtonStringTag.characters
        
        let currentHeaderTrip = newTrip[currentCell.tag] as! Trip
        
        let currentLeg = currentHeaderTrip.LegList[Int(String(legIndex))!]  as! Leg
        // check if leg.show is true then change to false
     print("showClickedLine :::BEFORE::: currentLeg.filterLine = \(currentLeg.filterLine)")
        if (currentLeg.filterLine == ""){
        currentLeg.filterLine = sender.accessibilityIdentifier!
        
        } else {
        
            currentLeg.filterLine = ""
        }
     
        print("showClickedLine :::AFTER::: currentLeg.filterLine = \(currentLeg.filterLine)")
        
        /*
        if (currentLeg.filterLine == sender.accessibilityIdentifier){
            
            print("CurrentLeg.showHide. in icon clicked function = True Before= \(currentLeg.showHide)")
            currentLeg.showHide = false
        } else {
            
            print("CurrentLeg.showHide. in icon clicked function = false before= \(currentLeg.showHide)")
            currentLeg.showHide = true
        }
        */
        print("Current Leg Show Hide Bool Value  == in icon clicked function = \(currentLeg.showHideLeg)")
        
        print("-----legCounts = \(currentHeaderTrip.LegList.count)")
        print("-----Leg at index 0  =LINE:  \(currentLeg.line)")
        print("---Leg At index 0 = Tye: \(currentLeg.type)")
        // set value for show hide cell
        print("Sender's tag is = \(sender.tag)")
        print("Current tag of header cell when button clicked s = \(currentCell.tag)")
        print("showClickedLine:::Before: current Header Trip show hide cell value  is = \(currentHeaderTrip.showHideCell)")
        tableView.reloadData()
        
       24th dec 0930 */
//--------_END
        
        /* commenting on 23rd Dec 2016 2030HRS
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
        */
    }
    24th dec 1100 */
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
    let header_ref_cellHeight = 10
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
    //MARK: Master next dep trip info button
    @IBAction func nextDeparturesTripInfo(_ sender: UIButton) {
        
        print("Get NEXT Departures for Trip Info Has been pressed....TAG=\(sender.tag)Selected=\(sender.isSelected)")
        sender.isSelected = true
        getNextDeparturesTripInfo(sender: sender, tableViewCurrent: tableView)
        
//        print("Next Departures Trip Info Clicked:: BUtton....")
   getNextDeparturesTripInfo(sender: sender, tableViewCurrent: tableView)
//    
    /*
         let currentDepartureCell = scrollView.viewWithTag(55)?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell //LegTripNextDeparturesTableViewCell
         print("next::Cell.Current:Cell.....987::\(currentDepartureCell.currentIndexPathSection) ---- \(currentDepartureCell.currentIndexPathRow)")
         let keyName = String(currentDepartureCell.currentIndexPathSection) + String(currentDepartureCell.currentIndexPathRow)
         print("next::Cell.Current Key Name = \(currentDepartureCell.keyName)")
         
         //            var indexPath = IndexPath(item: (currentDepartureCell.currentIndexPathRow), section: currentDepartureCell.currentIndexPathSection)
         //            let tripInfoCurrent = tableView.cellForRow(at: indexPath) as! LegListCells
         //            print("next departure Master DIct All keys = \(custom_Trip_NextDepartures_Dict.allKeys) & tripinfo keyName = \(tripInfoCurrent.keyName)")
         print("next::custom trip object count = \(custom_Trip_NextDepartures_Dict.allKeys) && keyname = \(keyName)")
         print("next::current Departure Cell = \(currentDepartureCell.keyName)")
         if ( custom_Trip_NextDepartures_Dict.value(forKey: keyName) != nil ){
         let collectionTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
         print("next::collection trip object count = \(collectionTripObject.count)")
         if (xMovement < 0){
         navigationDeparturesTripInfo = NEXT
         if (navigationDeparturesTripInfo.contains(NEXT))
         {
         simple_earliestDepartLatestArrival_flag = true
         
         // value 1 is bringing based on arrival
         simple_earliestDepartLatestArrival_Value = 0
         // send info from last object
         let lastObjectIndex = collectionTripObject.count - 1
         
         let lastObject = collectionTripObject[lastObjectIndex] as! Trip
         simple_expectedTripDate = lastObject.originDetail.date
         simple_expectedTripTime = lastObject.originDetail.time
         print("next From station = \(lastObject.originDetail.name)")
         print("next time = \(lastObject.originDetail.time)")
         print("next to station = \(lastObject.destinationDetail.name)")
         print("next From Station :: To Station:: = \(keyName)")
         // Temp off 8th jan getNextDeparturesForCollection(fromStation: lastObject.originDetail.name,toStation: lastObject.destinationDetail.name, fromTime: lastObject.originDetail.time, tableView: tableView, keyName: keyName,navigationType: navigationDeparturesTripInfo)
         }

 */
    }
    
    @IBAction func previousDeparturesInTripInfo(_ sender: UIButton) {
          sender.isSelected = true
        print("Get Previous Departures for Trip Info Has been pressed......")
        
        getPreviousDeparturesTripInfo(sender: sender, tableViewCurrent: tableView)
        
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
    
    //MARK: COLLECTION NEXT TRIPS GRAB
    func getNextDeparturesForCollection(fromStation: String,toStation:String, fromTime: String,tableView: UITableView,keyName: String,navigationType: String){
        print("TripInfo:: Navigation type clicked = \(navigationType) & earlest Dp Flag = \(simple_earliestDepartLatestArrival_flag) & Value = \(simple_earliestDepartLatestArrival_Value)")
    
        // get current cell's from time and from station
       
        // get section row as well
        // one timp is to get these as parameters, and send from scroll view 
        // after getting view with tag, 55 tag is working
        let customTripClass = CustomTripMethods()
        print("about to call webservice ..getNextDeparturesForCollection....")

//            let sectionId = sectionStr
//        let rowId = rowStr
        
     // MARK: Departures Collection View in progress jan 2017   
       // customTripClass.get_data_from_url_ForExistingDepartures(from: <#T##String#>, to: <#T##String#>, tableView: <#T##UITableView#>, headerSectionId: <#T##String#>, legRow_id: <#T##String#>)
        //(from: currentCell.from_station.text!, to: currentCell.to_station.text!, tableView: tableView, headerSectionId: sectionId,onInfo, legRow_id: rowId)
        
        let sectionExtracted = String(SlifeMethods.extractCharFromStringAtIndex(inputString: keyName, lookIndex: 1))
        let rowExtracted_forTripInfo = String(SlifeMethods.extractCharFromStringAtIndex(inputString: keyName, lookIndex: 2))
print("Key Name Received =next dep refresh= \(keyName)")
        
        
        print("sectionExtracted  = \(sectionExtracted)")
        print("rowExtracted  = \(rowExtracted_forTripInfo)")
        print("inside get next dep function::fromStation::\(fromStation)")
        print("inside get next dep function::toStation::\(toStation)")
        print("inside get next dep function::toStation::\(toStation)")
        
        
        customTripClass.get_data_from_url_ForExistingDepartures(from_Station: fromStation, to_Station: toStation, tableView: tableView, headerSectionId: sectionExtracted, legRow_id_From : rowExtracted_forTripInfo,keyName: keyName,navigationTypeClicked: navigationType,legRow_id_To: "0",previousNext_Dep_Flag: NEXT_DEP)
        //customTripClass.get_data_from_url(from: fromStation, to: fromTime, tableView: tableView, headerSectionId: sectionExtracted , legRow_id: rowExtracted_forTripInfo)
//        
    
    }
    // MARK: ShowNextDeparture Action
    func nextDepartureTarget(_ sender: UIButton)  {
        print("Sender.Tag:: = \(sender.tag)")
       sender.backgroundColor = UIColor.gray
    }
    /*
    @IBAction func nextDeparturesFromCurrentLeg(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
    }*/

    @IBAction func showNextDepartures_RemainingJourney(_ sender: UIButton) {
  //  }
 /* 17th jan 2017 0400
        @IBAction func showNextDepartures_InTripInfo(_ sender: UIButton) {
            */
        //     let currentCell = sender.superview as! LegListCells
        //  if(newTrip.count != 0) {
        
        if(watchIcons == false){
        
        //    watchIcons = true
        
        }
        
        
        var clicked = false
        
        let button = sender as! UIButton
        let view = button.superview!
      //  button.backgroundColor = UIColor.yellow
        //MARK: Departure temp off 9th nov 8pm
        // get values from the departure button clicked (from its super view)
           
        let currentCell = view.superview as! TripInfoTableViewCell
        let departureCellIndex = Int(currentCell.rowInfo)! + 1
        // check if the key exist to check if the cell is opened or not
               print("Button Tag = \(sender.tag)")
        print("Line:1046:BeforenextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
            
        if let valueExistDepartCellStatus = nextDepartureRemainingLegStatusDict.value(forKey: currentCell.keyName) as? Bool
        {
        // just  change status to show for the current cell
           print("valueExistDepartCellStatus: \(valueExistDepartCellStatus)")
            // if value is false: then it is not funcitonal for now
            if (valueExistDepartCellStatus == false){
                  currentCell.showHideDepartureCell_Master = true
            // MARK: Next Departure isSelected
//                  currentCell.nextDeparturesOutlet.isSelected = true
            // already shown now hide it
                print("ValueExistDepartCellStatus:False....")
                currentCell.showHideDepartureCell_Master = true
               //   currentCell.showHide_Departures = true
            } else if (valueExistDepartCellStatus == true){
               // currentCell.showHide_Departures = false
                currentCell.showHideDepartureCell_Master = false
//                currentCell.nextDeparturesOutlet.isSelected = false
//                
//                currentCell.nextDeparturesOutlet.setTitle("N", for: UIControlState.normal)
//                  currentCell.nextDeparturesOutlet.isSelected = false
                print("ValueExistDepartCellStatus:True....")
                // remove the departure cell values as well as the dict key
                
                print("Line:1072:BeforenextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
                print("Line:1072:Before:newTrip.Leglist Count:\((newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.count)")
                
                nextDepartureRemainingLegStatusDict.removeObject(forKey: currentCell.keyName)
                (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.removeObject(at: departureCellIndex)
                print("Line:1072:After:newTrip.Leglist Count:\((newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.count)")
                
                print("Line:1072:After:nextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
                
            }
        
        } else {
        // load values and add key as true
          print("Not Loaded Before: about to load now:")
        //    currentCell.nextDeparturesOutlet.isSelected = true
              currentCell.showHideDepartureCell_Master = true
//            currentCell.nextDeparturesOutlet.isSelected = true
//            
//            currentCell.nextDeparturesOutlet.setTitle("S", for: UIControlState.selected)
//            
                //currentCell.showHide_Departures = true
            nextDepartureRemainingLegStatusDict.setValue(true, forKey: currentCell.keyName)
            let customTripClass = CustomTripMethods()
            print("about to call webservice ......")
            customTripClass.get_data_from_url(currentCollectionView: UICollectionView() ,from: currentCell.from_station.text!, to: currentCell.to_station.text!, tableView: tableView, headerSectionId: currentCell.sectionInfo, legRow_id_from: String((Int(currentCell.rowInfo)! + 1)),fromTime: currentCell.from_time.text!, legRowID_To: String((Int(currentCell.rowInfo)! + 1)),previousOrNextFlag: NEXT_DEP,fromDate_Dep: "",fromTime_Dep: "")
            //MARK: EXTRA
            // insert into newtrip
            print("Custom Trip Next Departure dict status = \(custom_Trip_NextDepartures_Dict.count)")
            //            if (custom_Trip_NextDepartures_Dict.count != 0)
            //            {
            // MARK: replace it later with collection dict
            
            let newDepartureObject = TripInfoDepartures()
            print("Adding in new trip ........")
            (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(newDepartureObject, at: departureCellIndex)
         }
        
        print("All keys in:nextDepartureRemainingLegStatusDict:S:\(currentCell.sectionInfo):R:\(currentCell.rowInfo):\(nextDepartureRemainingLegStatusDict) ")

        tableView.reloadData()

       /*
        print("Line 1026: showNextDepartures_ :keyName.CurrentCell: \(currentCell.keyName):T:\(currentCell.tag) Sec:\(currentCell.sectionInfo): R:\(currentCell.rowInfo): ")
        print("button.nextdeparture.current tag = \(button.tag)")
        //currentCell.backgroundColor = UIColor.red
       // if(currentCell.showdi)
        print("showNextDepartures_InTripInfo has been Pressed ::::::::\(currentCell.sectionInfo)::\(currentCell.rowInfo):::")
        print("Departure cell Index = \(departureCellIndex)")
       // print("CurrentCell Current Index ==== \(currentCell\)")

       if (currentCell.showHideDepartureCell_Master == false){
          
          //  currentCell.showHideDepartureCell_Master = true
        
            // check if the data has been loaded already 
//            if let departTrip =  (newTrip[(Int(currentCell.sectionInfo))!] as! Trip).LegList[departureCellIndex] {
//            
//            print("")
//            
//            }

           
            // before cell was hidden
            // show departure cell
            //let image = UIImage(contentsOfFile: "TripInfoDeparturesSelected.png")
           // currentCell.nextDeparturesOutlet.isSelected = true
            // get the data
        //---------------------------end departure collection view old
        
            //    (newTrip[Int(currentCell.sectionInfo)!] as! Trip).LegList.insert(custom_Trip_NextDepartures_Dict, at: departureCellIndex)
         //   }
            
            print("setting value to true for currentcell.showhide........")
            }
            else if (currentCell.showHideDepartureCell_Master == true)
        {
            
            
            currentCell.nextDeparturesOutlet.isSelected = false
            
           //    currentCell.showHideDepartureCell_Master = false
            /*
            if (currentCell.showHideDepartureCell == true){
                currentCell.showHideDepartureCell = false
               // currentCell.nextDeparturesOutlet.isSelected = false
                
            }*/
            
            
            
        
            print("setting value to false......and removing object.......")
           // let image = UIImage(contentsOfFile: "TripInfoDepartures.png")
           // currentCell.nextDeparturesOutlet.isSelected = false
            // currentCell.nextDeparturesOutlet.setImage(image, for: .normal)
            
            print("Before Removal::::tableviews current count = \(tableView.subviews.count)")
          
          //  currentCell.showHideDepartureCell = false
//           
//            tableView.subviews[0].removeFromSuperview()
//            tableView.subviews[1].removeFromSuperview()
//            
        //    tableView.subviews[2].removeFromSuperview()
         }
    */
    }
   // Leg Image Names
    //MARK: Show Trip Details
    @IBAction func sectionAction(sender: UIButton) {
        print("section button is pressed with :\(sender.state) ")
        let currentCell = sender.superview?.superview?.superview?.superview?.superview?.superview?.superview as! TripSuggestionsCell_new
        print("Current Cell.\(currentCell)")
        print("Current Cell.\(currentCell.from_station)")
        
        
        if let currentCell = sender.superview?.superview?.superview?.superview?.superview?.superview?.superview as? TripSuggestionsCell_new
            
        {
        print("Header Cell found::)")
      
        let currentSection = 0
            let currentTrip = newTrip[currentSection] as! Trip
            
           // let currentLegListCount = currentTrip.LegList
            var i = 0
            var count = currentTrip.LegList.count
            print("count of leglist = \(currentTrip.LegList.count)")
            
            let ary = currentTrip.LegList as? NSMutableArray
            for index in 1...count
                
                {
            print("Line 1202:::")
            let keyName = String(currentSection) + String(i)
                    
                    print("Line 1205:::")
                    if let valueExistDepartCellStatus = nextDepartureRemainingLegStatusDict.value(forKey: keyName) as? Bool
                    {
                    // remove the key
                        var currentRow = i
                        var departRow = i + 1
                        print("Line1210: all dict keys =Before: \(nextDepartureRemainingLegStatusDict.allKeys)")
                        nextDepartureRemainingLegStatusDict.removeObject(forKey: keyName)
            
                         print("Line1210: all dict keys =After: \(nextDepartureRemainingLegStatusDict.allKeys)")
                        
                        // remove the object
                        
                                   (newTrip[Int(currentSection)] as! Trip).LegList.removeObject(at: (departRow))
                    // change the value of the button? 
                    // get the cell and change the status
                
                    let newIndexPath = IndexPath(row: currentRow, section: currentSection)
                        
                        // MARK: nill found 
                        // fatal error: unexpectedly found nil while unwrapping an Optional value
                        let tripInfoCell = tableView.cellForRow(at: newIndexPath) as! TripInfoTableViewCell
                        
                        print("tripInfoCell: : \(tripInfoCell.from_station)")
                        //tripInfoCell.nextDeparturesOutlet.isSelected = false
                        
                //    currentCell.showHideDepartureCell_Master = false
                    //                currentCell.nextDeparturesOutlet.isSelected = false
                    //
                    //                currentCell.nextDeparturesOutlet.setTitle("N", for: UIControlState.normal)
                    //                  currentCell.nextDeparturesOutlet.isSelected = false

                    // remove the departure cell values as well as the dict key
                    }
     i += 1

            }
        
        }
        sectionShow = sender.tag
        print("Section Show sender = \(sectionShow) + tag ? \(sender.tag)")
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
  //  var newTrip = NSMutableArray()
    
    // Rows Data Source
    
    //    var newTrip = [Trip]()
    let legList = ["test-0","test-1","test-2"]
    //    var trips = [Trips]()
    
    var from = String()
    var to = String()
    var searchForArrivals = String()
    /*
    func refresh(sender: AnyObject) {
        let refreshControlTemp = sender as! UIRefreshControl
        print("----REFRESH HAS BEEN CALLED ...............")
        masterTripGrabberFromSL_Refresh()
        refreshControl?.endRefreshing()
        // Code to refresh table view
    }
    */
    /*
     func viewWillAppear(){
    
    
    print("Line 1822:TripToShow. \(tripToShow.LegList.count) Flag:\(genericTripFlag)")
    
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let tripSelection = currentTripScope[0] as! Trip
        let tripSelection = newTrip[tripSection] as! Trip
        
        print("Trip in view did load , trip info = \(tripSelection.originDetail.time)")
        print("Current Trip selected : \(tripSection)")
        print("Line1825: \(currentTripScope.count)")
        print("Line1825: TripToShow = \(tripToShow.LegList.count) && Generic Flag= \(genericTripFlag)")
        
        
//        print("Nav bar status Before: \(self.navigationController?.isNavigationBarHidden)")
//        self.navigationController?.setToolbarHidden(true, animated: true)
//        
//        print("Nav bar status After: \(self.navigationController?.isNavigationBarHidden)")
//        print("INSIDE TRIP INFO TABLE VIEW CONTROLLER.. SHOW Values for \(showTripIndexOnTripInfo )...")
//         //MARK: PULL TO REFRESH
       /* refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(TripSuggestionsTViewController.refresh), for: UIControlEvents.valueChanged)
 
        tableView.addSubview(refreshControl!) // not required when using UITableViewController
*/
        
 // MARK: AutoRowHeight
        // tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tripRootMapFlag = false
        tableView.reloadData()
    
     //MARK: Temp 20th jan   masterTripGrabberFromSL()
      }

    /* temp closed 20th jan
    func masterPreviousTripGrabberFromSL(){
        print("masterPreviousTripGrabberFromSL.. has been called.....")
        
        // set Earliest Arrival / Departure flag
        simple_earliestDepartLatestArrival_flag = true
        
        // value 1 is bringing based on arrival
        simple_earliestDepartLatestArrival_Value = 1
        // get the first object from newtrip
        let firstTripObject = newTrip.firstObject as! Trip
        simple_expectedTripDate = firstTripObject.originDetail.date
        simple_expectedTripTime = firstTripObject.originDetail.time
        
        //        let fromTime_firstObject = firstTripObject.originDetail.time
        //        let fromStation_firstObject = firstTripObject.originDetail.name
        //        let toStation_firstObject = firstTripObject.destinationDetail.name
        ////        let toStation_firstObject = firstTripObject.dest
        
        
        let searchTrips = WebServiceHandler()
        var url = String()
        print("from = = Previous Trips= = = \(from)")
        print("to = = =Previous Trips = = \(to)")
        // recent trips addition
        // MARK: Recent Trips Adding
        print(" sr_fromStation_id:Previous Trips: \(sr_fromStation_id) && count is \(sr_fromStation_id.characters.count)")
        print(" sr_fromStation_id:Previous Trips: \(sr_toStation_ID) && count is \(sr_toStation_ID.characters.count)")
        SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
        print("Previous Trips: advancedOptionsFlag = \(advancedOptionsFlag)")
        print("Previous Trips: earliestDepartLatestArrival_flag = \(earliestDepartLatestArrival_flag) &value=\(earliestDepartLatestArrival_Value) && Time = \(firstTripObject.originDetail.time)")
        
        if (advancedOptionsFlag == false){
            print("Previous Trips: advancedOptionsFlag = \(advancedOptionsFlag)")
            // coming from simple screen
            self.title = simple_expectedTripDate + "-" + simple_expectedTripTime
            // search for arrival
            // By default / default are looking for the time that you want the trip to resign. By putting searchForArrival = 1, so looking instead travels based on the time you want to arrive. Default = 0th
            url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
            // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            // from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
        } else if (advancedOptionsFlag == true){
            self.title = expectedTripDate + "-" + expectedTripTime
            //        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
        }
        print("-------------------url----\(url)")
        previousTripClickedFlag = true
        get_data_from_url(url: url)
        print("-----------------------ended--090")
        
    }
    */
    /* temp closed 
     20th jan func masterNextTripGrabberFromSL(){
        print("masterPreviousTripGrabberFromSL.. has been called.....")
        
        // set Earliest Arrival / Departure flag
        
        simple_earliestDepartLatestArrival_flag = true
        
        // value 1 is bringing based on arrival
        simple_earliestDepartLatestArrival_Value = 0
        // get the first object from newtrip
        let lastTripObject = newTrip.lastObject as! Trip
        simple_expectedTripDate = lastTripObject.originDetail.date
        simple_expectedTripTime = lastTripObject.originDetail.time
        
//        let fromTime_firstObject = firstTripObject.originDetail.time
//        let fromStation_firstObject = firstTripObject.originDetail.name
//        let toStation_firstObject = firstTripObject.destinationDetail.name
////        let toStation_firstObject = firstTripObject.dest
        
        
        let searchTrips = WebServiceHandler()
        var url = String()
        print("from = = Previous Trips= = = \(from)")
        print("to = = =Previous Trips = = \(to)")
        // recent trips addition
        // MARK: Recent Trips Adding
        print(" sr_fromStation_id:Previous Trips: \(sr_fromStation_id) && count is \(sr_fromStation_id.characters.count)")
        print(" sr_fromStation_id:Previous Trips: \(sr_toStation_ID) && count is \(sr_toStation_ID.characters.count)")
        SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
        print("Previous Trips: advancedOptionsFlag = \(advancedOptionsFlag)")
        print("Previous Trips: earliestDepartLatestArrival_flag = \(earliestDepartLatestArrival_flag) &value=\(earliestDepartLatestArrival_Value) && Time = \(lastTripObject.originDetail.time)")
        
        if (advancedOptionsFlag == false){
            print("Previous Trips: advancedOptionsFlag = \(advancedOptionsFlag)")
            // coming from simple screen
            self.title = simple_expectedTripDate + "-" + simple_expectedTripTime
            // search for arrival
            // By default / default are looking for the time that you want the trip to resign. By putting searchForArrival = 1, so looking instead travels based on the time you want to arrive. Default = 0th
            url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
            // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            // from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
        } else if (advancedOptionsFlag == true){
            self.title = expectedTripDate + "-" + expectedTripTime
            //        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
        }
        print("-------------------url----\(url)")
        nextTripClickedFlag = true
        get_data_from_url(url: url)
        print("-----------------------ended--090")
        
    }
*/
    //MARK:  Basic Version
    func masterTripGrabberFromSL(){
        print("masterTripGrabberFromSL___ has been called.....")
        let searchTrips = WebServiceHandler()
        var url = String()
        print("from = = = = = \(from)")
        print("to = = = = = \(to)")
        // recent trips addition
        // MARK: Recent Trips Adding
        print(" sr_fromStation_id \(sr_fromStation_id) && count is \(sr_fromStation_id.characters.count)")
        print(" sr_fromStation_id \(sr_toStation_ID) && count is \(sr_toStation_ID.characters.count)")
        SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
        if (advancedOptionsFlag == false){
            // coming from simple screen
            self.title = simple_expectedTripDate + "-" + simple_expectedTripTime
           // search for arrival
            // By default / default are looking for the time that you want the trip to resign. By putting searchForArrival = 1, so looking instead travels based on the time you want to arrive. Default = 0th
            url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
            // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            // from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
        } else if (advancedOptionsFlag == true){
            self.title = expectedTripDate + "-" + expectedTripTime
            //        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0",tripDate: "", tripTime: "")
            
        }
        print("-------------------url----\(url)")
        get_data_from_url(url: url)
        print("-----------------------ended--090")

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print("Line 2007:\(tableVie)")
      //  super.viewWillAppear()
    
//        collectionView.reloadData()
        
        //        tableView.backgroundColor = UIColor.white
        
        print("view will current real_time_flag value is ====old???? \(real_time_flag)")
        print("Generic Flag = \(genericTripFlag)")
        tableView.reloadData()
        
//        let ip = IndexPath(
//        print("Line 2017: \(tableView.cellForRow(at: IndexPath())")
        //[self.view layoutIfNeeded];
        //[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        
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
                        // add newtrips to begining if previous is clicked
                        self.getTrips(json: convertedJsonIntoNSDict1)
                        print("-trip--7.1---B--")
                        //--for-1--------------------------------------------------------------------------------------------------
                        print("-trip--7.2--about to return after parsing")
                        // reload the table here
                        self.tableView.reloadData()
                        
                        if (previousTripClickedFlag == true){
                        previousTripClickedFlag = false
                        }
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
                let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString, currentLegStatus: true)
                
                
                
                print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                print("rtu message status from leg = message = \(leg.rtu_Message)")
                trip.LegList.add(leg)
                forMain11 += 1
                //----------------if condition walk & travel----------end
            }
            print("---NewTrip total counter:\(newTrip.count)")
            
            print("Newtripi Total Count = \(newTrip.count)---Current Index:\(forMain1)")
            if(previousTripClickedFlag == true){
                print("-previousTripClickedFlag= True--Adding trips to the first index.FromTime=.\(trip.originDetail.time).-Totime:\(trip.destinationDetail.time)--from origin=\(trip.originDetail.name)::to dest: \(trip.destinationDetail.name)")
                
             newTrip.insert(trip, at: forMain1)
            //    self.newTrip.add(trip)
            } else {
                newTrip.add(trip)
            }
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1 += 1
        }
    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        // temp----start
        // return 5
        // temp ---end
        //Mark: need to upate
        // MARK temp big change 
        // 1st of feb
        print("Line2305: Number ofSections: Coll:---0 ")
        let parentCellCollectionDepartureView = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
        
        let currentSection = String(parentCellCollectionDepartureView.currentIndexPathSection)
        let currentRow = String(parentCellCollectionDepartureView.currentIndexPathRow)
        let keyName = String(parentCellCollectionDepartureView.indexPathSelected.section) + String(parentCellCollectionDepartureView.indexPathSelected.row)
        // Temp : found Nil.
       print("Line2317: CurrentLeg=\(parentCellCollectionDepartureView.indexPathSelected)")
        var collectionReturnCount = 0
        let currentTrip = newTrip[tripSection] as! Trip
         var currentLeg = currentTrip.LegList[parentCellCollectionDepartureView.indexPathSelected.row] as! Leg
        print("Current Leg Index:\(parentCellCollectionDepartureView.indexPathSelected)")
         print("Departure Available:\(currentLeg.departureAvailable))")
        print("Dep Count= \(currentLeg.nextDeparturesTrip.count)")
        print("Line2588: Trip Count Check:BEFORE:\(currentLeg.nextDeparturesTrip.count)")
//        if(currentLeg.nextDeparturesTrip.count != 0){
//        currentLeg.nextDeparturesTrip.removeFirst()
//        }
        //var duplicateCheckArray = NSMutableArray()
      // duplicateCheckArray.add(currentLeg.nextDeparturesTrip)
        
      checkAllTripsForDuplicatesTrips(legIndex: parentCellCollectionDepartureView.indexPathSelected.row)
    //  checkAllTripsForDuplicatesTrips(departureTripsArray: duplicateCheckArray)
        //currentLeg.nextDeparturesTrip.remove(at: 1)
        print("Line2588: Trip Count Check:AFTER:\(currentLeg.nextDeparturesTrip.count)")
        
        var returnCount = currentLeg.nextDeparturesTrip.count
        
       if (currentLeg.departureAvailable == true)
        {
            //if (currentLeg.nextDeparturesTrip[IndexPath])
            
//            //---5th Feb:Trip Level Changes: Major---------start
//            // return the count of Trips. it would serve as number of sections
//            var currentLegDepartureCount = (currentTrip.LegList[parentCellCollectionDepartureView.indexPathSelected.row] as! Leg).nextDeparturesTrip.count
//            // return the departure trip counts for current leg within selected current trip
//            
//            return currentLegDepartureCount
            
            //---5th Feb:Trip Level Changes: Major---------END
            
            print("CurrentLeg.nextDep.Count=\(parentCellCollectionDepartureView.indexPathSelected)=\(currentLeg.nextDeparturesTrip.count)")
            collectionView.reloadData()
            self.view.setNeedsDisplay()
            // if coming via tripSuggestion then flag is false
            if (genericTripFlag == false){
            return returnCount
            }
            else if (genericTripFlag == true){
            
            let countLeg = tripToShow.LegList.count
                if (countLeg != 0){
                
                return 1
                    
                }
            }
        }
            
        else
        {
            
            if (returnCount == 0)
            {
                
                
            returnCount = 1
                
            }
            print("Lein2673: \(returnCount)")
            return returnCount
        }
        //---------1st of feb
        print("collection view main change : 1")
        
        return 1
        
        
         print("Collection View::\(collectionView.superview?.superview)")
        
      
        // MARK: Bug: Found 1028-12jan2017
        // 2017-01-12 10:26:25.134415 SLife[4559:1648852] fatal error: unexpectedly found nil while unwrapping an Optional value
        
        print("Parent Cell Collection Departure View = \(parentCellCollectionDepartureView.currentIndexPathSection) & row = \(parentCellCollectionDepartureView.currentIndexPathRow)")
    
        if let currentCollectionDepartureTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as? NSMutableArray
        {
        //let currentCollectionDepartureTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
        print("Current Collection Departure Trip Object = \(currentCollectionDepartureTripObject.count)")
        
        // check for the duplication and remove if you find any
        print("Count before checking of the duplication .coll.departy.= \(currentCollectionDepartureTripObject.count)")
    //MARK: Temp duplicate Off 6th jan
          print("checking duplicates in tripaArray.collection.depart after refresh = \(checkAllTripsForDuplicates(tripArray: currentCollectionDepartureTripObject))")
      var u = 0
        
        for index in currentCollectionDepartureTripObject {
        
        let currentPrintingTrip = currentCollectionDepartureTripObject[u] as! Trip
        print("Dep: Collection:::Check::From Time: \(currentPrintingTrip.originDetail.time) & From Station \(currentPrintingTrip.originDetail.name)-----> to time:\(currentPrintingTrip.destinationDetail.time) toStation:\(currentPrintingTrip.destinationDetail.name)")
        u += 1
        }
         print("Count after checking of the duplication .coll.departy.= \(currentCollectionDepartureTripObject.count)")
        collectionReturnCount += currentCollectionDepartureTripObject.count
        }
        //--------
 
        return collectionReturnCount
    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        if (newTrip[tripSection] != nil){
        
        
        return 1
        }
        else
        {
            return 0
            
        }
        /* 1st of feb
        let currentCount = currentTripScope.count // +  toolHeaderCellCount
        
        print("CurrentCount of Trips to show = \(currentCount)")
        //
        //                if let currentTrip = newTrip[showTripIndexOnTripInfo] as? Trip {
        //
        //            return 1
        //        }
        return currentCount //headerSectionCount
        */
    }
    
   /*
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            // let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! UICollectionReusableView
            let headerView = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuse", for: indexPath as IndexPath) as!
            TripInfoCollectionReusableView
            print("Header View is called......")
            
            let parentCell = collectionView.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell
            print("Line2731: \(parentCell.currentIndexPathRow)")
            //let currentLegId = parentCell.currentIndexPathRow
            headerView.from_time.text = "99999"
            return headerView
            /*
             case UICollectionElementKindSectionFooter:
             let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Footer", forIndexPath: indexPath) as! UICollectionReusableView
             
             footerView.backgroundColor = UIColor.greenColor();
             return footerView
             */
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
 */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did Slect is pressed........")
        let cellSelected = tableView.cellForRow(at: indexPath) as! TripInfoTableViewCell
        cellSelected.backgroundColor = UIColor.lightGray
//        let indexPathToolCell = IndexPath(row: 0, section: 0)
        
        var departLegSelected = NSMutableDictionary()
      
        // check if value exists---return false
        print("Current Status of DepartSelected:Keys:\(departLegSelected.allKeys) & cellSelected.SectionInfo:\(cellSelected.sectionInfo))")
        
        let tripSectionIndex = cellSelected.sectionInfo
        let tripInfoRowIndex = cellSelected.rowInfo
        
//        if let valueExists = departLegSelected[tripSectionIndex]
//        {
//        print("value exists .......")
//        
//            
//            
//            
//        }
//        else {
//       
//            print("No Value exists.........")
//       
//        }
        
        let clickedLegInfoExist = RealTidMethods.checkIfKeyExists(dictToCheck: departLegSelected, keyName: tripInfoRowIndex)
        //let currentSection = Int(tripSectionIndex)
        // current sectionTrip
        print("-------------1-------------2257------)")
        
        let currentTripSection = newTrip[Int(tripSectionIndex)!] as! Trip
        print("-------------2-------------2260----\(tripInfoRowIndex)--)")
        
        let currentLegClicked = currentTripSection.LegList[Int(tripInfoRowIndex)!] as! Leg
        print("-------------3-------------2263------)")
        
        // add value to the dict : current LegIndex
        if (clickedLegInfoExist == false && (departLegSelected.count == 0)){
            // cellSelected.legTag is indexRow
            print("No Value exists....valueExists..Line2273...\(clickedLegInfoExist)")
        departLegSelected.setValue(true, forKey: String(tripInfoRowIndex))
            
            print("status if the key has been added = \(departLegSelected.allKeys)")
        
            
            // select the current leg which is being clicked
            
        fromLegIndex_clicked = Int(tripInfoRowIndex)!
            
        toLegIndex_clicked = Int(tripInfoRowIndex)!
            
            depValueUpdated = true
             showHideDepartureToolBar = true
        
        }
        else if (clickedLegInfoExist == false && (departLegSelected.count != 0))
            {
                departLegSelected.setValue(true, forKey: String(tripInfoRowIndex))
                
                // select the current leg which is being clicked
                toLegIndex_clicked = Int(tripInfoRowIndex)!
         }
        else if (clickedLegInfoExist == true){
        
        departLegSelected.removeObject(forKey: String(cellSelected.legTag))
       
            if (departLegSelected.count == 0)
            {
            
            depValueUpdated = false
            showHideDepartureToolBar = false

            }
            else if (departLegSelected.count != 0){
            
            }
        }
        
       tableView.reloadData()
        
        
        // check current keys status
        print("Line 2285: current status of dep keys AFTER= \(departLegSelected)")
            // set from and to value
        
        // if the value exist---return true
        
        
        
        
        // each time when the leg is selected then add key if not available before and 
        // add value to the key as true if the value is available 
        
        // check if the key exists
            // if yes then remove it
                // after removing if key = is
        
        
        
        /* 21st jan
        let pcell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        print("row has been selected....Cell = \(pcell)..IP=\(indexPath)....\(indexPath.row)")
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
        //MARK: Problem 7th Jan
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
            print(tableView.indexPathForSelectedRow!)
            
        } else {
            
            transportTypeFlag = "WALK"
        }
    */
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("IN NUMBER OF ROWS IN SECTION  : \(section)")
               //let legList = newTrip[section] as! Trip
        //MARK: Compare trip test
       
        /*
 if (section == 0){
        
        return 0
        }
 */
        
       // print("CurrentTrip Scope Count = \((newTrip[tripSection] as! Trip).count)")
        let currentIndex = tripSection // section //- 1
        let rowsCount = newTrip[tripSection] as! Trip
        
     //   let rowsCount = currentTripScope[currentIndex] as! Trip
       
        print("Line2965:rowsCount.LegList.count=\(section)=\(rowsCount.LegList.count)")
        return rowsCount.LegList.count
        
        /*
        if (section > 0){
            
            
            
//            if let currentTrip = newTrip[showTripIndexOnTripInfo] as? Trip {
//                
//                print("Inside trip info show vc \(currentTrip.LegList.count)")
//
//            return currentTrip.LegList.count
//            }
//            let existingTrip = newTrip[section - 1] as! Trip
//        print("-------------comparing section = \((section - 1)) with current = \(section)")
//            let result = compareTrips(tripExisting: existingTrip , tripToCheck: legList)
//            print("Result from trip comparison for existing previous and next trip = \(result).--section = \(section)---\(existingTrip.originDetail.time)")
//            
        }
        print("----LegList Count is in number of rows in section=\(legList.LegList.count)")
        print("section show value in number of rows in section = \(sectionShow)")
        // extract value of section if not null
        // check if it is true then show
        // else return 0
        
        // check for null
        print("section # is \(section)")
        let section_null_or_not = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        
        */
        /* temp 20th jan
        if (section_null_or_not.contains("null")){
            
            
            
            print("section null or not contains===== false = \(section_null_or_not)")
            
            
        }
        else if (section_null_or_not.contains("true"))
        {
            
            print("section null or not contains===== True = \(section_null_or_not)")
            
            print(" \(legList.LegList.count)")
            
          
        return legList.LegList.count
        }
        temp 20th jan closed
        */
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
      
    }
    
    // MARk: Collection View Methods
//------------start---temp add from below same---
   // extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
        //1/*
    /* 28th dec 0800
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
    /*
            //2
//            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//            let availableWidth = view.frame.width - paddingSpace
//            let widthPerItem = availableWidth / itemsPerRow
//            
//            return CGSize(width: widthPerItem, height: widthPerItem)
            
            //---------start
            
            
            print("Custom Trip Next Departures:size of the item: :::: \(custom_Trip_NextDepartures_Dict.allKeys)")
            /*
            if (custom_Trip_NextDepartures_Dict.count > 0 ){
                let currentSection = String(indexPath.section)
                let currentRow = String(indexPath.row)
                let view = collectionView.superview!
                // MARK: Collection view friday eve 9th nov temp off
                //
                //            let currentCell = view.superview as! LegListCells
                let currentCell = view.superview as! LegTripNextDeparturesTableViewCell
                print("collection view cell for item is hidden or not = \(currentCell.isHidden)")
                if (currentCell.isHidden == true){
                
                
                print("collection view cell true value found.....")
                }
                let keyNameTemp = currentCell.keyName
                print("At Collection Size::printing cells..keyname temp from current cell = \(keyNameTemp)")
                let keyName = currentSection + currentRow
                print("At Collection Size::printing cells..Collection ALL KEYS = \(custom_Trip_NextDepartures_Dict.allKeys)")
                print("At Collection Size::printing cells..generated current key via indexpth.section and row = \(keyNameTemp)")
                print("At Collection Size::printing cells..index path row values in collection cell for = \(indexPath.row)")
                if let collection_Values_flag = custom_Trip_NextDepartures_Dict[keyNameTemp]
                {
                    
                    //if (collection_Values_flag == true){
                    let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                    
                    print("customDepTripArray Count = \(customDepTripArray.count)")
                    
                    print("At Collection Size::printing cells..-----test 10989")
                    // MARK: temp wed 14 th dec changing
                    
                    let tripCustom = customDepTripArray[indexPath.section] as! Trip
                    let tripCustomLeg = tripCustom.LegList[indexPath.row] as! Leg
                    print("Trip Custom.showhideLeg ==== \(tripCustomLeg.showHideLeg)")
                    if (tripCustomLeg.showHideLeg == false){
                    
                        return CGSize(width: 0, height: 0)
                    }
                }
                return CGSize(width: 76, height: 144)
                
            }
            */
            
            
            print("At Collection Size::printing cells.. inside collection view size of the item......\(indexPath)")
            if (indexPath.row == 0){
            
            
                return CGSize(width:80, height: 150)
            }
            if (indexPath.row == 1) {
            
                return CGSize(width: 0, height: 0)
                
            }
            if (indexPath.row == 2){
                
                return CGSize(width:80, height: 150)
                
            
            }
 */
            if (indexPath.section == 0){
                return CGSize(width:80, height: 100)}
            else if (indexPath.section == 1)
            {
                return CGSize(width:0, height: 0)}
    
    else if(indexPath.section == 2) {
    
    
    return CGSize(width:100, height: 200)}
    
    
    
        
            

return CGSize(width:0, height: 0)
    }
    off: 28th dec 0800 */

    //}

    /*
        //3
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return 10 //sectionIndexTitles
        }
        
        // 4
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0 // sectionIndexTitles.left
        }
  //  }
    */
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    */
    
    func checkAllTripsForDuplicatesTrips (legIndex: Int) -> Bool {
        print("Line3105:")
        var departureTrips = ((newTrip[tripSection] as! Trip).LegList[legIndex] as! Leg).nextDeparturesTrip //departureTripsArray as! [Trip]
        // let trips = tripArray
        var status = true
        var i = 0
        var objectsRemoved = 0
        var forCount = departureTrips.count
        if (departureTrips.count != 0){
        for index in 1...departureTrips.count {
            
            print("Test 1 ....check duplicate...")
            if ((i + 1) <= departureTrips.count){
                print("A-----at duplicate..objects=\(departureTrips.count)...i:\(i).")
                var currentTripObject = departureTrips[i]
                
                //let currentTripObject = tripArray[i] as! Trip
                print("b-----at duplicate......")
                print("B-----at duplicate......")
                if (i > 0 ){
                    print("c-----at duplicate......")
                    print("Test 2 ....check duplicate..\(i).")
                    
                    //check if the object exist
                    if (departureTrips[i - 1] == nil){
                        print("Trip Array returned null object.....")
                        
                    } else {
                        let  previousTripObject = departureTrips[i - 1] as! Trip
                        
                        
                        let statusCompare = compareTrips(tripExisting: previousTripObject, tripToCheck: currentTripObject)
                        print("previousTripObject.originDetail.time \(previousTripObject.originDetail.time) :To Tim = \(previousTripObject.destinationDetail.time)_Cure Dur=\(previousTripObject.dur) ")
                        
                        print("currentTripObject.originDetail.time  = \(currentTripObject.originDetail.time) : To:Tim : Time  = \(currentTripObject.destinationDetail.time) & Cure Dur=\(currentTripObject.dur)")
                        print("--------Result Comparison = \(statusCompare)")
                        
                        
                        if (statusCompare == true){
                            // if it doesnt work then creat two functions and remove parameter and give them direct acces to class variable or global
                            // variable to remove duplicates
                            //                    i.e. newTrip and the collection trips
                            // MARK: Temp change newtrip to the trip which is received in parameter
                            print("Line3147: <previous Trips> :Name:\(previousTripObject.originDetail.name) :Time:\(previousTripObject.originDetail.time) ")
                               print("Line3147: <previous Trips> :Name:\(currentTripObject.originDetail.name) :Time:\(previousTripObject.originDetail.time) ")
                            print("Before:About to remove duplication object ::::\(i): \(departureTrips.count)")
                            print("Before:About to remove duplication object :::MASTER:\(i): \(((newTrip[tripSection] as! Trip).LegList[legIndex] as! Leg).nextDeparturesTrip.count)")
                            
                            ((newTrip[tripSection] as! Trip).LegList[legIndex] as! Leg).nextDeparturesTrip.remove(at: i)
                                 print("Before:About to remove duplication object :::MASTER:\(i): \(((newTrip[tripSection] as! Trip).LegList[legIndex] as! Leg).nextDeparturesTrip.count)")
                           // departureTrips.remove(at: i)
                         //  departureTrips.removeObject(at: i)
                            print("Removed:About to remove duplication object ::::\(i):\(departureTrips.count) ")
                            
                            /*
                             print("Before:About to remove duplication object ::::\(i): \(newTrip.count)")
                             newTrip.removeObject(at: i)
                             print("Removed:About to remove duplication object ::::\(i):\(newTrip.count) ")
                             */   // need to correct status
                        }
                    }
                }
                i += 1
            } else {
                objectsRemoved += 1
                print("number of objects removed = \(objectsRemoved)")
                
            }
        }
        }
        return status
    }
    
    func checkAllTripsForDuplicates (tripArray: NSMutableArray) -> Bool {
       // let trips = tripArray
    var status = true
    var i = 0
    var objectsRemoved = 0
        for index in tripArray {
            
            print("Test 1 ....check duplicate...")
            if ((i + 1) <= tripArray.count){
                print("A-----at duplicate..objects=\(tripArray.count)...i:\(i).")
            let currentTripObject = tripArray[i] as! Trip
                print("b-----at duplicate......")
                print("B-----at duplicate......")
            if (i > 0 ){
                print("c-----at duplicate......")
                print("Test 2 ....check duplicate..\(i).")
                
                //check if the object exist
                if (tripArray[i - 1] == nil){
                print("Trip Array returned null object.....")
                
                } else {
                let  previousTripObject = tripArray[i - 1] as! Trip
                
            
            let statusCompare = compareTrips(tripExisting: previousTripObject, tripToCheck: currentTripObject)
        print("previousTripObject.originDetail.time \(previousTripObject.originDetail.time) :To Tim = \(previousTripObject.destinationDetail.time)_Cure Dur=\(previousTripObject.dur) ")
                
            print("currentTripObject.originDetail.time  = \(currentTripObject.originDetail.time) : To:Tim : Time  = \(currentTripObject.destinationDetail.time) & Cure Dur=\(currentTripObject.dur)")
            print("--------Result Comparison = \(statusCompare)")
                
                
                if (statusCompare == true){
                    // if it doesnt work then creat two functions and remove parameter and give them direct acces to class variable or global
                    // variable to remove duplicates
//                    i.e. newTrip and the collection trips
               // MARK: Temp change newtrip to the trip which is received in parameter
                    print("Before:About to remove duplication object ::::\(i): \(tripArray.count)")
                    tripArray.removeObject(at: i)
                    print("Removed:About to remove duplication object ::::\(i):\(tripArray.count) ")
                    
                    /*
                    print("Before:About to remove duplication object ::::\(i): \(newTrip.count)")
                newTrip.removeObject(at: i)
                       print("Removed:About to remove duplication object ::::\(i):\(newTrip.count) ")
                 */   // need to correct status
                }
            }
            }
                i += 1
            } else {
            objectsRemoved += 1
            print("number of objects removed = \(objectsRemoved)")
                
            }
            }
    return status
    }
    func compareTrips (tripExisting: Trip, tripToCheck: Trip) -> Bool {
    var result = false
        // false means both trips are different
        // true means both trips are same thus remove the current trip and return one less number of rows for the current header session.
        
        // variables to check
        // from time, & from station
        // to time & to station
        // iterate through the leg list and check the line and transport type if same
        
        // Existing Trip
        
        
        let exist_from_Station = tripExisting.originDetail.name
        let exist_from_station_time =  tripExisting.originDetail.time
        let exist_to_station =  tripExisting.destinationDetail.name
        let exist_to_station_time =  tripExisting.destinationDetail.time
        
        let exist_duration =  tripExisting.dur
        
        //Trip to compare
        let compare_from_Station = tripToCheck.originDetail.name
        let compare_from_station_time = tripToCheck.originDetail.time
        
        let compare_to_station = tripToCheck.destinationDetail.name
        let compare_to_station_time = tripToCheck.destinationDetail.time
        
        let compare_duration = tripToCheck.dur
        
        print("1-exist_from_Station:: \(exist_from_Station)--compare_from_Station=\(compare_from_Station)")
        
        print("2-exist_from_station_time:: \(exist_from_station_time)--compare_to_station_time=\(compare_to_station_time)")
        
        print("3-exist_to_station:: \(exist_to_station)--compare_to_station=\(compare_to_station)")
        print("4-exist_to_station_time:: \(exist_to_station_time)--compare_to_station_time=\(compare_to_station_time)")
        
        print("4-exist_duration:: \(exist_duration)--compare_duration=\(compare_duration)")
        if ((exist_from_Station.contains(compare_from_Station)) && (exist_from_station_time.contains(compare_from_station_time)) && (exist_to_station.contains(compare_to_station)) && (exist_to_station_time.contains(compare_to_station_time)) && (exist_duration.contains(compare_duration))){
        // all aboe are same
            // if any one of above is not same then it means that the trip is different thus both 
            // existing and trip to comapre are different thus return false
        result = true
        }
        print("Trips compare result = \(result)")
        return result
    }
     override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
       // print("scrollViewDidScrollToTop::::CALLED::::.")
    
            }
     override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // print("scrollViewDidScroll:scrollView.accessibilityActivationPoint    \(scrollView.accessibilityActivationPoint)")
    
//    print("contentOffset    \(scrollView.contentOffset)")
//      print("bounds    \(scrollView.bounds)")
//    scrollView.flashScrollIndicators()
    
    }
    // MARK: Next/Previous Departures Refresh Master
  
    /*
   override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
   //print("\(scrollView.showsHorizontalScrollIndicator)")
    
//   print("-Scroll View superview-----\(scrollView.viewWithTag(55))")
//    print("-Scroll View superview-----\(scrollView.viewWithTag(65))")
//    scrollView.isPagingEnabled = true

    
    
    // extract the cell from here
    
    if ( scrollView.bounces){
        bounce += 1
        //print("Bounced ::::::::::::::bounce::::\(bounce) && \(scrollView.contentOffset.x):")
        print("Cell = \(scrollView.viewWithTag(55))")
        let xMovement = scrollView.contentOffset.x
         // MARK: Previous Departures Bring
        if ((xMovement > 0) && scrollView.bounces){
            
//        print("previous::touched Left and bounced.......")
//            print("previous::TripLegIconsCollectionViewCell:0 = \(scrollView.viewWithTag(55))")
//            print("previous::TripLegIconsCollectionViewCell:1 = \(scrollView.viewWithTag(55)?.superview)")
//            print("previous::TripLegIconsCollectionViewCell:2 = \(scrollView.viewWithTag(55)?.superview?.superview)")
//            print("previous::TripLegIconsCollectionViewCell:3 = \(scrollView.viewWithTag(55)?.superview?.superview?.superview)")
//            
          //            var indexPath = IndexPath(item: (currentDepartureCell.currentIndexPathRow), section: currentDepartureCell.currentIndexPathSection)
//            let tripInfoCurrent = tableView.cellForRow(at: indexPath) as! LegListCells
//            print("next departure Master DIct All keys = \(custom_Trip_NextDepartures_Dict.allKeys) & tripinfo keyName = \(tripInfoCurrent.keyName)")
 
//                let NEXT = "NEXT"
//                let PREVIOUS = "PREVIOUS"
//                var navigation = ""
                let currentDepartureCell = scrollView.viewWithTag(55)?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell //LegTripNextDeparturesTableViewCell
                print("previous::Cell.Current:Cell.....987::\(currentDepartureCell.currentIndexPathSection) ---- \(currentDepartureCell.currentIndexPathRow)")
                let keyName = String(currentDepartureCell.currentIndexPathSection) + String(currentDepartureCell.currentIndexPathRow)
                print("previous::Cell.Current Key Name = \(currentDepartureCell.keyName)")
            print("previous::custom trip object count = \(custom_Trip_NextDepartures_Dict.allKeys) && keyname = \(keyName)")
            print("previous::current Departure Cell = \(currentDepartureCell.keyName)")
            
            if ( custom_Trip_NextDepartures_Dict.value(forKey: keyName) != nil ){
                
                let collectionTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
                
                print("collection trip object count = \(collectionTripObject.count)")

                if (xMovement > 0){
                navigationDeparturesTripInfo = PREVIOUS
                
                if (navigationDeparturesTripInfo.contains(PREVIOUS))
                {
                
                    
                    let firstObject = collectionTripObject.firstObject as! Trip
                    // arrive latest by first object's origin.time
                    simple_earliestDepartLatestArrival_flag = true
                    // value 1 is bringing based on arrival
                    simple_earliestDepartLatestArrival_Value = 1
                    simple_expectedTripDate = firstObject.originDetail.date
                    simple_expectedTripTime = firstObject.originDetail.time
                    print("PREVIOUS:From station = \(firstObject.originDetail.name)")
                    print("PREVIOUS:from time = \(firstObject.originDetail.time)")
                    print("PREVIOUS:to station = \(firstObject.destinationDetail.name)")
                    print("PREVIOUS:From Station :: To Station:: = \(keyName)")
                 // Temp Off    getNextDeparturesForCollection(fromStation: firstObject.originDetail.name,toStation: firstObject.destinationDetail.name, fromTime: firstObject.originDetail.time, tableView: tableView, keyName: keyName,navigationType: navigationDeparturesTripInfo)
                    }
                } else {
             //   navigation = PREVIOUS
                    // ONCE NEXT IS WORKING THEN WORK ON THIS
                
                }
            }
            
//         let currentTripInfoCell
            print("PREVIOUS:Cell.Current Key Name = \(currentDepartureCell.keyName)")
            print("PREVIOUS:Going to get departures.....")
           // getNextDeparturesForCollection(fromStation: tripInfoCurrent.from_station.text!, fromTime: tripInfoCurrent.from_time.text!, tableView: tableView, keyName: tripInfoCurrent.keyName)
        }
            
            // MARK: Next Departures Bring
        else if ((xMovement < 0 && scrollView.bounces)){
            
//            print("TripLegIconsCollectionViewCell:0 = \(scrollView.viewWithTag(55))")
//            print("TripLegIconsCollectionViewCell:1 = \(scrollView.viewWithTag(55)?.superview)")
//            print("TripLegIconsCollectionViewCell:2 = \(scrollView.viewWithTag(55)?.superview?.superview)")
//            print("TripLegIconsCollectionViewCell:3 = \(scrollView.viewWithTag(55)?.superview?.superview?.superview)")
//            
            let currentDepartureCell = scrollView.viewWithTag(55)?.superview?.superview?.superview as! LegTripNextDeparturesTableViewCell //LegTripNextDeparturesTableViewCell
            print("next::Cell.Current:Cell.....987::\(currentDepartureCell.currentIndexPathSection) ---- \(currentDepartureCell.currentIndexPathRow)")
            let keyName = String(currentDepartureCell.currentIndexPathSection) + String(currentDepartureCell.currentIndexPathRow)
            print("next::Cell.Current Key Name = \(currentDepartureCell.keyName)")
            
            //            var indexPath = IndexPath(item: (currentDepartureCell.currentIndexPathRow), section: currentDepartureCell.currentIndexPathSection)
            //            let tripInfoCurrent = tableView.cellForRow(at: indexPath) as! LegListCells
            //            print("next departure Master DIct All keys = \(custom_Trip_NextDepartures_Dict.allKeys) & tripinfo keyName = \(tripInfoCurrent.keyName)")
            print("next::custom trip object count = \(custom_Trip_NextDepartures_Dict.allKeys) && keyname = \(keyName)")
            print("next::current Departure Cell = \(currentDepartureCell.keyName)")
            if ( custom_Trip_NextDepartures_Dict.value(forKey: keyName) != nil ){
                let collectionTripObject = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
                print("next::collection trip object count = \(collectionTripObject.count)")
                if (xMovement < 0){
                    navigationDeparturesTripInfo = NEXT
                    if (navigationDeparturesTripInfo.contains(NEXT))
                    {
                        simple_earliestDepartLatestArrival_flag = true
                        
                        // value 1 is bringing based on arrival
                        simple_earliestDepartLatestArrival_Value = 0
                        // send info from last object
                        let lastObjectIndex = collectionTripObject.count - 1
                        
                        let lastObject = collectionTripObject[lastObjectIndex] as! Trip
                        simple_expectedTripDate = lastObject.originDetail.date
                        simple_expectedTripTime = lastObject.originDetail.time
                        print("next From station = \(lastObject.originDetail.name)")
                        print("next time = \(lastObject.originDetail.time)")
                        print("next to station = \(lastObject.destinationDetail.name)")
                        print("next From Station :: To Station:: = \(keyName)")
                       // Temp off 8th jan getNextDeparturesForCollection(fromStation: lastObject.originDetail.name,toStation: lastObject.destinationDetail.name, fromTime: lastObject.originDetail.time, tableView: tableView, keyName: keyName,navigationType: navigationDeparturesTripInfo)
                    }
                } else {
                   // navigation = PREVIOUS
                    // ONCE NEXT IS WORKING THEN WORK ON THIS
                    
                }
            }
            

           print("touched Right and bounced....for next trips...")
        
        }
       
//        if (bounce == 4){
//        //masterTripGrabberFromSL()
//            bounce = 0
//            scrollView.isPagingEnabled = true
//            
//        }
  //  show alert when real bounce aocciurs like some -ve value comes in
       //----------Alert-----
//        Mark: Alert Code
        /*
         let alertController = UIAlertController(title: "Load Next Trips?", message: "Simple alertView demo with Destructive and Ok.", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            
            print("Destructive")
        }
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
            
        //    self.masterTripGrabberFromSL_Refresh()
        }
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        */
        //-----Alert code ends here----
    
      //  print("-----Bounce: \(bounce)----\(scrollView.isPagingEnabled)------contentOffset    \(scrollView.contentOffset.y) && D Acc Rte = \(scrollView.decelerationRate)---\(scrollView.isDragging)")
        let bounceThreshHold = CGFloat(275)
        /*if (scrollView.contentOffset.y > bounceThreshHold){
        
            print("---BOUNCE CAUGHT-------------------------contentOffset    \(scrollView.contentOffset.y)")
            let bounceThreshHold = CGFloat(30)
            
        masterTripGrabberFromSL()
        
        } */
    
//        print("-BOUNCED-----------------------Bounce check ==if=== \(scrollView.bounces)-----Count = \(bounce)")

//        print("-----------contentOffset    \(scrollView.contentOffset.y).....).\(scrollView.bounds.size)")
//        print("-----------bounds    \(scrollView.bounds)")
    
        //masterTripGrabberFromSL()
    } else {
    
      //  print("---NOT BOUNCED-------------------Bounce check ==else=== \(scrollView.bounces)")
    }
    
        //print("Scroll View Testing: Scorll View Did End Dragging: \(decelerate)")
    }
    */

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Line 3535: Coll...\(indexPath).")
        let parentCellCollectionDepartureView = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
        print("Parent Row Status=IP Selected =\(parentCellCollectionDepartureView.indexPathSelected)")
     print("Line 3200:Section:\(indexPath.section) Row:\(indexPath.row)")
//        print("Line3521: Coll.X:\(collectionView.bounds.origin.x)")
//       // collectionView.bounds.origin.x = 0
//        print("Line3521: Coll.X:\(collectionView.bounds.origin.x)")
////        collectionView.setNeedsLayout()
//        collectionView.layoutMargins.left.distance(to: 0)
//-------temp
//        
//        let cellColl1 = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuseIdentifier", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
//
//        return cellColl1
        
        //------temp
     // triplegiconscollection view cell name is old but now it is being used for next departures collection view show
     
     //          tableView.backgroundColor = UIColor.white
        // 1st of feb  let leg = (currentTripScope[0] as! Trip).LegList[collectionView.tag] as! Leg
        
        
        
        var currentTrip = Trip() //newTrip[tripSection] as! Trip
         var indexRow = Int()
        if (genericTripFlag == false) {
        print("generic trip flag is false =\(genericTripFlag)")
            currentTrip = newTrip[tripSection] as! Trip
        indexRow = parentCellCollectionDepartureView.indexPathSelected.row
        }
        else if (genericTripFlag == true){
            print("generic trip flag is true =\(genericTripFlag)")

        currentTrip = tripToShow
        
        indexRow = indexPath.row
        }
       
        

       // let leg = currentTrip.LegList[parentCellCollectionDepartureView.indexPathSelected.row] as! Leg
        let leg = currentTrip.LegList[indexRow] as! Leg
        
        print("CollectionView:Section:\(indexPath):Leg Dep Status:\(leg.departureAvailable) & Trip Count = \(leg.nextDeparturesTrip.count)")
        // check if departures are available
        print("Line3539: CurrentLeg Show Hide Status \(indexPath):TRIPINFO:LEG::\(parentCellCollectionDepartureView.indexPathSelected.row):\(leg.departureAvailable == true):\(leg.showHideLeg):Scope:From_\(leg.depScope_fromLegIndex)Scope:TO:\(leg.depScope_toLegIndex)")
        if (leg.departureAvailable == true){
            // Trip.expand == false
            // show only Trip
          let currentLegTrip = leg.nextDeparturesTrip[indexPath.section]
          
            if(currentLegTrip.depExpand == false){
            // show only trip
                let cellDepTrip = collectionView.dequeueReusableCell(withReuseIdentifier: "TripInfoDepartureCells", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
                cellDepTrip.prepareForReuse()
                
                
                cellDepTrip.from_time.text = currentLegTrip.originDetail.time
                cellDepTrip.from_station.text = currentLegTrip.originDetail.name
                cellDepTrip.to_time.text = currentLegTrip.destinationDetail.time
                cellDepTrip.to_station.text = currentLegTrip.destinationDetail.name
                cellDepTrip.duration.text = currentLegTrip.dur
                cellDepTrip.tripLevel = true
              //  let tripCell = currentLegTrip.LegList.count
                //--- ICON PRINTING CODE-----------------------------------start
               // let legIcons_y = //headerCell.viewWithTag(10)?.frame.size.height
                let legIcons_y = cellDepTrip.frame.size.height + 20 //.viewWithTag(10)?.frame.size.height

                // old starting vlaue of y is = 100
                
                print("y positions is ==== \(legIcons_y)")
             //   var startingPoint = CGPoint(x: 5.0,y: (legIcons_y + 20.0))
                
        print("Line3649: y pos: \(cellDepTrip.to_time.frame.origin.y)")
                var startingPoint = CGPoint(x: 5.0,y: 120)
                 print("Line 3589")
                let default_Dep_startingSize = CGSize(width:28.0,height:28.0)
                
                   print("Line 3591")
                let startingSize = default_Dep_startingSize //default_startingSize // CGSize(width:30.0,height:30.0)
                   print("Line 3593")
                let orientation = "x"  // x, y, or xy
                let innerSpacing = CGPoint(x:-1,y:0) // works most probabily
                let spaceFactorBwTwoLegs = CGFloat(10.0) // works
                   print("Line 3596")
                let innerLegSpacing = CGPoint(x:0,y: 0)
                   print("Line 3598")
                let sizeFactor = CGSize(width: 0.0,height: 0.0)
                // MARK: Draw Leg Icons
               // print("tripCell.LegList.Count ==== \(tripCell.LegList.count)")
               
                var iconLegLine = 0
                legIconsLineCounter = 0
                var y = 0
                var line = 1
                var column = 1
                var icon_Count_Total =  currentLegTrip.LegList.count //tripCell.LegList.count
                var screenWidth = cellDepTrip.frame.width //UIScreen.main.bounds.width
                // MARK: Leg Image width required
                // icon width is equal to two icons and inner spacing
                // 70 is being used
                // for coll use 20 for each and 5 inner spacing
                let iconLimits = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(35.0))
                print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
                // MARK: Line Termination
                
                var iconLiveCount = 3
                
                var iconLineLiveCount = 0
                var increment = 0
                // move this to above
                let legIconTopSpace = 10.0
                
                //var defaultPositionToStart =  CGPoint(x: 5.0,y: (legIcons_y + 10.0))
                 var defaultPositionToStart =  CGPoint(x: 5.0,y: (legIcons_y + 10.0))
                let iconVerticalSpaceFactor = 2.0
                let iconHorizontalSpaceFactor = 5.0
                
                for index in currentLegTrip.LegList {
                    
                //tripCell.LegList {
                    print("Line 3620 tripcell:LegList Value is here ::::\(currentLegTrip.LegList)")
                    //let someObject = tripCell.LegList[increment] as! AnyObject
                    let someObject = currentLegTrip.LegList[increment] as! AnyObject
                    
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
                            
                            startingPoint.x += startingSize.width + spaceFactorBwTwoLegs //+  startingSize.width //+ iconHorizontalSpaceFactor
                          // startingPoint.y += startingSize.height +  startingSize.height //+ iconHorizontalSpaceFactor
                            
                            iconLiveCount += 1
                        }
                        // keep printing icons
                        let ns = NSMutableArray()
                        var t = 0
                        /*
                        for index in currentLegTrip.LegList {//tripCell.LegList {
                            print(" current index counter t = \(t)")
                            
                            let obj2check = currentLegTrip.LegList[t] as! AnyObject
                            print("obj2check = \(obj2check)")
                            if (RealTidMethods.checkIfDepartureObject(objectToCheck: obj2check)){
                                
                                print("Obj2Check = Departure Cell found")
                                
                            } else {
                                
                                print("LegIcon  found .......")
                            }
                            
                            t += 1
                        }
                        */
                        //                let t = tripCell.LegList[0] as! Leg
                        
                        
                       
                        print("tripCell.LegList.count = \(currentLegTrip.LegList.count)")
                        ns.add(currentLegTrip.LegList[increment])
                        print("leglist to print = \(ns.count)")
                        
                        // MARK: temp friday draw 1
                        print("increment.........value is = \(increment)")
                        print("Count of leglists === \(currentLegTrip.LegList.count)")
                        //MARK: Temp friday 9th of drawLegs
                        //MARK: Header Cell Leg Icon Printing
                        // creating tag
                        // get section
                        // get leg current indexPath
                        // join them together
                        // merge 0 or 1 accordingly
                        let tagSeriesStart = "6"
                        let sectionIndexString = String(indexPath.section)
                        let legIndexString = String(increment)
                        let sectionLegIndexUnion = tagSeriesStart + sectionIndexString + legIndexString
                        // on every new leg printing, add 2 to the last count
                        
                        let iconTagString = sectionLegIndexUnion + "0"
                        let lineNoTagString = sectionLegIndexUnion + "1"
                        let iconTagInt = Int(iconTagString)
                        let lineNoInt = Int(lineNoTagString)
                        
                        print("Creating Tag for icon Legs:::::----------")
                        print("Current Section:\(indexPath.section)()")
                        print("Current Leg-Index:\(increment) & TotalLegs=\(currentLegTrip.LegList.count)")
                        
                        print("---------Do we have same tag values Test 1----packagin---")
                        print("----------String---------------")
                        print("iConTagString: \(iconTagString)")
                        print("lineNoTagString: \(lineNoTagString)")
                        print("----------Int---------------")
                        print("iconTagInt: \(iconTagString)")
                        print("lineNoTagString: \(lineNoTagString)")
                        
                        print("---------Do we have same tag values Test 1---Values Sent----")
                        
                       // let tagValueReceives = SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: default_startingSize, legs: ns , cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: section,indexValueFromCurrentLeg: increment, iconTagIntValue: iconTagInt!, lineNoIntValue: lineNoInt!)
                        
                        print("Line 3758: Before:\(indexPath) \(cellDepTrip.contentView.subviews.count)")
                        print("LegList Count :\(ns.count)")
                       // MARK: Test Code
                        /*
                        let countCurrent = cellDepTrip.contentView.subviews.count
                       
                         var u = 0
                
                        for index in 1...countCurrent {
                        
                       // let currentView = cellDepTrip.contentView.subviews[u]
                        
                            if let button = cellDepTrip.contentView.subviews[u] as? UIButton {
                   
                    button.backgroundColor = UIColor.red
                                
                    print("Line 3770: Button Label:\(button.title(for: UIControlState.normal)) & ")
                                print("Line 3770: Button  tag=\(button.tag) & ")
                                print("Line 3770: Button  tag=\(button.backgroundImage(for: UIControlState.normal)) & ")
                                
                                
                                
                        }
                            
                            if let image = cellDepTrip.contentView.subviews[u] as? UIImageView {
                                
                                print("Line 3770: image \(image)")
                                
                            }
                            
                            
                            
                           print("Line 3809: \(cellDepTrip.contentView.subviews[u])")
                         
                            
                            u += 1
                        }
                        var y = 0
                        print("Leg------INDEX = \(indexPath)---\(currentLegTrip.LegList.count)")
                        for index in ns
                        {
                        
                        
                        let legToPrint = ns[y] as! Leg
                        print("LegToPrint: Image Name-\(legToPrint.legImageName) & \(legToPrint.type) : Time:\(legToPrint.destination.time) :Line \(legToPrint.line)")
                        }
                        */
                        print("Line 4238-dep:Starting POint :\(startingPoint) & \(ns.count)")
                          print("INCREMENT IS 1.....\(increment)")
                        if (increment < 3){
                            
                        let tagValueReceives = SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: ns , collectionViewCell: cellDepTrip, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                        }
                        else if (increment == 3){
                            print("INCREMENT IS 1....llll.")
                            let newAddress = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
                            let legMore = Leg(journeyType: "", name: "", type: "", idx: "", geomRef: "", dist: "", hide: "", dir: "", line: "", journeyDetailRef: "", origin: newAddress, destination: newAddress, legImageName: MORELEGSDEP, rtu_Message_Flag: false, rtu_Message: "", currentLegStatus: false)
                            
                            legMore.line = "599"
                            legMore.name = "599"
                            legMore.type = MORELEGSDEP
                            let nsMore = NSMutableArray()
                            nsMore.add(legMore)
                        let tagValueReceives = SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: nsMore , collectionViewCell: cellDepTrip, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                        
                        }
                        else if (increment > 3){
                        
                        print("Legs are not going to be printed.... increment=\(increment) && \(indexPath)")
                            
                        
                        }
//                        print(" Tag Values =IP=\(indexPath) = VR =\(tagValueReceives.lineNoIntReturned) =\(tagValueReceives.iconTagIntReturned)")
//                        
//                        print("Line 3758: After:\(indexPath) \(cellDepTrip.contentView.subviews.count)")
                        
                      // let tagValuesReceivesCol = SlifeMethods.drawLegsCollectionView(startingPoint: <#T##CGPoint#>, startingSize: <#T##CGSize#>, legs: <#T##NSMutableArray#>, collectionViewCell: <#T##UICollectionViewCell#>, orientation: <#T##String#>, innerLegSpacingFactor: <#T##CGPoint#>, interLegSpacingFactor: <#T##CGPoint#>, sizeFactor: <#T##CGSize#>)
                        // Extract buttons which have been added
                        print("--view for header: line : 5001-------Do we have same tag values Test 1-----Values Received--")
                        print("Current Section:\(indexPath.section)")
                      //  print(" Line 5003tagValueReceives.iconTagIntReturned = \(tagValueReceives.iconTagIntReturned)")
                        //print(" tagValueReceives.lineNoIntReturned = \(tagValueReceives.lineNoIntReturned)")
                        
                        //                let iconButton = headerCell.contentView.v
                        
                        //                print("iconButton:::::: \(iconButton)")
                        //MARK: Trip Info Leg Icon Interaction
                  //      let iconNumberButton = cellDepTrip.contentView.viewWithTag(tagValueReceives.iconTagIntReturned) as! UIButton
                        
                        
                        
                   //     let lineNumberButton = cellDepTrip.contentView.viewWithTag(tagValueReceives.lineNoIntReturned) as! UIButton
                     /*   let currentLeg = currentLegTrip.LegList[increment] as! Leg
                        
                        print("currentLeg.enabled_TransportType = \(currentLeg.enabled_TransportType) && Line Number Enab= \(currentLeg.enabled_LineNumber)")
                        
                        print("iconButton Accessibility identifier: & ---\(iconNumberButton.accessibilityIdentifier) && \(currentLeg.type) && Line = \(currentLeg.line)")
                        */
                        // MARK: Version 2 enabl disable
                        /*--
                         if ((currentLeg.enabled_TransportType == true ) && (currentLeg.type.contains(iconNumberButton.accessibilityIdentifier!))){
                         // green means it is enabled while red means it is disabled :show or hide
                         
                         iconNumberButton.backgroundColor = iconSelectedColor
                         lineNumberButton.backgroundColor = disabledColor
                         }
                         else {
                         
                         
                         iconNumberButton.backgroundColor = disabledColor
                         
                         // lineNumberButton.backgroundColor = enabledColor
                         
                         }
                         */
                     //   print("currentLeg.filterLine = update::: \(currentLeg.enabled_LineNumber) & \(currentLeg.line)")
                        
                        
                        
                        /*if (currentLeg.enabled_LineNumber){
                         lineNumberButton.backgroundColor = enabledColor
                         iconNumberButton.backgroundColor = disabledColor
                         }
                         
                         else if (currentLeg.enabled_LineNumber == false){
                         
                         
                         lineNumberButton.backgroundColor = disabledColor
                         
                         
                         }*/
                        //
                        //                if (currentLeg.enabled_LineNumber == true ){
                        //                    // green means it is enabled while red means it is disabled :show or hide
                        //
                        //                    lineNumberButton.backgroundColor = iconSelectedColor
                        //
                        //                }
                        //                else {
                        //
                        //
                        //                    lineNumberButton.backgroundColor = disabledColor
                        //
                        //                }
                        
                      //  print("lineNumberButton Accessibility identifier: \(lineNumberButton.accessibilityIdentifier)")
                        
                        
                    //    print("legicon:::::trip level:\(currentLeg.clickLevel):Line:\(currentLeg.line)-Lin Status=\(currentLeg.enabled_LineNumber) Type: \(currentLeg.type) & typeStatus = \(currentLeg.enabled_TransportType)")
                        // Mark: 23rd dec 1800-changed clicked to  showClickedTransportType
                        //                showClickedLine
                        
                        /* MARK: VERSION 2.0 filter trip > tripinfo
                         lineNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedLegOrLineFilter), for: UIControlEvents.touchUpInside)
                         // lineNumberButton.backgroundColor = UIColor.red
                         // iconNumberButton.backgroundColor = UIColor.cyan
                         
                         iconNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedLegOrLineFilter), for: UIControlEvents.touchUpInside)
                         
                         */
                        
                        
                    }
                    increment += 1
                    //  }
                    
                    
                    // temp skip departure cell end here------------------------
                }
                
                
                

  /*
                let count = cellDepTrip.contentView.subviews.count
                print("Line3568: Before:\(count): \(indexPath)")
                var p = 0
                for index in 1...count {
                    
                    print("Line3579: View Printing:\(cellDepTrip.contentView.subviews[p])")
                    if let checkButton =  cellDepTrip.contentView.subviews[p] as? UIButton
                    {
                    
                        print("Line 3579: checkButton Caught:b4:\(cellDepTrip.contentView.subviews.count)")
                        cellDepTrip.contentView.willRemoveSubview(checkButton)
                        
                        print("Line 3579: checkButton Caught:aft::\(cellDepTrip.contentView.subviews.count)")
                        //self.contentView.willRemoveSubview(nextDepartureTillCurrLeg_Outlet)
                        
                        
                    }
                    p += 1
                    
                }
                print("Line3568: After:\(cellDepTrip.subviews.count)")
*/
                return cellDepTrip
            }
 
            // Trip.expand == true
            // show all legs within trip
        
        // return trip
            /* 2nd feb change start
            let legDepartureTrip = leg.nextDeparturesTrip[indexPath.row]
            let cellColl = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuseIdentifier", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
            cellColl.from_station.text = legDepartureTrip.originDetail.name
            cellColl.from_time.text = legDepartureTrip.originDetail.time
            cellColl.to_station.text = legDepartureTrip.destinationDetail.name
            cellColl.to_time.text = legDepartureTrip.destinationDetail.time
            cellColl.duration.text = legDepartureTrip.dur
           2nd feb change end */
           // temp integeration with old vay of departure show...........1100 2ND FEB...........START
            // triplegiconscollection view cell name is old but now it is being used for next departures collection view show
            
            //          tableView.backgroundColor = UIColor.white
            print("--Collection view-----------Section = \(parentCellCollectionDepartureView.indexPathSelected)")
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripInfoDepartureCells", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
            print("Line3539: CurrentLeg Show Hide Status :\(leg.showHideLeg)")
          //  cell.isHidden = leg.showHideLeg
            print("Line3539: CurrentLeg Show Hide Status :Cell:IP \(parentCellCollectionDepartureView.indexPathSelected)::\(cell.isHidden):\(leg.showHideLeg)")
            cell.tripLevel = false
            print(cell.superview?.superview.debugDescription)
            
            // MARK: border collection view
            
          /*  var layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            //    layout = collectionView.delegate
            layout.minimumInteritemSpacing = 5.0
            */
            //layout.scrollDirection = UICollectionViewScrollDirection.horizontal
                   //   if (custom_Trip_NextDepartures_Dict.count > 0 ){
            //   let view = collectionView.superview!
                // MARK: Collection view friday eve 9th nov temp off
                //
                //            let currentCell = view.superview as! LegListCells
                let currentCell = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell // chg 002 2nd febview.superview as! LegTripNextDeparturesTableViewCell
            
            let currentSection = String(indexPath.section)// String(currentCell.indexPathSelected.section)//String(indexPath.section)
            let currentRow = String(indexPath.row) // String(currentCell.indexPathSelected.row)
            
            
                //MARK: Reset Trip INfo Dep navigation buttons
//                currentCell.NextDepOutLet.isSelected = false
//                currentCell.PrevDepOutLet.isSelected = false
//                // Mark: scroll
                /*
                 if (navigationDeparturesTripInfo.contains(NEXT)){
                 print("latest count of trip departures = \(lastCountTripInfoDepartureCells)")
                 
                 navigationDeparturesTripInfo = ""
                 }
                 */
                let keyNameTemp = currentCell.keyName
                print("printing cells..keyname temp from current cell = \(keyNameTemp)")
                let keyName = currentSection + currentRow
                print("generated current key via indexpth.section and row = \(keyNameTemp)")
              //if (collection_Values_flag == true){
//                    let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
//                    
//                    print("customDepTripArray Count = \(customDepTripArray.count)")
//                    
//                    print("-----test 10989")
//                    // MARK: temp wed 14 th dec changing
                      let trip = newTrip[tripSection] as! Trip //customDepTripArray[indexPath.section] as! Trip
            let tripCustom = ((trip.LegList[currentCell.indexPathSelected.row] as! Leg).nextDeparturesTrip[indexPath.section]) as! Trip

                //let tripCustom = customDepTripArray[indexPath.section] as! Trip
                    print("Trip Level info in collection view = \(tripCustom.originDetail.type)")
                    print("Collection View Cell Section  =\(indexPath.section) && Row = \(indexPath.row)")
                    //MARK: Temp 14th dec changes
                    // print("Trip Custom Count Collection View :customDepTripArray \(customDepTripArray.count)")
                    
                    print("Trip Custom Count Collection View : \(tripCustom.LegList.count)")
                      let leg = tripCustom.LegList.firstObject as! Leg
                    print("Leg: LIne 3371:name:\(leg.origin.name)")
            print("Leg: LIne 3371:time:\(leg.origin.time)")
            

            //  let leg = ((tripCustom.LegList[currentCell.indexPathSelected.row] as! Leg).nextDeparturesTrip[indexPath.section].LegList[indexPath.row] as! Leg)  //tripCustom.LegList[indexPath.row] as! Leg
                    print("After::: current Status coll. leg show/hide = \(leg.showHideLeg)---\(leg.line)--\(indexPath)")
                    
                    print("defaul value leg.show hide value = \(leg.showHideLeg)")
            
                    cell.from_station.text = "COLL VALUE "
            
            /*
 if (leg.showHideLeg == true)
                    {
                        cell.isHidden = false
                    }    else {
                        
                        
                        cell.isHidden = true
                        
                     }
 */
            print("Current Hidden value of departure cell = indexpath = \(indexPath)\(cell.isHidden)")
                    
                    //---Departure filter check if only selected line has to be shown-------END
                    
                    
                    //   let leg = tripCustom.LegList[indexPath.row] as! Leg
                    // -----temp
                    print("trifpCustom.LegList.count===\(tripCustom.LegList.count)")
                    
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
                        
                        print("collectionCellColor = FALSE section \(indexPath.section) & row \(indexPath.row)")
                    } else {
                        
                        //collectionCellColor = true
                        cell.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
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
                    let legTemp = tripCustom.LegList[indexPath.row] as! Leg
                    // MARK: Collection View Departure icon count
                    
                   //2nd feb change testCollectionMArray.add(tripCustom.LegList[indexPath.row])
          // testCollectionMArray.add(leg)
            testCollectionMArray.add(legTemp)
            
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
            print("Line 4238:Starting POint :\(startingPoint)")
            

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
                    if (cell.viewWithTag(30) == nil) {
                        print("button is null........ ")
                        
                        
                    } else {
                        
                        let iconButton = cell.viewWithTag(30) as! UIButton
                        iconButton.isHidden = true
                        
                        let iconUILabel_button = cell.viewWithTag(35) as! UIButton
                        
                        iconUILabel_button.isHidden = true
                        
                    }
            
            SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: testCollectionMArray, collectionViewCell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
            
                    // SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: testCollectionMArray, collectionViewCell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
                    
                    print("Collection View cell tag is = \( cell.viewWithTag(30))")
                    //MARK: Departure Cell Info Filling
                    
                    
                    let width = 8
                    
                    
            
                    
                    cell.from_station.text = legTemp.origin.name
                    
                    
                    cell.to_station.text = legTemp.destination.name
                    
                    
                    
                    //cell.line_number.text = String(leg.line)
                    print("test 2")
                    cell.from_time.text = legTemp.origin.time
                    cell.to_time.text = legTemp.destination.time
                    
                    //cell.from_time.setTitle(leg.origin.time, for: .normal)
                    print("test 3")
                    //cell.to_time.setTitle(leg.destination.time, for: .normal)
                    print("test 4")
                    //                cell.from_time.setTitle(tripCustom.originDetail.time, for: .normal)
                
                
                
                print("-----end--------Section = \(indexPath.section) & Row = \(indexPath.row)")
                
                
            
            

            
            // temp integeration with old vay of departure show..........1100 2ND FEB............END
        
        return cell
        }
//        else {
        
     // MARK temp main change start here
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripInfo_CollectionCell", for: indexPath as IndexPath) as! TripInfoCollectionViewCell
        print("Cell Trip Info:::::: collection view :\(indexPath)")
        
        //cell.from_station.text = "" + String(collectionView.tag)
     // 1st of feb
        //   if (currentTripScope.count == 1){
        
       
        
            cell.from_station.text = leg.origin.name
            cell.from_time.text = leg.origin.time
            
            cell.to_station.text = leg.destination.name
            cell.to_time.text = leg.destination.time

            cell.towards.text = leg.dir
            cell.line_dist.text = leg.line
          print("Before:cell.nextDepartureCL.frame.origin.x==\(cell.nextDepartureCL.frame.origin.x)")
            print("CellCollection Width= \(cell.frame.width)")
           // cell.frame.width = 200
            var bounds = UIScreen.main.bounds
            var width = bounds.width - 100
            cell.nextDepartureCL.frame.origin.x = width
            // T-Des
            cell.nextDepTillDestination.frame.origin.x = width
            cell.nextDepTillDestination.frame.origin.y = 30
            // IS
            cell.intermediateStops.frame.origin.x = width
            cell.intermediateStops.frame.origin.y = 60
            
            cell.nextDepartureCL.frame.origin.y = 0
            print("After:cell.nextDepartureCL.frame.origin.x==\(cell.nextDepartureCL.frame.origin.x)")
            //cell.rtu_Message.isHidden = true
            
            // old let code integration start here
            cell.tag = indexPath.row
            cell.transportTypeOutlet.isHidden = true
      //  }
   //1st of feb  let legList = currentTripScope[0] as! Trip //).LegList[collectionView.tag]
            let legList = newTrip[tripSection] as! Trip //).LegList[collectionView.tag]
            
     // let currentCell =  cellTripInfo.superview?.superview?.superview  as! LegTripNextDeparturesTableViewCell
        let view = collectionView.superview!
        let currentCell = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
        print("CurrentCell collection.attempt = \(currentCell.currentIndexPathSection) & Row = \(currentCell.currentIndexPathRow)")
    print("Current Cell in collection view =collectionView.tag= \(collectionView.tag)")
         print("CcollectionView.superviewview =Level 0 = \(collectionView.superview)")
    
        print("CcollectionView.superviewview =Level 1 = \(collectionView.superview?.superview)")
        
      // print("CurrentCell: TripInfo :SECTION= \(currentCell.currentIndexPathSection)----ROW-\(currentCell.currentIndexPathRow)")
       //  cellTripInfo.from_station.text = String(currentCell.currentIndexPathSection) + String(currentCell.currentIndexPathRow)
        cell.rtuMessage.isHidden = true
        //----------------------------------cell integeration starts here ----- 30th jan 
        let currentIndex = indexPath.row - departureCounter
        let test = NSMutableArray()
        var count = legList.LegList.count
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "TripInfoCell", for: indexPath as IndexPath) as! TripInfoTableViewCell
        //MARK: DepartureButton On TripInfo cell Level
        cell.tag = indexPath.row
        
        //print("Line 3983: B4:indexPath: \(indexPath): AllKeys=\(nextDepartureRemainingLegStatusDict.allKeys):CellState: \(cell.nextDeparturesOutlet.state)")
        
       // cell.showCurrentLegDep_outlet.tag = indexPath.row
        /*
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = cellBorderWidth
        //        headerCell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
        //MARK:BorderTripInfo
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = cellBorderWidth
        */
        //headerCell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
            tableView.backgroundColor = UIColor.lightGray
        cell.sectionInfo = String(indexPath.section)
        cell.rowInfo = String(indexPath.row)
        print("IndexPath:Section:\(indexPath)")
        cell.keyName = cell.sectionInfo + cell.rowInfo
        print("Cell.KeyName:assigned for indexpath= \(cell.keyName)")
        print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
        // cell.name.isHidden = true
        //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
        //cell.towards_or_walk.isHidden = true
        test.add(legList.LegList[currentCell.indexPathSelected.row])
        
        //        CGPoint(x: 40, y: 40)
        let startingPoint = CGPoint(x: cell.to_time.frame.origin.x,y: cell.to_time.frame.size.height + 20)
        let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
        let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        // MARK: Move to collection 1 ---end
        count = count - 1
        cell.legImage.image = UIImage(named: leg.legImageName)
        // MARK: Leg
        
        // legList.originDetail.name
        //----#1-----#2------------------------ Origin Station....Leg
        cell.from_station.text = leg.origin.name
        print("cell.from_station.text::::\(cell.from_station.text)")
        // temp cell.from_time.text = legList.originDetail.time
        cell.from_time.text = leg.origin.time
        // MARK: RTU Message Cell Level
        // MARK: Temp Testing
        print("CurrentLeg : index path : Line4335: \(indexPath) & \(leg.nextDeparturesTrip.count)")
        
        if (leg.rtu_Message_Flag == true){
            print("cell:: RTU Message ::::")
            print(leg.rtu_Message)
            cell.rtuMessage.isHidden = true
            cell.rtuMessage.text = leg.rtu_Message
            cell.rtuMessage.textColor = UIColor.red
            cell.from_station.backgroundColor = UIColor.red
            cell.from_station.textColor = UIColor.white
        } else {
            cell.rtuMessage.isHidden = true
        }
        //         cell.towards_or_walk.text = ""
        
        //-----#3------Visual Leg
        /* 17th jan 2017 0400
         cell.nextDepartureTillCurrLeg_Outlet.tag = indexPath.row
         cell.nextDeparturesLatest.addTarget(self, action: #selector(TripSuggestionsTViewController.nextDepartureTarget), for: UIControlEvents.touchUpInside)
         print("Cell.NextDepartureTillCurr: \(indexPath)")
         */
        print(test.count)
        // MARK: Move to collection 2
        // MARK: temp friday draw 3 cell view
        let tagSeriesStart = "7"
        let sectionIndexString = String(indexPath.section)
        let increment = indexPath.row
        let legIndexString = String(increment)
        let sectionLegIndexUnion = tagSeriesStart + sectionIndexString + legIndexString
        // on every new leg printing, add 2 to the last count
        
        let iconTagString = sectionLegIndexUnion + "0"
        let lineNoTagString = sectionLegIndexUnion + "1"
        let iconTagInt = Int(iconTagString)
        let lineNoInt = Int(lineNoTagString)
        // check if old icon exists then remove them because they
        //        print("Leg Icon To Remove Old  Tag = \(iconTagInt)")
        //        if let legIconToRemove = cell.contentView.viewWithTag(iconTagInt!) as? UIButton {
        //        print("LegIconToRemove Old Found =icontag: \(legIconToRemove.accessibilityIdentifier)")
        //        legIconToRemove.backgroundColor = UIColor.black
        //        }
        //
        //        if let legLineDistIconToRemove = cell.viewWithTag(lineNoInt!) as? UIButton {
        //            print("LegIconToRemove Old Found = lineno:\(legLineDistIconToRemove.accessibilityIdentifier)")
        //            legLineDistIconToRemove.backgroundColor = UIColor.black
        //        }
        //
        if (watchIcons == false){
           // let tagValueReceived = SlifeMethods.drawLegsCollectionView(startingPoint: startingPoint, startingSize: startingSize, legs: test, collectionViewCell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
           // let tagValueRec = SlifeMethods.drawTripInfoIconsOnColView(startingPoint: CGPoint, startingSize: <#T##CGSize#>, legs: <#T##NSMutableArray#>, cellCollectionView: <#T##UICollectionView#>, orientation: <#T##String#>, innerLegSpacingFactor: <#T##CGPoint#>, interLegSpacingFactor: <#T##CGPoint#>, sizeFactor: <#T##CGSize#>, indexValueFromSectionOrRow: <#T##Int#>, indexValueFromCurrentLeg: <#T##Int#>, iconTagIntValue: <#T##Int#>, lineNoIntValue: <#T##Int#>)
            
            print("Line3444:indexPath.Row...\(currentCell.indexPathSelected.row)")
            let tagValueReceived = SlifeMethods.drawLegOnTripInfo(startingPoint: startingPoint, startingSize: startingSize, legs: test, cellCollectionView: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: currentCell.indexPathSelected.row,indexValueFromCurrentLeg: currentCell.indexPathSelected.row,iconTagIntValue: iconTagInt! ,lineNoIntValue: lineNoInt!)
            
            cell.legTag = tagValueReceived.iconTagIntReturned
            cell.lineDistTag = tagValueReceived.lineNoIntReturned
            
            print("cell.legTag=indexPath=\(cell.legTag)")

            //-------add ibaction to icons and line number---start
            
            
            // Extract buttons which have been added
            //MARK: Trip Info Leg Icon Interaction
            let iconNumberButton = cell.viewWithTag(tagValueReceived.iconTagIntReturned) as! UIButton
            let lineNumberButton = cell.viewWithTag(tagValueReceived.lineNoIntReturned) as! UIButton
            
            /*
            let iconNumberButton = cell.contentView.viewWithTag(tagValueReceived.iconTagIntReturned) as! UIButton
            //        iconNumberButton.backgroundColor = UIColor.red
            let lineNumberButton = cell.contentView.viewWithTag(tagValueReceived.lineNoIntReturned) as! UIButton
           */
            //           iconNumberButton.backgroundColor = UIColor.red
            //            lineNumberButton.backgroundColor = UIColor.yellow
            if (leg.showHideLeg == true && leg.enabled_LineNumber == true){
                // green means it is enabled while red means it is disabled :show or hide
                //            iconNumberButton.backgroundColor = UIColor.orange
                lineNumberButton.backgroundColor = UIColor.blue
                
            }
            else {
                lineNumberButton.backgroundColor = UIColor.yellow
                //            iconNumberButton.backgroundColor = UIColor.red
            }
            print(" After entering leg.show hide : cell color is = \(UIColor.orange)")
            print("trip info trip info lineNumberButton Accessibility identifier: \(lineNumberButton.accessibilityIdentifier)")
            print("trip info legicon:::::should be trip info:\(leg.clickLevel):")
            // Mark: 23rd dec 1800-changed clicked to  showClickedTransportType
            //                showClickedLine
            lineNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedTransportTypeOrLineInNextDepartures), for: UIControlEvents.touchUpInside)
            print("leg.enabled_TransportType_______\(indexPath)_Leg.TT.\(leg.enabled_TransportType)-LLE_\(leg.enabled_LineNumber) &Line& \(leg.line) && \(leg.type)")
            lineNumberButton.isUserInteractionEnabled = true
            iconNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedTransportTypeOrLineInNextDepartures), for: UIControlEvents.touchUpInside)
            iconNumberButton.isUserInteractionEnabled = true
            print("Line 4111:LndexPath:Status: ,,,,,,,,,\(indexPath):iconNumberButtonUserInter=\(iconNumberButton.isUserInteractionEnabled):IconTag:\(iconNumberButton.tag)")
            print("Line 4111:LndexPath:Status: \(indexPath):lineNumberButton=\(lineNumberButton.isUserInteractionEnabled):LineTag:\(lineNumberButton.tag)")
            print("Line 4148...")
      // 1st of feb  }
        }
            print("About to return celll...\(indexPath).")
      //  }
        return cell
        // ----------------cell integeration ends here ---30th jan
       
    // MARK temp main change End here
        // MARK: Major Change start here : see above 
        /* 30th jan 2017
     print("--Collection view-----------Section = \(indexPath.section) & Row = \(indexPath.row)")
     
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewReuseIdentifier", for: indexPath as IndexPath) as! TripLegIconsCollectionViewCell
     
        
    print(cell.superview?.superview.debugDescription)
    
     // MARK: border collection view
     
           var layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//    layout = collectionView.delegate
        layout.minimumInteritemSpacing = 5.0
    
     //layout.scrollDirection = UICollectionViewScrollDirection.horizontal
     print("Custom Trip Next Departures\(custom_Trip_NextDepartures_Dict.allKeys)")
        print("Custom Trip Next Departures Dict.count = In departure cell = \(custom_Trip_NextDepartures_Dict.count)")
     if (custom_Trip_NextDepartures_Dict.count > 0 ){
     let currentSection = String(indexPath.section)
     let currentRow = String(indexPath.row)
     let view = collectionView.superview!
     // MARK: Collection view friday eve 9th nov temp off
     //
     //            let currentCell = view.superview as! LegListCells
     let currentCell = view.superview as! LegTripNextDeparturesTableViewCell
     
        //MARK: Reset Trip INfo Dep navigation buttons
        currentCell.NextDepOutLet.isSelected = false
        currentCell.PrevDepOutLet.isSelected = false
        
        
       
        // Mark: scroll
        /*
        if (navigationDeparturesTripInfo.contains(NEXT)){
        print("latest count of trip departures = \(lastCountTripInfoDepartureCells)")
        
        navigationDeparturesTripInfo = ""
        }
        */
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
     
    let tripCustom = customDepTripArray[indexPath.section] as! Trip
     //let tripCustom = customDepTripArray[indexPath.section] as! Trip
        print("Trip Level info in collection view = \(tripCustom.originDetail.type)")
     print("Collection View Cell Section  =\(indexPath.section) && Row = \(indexPath.row)")
        //MARK: Temp 14th dec changes
        // print("Trip Custom Count Collection View :customDepTripArray \(customDepTripArray.count)")
        
        print("Trip Custom Count Collection View : \(tripCustom.LegList.count)")
        //  let leg = tripCustom.LegList.firstObject as! Leg
        let leg = tripCustom.LegList[indexPath.row] as! Leg
    print("After::: current Status coll. leg show/hide = \(leg.showHideLeg)---\(leg.line)--\(indexPath)")
       
        print("defaul value leg.show hide value = \(leg.showHideLeg)")
        if (leg.showHideLeg == true)
        {
        cell.isHidden = false
        }    else {
        
        
            cell.isHidden = true
            
        
        
        }
        print("Current Hidden value of departure cell = indexpath = \(indexPath)\(cell.isHidden)")
        
        //---Departure filter check if only selected line has to be shown-------END
        
     
     //   let leg = tripCustom.LegList[indexPath.row] as! Leg
     // -----temp
     print("trifpCustom.LegList.count===\(tripCustom.LegList.count)")
     
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
        
     print("collectionCellColor = FALSE section \(indexPath.section) & row \(indexPath.row)")
     } else {
     
     //collectionCellColor = true
     cell.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
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
     
  //   collectionView.setNeedsLayout()
     
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
     
     // text related operation
        
     
     return cell
        MAJjor change: 30th jan */
     }
    
    
 //-------------------------end
    //    swiitching off on 23rd Dec
    /*replaced from above which is same as below
     //MARK: checked : 23rd dec: same as other latest
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
    //MARK: This is the latest one : checked 23rd dec 0933

//    - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 100, 0, 0);
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //--------------------
        let currentCell = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
    
        var currentTrip = newTrip[tripSection] as! Trip
        var currentLeg = currentTrip.LegList[currentCell.indexPathSelected.row] as! Leg
        var currentLegDepTrip = currentLeg.nextDeparturesTrip[indexPath.section]
        //--------------below is the code if you want to show tripInfo in the same collection view 
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        print("------S2--------")
        print("-Trip Header Cell Clicked-----S2--------")
        let vc = storyboard?.instantiateViewController(withIdentifier: "TripInfoTableViewController") as! TripInfoTableViewController
        print("--Trip Header Cell Clicked-----S3--------")
        
        //        vc?.setValue(0, forKey: "showTripIndex")
        // let currentTrip = newTrip[0] as! Trip
        let currentTripToShow = Trip()
        
        print("--Trip Header Cell Clicked-----with tag = \(showTripIndexOnTripInfo)--------")
        
       // currentTripInArray.add((newTrip[showTripIndexOnTripInfo] as! Trip))
        // vc.setValue(selectedTripHeaderCell., forKey: "tripselected")
     //   vc.setValue(selectedTripHeaderCell.tag, forKey: "tripSection")
        vc.setValue(true, forKey: "genericTripFlag")
        vc.setValue(currentLegDepTrip, forKey: "tripToShow")
//
       /*
         let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TripInfoTableViewController") as! TripInfoTableViewController
        self.addChildViewController(popOverVC)
        popOverVC.setValue(true, forKey: "genericTripFlag")
        popOverVC.setValue(currentLegDepTrip, forKey: "tripToShow")
        
        //popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        */
        self.dismiss(animated: true, completion: { print("Dissmissed is called::::.")})
        
        //----------------
        self.navigationController?.pushViewController(vc, animated: true)
        // but the problem is how to use prepare for resuse because images are not appearning correct
        // check if the current tapped cell is of type Trip Level Coll.Cell
     /*
         let currentCollCell = collectionView.cellForItem(at: indexPath) as! TripLegIconsCollectionViewCell
        print("Line 4982: IP:Selected:\(currentCell.indexPathSelected.row)")
        print("Line 4982: IP:Section:\(indexPath.section)")
        print("Line 4983: Current Trip Level :BEFORE:IP:\(indexPath):: \(currentCollCell.tripLevel)")
        print("Line 4983: Current Trip Level BEFORE: \(currentLegDepTrip.depExpand)")
       
         if (currentCollCell.tripLevel == true){
        print("INSIDE TRUE")
        // set it to false
            currentCollCell.tripLevel = false
            currentLegDepTrip.depExpand = true
         //   collectionView.insertItems(at: [IndexPath(item: indexPath.row, section: indexPath.section)])
            
        }
        else {
          print("INSIDE FALSE")
        // set it to true
            currentCollCell.tripLevel = true
             currentLegDepTrip.depExpand = false
        
        }
         print("Line 4983: Current Trip Level :AFTER \(currentCollCell.tripLevel)")
        print("Line 4983: Current Trip Level :AFTER: \(currentLegDepTrip.depExpand)")
        
        collectionView.reloadData()
        
        print("Line 4936: indexpath:\(indexPath)")
        */
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
 
//    (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Line4942: CollectionView DataSource:\(indexPath):\(collectionView.dataSource)")
        let currentTrip = newTrip[tripSection] as! Trip
        let currentLegRowID = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
        print("Line4288:CurrentLegRowID:\(currentLegRowID.indexPathSelected)")
        
        let currentLeg = currentTrip.LegList[currentLegRowID.indexPathSelected.row] as! Leg
        print("Line 4261: currentleg:\(currentLegRowID.currentIndexPathSection):ROW :\(currentLegRowID.currentIndexPathRow) ")
        if (currentLeg.departureAvailable == true){
        
        print("CurrentLeg.DepartureAvailable: TRUE...")
        return CGSize(width: 90, height: 200)
        
        }
        
        print("CurrentLeg.DepartureAvailable: false...")
        var bounds = UIScreen.main.bounds
        var width = bounds.width - 20
        
        
        return CGSize(width: width, height: 144)
    }
 
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        print("Line 5070:...")
        // temp start
//        print("Line 4294:.....\(section)")
//        return 2
//        // temp end
       //        let tripCell = newTrip[section] as! Trip
        //
        //        print("Trip Cell (Number of items in section--\(tripCell.LegList.count)")
        //        return tripCell.LegList.count
        //
        // MAIN CHange temp start
          let parentCellCollectionDepartureView = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
        
//        print("Line:4319:Parent Leg:ID:\(parentCellCollectionDepartureView.indexPathSelected)")
//        print("Going to return number of items.....\(section).")
//        return
        print("Line 5071: in number of items.......")
       let currentTrip = newTrip[tripSection] as! Trip
        // Get current Leg:
        let currentLegRowID = collectionView.superview?.superview as! LegTripNextDeparturesTableViewCell
        
        print("Line4291:CurrentLeg:ID:\(currentLegRowID.indexPathSelected.row)")
        
        
        let currentLeg = currentTrip.LegList[currentLegRowID.indexPathSelected.row] as! Leg
        
        if (currentLeg.departureAvailable == true){
        
            
            
        print("Line4292: For Leg:Section:\(section) & Count = \(currentLeg.nextDeparturesTrip.count)")
            let legListCurrentDepTrips = currentLeg.nextDeparturesTrip[section].LegList as! NSMutableArray
            let legDepartureTrip = currentLeg.nextDeparturesTrip[section] as! Trip
            
            
            //5th Feb ----------------------1520-start
            // if trip expand is true then return legList.Count else return 1
            print("Line 5082: LegDepartureTrip: \(legDepartureTrip.depExpand)")
            if (legDepartureTrip.depExpand == true){
            
                
                
                
                
                
                
                print("Leg Departure Trip: Count: \(legDepartureTrip.LegList.count)")
            return legDepartureTrip.LegList.count
            
            
            } else if (legDepartureTrip.depExpand == false){
            
                if (genericTripFlag == false ){
            
            return 1
                }
                else if (genericTripFlag == true){
               
                let legListCount = tripToShow.LegList.count
                print("Leg Departure Trip: Count:GenericFlag= \(legListCount)")
                    
                return legListCount
                    
                }
            }
          //  let currentLegDepLegCount = (currentTrip.LegList[currentLegRowID.indexPathSelected.row] as! Leg).
            //5th Feb ----------------------1520-start

            
            print("Line:4334:Parent Leg:ID:\(parentCellCollectionDepartureView.indexPathSelected)")
            print("Line4335:Section Return.....\(section).")
            print("LDep Count::\(currentLeg.nextDeparturesTrip.count)")
            //collectionView.reloadData()
            let legCounts = currentLeg.nextDeparturesTrip[section].LegList.count
            print("Current LegCounts for LegID:\(parentCellCollectionDepartureView.indexPathSelected) section: \(section) : Legs:\(legCounts)")
        return legCounts // currentLeg.nextDeparturesTrip.count
            
        }
        // else return 1
        print("Line5132: returning count \(1)")
        return 1
        
    
        /* 1st feb old
        // MAIN change temp end
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
                let legsToFilter = tripInfoDepartureCount.LegList as! NSMutableArray
                //--------------- start
                //if (collection_Values_flag == true){
                //let customDepTripArray = custom_Trip_NextDepartures_Dict[keyNameTemp] as! NSMutableArray
                
                print("customDepTripArray Count = \(customDepTripArray.count)")
                
                print("-----test 10989")
                let tripCustom = customDepTripArray[section] as! Trip
                print("tripCustom.LegList.count==number of items = Section = \(section)\(tripCustom.LegList.count)")
                var i = 0
                print("Returning collection view item count = tripCustom.LegList.count = \(tripCustom.LegList.count) ")
                
                // MARK: Collection View item count latest
                var itemCountComplete = 0
                
                //-------------Departure Filter code .........  28th dec Wed 0730------start
                // 28th dec wed 0730 -----start
                let mainTrip = newTrip[currentCell.currentIndexPathSection] as! Trip
                //print("Main Trip Count is === \(maintr)")
                //MARK: bug SLife.TripInfoDepartures' (0x10b936608) to 'SLife.Leg' (0x10b93b338).
                
                let legDepartureFilterStatus = mainTrip.LegList[currentCell.legIndexForDepartureShow] as! Leg //tripCustom.LegList[indexPath.row - 1] as!Leg
                let line_dist_Value = legDepartureFilterStatus.line
                let transp_type_Value = legDepartureFilterStatus.type
                let filterDepartureStatus = legDepartureFilterStatus.filterDepartures
                
                print("Line Dist Value =Departure Cells=Line/Dist =  \(line_dist_Value) && TrsnType =  \(transp_type_Value)")
                
                print("Leglist count in mainTrip =tripCustom.LegList.count= \(tripCustom.LegList.count)")
                
                print("filterDepartureStatus====----------checking if departure is true----------section--\(section)----TRUE / FALSE:\(filterDepartureStatus)")
               // print("Before: Coll Cell old value before all tess is = \(cell.isHidden)")
                // iterate through LegLi
               var o = 0
                var collectionCellCount = 0
                
                print("legDepFilterStatus.EnabledTYpe==== \(legDepartureFilterStatus.enabled_TransportType) && Line = \(legDepartureFilterStatus.enabled_LineNumber)")
                print("section = \(section)")
                print("Type ? \(legDepartureFilterStatus.type) && Line = \(legDepartureFilterStatus.line)")
                
                if (legDepartureFilterStatus.enabled_TransportType || legDepartureFilterStatus.enabled_LineNumber){
               var t = 0
                    for index in legsToFilter {
                    let leg = legsToFilter[t] as! Leg
                    
                    print("inside for loop ----Leg type & Line \(leg.type)--\(leg.line) && legdep= Type = \(legDepartureFilterStatus.type)--\(legDepartureFilterStatus.line) & & count = \(tripInfoDepartureCount.LegList.count)")
                    
                    if (legDepartureFilterStatus.enabled_TransportType){
                    // check if current leg is
                        
                        
                        if(leg.type.contains(legDepartureFilterStatus.type)) {
                        
                        // return current section count
                        print("Returning in type  = \( tripInfoDepartureCount.LegList.count)")
                            return tripInfoDepartureCount.LegList.count
                        
                        
                        } else
                        {
                            
                            print("In Type Current Index = \(o) && leglist count = \(tripInfoDepartureCount.LegList.count)")
                         // remove comments if you want to find transport type similar leg
                            //   if ((t + 1) == tripInfoDepartureCount.LegList.count){
                                print("in type Returning 0 =Type \(leg.type) & Line = \(leg.line) Section = \(section)-CURRENT INDEX = \(t)--& Count = \(tripInfoDepartureCount.LegList.count)")
                                
                                return 0
                                
                      //      }
                        }
                    
                    
                    } else if (legDepartureFilterStatus.enabled_LineNumber){
                    
                        if(leg.line.contains(legDepartureFilterStatus.line)) {
                            
                            // return current section count
                                    print("Returning in line  = \( tripInfoDepartureCount.LegList.count)")
                            return tripInfoDepartureCount.LegList.count
                            
                            
                        } else {
                            
                            //print("in type Returning 0 =Type \(leg.type) & Line = \(leg.line) Section = \(section)-CURRENT INDEX = \(o)--")
                            
                         //   if ((o + 1) == tripInfoDepartureCount.LegList.count){
                                print("in line Returning 0 =Type \(leg.type) & Line = \(leg.line) Section = \(section)--& current Index = \(t)-Count = \(tripInfoDepartureCount.LegList.count)")
                                
                                return 0
                                
                           // }
                        
                        }
                 
                        print("current ===== \(o)")
                    }
                    /*
                    if(filterDepartureStatus == true)
                    {
                        
                        
                        if ((leg.line.contains(line_dist_Value)) && ((leg.type.contains(transp_type_Value))) && (tripCustom.LegList.count == 1)){
                            
                            leg.showHideLeg = true
                            collectionCellCount += 1
                            print("Just added to Total Count for Collection Section = \(section) -\(transp_type_Value)- \(line_dist_Value)")
                        } else {
                            leg.showHideLeg = false
                            
                        }
                        
                        
                    }
                    else
                    {
                        
                        // show all legs because false received from icon pressed in Trip Info
                        leg.showHideLeg = true
                        collectionCellCount += 1
                        print("DepartureFilter is False:All Legs must be visiblefor Section = \(section) -\(transp_type_Value)- \(line_dist_Value)")
                        
                    }
                    */
                        
                        t += 1
                        o += 1
                        
                    }
                }
                print("Collection:Cell: Returning for section = \(section) --count = \(collectionCellCount)")
                //return collectionCellCount
                return tripInfoDepartureCount.LegList.count
                //----28th dec wed 0730 -------end
                
                
                //-------------Departure Filter code .........  28th dec Wed 0730-------end
                
                /* 28 dec ....just a garbage printing
                for index in tripCustom.LegList {

                    let leg = tripCustom.LegList[i] as! Leg
                    
                    print("----i = \(i)----collection view loop------------------start-------------------")
                    print("leg.origin.name = \(leg.origin.name)")
                    print("leg.Destination.name = \(leg.destination.name)")
                    print("leg.dir = \(leg.dir)")
                    print("--------------------------end-------------------")
                    i += 1
                
                }
                */
                return tripCustom.LegList.count
                
                //--------------- end
                 print("customDepTripArray Count= items in number of sections...... = \(tripCustom.LegList.count)")
               // print("customDepTripArray Count= items in number of sections...... = \(tripCustom.leg)")
                
                print("customDepTripArray Count= items in number of sections...... = \(customDepTripArray.count)")
                
                number = customDepTripArray.count
              //  return customDepTripArray.count
        //    return tripCustom.LegList.count // 23 dec 10004
            }
            
        }
        
        print("custom_Trip_NextDepartures_Dict = count = \(custom_Trip_NextDepartures_Dict.count)")
        print("Section for collection view count = \(section) ")
        print("Count for collection view count = \(number) ")
        return number
        */
    }
    //    override func prepareforreuse (){
    // it is behaving wrongly
    // when you click then you cant drag. it starts animation
    /*
   func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     print("Animation has been called....collection view...")
        collectionView.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 1, animations: {
            collectionView.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        
    }
    func tableView(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("Animation has been called.......")
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 1, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //------Main change starts here 
        print("ggggggggggggg-1-\(indexPath)")
        let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
       //  let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures") as! LegTripNextDeparturesTableViewCell

        
        print("ggggggggggggg-2")

        print("returning cell...... leg deparutres....Cur-Row=\(indexPath)..")
        print("ggggggggggggg-3 ")

         cellDeparture.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        cellDeparture.indexPathSelected = indexPath
       // cellDeparture.currentIndexPathSection = indexPath.section
       let currentLeg = (newTrip[tripSection] as! Trip).LegList[indexPath.row] as! Leg
        print("Line 5207: \(indexPath):\(currentLeg.showHideLeg):Dep:\(currentLeg.departureAvailable):From:\(currentLeg.depScope_fromLegIndex):To:\(currentLeg.depScope_toLegIndex)")
        cellDeparture.isHidden = currentLeg.showHideLeg
        // cellDeparture.isHidden =
        return cellDeparture
  
        // MAIN change endds here
              print("TRIPINFO-0-current section in cell for row at\(indexPath.section) && \(indexPath.row)")
       //currentSectionIndex
        let tripCurrentObj = newTrip[indexPath.section] as! Trip
        
        print("tripcurrentObject show hide value is = \(tripCurrentObj.showHideCell)")
        // current leglist object
        let legListTemp = tripCurrentObj.LegList as! NSMutableArray
        // get object at current row
        let legObjToCheck = legListTemp[indexPath.row] as! AnyObject
        // 1.0) check for the type of object
        if (RealTidMethods.checkIfDepartureObject(objectToCheck: legObjToCheck))
        {
            let currentLegStatus = newTrip[indexPath.section] as! Trip
            let currentLeg = currentLegStatus.LegList[indexPath.row - 1] as! Leg
            print("CurrentLeg For Departures : indexPath = \(indexPath) & Dep Trip Count: \(currentLeg.nextDeparturesTrip.count)")
            
            //let showDeparturesForLeg = legList.LegList[indexPath.row] as! Leg
            // if object is departure then return depart object
            // copy paste departure code......
            print("cell departure must be printed now.......1.\(indexPath).")
            //    departureCounter += 1
            let cellDeparture = tableView.dequeueReusableCell(withIdentifier: "LegnextDepartures", for: indexPath as IndexPath) as! LegTripNextDeparturesTableViewCell
            cellDeparture.keyName = String(indexPath.section) + String(indexPath.row)
            cellDeparture.tag = indexPath.row
            cellDeparture.currentIndexPathRow = indexPath.row
            cellDeparture.currentIndexPathSection = indexPath.section
            cellDeparture.legIndexForDepartureShow = indexPath.row - 1
            // MARK: Departure Collection Border
            cellDeparture.layer.masksToBounds = true
            cellDeparture.layer.borderWidth = collectionBorderWidth
            //        headerCell.layer.borderColor = UIColor.gray.cgColor
            cellDeparture.layer.borderColor = UIColor.lightGray.cgColor
             //MARK: CollectionView temp off
            
              cellDeparture.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            //headerCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: section)
            
        print("cell departure must be printed now......2...")
        
        showDeparture = false
        return cellDeparture
    }
        
        let legList = newTrip[indexPath.section] as! Trip
        let leg = legList.LegList[indexPath.row] as! Leg
        print("Leg.showHide: = \(leg.showHideLeg)")
    
        let currentIndex = indexPath.row - departureCounter
         let test = NSMutableArray()
        var count = legList.LegList.count
         let cell = tableView.dequeueReusableCell(withIdentifier: "TripInfoCell", for: indexPath as IndexPath) as! TripInfoTableViewCell
        //MARK: DepartureButton On TripInfo cell Level
        cell.tag = indexPath.row
        
        //print("Line 3983: B4:indexPath: \(indexPath): AllKeys=\(nextDepartureRemainingLegStatusDict.allKeys):CellState: \(cell.nextDeparturesOutlet.state)")
        
        cell.showCurrentLegDep_outlet.tag = indexPath.row
                /*  18th jan :if(cell.showHideDepartureCell_Master == true){
        cell.nextDeparturesOutlet.isSelected = true
            
//        cell.nextDeparturesOutlet.backgroundColor = UIColor.blue
        
        } else {
            cell.nextDeparturesOutlet.isSelected = false
            
        //    cell.nextDeparturesOutlet.backgroundColor = UIColor.red
            
        
        }
        */
        /* temp 17th jan 1400 HRS
        if let valueExistDepartCellStatus = nextDepartureRemainingLegStatusDict.value(forKey: cell.keyName) as? Bool
        {
            
            // just  change status to show for the current cell
            print("valueExistDepartCellStatus: \(valueExistDepartCellStatus)")
            // if value is false: then it is not funcitonal for now
            if (valueExistDepartCellStatus == true){
                // currentCell.showHide_Departures = false
                cell.nextDeparturesOutlet.isSelected = true
                
                cell.nextDeparturesOutlet.setTitle("S", for: UIControlState.selected)
                cell.nextDeparturesOutlet.backgroundColor = UIColor.blue
                //                  currentCell.nextDeparturesOutlet.isSelected = false
                print("Line 4201:ValueExistDepartCellStatus:True....")
                // remove the departure cell values as well as the dict key
                //   nextDepartureRemainingLegStatusDict.removeObject(forKey: cell.keyName)
                // (newTrip[Int(cell.sectionInfo)!] as! Trip).LegList.removeObject(at: departureCellIndex)
                cell.prepareForReuse()
            
            }
        }
        else {
            cell.nextDeparturesOutlet.isSelected = false
            cell.nextDeparturesOutlet.setTitle("N", for: UIControlState.normal)
            cell.nextDeparturesOutlet.backgroundColor = UIColor.red
        }
        */
       // print("Line 3983: indexPath:After \(indexPath): AllKeys=\(nextDepartureRemainingLegStatusDict.allKeys):CellState: \(cell.nextDeparturesOutlet.state)")
        
        // MARK: TripInfo Borde
       // cell.prepareForReuse()
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = cellBorderWidth
        //        headerCell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
           //MARK:BorderTripInfo
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = cellBorderWidth
        
        //headerCell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.lightGray
         cell.sectionInfo = String(indexPath.section)
        cell.rowInfo = String(indexPath.row)
       
        cell.keyName = cell.sectionInfo + cell.rowInfo
        print("Cell.KeyName:assigned for indexpath= \(cell.keyName)")
        print("Current Section = \(indexPath.section).self && Current Row = \(indexPath.row)")
       // cell.name.isHidden = true
        //cell.nextDeparturesOutlet.backgroundColor = UIColor.lightGray
        //cell.towards_or_walk.isHidden = true
        test.add(legList.LegList[indexPath.row])
        
//        CGPoint(x: 40, y: 40)
        let startingPoint = CGPoint(x: cell.to_time.frame.origin.x,y: cell.to_time.frame.size.height + 20)
        let startingSize = default_startingSize //CGSize(width:20.0,height:20.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = default_innerSpacing //CGPoint(x:10,y:0)
        let innerLegSpacing = default_innerLegSpacing //CGPoint(x:25,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        // MARK: Move to collection 1 ---end
        count = count - 1
         cell.legImage.image = UIImage(named: leg.legImageName)
        // MARK: Leg
   
        // legList.originDetail.name
        //----#1-----#2------------------------ Origin Station....Leg
        cell.from_station.text = leg.origin.name
        print("cell.from_station.text::::\(cell.from_station.text)")
        // temp cell.from_time.text = legList.originDetail.time
        cell.from_time.text = leg.origin.time
        // MARK: RTU Message Cell Level
        // MARK: Temp Testing
        print("CurrentLeg : index path : Line4335: \(indexPath) & \(leg.nextDeparturesTrip.count)")
        
        if (leg.rtu_Message_Flag == true){
            print("cell:: RTU Message ::::")
            print(leg.rtu_Message)
            cell.rtuMessage.isHidden = true
            cell.rtuMessage.text = leg.rtu_Message
            cell.rtuMessage.textColor = UIColor.red
            cell.from_station.backgroundColor = UIColor.red
            cell.from_station.textColor = UIColor.white
        } else {
            cell.rtuMessage.isHidden = true
        }
//         cell.towards_or_walk.text = ""
   
           //-----#3------Visual Leg
          /* 17th jan 2017 0400
         cell.nextDepartureTillCurrLeg_Outlet.tag = indexPath.row
        cell.nextDeparturesLatest.addTarget(self, action: #selector(TripSuggestionsTViewController.nextDepartureTarget), for: UIControlEvents.touchUpInside)
        print("Cell.NextDepartureTillCurr: \(indexPath)")
        */
        print(test.count)
        // MARK: Move to collection 2
        // MARK: temp friday draw 3 cell view
           let tagSeriesStart = "7"
        let sectionIndexString = String(indexPath.section)
        let increment = indexPath.row
        let legIndexString = String(increment)
        let sectionLegIndexUnion = tagSeriesStart + sectionIndexString + legIndexString
        // on every new leg printing, add 2 to the last count
        
        let iconTagString = sectionLegIndexUnion + "0"
        let lineNoTagString = sectionLegIndexUnion + "1"
        let iconTagInt = Int(iconTagString)
        let lineNoInt = Int(lineNoTagString)
        // check if old icon exists then remove them because they
//        print("Leg Icon To Remove Old  Tag = \(iconTagInt)")
//        if let legIconToRemove = cell.contentView.viewWithTag(iconTagInt!) as? UIButton {
//        print("LegIconToRemove Old Found =icontag: \(legIconToRemove.accessibilityIdentifier)")
//        legIconToRemove.backgroundColor = UIColor.black
//        }
//        
//        if let legLineDistIconToRemove = cell.viewWithTag(lineNoInt!) as? UIButton {
//            print("LegIconToRemove Old Found = lineno:\(legLineDistIconToRemove.accessibilityIdentifier)")
//            legLineDistIconToRemove.backgroundColor = UIColor.black
//        }
//        
        if (watchIcons == false){
        let tagValueReceived = SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: test, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: indexPath.row,indexValueFromCurrentLeg: indexPath.row,iconTagIntValue: iconTagInt! ,lineNoIntValue: lineNoInt!)
      
            cell.legTag = tagValueReceived.iconTagIntReturned
        cell.lineDistTag = tagValueReceived.lineNoIntReturned
        
            print("cell.legTag=indexPath=\(cell.legTag)")
        print("Trip Info Tag Values =Line 4401:cell.nextDepartureTillCurrLeg_Outlet: \(cell.nextDepartureTillCurrLeg_Outlet)")
        //-------add ibaction to icons and line number---start
        
        
        // Extract buttons which have been added
          //MARK: Trip Info Leg Icon Interaction
          
        let iconNumberButton = cell.contentView.viewWithTag(tagValueReceived.iconTagIntReturned) as! UIButton
//        iconNumberButton.backgroundColor = UIColor.red
         let lineNumberButton = cell.contentView.viewWithTag(tagValueReceived.lineNoIntReturned) as! UIButton
//           iconNumberButton.backgroundColor = UIColor.red
//            lineNumberButton.backgroundColor = UIColor.yellow
        if (leg.showHideLeg == true && leg.enabled_LineNumber == true){
            // green means it is enabled while red means it is disabled :show or hide
//            iconNumberButton.backgroundColor = UIColor.orange
            lineNumberButton.backgroundColor = UIColor.blue
  
        }
        else {
            lineNumberButton.backgroundColor = UIColor.yellow
//            iconNumberButton.backgroundColor = UIColor.red
         }
        print(" After entering leg.show hide : cell color is = \(UIColor.orange)")
        print("trip info trip info lineNumberButton Accessibility identifier: \(lineNumberButton.accessibilityIdentifier)")
        print("trip info legicon:::::should be trip info:\(leg.clickLevel):")
        // Mark: 23rd dec 1800-changed clicked to  showClickedTransportType
        //                showClickedLine
        lineNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedTransportTypeOrLineInNextDepartures), for: UIControlEvents.touchUpInside)
        print("leg.enabled_TransportType_______\(indexPath)_Leg.TT.\(leg.enabled_TransportType)-LLE_\(leg.enabled_LineNumber) &Line& \(leg.line) && \(leg.type)")
        lineNumberButton.isUserInteractionEnabled = true
        iconNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedTransportTypeOrLineInNextDepartures), for: UIControlEvents.touchUpInside)
        iconNumberButton.isUserInteractionEnabled = true
            print("Line 4111:LndexPath:Status: -------\(indexPath):iconNumberButtonUserInter=\(iconNumberButton.isUserInteractionEnabled):IconTag:\(iconNumberButton.tag)")
            print("Line 4111:LndexPath:Status: \(indexPath):lineNumberButton=\(lineNumberButton.isUserInteractionEnabled):LineTag:\(lineNumberButton.tag)")
        }
        //----#4------
//        cell.name.text = ""//leg.name
        //----#4.5------
        //----#5------line/dist
      //MARK: Temp 20th jan transportTypeis hidden
        //  cell.transportTypeOutlet.text = leg.journeyType
       // cell.transportTypeOutlet.isHidden = true

        var line_dist = String()
        var helpingWord = String()
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
        cell.ine_dist.text = line_dist
 
        cell.to_station.text = leg.destination.name
        cell.to_time.text = leg.destination.time
        // cell.transportTypeOutlet.text = leg.destination.type
     
        
        // MARK: TripInfo Show/Hide based on button clicked
        print("Cell: Line:4128 = indexPath= \(indexPath) = keyName = \(cell.keyName): isSelected: \(cell.nextDepartureTillCurrLeg_Outlet.isSelected): cell status: \(cell.showHideDepartureCell_Master)")
        
     /*
        if (cell.showHideDepartureCell_Master == true){
        
        cell.nextDepartureTillCurrLeg_Outlet.isSelected = true
        } else {
        
            cell.nextDepartureTillCurrLeg_Outlet.isSelected = false
            
        
        }*/
        /*
        if ((indexPath.section == 0) && (indexPath.row == 0)){
            
            
            cell.from_station.text = String(indexPath.section) + String(indexPath.row)
            print("Cell.From_Station.text.ids= \(cell.from_station.text)")
            cell.nextDeparturesOutlet.isSelected = true
            
            cell.nextDeparturesOutlet.setTitle("S", for: UIControlState.selected)
            
        } else {
        
            cell.nextDeparturesOutlet.isSelected = false
            
            cell.nextDeparturesOutlet.setTitle("N", for: UIControlState.normal)

        
        }
        */
        
        
        print("Line:4188:BeforenextDepartureRemainingLegStatusDict.allkeys= \(nextDepartureRemainingLegStatusDict.allKeys)")
        /* Temp move to line 3987 :17th jan
        if let valueExistDepartCellStatus = nextDepartureRemainingLegStatusDict.value(forKey: cell.keyName) as? Bool
        {
            
            // just  change status to show for the current cell
            print("valueExistDepartCellStatus: \(valueExistDepartCellStatus)")
            // if value is false: then it is not funcitonal for now
                if (valueExistDepartCellStatus == true){
                // currentCell.showHide_Departures = false
                cell.nextDeparturesOutlet.isSelected = true
                
                cell.nextDeparturesOutlet.setTitle("S", for: UIControlState.normal)
                //                  currentCell.nextDeparturesOutlet.isSelected = false
                print("Line 4201:ValueExistDepartCellStatus:True....")
                // remove the departure cell values as well as the dict key
                //   nextDepartureRemainingLegStatusDict.removeObject(forKey: cell.keyName)
                // (newTrip[Int(cell.sectionInfo)!] as! Trip).LegList.removeObject(at: departureCellIndex)
                }
        }
        else {
            cell.nextDeparturesOutlet.isSelected = false
            cell.nextDeparturesOutlet.setTitle("N", for: UIControlState.normal)
        }
        */
        
     //   print("Line 4217:IP=\(indexPath)-state:\(cell.nextDeparturesOutlet.state) :Title:\(cell.nextDeparturesOutlet.titleLabel)")
        if let btt = cell.viewWithTag(7000) as? UIButton
        {
        print("btt.userinter:bttTag-\(btt.tag)-UI- \(btt.isUserInteractionEnabled):----Idn-:\(btt.accessibilityIdentifier)-\(btt.allTargets)")
        }
        if let btt = cell.viewWithTag(7001) as? UIButton
        {
            print("btt.userinter:-bttTag-\(btt.tag)-UI- \(btt.isUserInteractionEnabled):---Idn-:\(btt.accessibilityIdentifier)-\\(btt.allTargets)")
        }
        
        
        return cell
       //  30th jan Major Change:
 
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
// get new trip and then extract current leg
        print("Line 5738..\(tripSection)=IP=\(indexPath))")
        //let currentSection = newTrip[indexPath.section] as! Trip
        let currentSection = newTrip[tripSection] as! Trip
        print("Before if else object type other found = \(currentSection.LegList[indexPath.row])")
print(" in height of row current section.leglist.count = \(currentSection.LegList.count)")
         /*
        if let currentLeg = currentSection.LegList[indexPath.row] as? Leg {
        
            let currentLegConfirmed = currentSection.LegList[indexPath.row] as! Leg
            
            if (currentLegConfirmed.showHideLeg == true){
                
                return 130
                
            }
         
        } else {
            
          
             if let currentDepartures = currentSection.LegList[indexPath.row] as? TripInfoDepartures {
                //print("if.....object type = TripInfoDepartures Found = \(currentSection.LegList[indexPath.row])")
                return 150
                
            } else {
                print("else.....object type other found = \(currentSection.LegList[indexPath.row])")
            }
 
        }
      */
        
        return 150
    }
  // MARK: Height of row
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let titleHeader = "SLife:HEADER TITLE IS HERE" + String(section)
//        return titleHeader
//    }
//    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       // if section is depart.tool section then return 100 height
        
      
        print("Line 4423:   section current = \(section)")
        if (section == 0){
        
            
            print("line 4422::::::::::::=\(100)")
            
        return 150
        }
        
        
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
        
        let headerHeightCalculation = headerCell_StackView_Height + (total_icon_lines.lineCount * Int(default_startingSize.height)) //+ navigationHeaderCellHeight
        
        print("T \(headerHeightCalculation)")
        
        return CGFloat(headerHeightCalculation)
   
        return 250
        // temp check on above headerheightcalculation return CGFloat(headerCellTotalHeight)
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        print("if section is 6th then return navigation later trips cells = section \(section)")
        print("showHideDepartureToolBar=\(showHideDepartureToolBar)")
       /*
         
         // change is required  if uncomment this portion is required:
         1) number of sections (header= return 2
         2) numbeer of rows uncomment where it says if (... == 0)
 if (section == 0) {
        
            let headerDepToolCell = tableView.dequeueReusableCell(withIdentifier: "nextDepartureTools") as! NextDepartureHeaderTableViewCell
            headerDepToolCell.from_station.text = String(fromLegIndex_clicked)
            headerDepToolCell.to_station.text = String(toLegIndex_clicked)
            
        return headerDepToolCell
        
        }*/
        
        
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "TripInfoHeader") as! TripHeaderTripInfoTableViewCell
        
          let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
           //let trip_detail_flag = RealTidMethods.checkNullForBool(someValue: showTripDetail_Dict, keyName: String(section))
        if (trip_detail_flag.contains("true")){
        
            print("trip detail flag = True?= \(trip_detail_flag)")
        
        headerCell.sectionSelected.isSelected = true
        } else {
            
            print("trip detail flag = False?= \(trip_detail_flag)")

            headerCell.sectionSelected.isSelected = false
        
        
        }
        
        // tap gesture for header cell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TripSuggestionsTViewController.tripHeaderSelector))
        
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        headerCell.addGestureRecognizer(tapGesture)
        
        
        //----------
        headerCell.showTripRouteOnMapOutlet.isHidden = true
        headerCell.tag = section
        print("header cell tag = \(headerCell.tag)")
//        headerCell.sectionSelected.tag = 100 + section
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
                //MARK: HeaderRowColor
        //   headerCell.backgroundColor = headerRowSelectedColor
        //___________________________
        headerCell.layer.masksToBounds = true
        headerCell.layer.borderWidth = headerBorderWidth
        //        headerCell.layer.borderColor = UIColor.gray.cgColor
        headerCell.layer.borderColor = UIColor.lightGray.cgColor
          print(tableView.rowHeight)
      //  headerCell.sectionSelected.tag = section
        // MARK: ShowTripDetail_Dict
        
        print("tableView.frame.size.height ........")
        print(tableView.frame.size.height)
        print("headerCell.frame.size.height ........")
        print(headerCell.frame.size.height)
        print("--heADER CELL BUTTON ID-")
       
        //print(headerCell.sectionSelected)
        //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
        // headerCell.backgroundColor = UIColor.blue
        print("cell-header cell---\(headerCell)")
        
      //1st of feb  let head =  currentTripScope[section] as! Trip //newTrip[section] as! Trip
        
        
        var head = Trip() //newTrip[tripSection] as! Trip
        if (genericTripFlag == false){
        
        head = newTrip[tripSection] as! Trip
        
        }
        else if (genericTripFlag == true){
        
            head = tripToShow
        
        
        }
        // check if the Trip Count is greater than the Current Section then return navigational cell
        
        
       // print("returning bottom Navigational Cell: Total Trips::\(newTrip.count) Section = \(section)")
      
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
        
      //1st of feb  let tripCell = currentTripScope[section] as! Trip // newTrip[section] as! Trip
        
        
        var tripCell = Trip() //newTrip[tripSection] as! Trip
        if (genericTripFlag == false){
        
        tripCell = newTrip[tripSection] as! Trip
        }
        else if (genericTripFlag == true) {
        tripCell = tripToShow
        
        }
        
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
             // on every new leg printing, add 2 to the last count
                
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
                print("--view for header: line : 5001-------Do we have same tag values Test 1-----Values Received--")
                print("Current Section:\(section)")
                print(" Line 5003tagValueReceives.iconTagIntReturned = \(tagValueReceives.iconTagIntReturned)")
                print(" tagValueReceives.lineNoIntReturned = \(tagValueReceives.lineNoIntReturned)")
                
           //                let iconButton = headerCell.contentView.v
                
//                print("iconButton:::::: \(iconButton)")
                            //MARK: Trip Info Leg Icon Interaction
                let iconNumberButton = headerCell.contentView.viewWithTag(tagValueReceives.iconTagIntReturned) as! UIButton
                
               
                
                let lineNumberButton = headerCell.contentView.viewWithTag(tagValueReceives.lineNoIntReturned) as! UIButton
                let currentLeg = tripCell.LegList[increment] as! Leg
                
                print("currentLeg.enabled_TransportType = \(currentLeg.enabled_TransportType) && Line Number Enab= \(currentLeg.enabled_LineNumber)")
                
                print("iconButton Accessibility identifier: & ---\(iconNumberButton.accessibilityIdentifier) && \(currentLeg.type) && Line = \(currentLeg.line)")
              // MARK: Version 2 enabl disable
                /*--
                if ((currentLeg.enabled_TransportType == true ) && (currentLeg.type.contains(iconNumberButton.accessibilityIdentifier!))){
                  // green means it is enabled while red means it is disabled :show or hide
                  
                    iconNumberButton.backgroundColor = iconSelectedColor
                    lineNumberButton.backgroundColor = disabledColor
                }
                else {
                    
                
                    iconNumberButton.backgroundColor = disabledColor
                    
                   // lineNumberButton.backgroundColor = enabledColor
                    
                }
                */
                print("currentLeg.filterLine = update::: \(currentLeg.enabled_LineNumber) & \(currentLeg.line)")
                
                

                /*if (currentLeg.enabled_LineNumber){
                    lineNumberButton.backgroundColor = enabledColor
                    iconNumberButton.backgroundColor = disabledColor
                }
                
                else if (currentLeg.enabled_LineNumber == false){
                
                    
                    lineNumberButton.backgroundColor = disabledColor

                
                }*/
//
//                if (currentLeg.enabled_LineNumber == true ){
//                    // green means it is enabled while red means it is disabled :show or hide
//                    
//                    lineNumberButton.backgroundColor = iconSelectedColor
//                    
//                }
//                else {
//                    
//                    
//                    lineNumberButton.backgroundColor = disabledColor
//                    
//                }
                
                print("lineNumberButton Accessibility identifier: \(lineNumberButton.accessibilityIdentifier)")
                
          
                print("legicon:::::trip level:\(currentLeg.clickLevel):Line:\(currentLeg.line)-Lin Status=\(currentLeg.enabled_LineNumber) Type: \(currentLeg.type) & typeStatus = \(currentLeg.enabled_TransportType)")
                // Mark: 23rd dec 1800-changed clicked to  showClickedTransportType
//                showClickedLine
               
                /* MARK: VERSION 2.0 filter trip > tripinfo
                    lineNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedLegOrLineFilter), for: UIControlEvents.touchUpInside)
               // lineNumberButton.backgroundColor = UIColor.red
                // iconNumberButton.backgroundColor = UIColor.cyan
                
                iconNumberButton.addTarget(self, action: #selector(TripSuggestionsTViewController.showClickedLegOrLineFilter), for: UIControlEvents.touchUpInside)

                */
                
             
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
        
       // headerCell.ZoneInfo.text = tariffZones_text
        headerCell.PriceInfo.text = tariffRemarks_price
        // MARK: ZoneInfo Hide
        //MARK: TariffiInfo Hide
        //headerCell.ZoneInfo.isHidden = true
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
        /*
        if (evenOrNot){
             headerCell.backgroundColor = UIColor.lightGray
        }*/
        print("section::::::header:::\(section)")
//        headerCell.refresh_top_navigation.isHidden = true
//        headerCell.refresh_next_navigation.isHidden = true
//        
        /*
        if(section == 0){
     //   headerCell.backgroundColor = UIColor.green
          
           // headerCell.refresh_top_navigation.isHidden = false
           // headerCell.refresh_next_navigation.isHidden = true
 headerCell.backgroundColor = enabledColor
            
        } else if ((section + 1) == newTrip.count){
        headerCell.backgroundColor = disabledColor
          
          //  headerCell.refresh_top_navigation.isHidden = true
        // headerCell.refresh_next_navigation.isHidden = false

            
        }
     else {
            headerCell.refresh_top_navigation.isHidden = true
            headerCell.refresh_next_navigation.isHidden = true
         }    */
        
        print("headerCell.isUserInteractionEnabled ??? \(headerCell.isUserInteractionEnabled)")
        return headerCell
    }
    
    
    func even(number: Int) -> Bool {
        // Return true if number is evenly divisible by 2.
        return number % 2 == 0
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for Segue in TripSuggestion Has been called: Line 4871:\(segue.identifier)")
    
    if sender
    }
    */
    
    /*
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
        
     
    } */
    
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
    

// Switching off 23rd dec 0700 HRS Morning------------END
 // Switching off 23rd dec 0835 HRS Morning------------END

// MARK: Possible problem start on 22nd december///---------start------23rd dec 0700
/*
    
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
        // MARK: checked 23rd dec: Compared: same as being used: 09:30 23rd dec
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
        // MARK: checked : this is the most latest 23rd dec by.
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
// MARK: 23 dec : need to change the way it is returning: 
//MARK: 23 dec : keep it

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 5
            
        }
      //MARK: Seems to be latest 23rd dec: file compare checked.-------ADD IT
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
                    
                    lineNumberButton.
 (self, action: #selector(TripSuggestionsTViewController.Clicked), for: UIControlEvents.touchUpInside)
                    
                    
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
    
 // MARK: checked. almost same with 2 lines less here: checked on 23rd dec 0933
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
    // TYPE A
 // MARK: TYPE A is old : checked on 23rd dec 0900....
 
 /*
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
 */ //Type A ended here: checked and it is old one on filre comparison : 0900 23rd dec
    
    
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
    
 // 23rd dec 0930 checked, compared, old one.........

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

/* 20th jan friday 0820 starts
class TripInfoTableViewController: UITableViewController {

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
*/

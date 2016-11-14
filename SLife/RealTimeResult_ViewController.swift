//
//  RealTimeResult_ViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 04/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

//
//  SearchFrom_To_Controller.swift
//  SLife
//
//  Created by syed farrukh Qamar on 29/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//


// note currently not all the json object has been parsed. there is some more information which can be parsed
import Foundation
import UIKit

var tableData = NSMutableDictionary()
var jsonLoaded = false

let BUSES = "Buses"
let METROS = "Metros"
let SHIPS = "Ships"
let TRAINS = "Trains"
let TRAMS = "Trams"

var BUSESFLAG = false
var METROSFLAG = false
var SHIPSFLAG = false
var TRAINSFLAG = false
var TRAMSFLAG = false

var currentSelection = BUSES

//-----
var availableTransportModes = NSMutableArray()
var notAvailableTransportModes = NSMutableArray()
var totalCountRealTimeResult = 0
var buttonIndexArray = NSMutableArray()


var realTimeButtonPressed = false
var realTimeButtonSelectedTag = Int()



var busesTag = 10
var metroTag = 11
var railTag = 12
var tramTag = 13
var ferryTag = 14

//var lightRailTag = 12


//let defaultTransport = "BUS"

//var from_to_value = String()
//var tempDict = NSDictionary()
//var station = Station(name: "", site_id: "", type: "", x: "", y: "")

var timeWindowForRealRid = "30"

class RealTimeResult_ViewController:UITableViewController {
   
    
    @IBAction func showTrams(sender: UIButton) {
        
        currentSelection = TRAMS
        
        realTimeButtonSelectedTag = sender.tag
       
        realTimeButtonPressed = true
        
        tableView.reloadData()
        
    }
    @IBAction func showBuses(sender: UIButton) {
    currentSelection = BUSES
        
        realTimeButtonSelectedTag = sender.tag
        realTimeButtonPressed = true
        
    tableView.reloadData()
    }
    
    @IBAction func showMetros(sender: UIButton) {
        currentSelection = METROS
        
        realTimeButtonSelectedTag = sender.tag
        realTimeButtonPressed = true

        tableView.reloadData()

    }
  
    @IBAction func showTrains(sender: UIButton) {
        currentSelection = TRAINS
        
        realTimeButtonSelectedTag = sender.tag
        realTimeButtonPressed = true

        tableView.reloadData()
}
    
    @IBAction func showLocalTrains(sender: UIButton) {
        currentSelection = TRAMS
        
        realTimeButtonSelectedTag = sender.tag
        realTimeButtonPressed = true

        tableView.reloadData()

    }
    
    @IBAction func showShips(sender: UIButton) {
        currentSelection = SHIPS
        
        realTimeButtonSelectedTag = sender.tag
        realTimeButtonPressed = true

        tableView.reloadData()
        
    }
    
    //let tableData = ["Current Location","AltaCentrum","Three","Twenty-One"]
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        print("-in realtimeresult-top view controller-descryption navigation bar =\(self.navigationController?.topViewController?.description)")

        print("---descr navigation bar =\(self.navigationController.debugDescription)")
        print("---real----navigation count index =\(self.navigationController?.viewControllers.count)")
        
         let url = WebServiceHandler.constructURL_SL_Realtidsinformation_3(siteID: station.site_id, timeWindow: timeWindowForRealRid)
        print("The final URL for RealTimeResult View Controller is = \(url)")
        
        get_data_from_url(url: url)
// iterate through the tabledata to enable transport buttons on the result real time controller.
        for (key,value) in tableData {
            if (tableData.count >= 8){
            // extract all mode of transports
            // BUS
                if (key as! String == BUSES)
                {
                    if ((value as AnyObject).count == 0){
                    
                        // = false
                        BUSESFLAG = false

                    } else {
                        //Bus.enabled = true
                        BUSESFLAG = true
                        
                    }
                }
            // metros
                if (key as! String == METROS)
                {
                    if ((value as AnyObject).count == 0){
                        
                        //Metros.enabled = false
                        METROSFLAG = false
                        
                    } else {
                        //Metros.enabled = true
                        METROSFLAG = true
                        
                    }
                }
            // ships
                if (key as! String == SHIPS)
                {
                    if ((value as AnyObject).count == 0){
                        
                        //Ship.enabled = false
                        SHIPSFLAG = false
                        
                    } else {
                        //Ship.enabled = true
                        SHIPSFLAG = true
                        
                    }
                }

            // Trains
                if (key as! String == TRAINS)
                {
                    if ((value as AnyObject).count == 0){
                        
                        //Trains.enabled = false
                        TRAINSFLAG = false
                        
                    } else {
                        //Trains.enabled = true
                        TRAINSFLAG = true
                        
                    }
                }


            //Trams
                if (key as! String == TRAMS)
                {
                    if ((value as AnyObject).count == 0){
                        
                    //LocalTrains.enabled = false
                        TRAMSFLAG = false
                        
                    } else {
                        //LocalTrains.enabled = true
                        TRAMSFLAG = true
                        
                    }
                }

                // stopPointDeviation
            
            }
            else {
            
            // disable all & show message
            
            
            }
        
        
        
        }
//        self.resultSearchController = ({
//            let controller = UISearchController(searchResultsController: nil)
//            controller.searchResultsUpdater = self
//            controller.dimsBackgroundDuringPresentation = false
//            controller.searchBar.sizeToFit()
//            
//            self.tableView.tableHeaderView = controller.searchBar
//            
//            return controller
//        })()
        
        // Reload the table
      // self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        // process all json 
       // print("retStr---bef4-----------------\(searchController.searchBar.text!)")
        // receive site id here from the previous controller
        
        
      //  let retStr = SlifeMethods.stringToSlFormat(siteID)
        
      //  print("retStr---after-----------------\(retStr)")
        
        //  tableData.removeAllObjects()
        let url = WebServiceHandler.constructURL_SL_Realtidsinformation_3(siteID: station.site_id, timeWindow: timeWindowForRealRid)
        //--construct url-------------------end
        // call webservice
        
get_data_from_url(url: url)
        
        
        
    }
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // 1
//        // Return the number of sections.
//        return 1
//    }
//    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        // if section is first then return 1 else return accordingly
//        if (section == 0) {
//        return 1
//        }
//        
       // else {
        
        
//        print("number of rows in section 2 and the currentSelction is >")
//            print(currentSelection)
          //  tableData[currentSelection]?.count
         print(tableData.allKeys)
//        if(section == 1){
        if (jsonLoaded == true){
           
          //  disableTransportModesNotAvailable(tableData)
            print("--------JSON LOADED --------\(tableData.allKeys)--------------")
            //MARK: Nil found
            // when searched for slussen
            let rows = tableData[currentSelection] as! NSArray
            
            //   print("--------buses test --------\((tableData[currentSelection]? as AnyObject).count)--------------")
            return   (rows.count)
            }
  //        }
        return 1
            //    }
       // return tableData.count
        
        /*
         if (self.resultSearchController.active) {
         return self.filteredTableData.count
         }
         else {
         return self.tableData.count
         }
         */
    }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! RealTimeInfoDetailCells
 
        // 3
        //cell.textLabel?.text = tableData[indexPath.row] as! String
        print("-----------indexPath = \(indexPath)")
        var time = String()
        var lineNo = String()
        var Destination = String()
        var transportID = String()
        var message = String()
        var transportModeImageName = "BUS.png"
        if (jsonLoaded == true){
        if (currentSelection == BUSES){
             transportModeImageName = "BUS.png"
        print("--------buses found-----------table data keys \(tableData.allKeys)-----")
            
            
            
            let bussFound = RealTidMethods.checkNullForNSArray(someValue: tableData, keyName: currentSelection)
            
            if (bussFound.count == 0){
                
            print("null found in bus Found Check Array ......")
            
            
            } else
            {
            
                //let bussFound = tableData[currentSelection] as! NSArray

            
            print("--------buses found-----------buss found destination \(bussFound.count))----")
            let busRecord = bussFound[indexPath.row] as! Buses
            print("GroupOfLine= \(busRecord.GroupOfLine)")
            print("StopPointDesignation= \(busRecord.StopPointDesignation)")
            print("DisplayTime= \(busRecord.realTimeCommonTransportModeInfo.DisplayTime)")
             print("destination= \(busRecord.realTimeCommonTransportModeInfo.Destination)")
            time = busRecord.realTimeCommonTransportModeInfo.DisplayTime
            lineNo = busRecord.realTimeCommonTransportModeInfo.LineNumber
            Destination = busRecord.realTimeCommonTransportModeInfo.Destination
            transportID = busRecord.realTimeCommonTransportModeInfo.LineNumber
            
        
            print("busRecord.realTimeCommonTransportModeInfo.deviations = \(busRecord.realTimeCommonTransportModeInfo.deviations.count)")
            
            }
                  }
        else if (currentSelection == METROS)
        {
            
            transportModeImageName = "METRO.png"
            
            
            let metroFound = RealTidMethods.checkNullForNSArray(someValue: tableData, keyName: currentSelection)
            
            if (metroFound.count == 0){
                
                print("null found in bus Found Check Array ...metroFound...")
                
                
            } else
            {
            
                
            //let metroFound = tableData[currentSelection] as! NSArray
            
            let metroRecord = metroFound[indexPath.row] as! Metros
            print("--------metros found-----------metroFound destination \(metroFound.count))----")
            time = metroRecord.DisplayTime
            lineNo = metroRecord.LineNumber
            
            
            Destination = metroRecord.Destination
            transportID = metroRecord.TransportMode
            print("-----lineNo---metros found-----------metroFound destination \(lineNo))----")
            
//            let metro = metroFound[indexPath] as! Metros()
            
//            time = metro.
//            line = metroFound.LineNumber
//            Destination = metroFound.Destination
//
            }
            }
        else if (currentSelection == TRAINS){
            transportModeImageName = "TRAIN.png"

            let trainsFound = RealTidMethods.checkNullForNSArray(someValue: tableData, keyName: currentSelection)
            
            if (trainsFound.count == 0){
                
                print("null found in bus Found Check Array ...trainsFound...")
                
            } else
            {
            
//          let trainsFound = tableData[currentSelection] as! NSArray
            let trainsRecord = trainsFound[indexPath.row] as! Trains
            time = trainsRecord.realTimeCommonTransportModeInfo.DisplayTime
            lineNo = trainsRecord.realTimeCommonTransportModeInfo.LineNumber
            Destination = trainsRecord.realTimeCommonTransportModeInfo.Destination
            transportID = trainsRecord.realTimeCommonTransportModeInfo.TransportMode
            
            }
        
        }
        else if (currentSelection == TRAMS){
             transportModeImageName = "TRAM.png"
            let tramsFound = tableData[currentSelection] as! NSArray
            
            
            
            let tramsRecord = RealTidMethods.checkNullForNSArray(someValue: tableData, keyName: currentSelection)
            
            if (tramsRecord.count == 0){
                
                print("null found in bus Found Check Array ...tramsRecord...")
                
            } else
            {

            let tramsRecord = tramsFound[indexPath.row] as! Trams
            
            time = tramsRecord.realTimeCommonTransportModeInfo.DisplayTime
            lineNo = tramsRecord.realTimeCommonTransportModeInfo.LineNumber
            Destination = tramsRecord.realTimeCommonTransportModeInfo.Destination
               transportID = tramsRecord.realTimeCommonTransportModeInfo.TransportMode
            }
            
        }
        else if (currentSelection == SHIPS){
             transportModeImageName = "SHIP.png"
            
          //  let shipFound = tableData[currentSelection] as! NSArray
            
            
            
            let shipFound = RealTidMethods.checkNullForNSArray(someValue: tableData, keyName: currentSelection)
            
            if (shipFound.count == 0){
                
                print("null found in bus Found Check Array ...shipFounda...")
                
            } else
            {

             let shipsRecord = shipFound[indexPath.row] as! Ships
            
            time = shipsRecord.realTimeCommonTransportModeInfo.DisplayTime
            lineNo = shipsRecord.realTimeCommonTransportModeInfo.LineNumber
            Destination = shipsRecord.realTimeCommonTransportModeInfo.StopAreaName
            transportID = shipsRecord.realTimeCommonTransportModeInfo.TransportMode
            }
            }
        }
        
        print("-----Time : \(time)")
        print("-----lineNo : \(lineNo)")
        print("-----message : \(Destination)")
        print("-----transportID : \(transportID)")
        cell.transportModeImageView.image = UIImage(named: transportModeImageName)
        
        cell.time.text = time
        cell.lineNo.text = lineNo
        
        cell.message.text = Destination
        cell.transportID.text = transportID
        cell.transportID.isHidden = true
        
        return cell
        
        /*
         if (self.resultSearchController.active) {
         cell.textLabel?.text = filteredTableData[indexPath.row]
         
         return cell
         }
         else {
         cell.textLabel?.text = tableData[indexPath.row] as! String
         
         return cell
         }
         */
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! RealTimeResultMainHeaderCell
        print ("------header section is printed--------\(section)--")
        
        headerCell.showBuses.tag = busesTag // 10
        headerCell.showMetro.tag = metroTag // 11
        headerCell.showRail.tag = railTag // 12
      // headerCell.showLightRail.tag = lightRailTag
        headerCell.showTram.tag = tramTag // 13
        headerCell.showFerry.tag = ferryTag // 14
        
        if (jsonLoaded == true){
        if (realTimeButtonPressed == true){
            
            print(".Button pressed...........about to change buttons")
            
            print("headerCell.showBuses.tag = \(headerCell.showBuses.tag)")
            
            print("buttonSelectedTag ::::: = \(realTimeButtonSelectedTag)")
            
            
            Buttons.selectButton_AndResetRest(selectedButtonTag: realTimeButtonSelectedTag, buttonRangeFromTag: transportTypeBar_StartIndex, buttonRangeToTag: transportTypeBar_EndIndex, currentCell: headerCell)
            
            realTimeButtonPressed = false
        }
        else {
                Buttons.selectButton_AndResetRest(selectedButtonTag: DEFAULT_INDEX_TRAFFIC_STATUS, buttonRangeFromTag: transportTypeBar_StartIndex, buttonRangeToTag: transportTypeBar_EndIndex, currentCell: headerCell)
        }
            var y = 0

            for index in buttonIndexArray {
                print("-------------button index array------")
                print(buttonIndexArray[y])
                
                var buttonValue = buttonIndexArray[y] as! Int
                
               let button =  headerCell.viewWithTag(buttonValue) as! UIButton
                print("trying to change the buttons background color.....")
                button.backgroundColor = UIColor.lightGray
                button.setTitleColor(UIColor.darkGray, for: .normal)
                
                button.isUserInteractionEnabled = false
//                Buttons.disableButton(headerCell.viewWithTag(Int(buttonValue))! as! UIButton, title: "")
         
                y += 1
                
            }
        }
        
    
        
        //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
//        headerCell.backgroundColor = UIColor.lightGrayColor()
//        print("cell-header cell---\(headerCell)")
//        
//        let head = newTrip[section] as! Trip
//        print("-In Sections--[Sections]=\(section)--)")
//        print(".....head.count is \(head.dur)")
//        print("-----section # \(section)")
//        
//        //      label.text = data[indexPath.row]
//        
//        // function getLabel(cell: dequeReusable as ! tripSugg,current index: int, legListPictorialSummary: some array)
//        
//        //        drawLeg()
//        // try to run a for loop as all info is inside tripcell.
//        
//        let xy = CGPoint(x: 10.0,y: 0.0)
//        let size = CGSize(width:10,height:10)
//        
//        let spacingFloat = CGPoint(x: size.width,y: size.height )
//        
//        
//        //  let tripCell = trips[indexPath.row]
//        //let tripCell = newTrip[indexPath.row]
//        
//        
//        let realTimeHeaderCell = newTrip[section] as! Trip
//        
//        //drawLeg(xy, size: size, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, indexPath: <#T##NSIndexPath#>, orientation: <#T##Character#>, spacingFactor: <#T##Float#>)
//        
//        
//        let startingPoint = CGPoint(x: 5.0,y: 2.0)
//        let startingSize = CGSize(width:20.0,height:20.0)
//        let orientation = "x"  // x, y, or xy
//        let innerSpacing = CGPoint(x:10,y:0)
//        let innerLegSpacing = CGPoint(x:25,y:0)
//        let sizeFactor = CGSize(width: 0.0,height: 0.0)
//        
//        SlifeMethods.drawLegs(startingPoint, startingSize: startingSize, legs: tripCell.LegList, cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
//        
//        //   SlifeMethods.drawLeg(xy, size: size, legs: tripCell.LegList, cell: cell, indexPath: indexPath, orientation: "x", spacingFactor: spacingFloat)
//        
//        
//        //        SlifeMethods.drawLeg(xy, size: size, legs: tripCell.LegList, cell: cell, indexPath: indexPath, orientation: "x", spacingFactor: spacingFloat)
//        
//        print("------from station = \(tripCell.originDetail.name)")
//        print("------from time = \(tripCell.originDetail.time)")
//        
//        print("------to station = \(tripCell.destinationDetail.name)")
//        print("------to time = \(tripCell.destinationDetail.time)")
//        
//        headerCell.from_station.text = tripCell.originDetail.name
//        headerCell.from_time.text = tripCell.originDetail.time
//        
//        headerCell.to_station.text = tripCell.destinationDetail.name
//        headerCell.to_time.text = tripCell.destinationDetail.time
//        headerCell.duration.text = tripCell.dur
//        print("tripcell.duration is =)")
//        
//        

        
        return headerCell
    }
    
    
    
    
    
    
    /*
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        //---construct url start
        // http://api.sl.se/api2/typeahead.json?key=0b0656ad5c1d4a47a79dd668cb5f9d79&searchstring=a&stationsonly=true
        
        
        
        
        if(searchController.searchBar.text == "" )
        {
            print("empty string------")
            
            
        }
            
        else if (searchController.searchBar.text == nil) {
            
            print ("nilllllllllll")
            
        }
            
        else if (searchController.searchBar.text?.characters.count > 2)
        {
            print("retStr---bef4-----------------\(searchController.searchBar.text!)")
            let retStr = SlifeMethods.stringToSlFormat(searchController.searchBar.text!)
            print("retStr---after-----------------\(retStr)")
            
            //  tableData.removeAllObjects()
            let url = WebServiceHandler.constructURL_Sl_plats(retStr, stationOnly: true)
            
            //--construct url-------------------end
            // call webservice
            
            get_data_from_url(url)
            //get_data_from_url(url)
            print("----------------------------------------")
            //tableData.removeAllObjects()
            print("table data count is = \(tableData.count)")
            print("----------------------------------------")
            
        }
        
        
        print("searchController.searchBar.text! == \(searchController.searchBar.text!)")
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    */
    
    //----call webservice-----start
    
    func get_data_from_url(url:String)
    {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        //request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        print("---json step 1---real time--test real-")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print("---json step 2-----test-")
            
            DispatchQueue.main.async(execute: {
                
//            DispatchQueue.main.asynchronously(execute: {
      
                self.extract_json(jsonData: data! as NSData)
                print("-in real time result--7.1--about to return after parsing")
                jsonLoaded = true
                self.disableTransportModesNotAvailable(realTimeResultTrafficSource: tableData)
                // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                
                //self.getTrips(convertedJsonIntoNSDict)
                //--for-1--------------------------------------------------------------------------------------------------
                
                print("-in real time result-7.2--about to return after parsing")
                // reload the table here
                self.tableView.reloadData()
                return
            })
        }
        task.resume()
    }
    
    //----call webservice-----........end
    
    //---extract data from json-.------start
    
    
    func extract_json(jsonData:NSData)
    {
        print("-in real time result--json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("json downloading in progres........4....from/To....")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
             // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
        
        tempDict = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---6-----convertedJSON is being printed = \(tempDict.allKeys)")
           print("-before----tabledata count before adding--= \(tableData.count)")
        tableData.removeAllObjects()

        if (tempDict.count == 0){
            // check for message
            let message = "Message" + (tempDict["Message"] as! String)
//            tableData.addObject(message)
            tableData.setValue(message, forKey: "message")
            // check for station code
            let statusCode = "Status Code:" + (tempDict["StatusCode"] as! String)
            tableData.setValue(statusCode, forKey: "statusCode")

        } else {
            // check for the status code 
            
            // if it is zero
            
//            ----AFTER MAGHRIB NAMAZ IN SHA ALLAH----
            
            // if it is not zero then do the rest of the processing
            
            let StatusCode = tempDict["StatusCode"] as! Int
            
            if (StatusCode == 0){
               // print("ResponseData.Buses.Count=\((tempDict["ResponseData"]!["Buses"] as! NSArray).count)")
                
                RealTidMethods.extractBuses(jsonObject: ( tempDict["ResponseData"]! as! [String:Any])["Buses"] as! NSArray)
         //       print("ResponseData.METROS.Count=\((tempDict["ResponseData"]!["Metros"] as! NSArray).count)")
                
                RealTidMethods.extractMetros(jsonObject: (tempDict["ResponseData"]! as! [String:Any])["Metros"] as! NSArray)
                RealTidMethods.extractShips(jsonObject: (tempDict["ResponseData"]! as! [String:Any])["Ships"] as! NSArray)
                RealTidMethods.extractTrams(jsonObject: (tempDict["ResponseData"]! as! [String:Any])["Trams"] as! NSArray)
                RealTidMethods.extractTrains(jsonObject: (tempDict["ResponseData"]! as! [String:Any])["Trains"] as! NSArray)
                
                
               print("----going to leave from real time result view controller")
                
                 // means every thing is fine so go ahead
            // tableData.setValue(StatusCode, forKey: "statusCode")
            print(tableData.allKeys)
                print("---98789-----")
                print(tableData)
            }
            // if status code is not 0 then get the message
            else
            {
            
            let message = tempDict["Message"] as! String
               print("Message is available")
                print(message)
                
                tableData.setValue(message, forKey: "Message")
                
            }
            //print("response Data = \(responseData)")
            
            
            
//            for responseData in responseData {
//                let platsName = responseData["Name"]!
//                print("station is = \(platsName!)")
//                tableData.addObject(platsName!)
//            }
        }
        self.tableView.reloadData()
        
        print("-after----tabledata count AFTER-= \(tableData.count)")
        
    }
     //--extract data from json ........end
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//    
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//       
        print("current row is selected = \(tableData[indexPath.row])")
        self.dismiss(animated: true, completion: nil)
        from_to_value = tableData[indexPath.row] as! String
        // get all the values and return
        
        print("tempDict count is = \(tempDict.count)")
        if (real_time_flag == false){
            if (tempDict.count == 4){
                let responseData = tempDict["ResponseData"] as! NSArray
                station.name = ( responseData[indexPath.row] as! [String:Any])["Name"] as! String
                station.type = ( responseData[indexPath.row] as! [String:Any]) ["Type"] as! String
                station.site_id = ( responseData[indexPath.row] as! [String:Any])["SiteId"] as! String
                station.x = (responseData[indexPath.row] as! [String:Any]) ["X"] as! String
                station.y = (responseData[indexPath.row] as! [String:Any]) ["Y"] as! String
            }
            else if (tempDict.count == 2) {
                print("tableData name = \(tableData[indexPath.row])")
                print("station.name = \(station.name)")
            }
            navigationController?.popToRootViewController(animated: true)
        }
        else if (real_time_flag == true){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            // let vc = RealTimeResult_ViewController(nibName: "RealTimeResult_ViewController", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RealTimeResult_ViewController") as! RealTimeResult_ViewController
           // self.presentViewController(nextViewController, animated:true, completion:nil)
      //      self.navigationController?.prepareForSegue(nextViewController, sender: self)
         
            real_time_flag = false
            print("moving towards real time controller--------------------")
        }
    }
    
    // functions custom
    
    func disableTransportModesNotAvailable (realTimeResultTrafficSource: NSDictionary){
        availableTransportModes.removeAllObjects()
        totalCountRealTimeResult = 0
        buttonIndexArray.removeAllObjects()
        notAvailableTransportModes.removeAllObjects()
        
    // iterate through datasource dictionary
        
    // add disable transport mode names to nsmutable array
    var b = 0
        
        var i = 0
        print("totalCountRealTimeResult :::before adding any :: = \(totalCountRealTimeResult)")
        for (key,value) in realTimeResultTrafficSource {
        
        print("key----direct---\(key)")
            let someArray = value as! NSArray
            print("i value is = \(i)")
             if (someArray.count <= 1 ){
            
                
                print("realTimeResultTrafficSource[i]?.name = \(key)")
                print("someArray count is = \(someArray.count)")
                
                if (key as! String == BUSES){
                buttonIndexArray.add(busesTag)
                    
                }
                if (key as! String == METROS){
                    buttonIndexArray.add(metroTag)
                }
                if (key as! String == TRAINS){
                    buttonIndexArray.add(railTag)
                }
                if (key as! String == SHIPS){
                    buttonIndexArray.add(ferryTag)
                }
                if (key as! String == TRAMS){
                    buttonIndexArray.add(tramTag)
                }
                
                
            totalCountRealTimeResult += someArray.count
            print("key.value is = \(key)")
            notAvailableTransportModes.add(key)
            i += 1
            
            }
        }
        print("tag count available transport mode = \(buttonIndexArray.count)")
        print("not available transport modes status is = \(notAvailableTransportModes.count)")
        print("totalCountRealTimeResult ::::: = \(totalCountRealTimeResult)")
        
        /*
        for key in realTimeResultTrafficSource {
        
            print(".---------..bbbb.....\(b)")
            let transportModeResult = key.value as! NSArray
            print(key)
            print("transportModeResult.count======::::::\(transportModeResult.count)")
           
            if (transportModeResult.count > 0 ) {
            print(".---------..b.....\(b)")
            print("last value of total = \(totalCountRealTimeResult)")
            totalCountRealTimeResult += transportModeResult.count
                print("not equal to zero found = \(key.value)")
                print("totalCountRealTimeResult====\(totalCountRealTimeResult)")
                
                availableTransportModes.addObject(key.value)
                
            }
            else {
        
            // if count is 0 then add to disable list
          //  availableTransportModes.addObject(key.value)
                print("not available = \(key)")
                
            
            }
            
            b++
        }
        
        print("transport modes available = \(availableTransportModes.count)")
       
        var i = 0
        
        for index in availableTransportModes {
        
            print("-----------transport mode not available = \(i)--\(availableTransportModes[i])")
        
        
        i++
        }
        
        print("final value _ totalCountRealTimeResult====\(totalCountRealTimeResult)")
        */
    
    
    }
    
    
    
}


/*
import Foundation
import UIKit
class RealTimeResult_ViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----inside real time result view control............")
    }
}
 */

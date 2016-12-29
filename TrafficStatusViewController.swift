////
////  TrafficStatusViewController.swift
////  SLife
////
////  Created by syed farrukh Qamar on 16/05/16.
////  Copyright © 2016 Be My Competence AB. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class TrafficStatusViewController: UIViewController {
////}
//

//
//  TrafficStatusViewController.swifty
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

// temp switching off to move to central traffic status : 28 jul :1418 HRS---start
//
//let trafficStatusCode = "StatusCode"
//let MESSAGE_TRAFFICSTATUS = "Message"
//var trafficStatusDict = NSMutableDictionary()
//var dataSourceTrafficStatus = NSMutableArray()
//var dataSourceStatusCode = NSMutableDictionary()
//var jsonTrafficStatusLoaded = false
//
//
//let trafficStatusURL = "https://api.sl.se/api2/trafficsituation.json?key=5f8ccb4f332f4b068d77d4230eb7300c"

// temp switching off to move to central traffic status : 28 jul :1418 HRS---end
// Traffic status indexes

let METRO_INDEX = 0
let RAIL_TRAIN_INDEX = 1
let LOCAL_LIGHTRAIL_INDEX = 2
let TRAM_INDEX = 3
let BUS_INDEX = 4
let FERRY_INDEX = 5
var selected_index = 0
let DEFAULT_INDEX_TRAFFIC_STATUS = 14
let transportTypeBar_StartIndex = 10
let transportTypeBar_EndIndex = 14
var buttonSelectedTag = Int()
var buttonPressed = false
class TrafficStatusViewController:UITableViewController {
            //let tableData = ["Current Location","AltaCentrum","Three","Twenty-One"]
  
  //  @IBOutlet weak var busesStatusIcon: UIImageView!
    
    @IBAction func showBuses(sender: UIButton) {
       
        buttonSelectedTag = sender.tag
        buttonPressed = true
        print("Show Buses.....BUS_INDEX= \(BUS_INDEX)")
        selected_index = BUS_INDEX
        print("current tage pressed : \(sender.tag)")
        
        print("buttonSelectedTag ::::: = \(buttonSelectedTag)")
        
       sender.backgroundColor = UIColor.blue
              print("tag view self.view.tag = \(self.view.tag)")

        
//        var bb = sender.superview?.viewWithTag(buttonSelectedTag) as! UIButton
//        bb.backgroundColor = UIColor.blackColor()
    
        
        
     //   Buttons.selectButton_AndResetRest(sender.tag, buttonRangeFromTag: transportTypeBar_StartIndex, buttonRangeToTag: transportTypeBar_EndIndex, currentView: sender.superview!)
        
  // var currentButton = sender.tag as! UIButton
    // sender.backgroundColor = UIColor.blueColor()
        
   //   print("super view tag is = \(sender.superview?.tag)")
      //var bb =   v?.viewWithTag(selected_index) as! UIButton
        
    //  bb.backgroundColor = UIColor.blueColor()
       
       //var b =  self.view.viewWithTag(selected_index) as! UIButton
        
      //  b.backgroundColor = UIColor.blueColor()
         tableView.reloadData()
        
    }
    
    @IBAction func showMetro(sender: UIButton) {
        print("showMetro.....METRO_INDEX =\(METRO_INDEX)")
       
        selected_index = METRO_INDEX
        buttonSelectedTag = sender.tag
        buttonPressed = true

        tableView.reloadData()
        
    }
    @IBAction func showLightRail(sender: UIButton) {
        print("showLightRail...LOCAL_LIGHTRAIL_INDEX = \(LOCAL_LIGHTRAIL_INDEX).")
        selected_index = LOCAL_LIGHTRAIL_INDEX
        buttonSelectedTag = sender.tag
        buttonPressed = true
        tableView.reloadData()
        
    }

    @IBAction func showRail(sender: UIButton) {
        print("showRail...RAIL_TRAIN_INDEX = \(RAIL_TRAIN_INDEX).")
        selected_index = RAIL_TRAIN_INDEX
        buttonSelectedTag = sender.tag
        buttonPressed = true
        tableView.reloadData()
        
    }
    @IBAction func showTram(sender: UIButton) {
        print("showTram..TRAM_INDEX.= \(TRAM_INDEX)")
        selected_index = TRAM_INDEX
        buttonSelectedTag = sender.tag
        buttonPressed = true
        tableView.reloadData()
        
    }
    @IBAction func showFerry(sender: UIButton) {
        print("FERRY_INDEX...FERRY_INDEX=\(FERRY_INDEX)")
        selected_index = FERRY_INDEX
        buttonSelectedTag = sender.tag
        buttonPressed = true
        tableView.reloadData()
    }
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 240
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        // switching off the downloading of traffic status because it is being called on the main screen
        // Note* we need to add the refresh function then we would uncomment it
        
        /*
        let url = WebServiceHandler.constructURL_SL_Realtidsinformation_3(station.site_id, timeWindow: timeWindowForRealRid)
        get_data_from_url(trafficStatusURL)
        */
        
        //------traffic status bar image change ..........stand
        
        
        
        
        //.......traffic status bar image change ..........end
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // process all json
        // print("retStr---bef4-----------------\(searchController.searchBar.text!)")
        // receive site id here from the previous controller
        
        
        //  let retStr = SlifeMethods.stringToSlFormat(siteID)
        
        //  print("retStr---after-----------------\(retStr)")
        
        //  tableData.removeAllObjects()
        //let url = WebServiceHandler.constructURL_SL_Realtidsinformation_3(station.site_id, timeWindow: timeWindowForRealRid)
        //--construct url-------------------end
        // call webservice
        print("TRAFFIC STATUS----accessing URL-")
        get_data_from_url(url: trafficStatusURL)
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // 1
        // Return the number of sections.
       /*
        print("TRAFFIC STATUS SECTION COUNT IS = \(dataSourceTrafficStatus.count)")
        if (jsonTrafficStatusLoaded == true){
           // 29-07-2016 temp
            let sectionCount = dataSourceTrafficStatus.count + 1
            
            print("current section count is = \(sectionCount)")
            return sectionCount
        }
        // 29-07-2016 temp
        
        // return 0
 */
        return 1
    }
    
    
    // MARK:Row Height
    
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //      return 250
    //    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // check for status code (pending for now)
        // if status code is 0 then look for number of rows else return 0
        
        
        
        print("TRAFFIC STATUS-----number of rows in section --to be continue")
       
        //  tableData[currentSelection]?.count
        print(dataSourceTrafficStatus.count)
        //        if(section == 1){
      
        if (jsonTrafficStatusLoaded == true){
//            print("section traffic status = \()")
            print("-----traffic status loaded---JSON LOADED --------\(dataSourceTrafficStatus.count)--------------")
            // temp 29th jul
//            if (section == 0){
//            print("returning 1 .........")
//            
//            return 1
//            
//            }
//            else  {
            
            // temp replacing
           // let sectionIndex = section - 1
                
            let trafficEventCellData = dataSourceTrafficStatus[selected_index] as! TrafficType
            
                print("trafficEventCellData.------=\(trafficEventCellData.name)")
            
            print("trafficEventCellData.trafficEvents.count------=\(trafficEventCellData.trafficEvents.count)")
          
            // temp 29-07-2016 changing
            var rowsCount = 0
            
            rowsCount = trafficEventCellData.trafficEvents.count
                
            print("for section value is = section---\(section)")
            
            print("Total number of rows Count is \(rowsCount)")
            return rowsCount
           //return 0
            
         //   }
            
            //return 0
        }
       
        
        
        //         }
       // temp 29-07-2016 changing
       // return 1
        
        return 0
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        <#code#>
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("current section value is ====\(indexPath.section)")
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "TrafficEventCell", for: indexPath as IndexPath) as! TrafficEventCell
        
//        if (indexPath.section == 0){
//        
//        let trafficStatusCell = TrafficStatusCell()
//            
//            print("section is 0 , cell count is 0------------")
//            return trafficStatusCell
//        
//        
//        
//        }
        
       // else {
            
            
            
          //  let indexSection = indexPath.section //- 1
//            print("---original section value is----12----indexSection ===\(indexPath.section)")
//            
//            print("-------12----indexSection ===\(indexPath.section)")
//            print("-------12----indexRow ===\(indexPath.row)")

        // temp replacement on 29th of jul 
         let trafficEventCellData = dataSourceTrafficStatus[selected_index] as! TrafficType
//        let trafficEventCellData = dataSourceTrafficStatus[indexPath.section] as! TrafficType
        
     //   cell.transportMode.text =  trafficEventCellData.statusIcon
        
        
        print("Event Icon Name = \(trafficEventCellData.trafficEvents[indexPath.row].statusIcon)")
        print("station Name = \(trafficEventCellData.trafficEvents[indexPath.row].trafficLine)")
        print("station Name : Message = \(trafficEventCellData.trafficEvents[indexPath.row].message)")
        
        let defaultMessage = String("All Traffic is working fine.")
        if (trafficEventCellData.trafficEvents[indexPath.row].statusIcon == EVENTGOOD_ICON){
            
            cell.stationName.text = defaultMessage
            let iconName = EVENTGOOD_ICON + ".png"
            cell.eventIcon.image = UIImage(named: iconName)
        
        }
        else if (trafficEventCellData.trafficEvents[indexPath.row].statusIcon  == EVENTMINOR_ICON){
           
            let iconName = EVENTMINOR_ICON + ".png"
            cell.eventIcon.image = UIImage(named: iconName)

        
        } else {
        
            let iconName = EVENTPLANNED_ICON + ".png"
            cell.eventIcon.image = UIImage(named: iconName)
     }
        
        let s =  trafficEventCellData.trafficEvents[indexPath.row].message
as! String

        print("s.characters.count == \(s.characters.count)")
        
        cell.message.text =  trafficEventCellData.trafficEvents[indexPath.row].message
    
        cell.stationName.text = trafficEventCellData.trafficEvents[indexPath.row].trafficLine
        print("cell.stationName.text::::::::\(cell.stationName.text)")
//        print("--------indexPath.section--\(indexPath.section)----\(trafficEventCellData.trafficEvents[indexPath.row].lineNumbers)")
//        print("--------indexPath.section--\(indexPath.section)----\(trafficEventCellData.name)")
//        print("----trafficEventCellData.trafficEvents.count-- .\(trafficEventCellData.trafficEvents.count)")
        if ((cell.stationName.text?.characters.count)! < 5){
        
        cell.stationName.text = defaultMessage
        }
        return cell
        //}
            }
      override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
//    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
        print("TRAFFIC STATUS VC SECTYION NUMBER = ------- \(section)")
        // if section value is 0 then display traffic status bar
        
        
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "TrafficStatus") as! TrafficStatusCell
       
        headerCell.showMetro.tag = 10
        headerCell.showRail.tag = 11
        headerCell.showLightRail.tag = 12
        headerCell.showTram.tag = 13
        headerCell.showBuses.tag = 14
        headerCell.showFerry.tag = 15
        
//        print("headerCell.showBuses.tag = \(headerCell.showBuses.tag)")
//        
//         print("buttonSelectedTag ::::: = \(buttonSelectedTag)")
//        
        if (buttonPressed == true){
        
            print(".Button pressed...........about to change buttons")
            print("headerCell.showBuses.tag = \(headerCell.showBuses.tag)")
            print("buttonSelectedTag ::::: = \(buttonSelectedTag)")
            Buttons.selectButton_AndResetRest(selectedButtonTag: buttonSelectedTag, buttonRangeFromTag: transportTypeBar_StartIndex, buttonRangeToTag: transportTypeBar_EndIndex, currentCell: headerCell)
        
        buttonPressed = false
        
        }
        else {
            Buttons.selectButton_AndResetRest(selectedButtonTag: DEFAULT_INDEX_TRAFFIC_STATUS, buttonRangeFromTag: transportTypeBar_StartIndex, buttonRangeToTag: transportTypeBar_EndIndex, currentCell: headerCell)
         
        }
//        if (headerCell.showBuses.tag == buttonSelectedTag){
//      
//        print("trying to change the button background.....")
//        //    headerCell.showBuses.backgroundColor = UIColor.blueColor()
//         
//            let test = headerCell.viewWithTag(14) as! UIButton
//
//            test.backgroundColor = UIColor.blackColor()
//        }
//
       // headerCell.metroStatusIcon.image = UIImage(named: "EventGood.png")
        
        //..................start
        
        if (downloadingNotFinishedTrafficStatus == false){
            
            print("dataSourceTrafficStatus:::::\(dataSourceTrafficStatus.count)")
            
            //dispatch_get_main_queue().async(execute: {
                DispatchQueue.main.async(execute:
                    {
                //<#T##DispatchWorkItem#>)
                
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
                        
                        headerCell.metroStatusIcon.image = UIImage(named: iconName)
                        // self.busesStatusIcon.image = UIImage(named: "EventGood.png")
                        break
                        
                        // respond to value 1
                        
                    // 1 train
                    case "train":
                        
                        print("train found ........train..iconName\(iconName).")
                        headerCell.railTrainStatusIcon.image = UIImage(named: iconName)
                        break
                    // 2 local
                    case "local":
                        print("local found ........local..iconName\(iconName).")
                        headerCell.lightRailStatusIcon.image = UIImage(named: iconName)
                        
                        break
                        
                        
                    // 3 tram
                    case "tram":
                        print("tram found ........tram..iconName\(iconName).")
                        headerCell.tramStatusIcon.image = UIImage(named: iconName)
                        
                        break
                        
                        
                    // 4 bus
                    case "bus":
                        print("bus found ........bus..iconName\(iconName).")
                        headerCell.busesStatusIcon.image = UIImage(named: iconName)
                        
                        break
                        
                    // 5fer
                    case "fer":
                        print("fer found ........fer..iconName\(iconName).")
                        headerCell.ferryStatusIcon.image = UIImage(named: iconName)
                        
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
        
        //..................end
        
        return headerCell

        /*
        if (section == 0) {
        
            let headerCell = tableView.dequeueReusableCellWithIdentifier("TrafficStatus") as! TrafficStatusCell
            
        
         return headerCell
        }
        // else if section value is > 0 then go with other display thing but subtract one so that normal section is being printed
        
        
        else {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("TrafficTypeHeaderCell") as! TrafficTypeCell
        headerCell.backgroundColor = UIColor.lightGrayColor()
       // temp replacing section with sectionIndex because 0 index belongs to traffic status which should be printed first
            
            let sectionIndex = section - 1
            
        let trafficTypeCellData = dataSourceTrafficStatus[sectionIndex] as! TrafficType
        
        headerCell.disruptionTypeIcon.text = trafficTypeCellData.statusIcon

        headerCell.trafficMode.text = trafficTypeCellData.type
        print ("------message-----name--\(trafficTypeCellData.name)--")
        print ("------status icon--------\(trafficTypeCellData.statusIcon)--")

        print ("------header section is printed--------\(section)--")
              //        //drawLeg(xy, size: size, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, indexPath: <#T##NSIndexPath#>, orientation: <#T##Character#>, spacingFactor: <#T##Float#>)
        //
               return headerCell
        }
        */
    }
        func get_data_from_url(url:String)
    {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("-INSIDE TRAFFIC STATUS--json step 1---real time--test real-")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print("-TRAFFIC STATUS----json step 2-----test-")
          DispatchQueue.main.async(execute:

    {
//    <#T##() -> Void#>)
//            DispatchQueue.main.asynchronously(execute: {
//           
                self.extract_json(jsonData: data! as NSData)
                print("TRAFFIC STATUS---in real time result--7.1--about to return after parsing")
                jsonTrafficStatusLoaded = true
                // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                 //self.getTrips(convertedJsonIntoNSDict)
                //--for-1-------------------------------------------------------------------------------------------------
                print("TRAFFIC STATUS-in real time result-7.2--about to return after parsing")
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
        print("--INSIDE TRAFFIC STATUS------in real time result--json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("json downloading in progres........4......-INSIDE TRAFFIC STATUS--.")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
        
        trafficStatusDict = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---INSIDE TRAFFIC STATUS---6-----convertedJSON is being printed = \(trafficStatusDict.allKeys)")
        print("--INSIDE TRAFFIC STATUS--.....before----dataSourceTrafficStatus count before adding--= \(dataSourceTrafficStatus.count)")
        dataSourceTrafficStatus.removeAllObjects()
        
        if (trafficStatusDict.count == 0){
            print("taffic status dict count is 0----")
            // check for message
            let message = "Message" + (trafficStatusDict["Message"] as! String)
            //            tableData.addObject(message)
            // check for station code
            let statusCode = "Status Code:" + (trafficStatusDict["StatusCode"] as! String)
            let statusCodeInt = trafficStatusDict["StatusCode"] as! Int
            
            dataSourceStatusCode.setValue(message, forKey: "message")
            
            dataSourceStatusCode.setValue(statusCodeInt, forKey: trafficStatusCode)
//            dataSourceTrafficStatus.setValue(statusCode, forKey: "statusCode")
            
        } else {
            // check for the status code
            
            // if it is zero
            
            // if it is not zero then do the rest of the processing
            
            let StatusCode = trafficStatusDict["StatusCode"] as! Int
            
            dataSourceStatusCode.setValue(StatusCode, forKey: trafficStatusCode)
            
            if (StatusCode == 0){
              //  print("traffic status : ResponseData. Traffic Types =\((trafficStatusDict["ResponseData"]!["TrafficTypes"] as! NSArray).count)")
                let traffictypes = (trafficStatusDict["ResponseData"] as! NSDictionary)["TrafficTypes"] as! NSArray
                
                TrafficStatusMethods.extractTrafficType(trafficTypes: traffictypes)
//                RealTidMethods.extractBuses(tempDict["ResponseData"]!["Buses"] as! NSArray)
//                print("ResponseData.METROS.Count=\((tempDict["ResponseData"]!["Metros"] as! NSArray).count)")
//                
//                RealTidMethods.extractMetros(tempDict["ResponseData"]!["Metros"] as! NSArray)
//                RealTidMethods.extractShips(tempDict["ResponseData"]!["Ships"] as! NSArray)
//                RealTidMethods.extractTrams(tempDict["ResponseData"]!["Trams"] as! NSArray)
//                RealTidMethods.extractTrains(tempDict["ResponseData"]!["Trains"] as! NSArray)
//                
                
                print("--traffic status--going to leave from real time result view controller")
                
                // means every thing is fine so go ahead
                // tableData.setValue(StatusCode, forKey: "statusCode")
                print(trafficStatusDict.allKeys)
                print("---98789----traffic statustrafficStatusDict.allKeys =\(trafficStatusDict.allKeys)-")
                
                print("--dataSourceTrafficStatususDict------")
                
                print(dataSourceTrafficStatus)
            }
                // if status code is not 0 then get the message
            else
            {
                
                let message = trafficStatusDict["Message"] as! String
                print("Message is available")
                print(message)
                
                dataSourceStatusCode.setValue(message, forKey: "Message")
                
            }
            //print("response Data = \(responseData)")
            
            
            
            //            for responseData in responseData {
            //                let platsName = responseData["Name"]!
            //                print("station is = \(platsName!)")
            //                tableData.addObject(platsName!)
            //            }
        }
        self.tableView.reloadData()
        
        print("-after----tabledata count AFTER-dataSourceTrafficStatus\(dataSourceTrafficStatus.count)")
        
        
        print("-after----tabledata count AFTER-= \(trafficStatusDict.count)")
        
    }
    
    
    //--extract data from json ........end
    
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//<#code#>
//}
//
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        print("current row is selected = \(dataSourceTrafficStatus[indexPath.row])")
        self.dismissViewControllerAnimated(true, completion: nil)
        from_to_value = tableData[indexPath.row] as! String
        // get all the values and return
        
        print("tempDict count is = \(tempDict.count)")
        if (real_time_flag == false){
            if (tempDict.count == 4){
                let responseData = tempDict["ResponseData"] as! NSArray
                station.name = responseData[indexPath.row]["Name"] as! String
                station.type = responseData[indexPath.row]["Type"] as! String
                station.site_id = responseData[indexPath.row]["SiteId"] as! String
                station.x = responseData[indexPath.row]["X"] as! String
                station.y = responseData[indexPath.row]["Y"] as! String
            }
            else if (tempDict.count == 2) {
                print("tableData name = \(tableData[indexPath.row])")
                print("station.name = \(station.name)")
            }
            navigationController?.popToRootViewControllerAnimated(true)
        }
        else if (real_time_flag == true){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            // let vc = RealTimeResult_ViewController(nibName: "RealTimeResult_ViewController", bundle: nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RealTimeResult_ViewController") as! RealTimeResult_ViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            print("moving towards real time controller--------------------")
        }
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

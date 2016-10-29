//
//  IntermediateStopsViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 15/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//


import Foundation
import UIKit

var intermediateStops = IntermediateStops()
var setJourneyDetailedReference = String()
var setOriginStop = Int()
var setDestinationStop  = Int()
var intermediateStops_JSON_Loaded_Flag = false
var check = 0

var setRootLegOriginTime = String()
var setRootLegOriginStation = String()

var setRootLegDestinationTime = String()
var setRootLegDestinationStation = String()


// journey detail ref variables
var jsonIntermediateStopsLoaded = false
let MESSAGE_INTERMEDIATE_STOPS = "Message"
var intermediateStops_Dict = NSDictionary()
var intermediateStops_Array = NSMutableArray()
let intermediateStops_Status = Int()
var dataSource_intermediateStops_StatusCode = NSMutableDictionary()

let test = "https://api.sl.se/api2/trafficsituation.json?key="
let intermediateStops_URL = "https://api.sl.se/api2/TravelplannerV2/journeydetail.json?key=28650f61c688449cb9e87c13fbbf8b5b&"
class IntermediateStopsViewController:UITableViewController {
    
    
    
    
    //let tableData = ["Current Location","AltaCentrum","Three","Twenty-One"]
    @IBAction func back_Action(_ sender: UIBarButtonItem) {
        print("back button is pressed....")

        self.navigationController?.popViewController(animated: true)
           }
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.bordered, target: self, action: "back:")
//        self.navigationItem.leftBarButtonItem = newBackButton
        
     //   let url = WebServiceHandler.constructURL_SL_Realtidsinformation_3(station.site_id, timeWindow: timeWindowForRealRid)
        if (setJourneyDetailedReference != "") {
            let final_intermediate_stop_URL = intermediateStops_URL + setJourneyDetailedReference
            print(" \(final_intermediate_stop_URL)")
            print("--------01010------9898-----")
            print(setJourneyDetailedReference)
            print("view did load _journey det ref = \(setJourneyDetailedReference)")
            
        } else {
        
        print("Walk has been caught........ in intermediateStops")
        
        }
        //get_data_from_url(final_intermediate_stop_URL)
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
        
        print("Intermediate Stop URL----accessing URL setJourneyDetailedReference = \(setJourneyDetailedReference)-")
        if (setJourneyDetailedReference != ""){
        let final_intermediate_stop_URL = intermediateStops_URL + setJourneyDetailedReference
        
        print("Journey Detail Reference Value is..... = \(setJourneyDetailedReference)")
        print("key \(final_intermediate_stop_URL)")
        
          get_data_from_url(url: final_intermediate_stop_URL)
        print("------after get data from url.................")
        } else {
        
        print("view will appear is here and walk could be one reason")
        
        }
        //get_data_from_url(trafficStatusURL)
    }
    
    // MARK: Swift 3 repl
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        override func numberOfSections(in tableView: UITableView) -> Int {
            
        // 1
        // Return the number of sections.
        print("Intermediate Stops Section Count is = \(dataSourceTrafficStatus.count)")
        if (intermediateStops_JSON_Loaded_Flag == true){
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


    // check for the downloading status
        if (intermediateStops_JSON_Loaded_Flag == true){
        print("-.....intermediate stops flag is true....intermediateStops.intermediateStops.count.....\(intermediateStops.intermediateStops.count).")
            
            return intermediateStops.intermediateStops.count
            
        }
          print("-.....intermediate stops flag is FALSE..........")
        return 0
    }
    
    
 override   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCells") as! IntermediateStopOriginCell
        
       // headerCell.sectionSelected.tag = section
        
    if (intermediateStops.intermediateStops.count != 0 ){
print("arrival time in header cell = \(intermediateStops.originStop.arrTime)")
//        headerCell.fromStation.text = intermediateStops.originStop.name
//        
//        headerCell.fromTime.text = intermediateStops.originStop.arrTime
        headerCell.fromStation.text = setRootLegOriginStation
        
        headerCell.fromTime.text = setRootLegOriginTime
    }
    return headerCell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        <#code#>
//    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerCell = tableView.dequeueReusableCell(withIdentifier: "FooterCells") as! IntermediateStopsDestinationCell
        
        // headerCell.sectionSelected.tag = section
        
        if (intermediateStops.intermediateStops.count != 0  ){
//        footerCell.fromStation.text = intermediateStops.destinationStop.name
//        
//        footerCell.fromTime.text = intermediateStops.destinationStop.arrTime

            footerCell.fromStation.text = setRootLegDestinationStation
            
            footerCell.fromTime.text = setRootLegDestinationTime
            
        
        }
        
        
        return footerCell
    }
    
    
    
    
    func back(sender: UIBarButtonItem) {
        print("Before-intermediateStops.intermediateStops.count === \(intermediateStops.intermediateStops.count)")
        
        intermediateStops.intermediateStops.removeAll()
        print("Last-intermediateStops.intermediateStops.count === \(intermediateStops.intermediateStops.count)")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntermediateStopCells", for: indexPath as IndexPath) as! IntermediateStopsCell
       
      //  if(indexPath.section == 1){
        print("index path row = \(indexPath.row)")
        
        print("intermediata stops count + 2= \(intermediateStops.intermediateStops.count)")
        
        print("intermediata stops count = \(intermediateStops.intermediateStops.count)")
        
        
        print("cell value = \(intermediateStops.intermediateStops[indexPath.row ].arrTime)")
            print("cell value = \(intermediateStops.intermediateStops[indexPath.row].arrDate)")
            
            
            print("----1-----")
            cell.fromTime.text = intermediateStops.intermediateStops[indexPath.row].arrTime
            
            print("----2-----")
            cell.fromStation.text = intermediateStops.intermediateStops[indexPath.row].name
            print(" total stops = \(intermediateStops.intermediateStops.count)")
   // }
    return cell
    }
    
    
    func get_data_from_url(url:String)
    {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
//        request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        print("-INSIDE intermediate stops--json step 1---real time--test real-")
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print("-intermediate stops----json step 2-----test-")
            DispatchQueue.main.async(execute: {
               
                print("A____intermediate stops---in real time result--7.1--about to return after parsing")
            //    let testDict = data as! NSDictionary
              //  print("test Dict in intermediate Stops::::: \(testDict.allKeys)")
                self.extract_json(jsonData: data! as NSData)
                print("B____intermediate stops---in real time result--7.1--about to return after parsing")
                jsonTrafficStatusLoaded = true
                // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                //self.getTrips(convertedJsonIntoNSDict)
                //--for-1-------------------------------------------------------------------------------------------------
                print("intermediate stops-in real time result-7.2--about to return after parsing")
                // reload the table here
                self.tableView.reloadData()
                
                return
            })
        }
        print("returned after dispatched block ...........................")
        task.resume()
    }
    
    //----call webservice-----........end
    
    //---extract data from json-.------start
    
    
    func extract_json(jsonData:NSData)
    {
        print("--intermediate stops------in real time result--json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("json downloading in progres........4......intermediate stops--.")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            
            print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
           intermediateStops_JSON_Loaded_Flag = true
            
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
        
        intermediateStops_Dict = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---intermediate stops---6-----convertedJSON is being printed = \(intermediateStops_Dict.allKeys)")
       // define a journey detail variable in the view controller intermediate stops
        // extract 1 by 1 its objects and put them in the
        if (intermediateStops_Dict.count == 0){
            print("taffic status dict count is 0----")
            // check for message
            let message = "Please try again Later......"
            //            tableData.addObject(message)
            // check for station code
            
            dataSource_intermediateStops_StatusCode.setValue(message, forKey: "message")
            
//            dataSource_intermediateStops_StatusCode.setValue(statusCodeInt, forKey: intermediateStops_StatusCode)
            //            dataSourceTrafficStatus.setValue(statusCode, forKey: "statusCode")
        }
        else {
            print("sc 1--.......")
            let dictJourneyDet =  intermediateStops_Dict["JourneyDetail"]! as! NSDictionary
            print("dict JourneyDict in intermediate stops.......\(dictJourneyDet.allKeys)")
            if ( intermediateStops_Dict["JourneyDetail"]! as! NSDictionary).value(forKey: "Directions") == nil {
            let errorCode =  (intermediateStops_Dict["JourneyDetail"]! as! NSDictionary).value(forKey: "errorCode") as! String
            print("Error Code:::kjl: \(errorCode)")
                print((intermediateStops_Dict["JourneyDetail"]! as! NSDictionary))
            }
            else {
            //MARK: NIL Found
                
                if ( intermediateStops_Dict["JourneyDetail"]! as! NSDictionary).value(forKey: "Directions")  == nil {
                    let errorCode =  (intermediateStops_Dict["JourneyDetail"]! as! NSDictionary).value(forKey: "errorCode") as! String
                    print("Error Code::8789:: \(errorCode)")
                }
            let testDict = ( intermediateStops_Dict["JourneyDetail"]! as! NSDictionary)["Directions"] as! NSDictionary
            print("printing all keys = \(testDict.allKeys)")
        // extract directions
             print("sc 1--.......")
            let directionsDict = (intermediateStops_Dict["JourneyDetail"]! as! [String:Any])["Directions"] as! NSDictionary
            let directionsArrayTest = RealTidMethods.checkIfArray(objectToCheck: directionsDict["Direction"]! as AnyObject)
            if (directionsArrayTest == false){
                
                print("Dict caught")
                
                intermediateStops.directions.directionName = RealTidMethods.checkNullForString(someValue: (directionsDict["Direction"]! as! NSDictionary), keyName: "$")
                 print("sc 2--.......")
                // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
                let routeIdfrm = RealTidMethods.checkNullForString(someValue: (directionsDict["Direction"] as! NSDictionary), keyName: "routeIdxFrom")
                
                intermediateStops.directions.routeIdFrom = Int(routeIdfrm)!
                
                let routeIdto = RealTidMethods.checkNullForString(someValue: directionsDict["Direction"] as!
                    NSDictionary, keyName: "routeIdxTo")
            intermediateStops.directions.routeIdTo = Int(routeIdto)!
                
            }
            else  {
            
            print("Array caught-.--......")
            
                let directionsArray = directionsDict["Direction"]! as! NSArray
                let directionsDictFromArray = directionsArray[0] as! NSDictionary
            
                intermediateStops.directions.directionName = RealTidMethods.checkNullForString(someValue: (directionsArray[0] as! NSDictionary), keyName: "$")
                
                print("sc 2--.......")
                // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
                let routeIdfrm = RealTidMethods.checkNullForString(someValue: (directionsArray[0] as! NSDictionary), keyName: "routeIdxFrom")
                
                intermediateStops.directions.routeIdFrom = Int(routeIdfrm)!
                
                let routeIdto = RealTidMethods.checkNullForString(someValue: (directionsArray[0] as! NSDictionary), keyName: "routeIdxTo")
                
                print("direction Arrya count = \(directionsArray.count)")
                
                intermediateStops.directions.routeIdTo = Int(routeIdto)!
            
            }
            print("sc 3--.......")
          //  var test = intermediateStops_Dict["Directions"]!["$"] as! String
            //print("VALUE RECEIVED FOR DIRECTIONS.$ in dict = \(test)")
            print("VALUE RECEIVED FOR DIRECTIONS.$ = \(intermediateStops.directions.directionName)")
            // extract geom reference
           // let geomRefDict  = intermediateStops_Dict["JourneyDetail"]!["GeometryRef"]  as! NSDictionary
            intermediateStops.geometryRef = RealTidMethods.checkNullForString(someValue: ((intermediateStops_Dict["JourneyDetail"]! as! [String:Any])["GeometryRef"]  as! NSDictionary), keyName: "ref")
            print("sc 4--.......Geom Ref\(intermediateStops.geometryRef)")
        
            // extract Lines
            
            let linesDict = ((intermediateStops_Dict["JourneyDetail"]! as! [String:Any])["Lines"]! as! [String: Any])["Line"] as! NSDictionary
            let namesDict = ((intermediateStops_Dict["JourneyDetail"]! as! [String:Any])["Names"]! as! [String: Any])["Name"] as! NSDictionary
            let lineNo = RealTidMethods.checkNullForString(someValue: (linesDict), keyName: "$")
            intermediateStops.line_and_name.lineNumber = Int(lineNo)!
            
            intermediateStops.line_and_name.lineName = RealTidMethods.checkNullForString(someValue: namesDict, keyName: "$")
            
            let line_routeIdFrom = RealTidMethods.checkNullForString(someValue: linesDict, keyName: "routeIdxFrom")
            
            intermediateStops.line_and_name.routeIdFrom = Int(line_routeIdFrom)!
            
            let line_routeIdTo = RealTidMethods.checkNullForString(someValue: linesDict, keyName: "routeIdxTo")
            
            intermediateStops.line_and_name.routeIdFrom = Int(line_routeIdTo)!
            
            
            print("sc 5--.....intermediateStops.line_and_name.lineNumber  = \(intermediateStops.line_and_name.lineNumber )..")
            // extract Stops
            let stopsDict = ((intermediateStops_Dict["JourneyDetail"]! as! NSDictionary)["Stops"]! as! NSDictionary)["Stop"] as! NSArray
            
            print("---RoutIdx--From :: \(intermediateStops.directions.routeIdFrom)")
            print("---RoutIdx--To :: \(intermediateStops.directions.routeIdTo)")
            
            let realStopCount = intermediateStops.directions.routeIdFrom - intermediateStops.directions.routeIdTo
            
            print("Real Stop Count = = = = = \(realStopCount)")
            print("setOriginStop = = = = interMed stops = \(setOriginStop))")
            print("setDestStop = = = = interMed stops = \(setDestinationStop))")

            
            var i = 0
            for index in stopsDict {
            
            print("index = iii \(i)")
                
                
                // arr date
               let arrDate = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "arrDate")
                // arr time
                
                let arrTime = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "arrTime")
                
                // dep date
                
                let depDate = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "depDate")
                
                
                // dep time
                
                let depTime = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "depTime")
                
                // id
                
                let id = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "id")
                
                // lat
                
                let lat = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "lat")
                
                // long
                
                let long = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "lon")
                
                // name
                
                let name = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "name")
                
                // route idx
                
                let routeIdx = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "routeIdx")
                print("1ööööö")
                print("setOriginStop value is = \(setOriginStop)")
                print("setDestStop value is = \(setDestinationStop)")
                
                print("i = \(i)")
                
                // check for the origin route idx
                if (setOriginStop == i){
                    print("-----caught----\(setOriginStop))")
                 print(stopsDict)
                    // dep date
                    intermediateStops.originStop.depDate = depDate
                    // dep time
                    intermediateStops.originStop.depTime = depTime
                    // id
                    intermediateStops.originStop.id = Int(id)!
                    // lat
                    intermediateStops.originStop.lat  = lat
                    // long
                    intermediateStops.originStop.long = long
                    // name
                    intermediateStops.originStop.name = name
                    // route idx
                    intermediateStops.originStop.routeIdx = Int(routeIdx)!
                   
                    print("intermediateStops.originStop.routeIdx = \(intermediateStops.originStop.routeIdx)")
                }
                     // check for the destination route idx
                else if (setDestinationStop == i ) {
                    print("-----caught---setDestinationStop-interMed Stops-\(setDestinationStop))")

                    // arr date
                    intermediateStops.destinationStop.arrDate = arrDate
                    // arr time
                     intermediateStops.destinationStop.arrTime = arrTime
                    // id
                    intermediateStops.destinationStop.id = Int(id)!
                    // lat
                    intermediateStops.destinationStop.lat  = lat
                    // long
                    intermediateStops.destinationStop.long = long
                    // name
                    intermediateStops.destinationStop.name = name
                    // route idx
                    intermediateStops.destinationStop.routeIdx = Int(routeIdx)!
                 
                    print("intermediateStops.destinationStop.routeIdx = \(intermediateStops.destinationStop.routeIdx)")
                    print("Destination stop.name = \(intermediateStops.destinationStop.name)")
                }
                    
                else if (i > setOriginStop  && i < setDestinationStop) {
                
                    print(".......interMed stops index count = \(i)")
                //print("intermediate stops = \(stopsDict.description)")
                    
                    let stop = Stops()
                    
                    print("10")
                    // dep date
                    
                    stop.arrDate = depDate
                    // dep time
                    
                    print("11")
                    stop.depTime = depTime
                    
                    // arr date
                    stop.arrDate = arrDate
                    // arr time
                    stop.arrTime = arrTime
                    // id
                    stop.id = Int(id)!
                    // lat
                    stop.lat  = lat
                    // long
                    stop.long = long
                    // name
                    stop.name = name
                    // route idx
                    stop.routeIdx = Int(routeIdx)!
                    
                    intermediateStops.intermediateStops.append(stop)
                    
                }
                // check for the intermediate stops
                
               
            i+=1
                print("index value  intermediate stops = \(i)")
                
                
            }
            print("origin is =\(intermediateStops.originStop.name)")
            print("count of intermediate stops is = \(intermediateStops.intermediateStops.count)")
            print("Destination is =\(intermediateStops.destinationStop.name)")
            print("sc 6--.......")
            
            // 1) extract origin stop
            
            
            // 2) extract last stop
            // 3) check for the destination to avoid printing the extra names
       // Extract Types
            }
         }
        //else {
            // check for the status code
            
            // if it is zero
            
            //            ----AFTER MAGHRIB NAMAZ IN SHA ALLAH----
            
            // if it is not zero then do the rest of the processing
            print("inside else.................")
            

        
        //self.tableView.reloadData()
        
        print("-intermediate stops:::::::after----tabledata count AFTER-dataSourceTrafficStatus\(dataSource_intermediateStops_StatusCode.count)")
        
        
        print("-after----tabledata count AFTER-= \(intermediateStops_Dict.count)")
        
    }
    
    
    //--extract data from json ........end
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//    
//    override func tableView(_tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
    }
    // custom methods for intermediate stops
    
    static func resetIntermediateStops (intermediateStopsFullObject: IntermediateStops){
    
        intermediateStopsFullObject.directions.directionName = ""
        intermediateStopsFullObject.directions.routeIdFrom = 0
        intermediateStopsFullObject.directions.routeIdTo = 0
        
        print("About to remove all elements from intermediat stops = \(intermediateStopsFullObject.intermediateStops.count)")
        intermediateStopsFullObject.intermediateStops.removeAll()
        print("Removed: Current Count Must be 0\(intermediateStopsFullObject.intermediateStops.count)")
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MAP")
        {
        
        let vc = segue.destination as! MapTripViewControllers
            vc.setValue(intermediateStops, forKey: "interMedStops")
        
        }
    }
}


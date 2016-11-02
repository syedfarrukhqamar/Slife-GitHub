//
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



class TripSuggestionsTViewController: UITableViewController {
    var transportTypeFlag = String()
    
   // show hide trip info
    var showTripInfo = false
    var sectionShow = 10
    var showHideArray = [Bool]()

    //Mark: Autolayout Variables
    var legIconsLineCounter = 0
    let legIconsHeight = 22
    let headerCellHeight = 60
    var legIconsLineTerminateCount = 1
    
  //  @IBOutlet weak var mapReferenceAction: UIButton!
//    MARK:- showTripOnMapAction
    
    @IBAction func addToFavourite(sender: UIBarButtonItem) {
        print("--------from-------------")
        print(sr_fromStation_name)
        print(sr_fromStation_id)
         print("--------To-------------")
        print(sr_toStation_name)
        print(sr_toStation_ID)
        
        SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: FAVOURITES)
        
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
    
    // Leg Image Names
    @IBAction func sectionAction(sender: UIButton) {
        print("section button is pressed with : ")
        print(sender.tag)
        sectionShow = sender.tag
        tableView.reloadData()
        
    }
    
    let firstLegImage   = "firstLeg.png"
    let middleLegImage  = "middleLeg.png"
    let lastLegImage    = "lastLeg.png"
    let onlyLegImage    = "onlyLeg.png"
    
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
        
        
        
          SlifeMethods.serializeObject(fromStationName: sr_fromStation_name, fromStationId: sr_fromStation_id, toStation_Name: sr_toStation_name, toStationId: sr_toStation_ID, objectToSerialize_keyName: RECENTTRIPS)
//        
//        if (advancedOptionsFlag == false){
//         url = searchTrips.constructURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
        
        
        if (advancedOptionsFlag == false){
            url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
            // from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
//             from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
        } else if (advancedOptionsFlag == true){
        
//        url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
            url = searchTrips.constructAdvancedURL(methodName: "Trip", origin: from.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: to.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
            
        }
        print("-------------------url----\(url)")
        
        get_data_from_url(url: url)
        print("-----------------------ended--090")
        
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-----webservice start
    func get_data_from_url(url:String)
    {
        
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
                let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
                 print("about to check ErrorCheckFlag....inside.......")
                
                
               // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
                if (errorCheckFlag == true){
                print("errorCheckFlag....inside.......")
                    //MARK: release nil found
                    self.navigationController?.popViewController(animated: true)
                    print("AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED..............")
                   
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
            print("json just downloaded.......5........\((json?["TripList"]!! as AnyObject).description)")
            
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
        // 2
      //  print("number of rows in Section: LegList= \(newTrip[section].)")
        
      //  print("s[section].Rows are = \(s[section].count)")
       // return newTrip[section].legList.count
        let legList = newTrip[section] as! Trip
        print("----LegList Count is in number of rows in section=\(legList.LegList.count)")
        if (section == sectionShow){
        
        
        
        
        return legList.LegList.count
            }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
        
        
        print("-Printing Cells--[Sections]=\(indexPath.section)--[Rows] = \(indexPath.row)")
        // 3
        // Configure the cell...
        let legList = newTrip[indexPath.section] as! Trip
        let test = NSMutableArray()
        
        test.add(legList.LegList[indexPath.row])
        let startingPoint = CGPoint(x: 35.0,y: 30.0)
       // let startingPoint = CGPoint(x: 35.0,y: -130.0)
        let startingSize = CGSize(width:20.0,height:20.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = CGPoint(x:10,y:0)
        let innerLegSpacing = CGPoint(x:25,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
       // ------------setting Leg Images---------START
        print("--Row = \(indexPath.row)----count = \(legList.LegList.count)")
        var count = legList.LegList.count
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
        print()
        print(test.count)
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
    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    
    
    // MARK: Height of row
    
     override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            let tripCell = newTrip[section] as! Trip
            print("heightForHeaderInSection...........\(section).")
            print(legIconsLineCounter)
            print(tripCell.LegList.count)
            var lineCount = (tripCell.LegList.count*2) / legIconsLineTerminateCount
            let remainder = (tripCell.LegList.count*2) % legIconsLineTerminateCount
            if (remainder != 0){
            lineCount+=1
                print("total line count is =inside heighForHeader==for section \(section)==is=\(lineCount)")
            
            }
        
        
        
        
        var icon_Count_Total = tripCell.LegList.count
        var screenWidth = UIScreen.main.bounds.width
       
        
        let total_icon_lines = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(60.0))
       // print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
       
        
        
        let headerCellTotalHeight = (legIconsHeight * total_icon_lines.lineCount) + headerCellHeight
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
        return CGFloat(headerCellTotalHeight)
        
    }
     override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCells") as! TripSuggestionsCell_new
        
        print(tableView.rowHeight)
        headerCell.sectionSelected.tag = section
        print("tableView.frame.size.height ........")
        print(tableView.frame.size.height)
        print("headerCell.frame.size.height ........")

        print(headerCell.frame.size.height)
        print("--heADER CELL BUTTON ID-")
        print(headerCell.sectionSelected)
        //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
     //   headerCell.backgroundColor = UIColor.lightGrayColor()
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
        var startingPoint = CGPoint(x: 5.0,y: legIcons_y!)
        let startingSize = CGSize(width:20.0,height:20.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = CGPoint(x:10,y:0)
        let innerLegSpacing = CGPoint(x:25,y:0)
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
        let iconLimits = SlifeMethods.iconCountsToDisplayIcons(availableWidth: screenWidth , iconsCount: icon_Count_Total, iconWidth: CGFloat(60.0))
        print("leg Icons Line Termination Count-iconLimits = \(iconLimits)")
         // MARK: Line Termination
        for index in tripCell.LegList {
            iconLegLine += 1
            
            if(iconLegLine == iconLimits.iconCount){
                
           // if(iconLegLine == legIconsLineTerminateCount){
                legIconsLineCounter += 1
                print("legIconsLineCounter = \(legIconsLineCounter) for section : \(section)")
                startingPoint.x = 5.0
                startingPoint.y+=20.0
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
            SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: ns , cell: headerCell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor)
            y += 1
         
        }
        
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
        headerCell.backgroundColor = UIColor.lightGray
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

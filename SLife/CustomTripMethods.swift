//
//  CustomTripMethods.swift
//  SLife
//
//  Created by syed farrukh Qamar on 2016-11-30.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import AVFoundation
import UIKit

// construct url

let EARLIEST_DEPARTURE_BY = "0"
let EARLIEST_ARRIVAL_BY = "1"

// CURRENT LEG> CURRENT, NEXT, PREVIOUS
let CURRENT_LEG_CURRENT_DEP = "CLCD"
let CURRENT_LEG_NEXT_DEP = "CLND"
let CURRENT_LEG_PREVIOUS_DEP = "CLPD"

// MULTIPLE LEG> CURRENT, NEXT, PREVIOUS
let MULTIPLE_LEG_CURRENT_DEP = "MLCD"
let MULTIPLE_LEG_NEXT_DEP = "MLND"
let MULTIPLE_LEG_PREVIOUS_DEP = "MLPD"
  //  get_data_from_url(url: url)
// simple flags
let NEXT_DEP = "NEXTDEPARTURES"
let PREVIOUS_DEP = "PREVIOUSDEPARTURES"
let CURRENTLEG_DEP = "CURRENTLEGDEPARTURES"

class CustomTripMethods: UITableView {

    var customTrips_convertedJsonIntoNSDict1 = NSDictionary()
    var customNewTrip = NSMutableArray()
    var customNewTripExtracted = NSMutableArray()
    
    func get_data_from_url_ForExistingDepartures(from_Station:String, to_Station:String, tableView: UITableView,headerSectionId: String, legRow_id_From: String,keyName : String,navigationTypeClicked: String,legRow_id_To: String, previousNext_Dep_Flag: String )
    {
        
// 1 extract existing trips from keyname(section,row)
        // create a new method to add trips to extracted trips
            // for next add them to the end
            // for previous add them in the begining as current index same as in header trip cells
            // just reload the table view and test
        
        let fromSl_FormatText =  SlifeMethods.stringToSlFormat(inputString: from_Station)
        let keyNameConstructed = headerSectionId + legRow_id_From
        print("ED--0-Key Received is keyNameConstructed::::\(keyNameConstructed)")
        let customNewTripExtracted =   custom_Trip_NextDepartures_Dict.value(forKey: keyNameConstructed) as! NSMutableArray //.setValue(self.customNewTrip, forKey: dictKey)
        
       // print("Count of existing extracted departures custom tip is = \(extractedTrip.count)")
        
        let toSl_FormatText =  SlifeMethods.stringToSlFormat(inputString: to_Station)
        let searchTrips = WebServiceHandler()
    
        var urlCustomTrips = searchTrips.constructURL(methodName: "Trip", origin: fromSl_FormatText, destination: toSl_FormatText, returnContentType: jsonType, searchForArrival: "0")
            // searchTrips.constructAdvancedURL(methodName: "Trip", origin: fromSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: toSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: "0")
        
        //        print("origin = \()")
        //        print("origin = \()")
        //
        //        print("origin = \()")
        //
        //        print("origin = \()")
        
        print("ED-1CustomTripMethods::Trip Suggestions inside url : \(urlCustomTrips)")
        
        
        
        //let newurl = "https://api.sl.se/api2/TravelplannerV2/Trip.json?key=92cbcaa8387c44e3be686f7dd4a1fd32&originId=Slussen&destId=Gamla%20stan&searchForArrival=0&realtime=true"
        
        let url:NSURL = NSURL(string: urlCustomTrips)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        //    let testurl = NSURLConnection(request: request, delegate: request)
        
        request.httpMethod = "GET"
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("ED-2-CustomTripMethods--json step 1------")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("ED-3--CustomTripMethods--error- has been caught")
                return
            }
            print("ED-4-CustomTripMethods--json step 2------")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("-ED-5-CustomTripMethods---trip--7.1--about to return after parsing")
                
                //          let tripFlag = RealTidMethods.checkIfArray(convertedJsonIntoNSDict1["TripList"]!["Trip"])
                // MARK: Nil check
                
                // call method to check if nil has encountered
                // check if the nsdict has error message
                // check if
                
                print("ED-6-CustomTripMethods--about to check the generic error---------")
                // Mark: Release check error
                // in slife method, produce error out of nil some how and see what happens
                // check for null
                // if null then go back with error message
                // else if not null then go below
                print("-ED-7---CustomTripMethods---about to check ErrorCheckFlag....inside..errorCheckFlag =....before.....")
                
                
                // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
                let nullCheck = RealTidMethods.checkIfKeyExists(objectToCheck: self.customTrips_convertedJsonIntoNSDict1, keyName: "TripList")
                
                if (nullCheck == false){
                    // MARK: Switch off slide off
                    //  navigationController?.popViewController(animated: true)
                    print("ED-8CustomTripMethods--AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED......null........")
                    
                } else {
                    
                    let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (self.customTrips_convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
                    
                    if (errorCheckFlag == true){
                        print("ED-9CustomTripMethods--errorCheckFlag....inside.......")
                        //MARK: release nil found
                        //                        navigationController?.popViewController(animated: true)
                        print("ED-10-CustomTripMethods--AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED.......error.......")
                        
                    }
                    else if (errorCheckFlag == false){
                        let tripArray = (self.customTrips_convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
                        print("-trip--7.1---A--")
//                        1---bring dict depart object.
//                        2-receive object based on keyname
//                        3---send it to get trips method ?
//                        4-- populate it to receive more objects.
//                        5---chceck if every thing is working
//                        6... handle next and previous
//                        
                        let statusCustomTrips =  self.getTrips(json: self.customTrips_convertedJsonIntoNSDict1,sectionID: headerSectionId,rowID_From: legRow_id_From,rowID_To: legRow_id_To ,previousNext_CL_Flag: previousNext_Dep_Flag)
                        
                        print("ED-11-CustomTripMethods----trip--7.1---B-departures collection-\(self.customNewTrip.count)")
                        //--for-1--------------------------------------------------------------------------------------------------
                        print("ED-12-CustomTripMethods---trip--7.2--about to return after parsing")
                        // reload the table here
                        if (statusCustomTrips == true){
                            print("ED-13::statusCustomTrips == true::::\(self.customNewTrip.count)")
                            //extract orig dict
                            print("KeyName = we need to look for = \(keyName)")
                            let currentTripObjInDeparture = custom_Trip_NextDepartures_Dict.value(forKey: keyName) as! NSMutableArray
                            print("current trip obj in departure count = \(currentTripObjInDeparture.count)")
                            // add objects to this current trip object 
                            
                            // MARK: Next TripInfo Departures Populate
                            if (navigationTypeClicked.contains(NEXT)){
                           
                                var  addedTripIndex = 0
                                for index in self.customNewTrip {
                                    print("Old count for currentTripObjInDeparture= \(currentTripObjInDeparture.count) Index = \(addedTripIndex)")
                                    // currentTripObjInDeparture.insert(self.customNewTrip[addedTripIndex], at: addedTripIndex)
                                    currentTripObjInDeparture.add(self.customNewTrip[addedTripIndex])
                                     print("New count for currentTripObjInDeparture= \(currentTripObjInDeparture.count) Index = \(addedTripIndex)")
                                     addedTripIndex += 1
                                }
                            } else if (navigationTypeClicked.contains(PREVIOUS)){
                            
                            
                                var  addedTripIndex = 0
                                for index in self.customNewTrip {
                                    print("Old count for currentTripObjInDeparture= \(currentTripObjInDeparture.count) Index = \(addedTripIndex)")
                                    
                                //    currentTripObjInDeparture.insert(self.customNewTrip[addedTripIndex], at: addedTripIndex)
                                  
                                    currentTripObjInDeparture.insert(self.customNewTrip[addedTripIndex], at: addedTripIndex)
                                    print("New count for currentTripObjInDeparture= \(currentTripObjInDeparture.count) Index = \(addedTripIndex)")
                                    addedTripIndex += 1
                                }
       }
                             // add nsmutable array to the dict from trip suggestion
                            
                            let dictKey = headerSectionId + legRow_id_From
                            print("ED-13-current dict key added via custom trips = \(keyName)")
                            print("CustomTripMethods--dict key for the custom trip next departure dict = \(keyName)")
                            //Customtripnextdepartures_dict has been defined in tripsuggestion
                            custom_Trip_NextDepartures_Dict.setValue(currentTripObjInDeparture, forKey: keyName)
                            print(" ED-14 custom_Trip_NextDepartures_Dict.allkeys in customNewTrip = \(custom_Trip_NextDepartures_Dict.count) & allkeys = \(custom_Trip_NextDepartures_Dict.allKeys): Latest Count for trip for departure = \(currentTripObjInDeparture.count)")
                            print("ED--15table.reload has been called.......in customNewTrip")
                            tableView.reloadData()
                        }
                        else {
                            
                            print("false has been reported")
                         }
                        
                    }
                }
                // dispatch_async(dispatch_get_main_queue(), {
                print("CustomTripMethods--before return....")
                return
            })
        }
        task.resume()
    }
    
    
    func getTripsForExistingDepartures(json: NSDictionary) -> Bool{
        
        let tripArray = (customTrips_convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
        //--for-1-------------------------------------------------------------------------------for 1---
        var forMain1 = 0
        for tripArray in tripArray {
            //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
            print("----CustomTripMethods----------------------------------------------------------------------------forMain1 \(forMain1)-----")
            
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
            
            
            print("CustomTripMethods-duration in trip suggestionsTViewController......\(dur)")
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
                print("-CustomTripMethods-----price info found---yes--")
                //                print("Price Info -----\(priceInfo.allKeys)")
                
                trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
                print("trip suggestions 1...test")
                trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
                print("trip suggestions 2...test")
                
                //print("Price Info -----\(priceInfo.allKeys)")
                
            } else {
                
                
                trip.tariffRemark = "Tariff Remarks N/A"
                trip.tariffZones = "Zones Not Available"
                
                print("--CustomTripMethods----price info not found-----")
                
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
                
                print("CustomTripMethods-trip suggestions 4...\((tripArray as! NSDictionary).value(forKey: "LegList"))")
                print("CustomTripMethods-change is 0 in trip suggestions tv")
                
                //leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
                
                
                let triparrayTest = tripArray as! NSDictionary
                print("trip array test.....\(triparrayTest.allKeys)")
                
                print(triparrayTest.count)
                
                
                let tripDicTest = triparrayTest.value(forKey: "LegList") as!NSDictionary
                
                print("CustomTripMethods-tripDicTest----890----------\(tripDicTest.allKeys)")
                let legTestDict = tripDicTest.value(forKey: "Leg") as! NSDictionary
                
                print("CustomTripMethods--legTestDict::::::\(legTestDict.allKeys)")
                
                
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
                print("CustomTripMethods-forMain1---- \(forMain1)")
                print("CustomTripMethods-forMain11---- \(forMain11)")
                for (tempLegList) in tempLegList {
                    
                    
                    let legCheck = tempLegList as! NSDictionary
                    
                    let orgCheck = legCheck.value(forKey: "Origin")
                    
                    print("CustomTripMethods-legCheck all keys......\(legCheck.allKeys)")
                    print("CustomTripMethods-orgCheck all keys......\(orgCheck)")
                    
                    
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
                let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString,currentLegStatus: true)
                
                print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                print("rtu message status from leg = message = \(leg.rtu_Message)")
                trip.LegList.add(leg)
                forMain11 += 1
                //----------------if condition walk & travel----------end
            }
            print("---LegList.allKeys----duration being entered is :\(dur)")
            
            // MARK: Adding trips in custom new trip
        //    customNewTrip.add(trip)
            //MARK: Departures Refreshed Added Data 
            // need to add code for next trips and previous trips for collection view
          customNewTripExtracted.add(trip)
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1 += 1
        }
        if (customNewTrip.count > 0){
            print("> 0 - customer new trip count = \(customNewTrip.count)")
            
            return true
        }
        else {
            
            print("< 0 - customer new trip count = \(customNewTrip.count)")
            
            return false
        }
        //  return customNewTrip
        
    }
    
    
    func extractDeparturesForCurrentLeg_Current (currentTripDep: Trip,fromLegIndex: Int, toLegIndex: Int) -> (fromStation_dep: String, toStation_Dep: String,timeDep: String,earliestArrivalFlagDep: String,queryScope_currentLeg_current: String) {
    
        var fromStation_dep = String()
        var toStation_Dep = String()
        var earliestArrivalFlagDep = String()
        var timeDep = String()
        
    // -------------------------------------------------------------------------------------------CLCD
    
    // Scope: Current
        if (fromLegIndex == toLegIndex){
        let currentTripInFocus = currentTripDep // Trip
            
        let legListForCurTrip = currentTripInFocus as! NSMutableArray
        let currentLegForDepSearch = legListForCurTrip[fromLegIndex] as! Leg

        fromStation_dep = currentLegForDepSearch.origin.name
        toStation_Dep = currentLegForDepSearch.destination.name
        timeDep = currentLegForDepSearch.origin.time
            earliestArrivalFlagDep = EARLIEST_DEPARTURE_BY
        // fromStation_dep = legForDepartureSearch.
        }
    
        return (fromStation_dep,toStation_Dep,timeDep,earliestArrivalFlagDep,CURRENT_LEG_CURRENT_DEP)
    }
    
    // -------------------------------------------------------------------------------------------CLND----NEXT
    // Scope: Next
    
    /*
    func extractDeparturesForCurrentLeg_NEXT (currentTripDep: Trip,fromLegIndex: Int, toLegIndex: Int) -> (fromStationDep: String, toStationDep: String,timeDep: String,earliestArrivalFlagDep: String,queryScope_currentLeg_current: String) {
        
        var fromStation_dep = String()
        var toStation_Dep = String()
        var earliestArrivalFlagDep = String()
        var timeDep = String()
        
        // -------------------------------------------------------------------------------------------CLCD
        
        // Scope: Current
        if (fromLegIndex == toLegIndex){
            let currentTripInFocus = currentTripDep // Trip
            
            let legListForCurTrip = currentTripInFocus as! NSMutableArray
            let currentLegForDepSearch = legListForCurTrip[fromLegIndex] as! Leg
            
            fromStation_dep = currentLegForDepSearch.origin.name
            toStation_Dep = currentLegForDepSearch.destination.name
            timeDep = currentLegForDepSearch.origin.time
            earliestArrivalFlagDep = EARLIEST_DEPARTURE_BY
            // fromStation_dep = legForDepartureSearch.
        }
        
        return (fromStation_dep,toStation_Dep,timeDep,earliestArrivalFlagDep,CURRENT_LEG_NEXT_DEP)
    }
    */
    
    // -------------------------------------------------------------------------------------------CLND----PREVIOUS
    // Scope: PREVIOUS
    /*
     add this function later.
     */
    
    
    func getAlternativeDeparturesForCurrentLegScope(currentTrip: Trip,fromLeg_Index: Int, toLeg_Index: Int, previousCurrentOrNext: String, from:String, to:String, tableView: UITableView,headerSectionId: String, legRow_id: String,previousNext_Dep_Flag: String)
    {
        
        print("getAlternativeDeparturesForCurrentLegScope have been called.......")
        // extract values for SL connect string
        let urlValues = extractDeparturesForCurrentLeg_Current(currentTripDep: currentTrip, fromLegIndex: fromLeg_Index, toLegIndex: toLeg_Index)
        
        let fromSl_FormatText =  SlifeMethods.stringToSlFormat(inputString: urlValues.fromStation_dep) //SlifeMethods.stringToSlFormat(inputString: from)
        let toSl_FormatText =    SlifeMethods.stringToSlFormat(inputString: urlValues.toStation_Dep) //SlifeMethods.stringToSlFormat(inputString: to)
        
        let searchTrips = WebServiceHandler()
        
        var urlCustomTrips = searchTrips.constructAdvancedURL(methodName: "Trip", origin: fromSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: toSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: urlValues.earliestArrivalFlagDep,tripDate: "",tripTime: "")
        
        
        //        print("origin = \()")
        //        print("origin = \()")
        //
        //        print("origin = \()")
        //
        //        print("origin = \()")
        
        print("Line 785-Next/previous-Depart..CustomTripMethods::Trip Suggestions inside url : \(urlCustomTrips)")
        
        
        
        //let newurl = "https://api.sl.se/api2/TravelplannerV2/Trip.json?key=92cbcaa8387c44e3be686f7dd4a1fd32&originId=Slussen&destId=Gamla%20stan&searchForArrival=0&realtime=true"
        
        let url:NSURL = NSURL(string: urlCustomTrips)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        //    let testurl = NSURLConnection(request: request, delegate: request)
        
        request.httpMethod = "GET"
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("--Next/previous-Depart.. CustomTripMethods--json step 1------")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("--Next/previous-Depart..-CustomTripMethods--error- has been caught")
                return
            }
            print("--Next/previous-Depart.. CustomTripMethods--json step 2------")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("-Next/previous-Depart..-CustomTripMethods---trip--7.1--about to return after parsing")
                
                //          let tripFlag = RealTidMethods.checkIfArray(convertedJsonIntoNSDict1["TripList"]!["Trip"])
                // MARK: Nil check
                
                // call method to check if nil has encountered
                // check if the nsdict has error message
                // check if
                
                print("Line 824-Next/previous-Depart..CustomTripMethods--about to check the generic error---------")
                // Mark: Release check error
                // in slife method, produce error out of nil some how and see what happens
                // check for null
                // if null then go back with error message
                // else if not null then go below
                print("-Libe 830---Next/previous-Depart..-CustomTripMethods---about to check ErrorCheckFlag....inside..errorCheckFlag =....before.....")
                
                
                // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
                let nullCheck = RealTidMethods.checkIfKeyExists(objectToCheck: self.customTrips_convertedJsonIntoNSDict1, keyName: "TripList")
                print("customTrips_convertedJsonIntoNSDict1= \(self.customTrips_convertedJsonIntoNSDict1.allKeys)")
                if (nullCheck == false){
                    // MARK: Switch off slide off
                    //  navigationController?.popViewController(animated: true)
                    print("Line 836-Next/previous-Depart..CustomTripMethods--AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED......null........")
                    
                } else {
                    
                    let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (self.customTrips_convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
                    
                    if (errorCheckFlag == true){
                        print("-Line 843:Next/previous-Depart..CustomTripMethods--errorCheckFlag....inside.......")
                        //MARK: release nil found
                        //                        navigationController?.popViewController(animated: true)
                        print("Line 846-Next/previous-Depart..CustomTripMethods--AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED.......error.......")
                        
                    }
                    else if (errorCheckFlag == false){
                        let tripArray = (self.customTrips_convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
                        print("Line 854----Next/previous-Depart..-trip--7.1---A--")
                        let statusCustomTrips =  self.getTrips(json: self.customTrips_convertedJsonIntoNSDict1,sectionID: headerSectionId,rowID_From: legRow_id,rowID_To: "0",previousNext_CL_Flag: previousNext_Dep_Flag )
                        print("-Next/previous-Depart..CustomTripMethods----trip--7.1---B-departures collection-\(self.customNewTrip.count)")
                        //--for-1--------------------------------------------------------------------------------------------------
                        print("-Next/previous-Depart..CustomTripMethods---trip--7.2--about to return after parsing")
                        // reload the table here
                        if (statusCustomTrips == true){
                            
                            // add nsmutable array to the dict from trip suggestion
                            let dictKey = headerSectionId + legRow_id
                            print("-Next/previous-Depart..current dict key added via custom trips = \(dictKey)")
                            print("-Next/previous-Depart..CustomTripMethods--dict key for the custom trip next departure dict = \(dictKey)")
                            //Customtripnextdepartures_dict has been defined in tripsuggestion
                            custom_Trip_NextDepartures_Dict.setValue(self.customNewTrip, forKey: dictKey)
                            print("-Next/previous-Depart..custom_Trip_NextDepartures_Dict.allkeys in customNewTrip = \(custom_Trip_NextDepartures_Dict.count)")
                            print("Line:866-Next/previous-Depart..table.reload has been called.......in customNewTrip")
                            tableView.reloadData()
                        }
                        else {
                            
                            print("-Next/previous-Depart..false has been reported")
                            
                            
                        }
                        
                    }
                }
                // dispatch_async(dispatch_get_main_queue(), {
                print("-Next/previous-Depart.. CustomTripMethods--before return...Line 882.")
                return
            })
        }
        task.resume()
    }
    
    func get_data_from_url(currentCollectionView: UICollectionView,from:String, to:String, tableView: UITableView,headerSectionId: String, legRow_id_from: String,fromTime: String,legRowID_To: String, previousOrNextFlag: String,fromDate_Dep: String,fromTime_Dep: String)
    {
        // get url
        
        let fromSl_FormatText =  SlifeMethods.stringToSlFormat(inputString: from)
        let toSl_FormatText =  SlifeMethods.stringToSlFormat(inputString: to)
         let searchTrips = WebServiceHandler()
        var searchForArrivals = String()
        
        if ( previousOrNextFlag == CURRENTLEG_DEP){
            searchForArrivals = "0"
        }
        else if (previousOrNextFlag == PREVIOUS_DEP ){
            searchForArrivals = "1"
             }
        else if  (previousOrNextFlag == NEXT_DEP ){
            searchForArrivals = "0"
        }

        
        
        var urlCustomTrips = searchTrips.constructURL(methodName: "Trip", origin: fromSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: toSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: searchForArrivals)
        
      //  var urlCustomTrips = searchTrips.constructAdvancedURL(methodName: "Trip", origin: fromSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: toSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: searchForArrivals,tripDate: fromDate_Dep,tripTime: fromTime_Dep)
       
        
        
            
         //var urlCustomTrips = searchTrips.constructAdvancedURL(methodName: "Trip", origin: fromSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), destination: toSl_FormatText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines), returnContentType: jsonType, searchForArrival: searchForArrivals)
        
       
//        print("origin = \()")
//        print("origin = \()")
//        
//        print("origin = \()")
//        
//        print("origin = \()")
        
       // print("-Next/previous-Depart..CustomTripMethods::Trip Suggestions inside url : \(urlCustomTrips)")
        //let newurl = "https://api.sl.se/api2/TravelplannerV2/Trip.json?key=92cbcaa8387c44e3be686f7dd4a1fd32&originId=Slussen&destId=Gamla%20stan&searchForArrival=0&realtime=true"
        
        let url:NSURL = NSURL(string: urlCustomTrips)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        //    let testurl = NSURLConnection(request: request, delegate: request)
        
        request.httpMethod = "GET"
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("--Next/previous-Depart.. CustomTripMethods--json step 1------")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("--Next/previous-Depart..-CustomTripMethods--error- has been caught")
                return
            }
            print("--Next/previous-Depart.. CustomTripMethods--json step 2------")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("-Next/previous-Depart..-CustomTripMethods---trip--7.1--about to return after parsing")
                
                //          let tripFlag = RealTidMethods.checkIfArray(convertedJsonIntoNSDict1["TripList"]!["Trip"])
                // MARK: Nil check
                
                // call method to check if nil has encountered
                // check if the nsdict has error message
                // check if
                
                print("-Next/previous-Depart..CustomTripMethods--about to check the generic error---------")
                // Mark: Release check error
                // in slife method, produce error out of nil some how and see what happens
                // check for null
                // if null then go back with error message
                // else if not null then go below
                print("----Next/previous-Depart..-CustomTripMethods---about to check ErrorCheckFlag....inside..errorCheckFlag =....before.....")
                
                
                // Error Check code. call slifemethod and send nsdictionary to see if it has error code key or not, if yes then change the central error values and move back
                let nullCheck = RealTidMethods.checkIfKeyExists(objectToCheck: self.customTrips_convertedJsonIntoNSDict1, keyName: "TripList")
                
                if (nullCheck == false){
                    // MARK: Switch off slide off
                  //  navigationController?.popViewController(animated: true)
                    print("-Next/previous-Depart..CustomTripMethods--AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED......null........")
                    
                } else {
                    
                    let errorCheckFlag =   SlifeMethods.checkForErrorMessage(jsonObjectDownloaded: (self.customTrips_convertedJsonIntoNSDict1["TripList"]! as! NSDictionary))
                    
                    if (errorCheckFlag == true){
                        print("-Next/previous-Depart..CustomTripMethods--errorCheckFlag....inside.......")
                        //MARK: release nil found
//                        navigationController?.popViewController(animated: true)
                        print("-Next/previous-Depart..CustomTripMethods--AFTER dissmissing because ERROR CODE HAS BEEN RECEIVED.......error.......")
                        
                    }
                    else if (errorCheckFlag == false){
                        let tripArray = (self.customTrips_convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
                        print("Line 970-Next/previous-Depart..-trip--7.1---A--")
                        print("Header Section Id: \(headerSectionId)")
                        print("legRow_id: \(legRowID_To)")
                        
                       let statusCustomTrips =  self.getTrips(json: self.customTrips_convertedJsonIntoNSDict1,sectionID: headerSectionId,rowID_From:  legRow_id_from,rowID_To: "0",previousNext_CL_Flag: previousOrNextFlag )
                        print("-Next/previous-Depart..CustomTripMethods----trip--7.1---B-departures collection-\(self.customNewTrip.count)")
                        //--for-1--------------------------------------------------------------------------------------------------
                        print("-Next/previous-Depart..CustomTripMethods---trip--7.2--about to return after parsing")
                        // reload the table here
                        if (statusCustomTrips == true){
                            
                            // add nsmutable array to the dict from trip suggestion
                            let dictKey = headerSectionId + legRowID_To
                            print("-Next/previous-Depart..current dict key added via custom trips = \(dictKey)")
                            print("-Next/previous-Depart..CustomTripMethods--dict key for the custom trip next departure dict = \(dictKey)")
                           //Customtripnextdepartures_dict has been defined in tripsuggestion
                            custom_Trip_NextDepartures_Dict.setValue(self.customNewTrip, forKey: dictKey)
                            print("-Next/previous-Depart..custom_Trip_NextDepartures_Dict.allkeys in customNewTrip = \(custom_Trip_NextDepartures_Dict.count)")
                            print("-Next/previous-Depart..table.reload has been called.......in customNewTrip")
                            tableView.reloadData()
                            currentCollectionView.reloadData()
                           
                            
                        }
                        else {
                        
                        print("-Next/previous-Depart..false has been reported")
                        
                        
                        }
                        
                    }
                }
                // dispatch_async(dispatch_get_main_queue(), {
                print("-Next/previous-Depart.. CustomTripMethods--before return....")
                return
            })
        }
        task.resume()
    }
  
    func extract_json(jsonData:NSData)
    {
        print("--Next/previous-Depart..-CustomTripMethods---json step 3------")
        let json: AnyObject?
        do {
            print("Line 1011-Next/previous-Depart..CustomTripMethods-json downloading in progres........4........")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject?
            print("-Next/previous-Depart..CustomTripMethods-json just downloaded.......5........\(json?.allKeys)")
            //MARK: Nil
            //print("json just downloaded.......5........\((json?["TripList"]!! as AnyObject).description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            // NIL json check
            
            json = nil
            
            
            return
        }
        
        //:MARK Changed
        
        customTrips_convertedJsonIntoNSDict1 = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("-Next/previous-Depart..--CustomTripMethods-6-----convertedJSON is being printed = \(customTrips_convertedJsonIntoNSDict1.allKeys)")
    }
    
    func getNextDeparturesForCurrentLeg(currentLegForDepartures: Leg,legIndexForDepartures: Int,json: NSDictionary) -> Bool{
        
        let tripArray = (customTrips_convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
        //--for-1-------------------------------------------------------------------------------for 1---
        var forMain1 = 0
        for tripArray in tripArray {
            //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
            print("--Next/previous-Depart..---CustomTripMethods----------------------------------------------------------------------------forMain1 \(forMain1)-----")
            let origin = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
            let destination = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
            
            var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: origin , destinationDetail: destination)
            let dur = (tripArray as! NSDictionary).value(forKeyPath: "dur")! as! String
            
            
            print("-Next/previous-Depart..CustomTripMethods-duration in trip suggestionsTViewController......\(dur)")
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
            print("--Next/previous-Depart..---1A------------")
            trip.dur = (tripArray as! NSDictionary).value(forKey: "dur")! as! String
            trip.chg = (tripArray as! NSDictionary).value(forKey: "chg")! as! String
            trip.co2 = (tripArray as! NSDictionary).value(forKey: "co2")! as! String
            let change = trip.chg
            print("--Next/previous-Depart..---2A------------")
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
                print("-CustomTripMethods-----price info found---yes--")
                //                print("Price Info -----\(priceInfo.allKeys)")
                
                trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
                print("trip suggestions 1...test")
                trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
                print("trip suggestions 2...test")
                
                //print("Price Info -----\(priceInfo.allKeys)")
                
            } else {
                
                
                trip.tariffRemark = "Tariff Remarks N/A"
                trip.tariffZones = "Zones Not Available"
                
                print("--Next/previous-Depart..-CustomTripMethods----price info not found-----")
                
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
                
                print("CustomTripMethods-trip suggestions 4...\((tripArray as! NSDictionary).value(forKey: "LegList"))")
                print("CustomTripMethods-change is 0 in trip suggestions tv")
                
                //leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
                
                
                let triparrayTest = tripArray as! NSDictionary
                print("trip array test.....\(triparrayTest.allKeys)")
                
                print(triparrayTest.count)
                
                
                let tripDicTest = triparrayTest.value(forKey: "LegList") as!NSDictionary
                
                print("CustomTripMethods-tripDicTest----890----------\(tripDicTest.allKeys)")
                let legTestDict = tripDicTest.value(forKey: "Leg") as! NSDictionary
                
                print("CustomTripMethods--legTestDict::::::\(legTestDict.allKeys)")
                
                
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
                print("CustomTripMethods-forMain1---- \(forMain1)")
                print("CustomTripMethods-forMain11---- \(forMain11)")
                for (tempLegList) in tempLegList {
                    
                    
                    let legCheck = tempLegList as! NSDictionary
                    
                    let orgCheck = legCheck.value(forKey: "Origin")
                    
                    print("CustomTripMethods-legCheck all keys......\(legCheck.allKeys)")
                    print("CustomTripMethods-orgCheck all keys......\(orgCheck)")
                    
                    
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
                let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString, currentLegStatus: true)
                
                
             
                print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                print("rtu message status from leg = message = \(leg.rtu_Message)")
                trip.LegList.add(leg)
                forMain11 += 1
                //----------------if condition walk & travel----------end
            }
            print("---LegList.allKeys----duration being entered is :\(dur)")
            
            // MARK: Adding trips in custom new trip
           // MARK: Next Departures add
            
            currentLegForDepartures.nextDeparturesTrip.append(trip)
            
            //customNewTrip.add(trip)
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1 += 1
        }
        
        if (currentLegForDepartures.nextDeparturesTrip.count > 0){
            
            print("> 0 - Line 1505 currentLegForDepartures.nextDeparturesTrip.count = \(currentLegForDepartures.nextDeparturesTrip.count)")
            
            return true
        }
        else {
            
            print("< 0 - Line 1505 currentLegForDepartures.nextDeparturesTrip.count = \(currentLegForDepartures.nextDeparturesTrip.count)")
        
            return false
        }
        
        
//        if (customNewTrip.count > 0){
//            
//            print("> 0 - customer new trip count = \(customNewTrip.count)")
//            
//            return true
//        }
//        else {
//            
//            print("< 0 - customer new trip count = \(customNewTrip.count)")
//            
//            return false
//        }
        //  return customNewTrip
        
    }
    
    


    func getTrips(json: NSDictionary, sectionID: String,rowID_From: String,rowID_To: String,previousNext_CL_Flag: String) -> Bool{
      print("Line1539:getTrips:Custom:section ID = \(sectionID)")
        let tripArray = (customTrips_convertedJsonIntoNSDict1["TripList"]! as! [String:Any])["Trip"] as! NSArray
        //--for-1-------------------------------------------------------------------------------for 1---
        var forMain1 = 0
        print("Line1542----sectionID-----\(sectionID)")
        var currentSectionTrip = newTrip[Int(sectionID)!] as! Trip
        // var currentTripLegForDep = currentSectionTrip.LegList[(Int(rowID)!) - 1] as! Leg
        var currentTripLegForDep = currentSectionTrip.LegList[Int(rowID_From)!] as! Leg
        
        print("Line1542---------")
        for tripArray in tripArray {
            //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
            print("--Next/previous-Depart..---CustomTripMethods----------------------------------------------------------------------------forMain1 \(forMain1)-----")
                 let origin = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
            let destination = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
            
            var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: origin , destinationDetail: destination)
            let dur = (tripArray as! NSDictionary).value(forKeyPath: "dur")! as! String
            
            
            print("-Next/previous-Depart..CustomTripMethods-duration in trip suggestionsTViewController......\(dur)")
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
            print("--Next/previous-Depart..---1A------------")
            trip.dur = (tripArray as! NSDictionary).value(forKey: "dur")! as! String
            trip.chg = (tripArray as! NSDictionary).value(forKey: "chg")! as! String
            trip.co2 = (tripArray as! NSDictionary).value(forKey: "co2")! as! String
            let change = trip.chg
            print("--Next/previous-Depart..---2A------------")
            
            if let priceInfo = (tripArray as! NSDictionary).value(forKey: "PriceInfo") {
                print("-CustomTripMethods-----price info found---yes--")
                //                print("Price Info -----\(priceInfo.allKeys)")
                
                trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
                print("trip suggestions 1...test")
                trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
                print("trip suggestions 2...test")
                
                //print("Price Info -----\(priceInfo.allKeys)")
                
            } else {
                
                
                trip.tariffRemark = "Tariff Remarks N/A"
                trip.tariffZones = "Zones Not Available"
                
                print("--Next/previous-Depart..-CustomTripMethods----price info not found-----")
                
            }
            
            var forMain11 = 0
            // create a leglist as an array to add the legs in the leglist
            var leglist = NSMutableArray()
            if (change == "0") {
                // MARK: Swift 3 doubtful
                //                leglist.addObject(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                
                print("CustomTripMethods-trip suggestions 4...\((tripArray as! NSDictionary).value(forKey: "LegList"))")
                print("CustomTripMethods-change is 0 in trip suggestions tv")
                
                //leglist.add(from:  ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSDictionary
                
                
                
                let triparrayTest = tripArray as! NSDictionary
                print("trip array test.....\(triparrayTest.allKeys)")
                
                print(triparrayTest.count)
                
                
                let tripDicTest = triparrayTest.value(forKey: "LegList") as!NSDictionary
                
                print("CustomTripMethods-tripDicTest----890----------\(tripDicTest.allKeys)")
                let legTestDict = tripDicTest.value(forKey: "Leg") as! NSDictionary
                
                print("CustomTripMethods--legTestDict::::::\(legTestDict.allKeys)")
                
                
                leglist.add(legTestDict)
                 }
            else {
                let tempLegList = ((tripArray as! NSDictionary).value(forKey: "LegList") as! NSDictionary).value(forKey: "Leg") as! NSArray
                var i = 0
                print("CustomTripMethods-forMain1---- \(forMain1)")
                print("CustomTripMethods-forMain11---- \(forMain11)")
                for (tempLegList) in tempLegList {
                    
                    
                    let legCheck = tempLegList as! NSDictionary
                    
                    let orgCheck = legCheck.value(forKey: "Origin")
                    
                    print("CustomTripMethods-legCheck all keys......\(legCheck.allKeys)")
                    print("CustomTripMethods-orgCheck all keys......\(orgCheck)")
                    
                    
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
                let leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: legImageName!,rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString, currentLegStatus: true)
                print("rtu message status from leg = flag = \(leg.rtu_Message_Flag)")
                
                print("rtu message status from leg = message =forMain11=\(forMain11)= \(leg.rtu_Message)")
                print("Line 1957: Origin Name : \(leg.origin.name)")
                print("Line 1957: Origin Time : \(leg.origin.time)")
                print("Line 1957: Dest Name : \(leg.destination.name)")
                print("Line 1957: Dest Time : \(leg.destination.time)")
                
                
                leg.legIndex = forMain11
                trip.LegList.add(leg)
                forMain11 += 1
                //----------------if condition walk & travel----------end
            }
            print("---LegList.allKeys----duration being entered is :\(dur)")
            
            // MARK: Adding trips in custom new trip
           // MARK: Temp off 1st of feb
            // customNewTrip.add(trip)
            // MARK: Add deprt trips
            
            // NEXT DEP: Add in the end of the current dep
            // current Leg: Just add them : Check if Current Leg is pressed then remove every thing and add new ones
            // Previous DEP: add in the begining
            
            //if(previousTripClickedFlag == true){
                
                if(previousNext_CL_Flag == PREVIOUS_DEP){
                    
                print("-previousTripClickedFlag= True--Adding trips to the first index.FromTime=.\(trip.originDetail.time).-Totime:\(trip.destinationDetail.time)--from origin=\(trip.originDetail.name)::to dest: \(trip.destinationDetail.name)")
                    
                    
                    currentTripLegForDep.nextDeparturesTrip.insert(trip, at: forMain1)
               // newTrip.insert(trip, at: forMain1)
                //    self.newTrip.add(trip)
            } else if (previousNext_CL_Flag == CURRENTLEG_DEP){
                   // if currentleg next dep is pressed. then remove the previous all departures.
                    if(currentTripLegForDep.nextDeparturesTrip.count == 5){
                //  currentTripLegForDep.nextDeparturesTrip.removeAll()
                    }
                    currentTripLegForDep.nextDeparturesTrip.append(trip)
                //newTrip.add(trip)
                } else if (previousNext_CL_Flag == NEXT_DEP){
            
                    currentTripLegForDep.nextDeparturesTrip.append(trip)

            }
            currentTripLegForDep.departureAvailable = true
            
            print("currentTripLegForDep:::\(currentTripLegForDep.departureAvailable)")
            //currentTripLegForDep.nextDeparturesTrip.append(trip)
            print("--End--------------End---Line : 1998--------\(currentTripLegForDep.nextDeparturesTrip.count)-------forMain1  \(forMain1)-----")
            forMain1 += 1
        }
        if (currentTripLegForDep.nextDeparturesTrip.count > 0){
        
        return true
        
        }
        else
        {
        return false
        
        
        }
   /*     if (customNewTrip.count > 0){
            
            print("> 0 - customer new trip count = \(customNewTrip.count)")
            
        return true
        }
        else {
        
            print("< 0 - customer new trip count = \(customNewTrip.count)")
            
        return false
        }
 */     //  return customNewTrip
        
    }
    
    
}




//
//  TripSuggestionsTVC_new.swift
//  SLife
//
//  Created by syed farrukh Qamar on 13/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
import UIKit


var convertedJsonIntoNSDict = NSDictionary()
class TripSuggestionsTVC_new: UITableViewController {
    //    var newTrip = [Trip]()
    var newTrip = NSMutableArray()
    let legList = ["test-0","test-1","test-2"]
    //    var trips = [Trips]()
    
    var from = String()
    var to = String()
    var searchForArrivals = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchTrips = WebServiceHandler()
        let url = searchTrips.constructURL(methodName: "Trip", origin: from.trimmingCharacters(in: CharacterSet.whitespaces), destination: to.trimmingCharacters(in: CharacterSet.whitespaces), returnContentType: jsonType, searchForArrival: "0")
        
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
        request.httpMethod = "GET"
//        request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("---json step 1------")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print("---json step 2------")
            
            DispatchQueue.main.async(execute: {
//                
//                }
//            DispatchQueue.main.asynchronously(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("-trip--7.1--about to return after parsing")
                // MARK: 
                _ = (convertedJsonIntoNSDict["TripList"]! as! [String:Any])["Trip"] as! NSArray
                
                self.getTrips(json: convertedJsonIntoNSDict)
                //--for-1--------------------------------------------------------------------------------------------------
                
                print("-trip--7.2--about to return after parsing")
                // reload the table here
                self.tableView.reloadData()
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
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            print("json just downloaded.......5........\(json?.allKeys)")
            print("json just downloaded.......5........\((json?["TripList"]!! as AnyObject).description)")
            
            // load this json into Trip---start
            
             // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
        
        convertedJsonIntoNSDict = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---6-----convertedJSON is being printed = \(convertedJsonIntoNSDict.allKeys)")
        
        
    }
    
    func getTrips(json: NSDictionary){
        
        let tripArray = ( convertedJsonIntoNSDict["TripList"]! as! [String:Any])["Trip"] as! NSArray
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
            let newAddress = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
            
            var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: newAddress , destinationDetail: newAddress)
            
           // var chg = ""
            //var co2 = ""
            
            let dur = (tripArray as! NSDictionary).value(forKeyPath: "dur") as! String
            var chg = (tripArray as! NSDictionary).value(forKeyPath: "chg") as! String
            var co2 = (tripArray as! NSDictionary).value(forKeyPath: "co2") as! String
            
            print("tripArray----all Keys \((tripArray as AnyObject).allKeys)")
            
           
            
            var tariffRemark = ""
            var tariffZones = ""
            // var LegList = [Leg]()
            // some variables which will be populated by external functions
            
            var from_time = ""
            var from_station = ""
            var to_Station = ""
            var to_time = ""
            print("----1A------------")
            //    trip.dur = (tripArray as Dictionary).value("dur")! as! String
            
          //  trip.dur = (tripArray as! NSDictionary).value(value(forKeyPath: "dur") as! String
           trip.dur = dur

           // trip.chg = tripArray.valueForKey("chg")! as! String
            trip.chg = chg
            trip.co2 = co2
            
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
            print("-------trip suggestions tvc new 1")
            let priceInfo = (tripArray as! NSDictionary).value(forKeyPath: "PriceInfo")! as! String
            
         //   print("Price Info -----\(priceInfo.allKeys)")
           print("-------trip suggestions tvc new 1")
            
            trip.tariffRemark = ((priceInfo as! [String:Any])["TariffRemark"] as! NSDictionary)["$"] as! String
           print("-------trip suggestions tvc new 2")
            trip.tariffZones = ((priceInfo as! [String:Any])["TariffZones"] as! NSDictionary)["$"] as! String
            // trip.tariffZones =  priceInfo["TariffZones"] as! NSDictionary
            print("-------trip suggestions tvc new 3")
            //--Priceinfo--End--------gather legs inside LegList-----start
            
            var forMain11 = 0
            
            // create a leglist as an array to add the legs in the leglist
            var leglist = NSMutableArray()
            
            print("-------trip suggestions tvc new 4")
            if (change == "0") {
                print("-------trip suggestions tvc new 5")
                leglist.add(((tripArray as! NSDictionary).value(forKeyPath: "LegList") as! [String: Any])["Leg"] as! String)
                // leglist.append(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
            print("here we are in trip suggestionstvc_new")
                //print("tripArray.valueForKey('LegList')--- \(((tripArray as AnyObject).value("LegList")? as AnyObject).count)")
            }
            else {
                print("-------trip suggestions tvc new 6")
                let tempLegList = ((tripArray as! NSDictionary).value(forKeyPath: "LegList")! as! [String:Any])["Leg"] as! NSArray
                var i = 0
                    print("forMain1---- \(forMain1)")
                    print("forMain11---- \(forMain11)")
                print("-------trip suggestions tvc new 7")
                for (tempLegList) in tempLegList {
                    leglist.add(tempLegList)
               //      print("tempLegList.count is---- \(tempLegList.count)")
                    print("i---- \(i)")
                i += 1
                }
            }
            var legs = NSMutableArray()
            let legListCount = leglist.count
            print("-------trip suggestions tvc new 8")
            print("leglist.count-b4--- \(leglist.count)")
//--for-1------------------------------------------------------------------------------from 11
            for leglist in leglist {
                // type could be "METRO" or "WALK"
               // let legCount = (leglist)["Leg"]!
                //print("leglist.count---- \(leglist.count)")
                print("forMain 1---- \(forMain11)")
                print("forMain 2---- \(forMain11)")
                let journeyType = (leglist as! [String: Any])["type"]! as! String
// if leg type is WALK then create a legwalk object populate it and then add it to trip
                var destinDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx: "")
                var originDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "",routeIdx:  "")
                print("-----journey type = \(journeyType)")
                //-----------------if condition walk and travel---------start
                
//                if (journeyType == "WALK"){
                
                
                // common variable extraction
                // extract ---------------------------------name-, type, idx
                let nameValue = (leglist as! [String:Any])["name"]! as! String
                let idxValue = (leglist as! [String:Any])["idx"]! as! String
                let typeValue = (leglist as! [String:Any])["type"]! as! String
                
                // extract ---------------------------------Geometry Reference
                let geomRef = (leglist as! [String:Any])["GeometryRef"] as! String
                let geometryReference = (geomRef  as! [String:Any])["ref"] as! String
                print("GEOMETRY REFERENCE VALUE IS .......\(geometryReference)")
                
                
                // --------------------------dist, hide---------------walk related variable extraction
                //------variables for walk
                var hideValue = "FALSE"
                var distValue = DEFAULT
                // -----variables for travel -
                var dirValue = DEFAULT
                var journeyDetailRefValue = DEFAULT
                var lineValue = DEFAULT
                if(journeyType == "Walk"){
                
                   distValue = (leglist as! [String:Any])["dist"]! as! String
                //var hideValue = ""
                if let hide = (leglist as! [String:Any])["hide"] as? String {
                    hideValue = hide
                }
                    
                else {
                    hideValue = "False"
                }
                }
                // travel related variable extraction
                // --------------------------dir, line, JourneyDetailReference
                    
                else if (journeyType == "Travel"){
                 dirValue = (leglist as! [String:Any])["dir"]! as! String
                let journeyDetailRef_Key = (leglist as! [String:Any])["JourneyDetailRef"]
                 journeyDetailRefValue = (journeyDetailRef_Key! as! [String:Any])["ref"] as! String
                 lineValue = (leglist as! [String:Any])["line"]! as! String

                }
//                    print("------ journey Type\(journeyType)")
//                    print("------ distValue\(distValue)")
//                    print("--------\(leglist.allKeys)")
//           
//                
//                
//                    var legwalkDict = Walk(dist: distValue, hide: hideValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref)
                    // extract origin
                    //create temp origin object and send it to legWalk object
                    
                    let origin = (leglist as! [String:Any])["Origin"] as! NSDictionary
                    //trip.from_time = origin["time"]! as! String
                    let originNameVal = origin["name"]! as! String
                    let originTypeVal = origin["type"]! as! String
                    let originIdVal = origin["id"]! as! String
                    let originLonVal = origin["lon"]! as! String
                    let originLatVal = origin["lat"]! as! String
                    let originTimeVal = origin["time"]! as! String
                    let originDateVal = origin["date"]! as! String
                    let originRoutIdx = origin["routeIdx"]! as! String
                    print("-12----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                    originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal,routeIdx:  originRoutIdx)
//                    print("---12--originNameVal-\(originNameVal)")
//                    print("--12---originDetail.name-\(originDetail.name)")
//                    
//                    print("---12--Origin- originNameVal-\(originNameVal)")
//                    
//                    
//                    print("-12----Origin- originNameVal-\(originNameVal)")
                
                    //                    let destination = leglist["Destination"] as! NSDictionary
                //    print("nested loop current index \(forMain11)")
                    let destination = (leglist as! [String:Any])["Destination"] as! NSDictionary
                    // trip.from_time = origin["time"]! as! String
                    let destinNameVal = destination["name"]! as! String
                    let destinTypeVal = destination["type"]! as! String
                    let destinIdVal = destination["id"]! as! String
                    let destinLonVal = destination["lon"]! as! String
                    let destinLatVal = destination["lat"]! as! String
                    let destinTimeVal = destination["time"]! as! String
                    let destinDateVal = destination["date"]! as! String
                    let destRouteIdx = destination["routeIdx"]! as! String
                    
                    destinDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal,routeIdx: destRouteIdx)
                    // DECIDED TO KEEP WALK AS IT IS , before it was being saved with key but there is no use of having key and saving it because then it is hard to access as well as below you can see it is being saved as LEGWALK
                    // let legWalkDict = ["WALK": legwalkDict] as NSDictionary
                    //    var legWalk = LegWalk(journeyType: journeyType, legWalk: legWalkDict as! Dictionary<String, Walk, originValue: originDetail , destinationValue: destinDetail)
                    
//                    var legWalk = LegWalk(journeyType: journeyType, legWalk: legwalkDict, originValue: originDetail , destinationValue: destinDetail)
                
                
                let checkKeyExist = RealTidMethods.checkIfKeyExists(objectToCheck: leglist as AnyObject, keyName: "RTUMessages")
                var rtuMessageString = String()
                if (checkKeyExist == true) {
                    let leglistRTUMessage = (leglist as! [String:Any])["RTUMessages"] as! NSDictionary
                    // MARK: Rtu Message Get
                    var rtuMessage = RealTidMethods.checkIfKeyExists(objectToCheck: leglistRTUMessage, keyName: "RTUMessage")
                    if (rtuMessage == true){
                        
                        print("--------rtu Message.....status................\(leglistRTUMessage.allKeys).")
                        print(rtuMessage)
                     //   print(leglistRTUMessage["RTUMessage"]!["$"] as! String)
                        rtuMessageString = ((leglistRTUMessage as! [String:Any])["RTUMessage"]! as! [String:Any])["$"] as! String
                    }
                    
                    
                }
                
                    // MARK: Leg 2 populate
                var leg =  Leg(journeyType: journeyType, name: nameValue, type: typeValue, idx: idxValue, geomRef: geometryReference, dist: distValue, hide: hideValue, dir: dirValue, line: lineValue, journeyDetailRef: journeyDetailRefValue, origin: originDetail, destination: destinDetail,legImageName: "Test",rtu_Message_Flag: checkKeyExist,rtu_Message: rtuMessageString)

                trip.LegList.add(leg)
                    
               // }
                    // else if leg type is travel then create legtravel object populate it and then add it to trip
               /*
                if (journeyType != "WALK"){
                    
                    print("-----TRAVEL HAS BEEN CAUGHT")
                    print("------ journey Type\(journeyType)")
                    
                   
                  //  print("------ dirValue\(dirValue)")
                    print("--------\(leglist.allKeys)")
                    
                   
                    let nameValue = leglist["name"]! as! String
                    let idxValue = leglist["idx"]! as! String
                    // extract Geometry Reference
                    let geomRef = leglist["GeometryRef"]
                    let ref_geom = geomRef!!["ref"] as! String
                    //
                    //                    let geomRef = leglist["GeometryRef"]
                    //                    let ref = geomRef!!["ref"] as! String
                    //
                    
                    print("GEOMETRY REFERENCE VALUE IS .......\(ref_geom)")
                    let dirValue = leglist["dir"]! as! String
                    let journeyDetailRefValue = leglist["JourneyDetailRef"]
                    let ref_jdr = journeyDetailRefValue!!["ref"] as! String
                    let lineValue = leglist["line"]! as! String

                    print("------ref jdr \(ref_jdr)")
                    
                    
                    
                    let legTravelDict = Travel(dir: dirValue, journeyDetailRef: ref_jdr, line: lineValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref_geom)
                    
                    //Walk(dist: distValue, hide: hideValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref)
                    // extract origin
                    //create temp origin object and send it to legWalk object
                    
                    
                    let origin = leglist["Origin"] as! NSDictionary
                    //trip.from_time = origin["time"]! as! String
                    let originNameVal = origin["name"]! as! String
                    let originTypeVal = origin["type"]! as! String
                    let originIdVal = origin["id"]! as! String
                    let originLonVal = origin["lon"]! as! String
                    let originLatVal = origin["lat"]! as! String
                    let originTimeVal = origin["time"]! as! String
                    let originDateVal = origin["date"]! as! String
                    
                    originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal)
                    
                    print("-----originNameVal-\(originNameVal)")
                    print("-----originDetail.name-\(originDetail.name)")
                    
                    print("-----Origin- originNameVal-\(originNameVal)")
                    print("-----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                    //                    let destination = leglist["Destination"] as! NSDictionary
                    //                    trip.to_time = destination["time"]! as! String
                    //                    trip.to_Station = destination["name"]! as! String
                    //
                    
                    
                    
                    // extract Destination
                    //create temp origin object and send it to legWalk object
                    
                    let destination = leglist["Destination"] as! NSDictionary
                    // trip.from_time = origin["time"]! as! String
                    let destinNameVal = destination["name"]! as! String
                    let destinTypeVal = destination["type"]! as! String
                    let destinIdVal = destination["id"]! as! String
                    let destinLonVal = destination["lon"]! as! String
                    let destinLatVal = destination["lat"]! as! String
                    let destinTimeVal = destination["time"]! as! String
                    let destinDateVal = destination["date"]! as! String
                    destinDetail = Address(name: destinNameVal, type: destinTypeVal, id: destinIdVal, lon: destinLonVal, lat: destinLatVal, time: destinTimeVal, date: destinDateVal)
                    // changing the way LegTravel is going to be added.Before it was dictionary based but now direct saving technique is being used to access it directly moreover the journeytype key is being saved below already so redundancy reported
                    
                    //let LegTravelDict = ["Travel": legTravelDict] as NSDictionary
                    
                    
                    
                    let legTravel = LegTravel(journeyType: journeyType, legTravel: legTravelDict, originValue: originDetail, destinationValue: destinDetail)
                    trip.LegList.addObject(legTravel)
                    
                }

                */
                
                
                //----------------------old code for legwalk and leg travel
                
                /*
 
                 if (journeyType == "WALK"){
                 print("------ journey Type\(journeyType)")
                 let distValue = leglist["dist"]! as! String
                 print("------ distValue\(distValue)")
                 print("--------\(leglist.allKeys)")
                 var hideValue = ""
                 if let hide = leglist["hide"] as? String {
                 hideValue = hide
                 }
                 
                 else {
                 hideValue = "False"
                 }
                 let nameValue = leglist["name"]! as! String
                 let idxValue = leglist["idx"]! as! String
                 // extract Geometry Reference
                 let geomRef = leglist["GeometryRef"]
                 let ref = geomRef!!["ref"] as! String
                 print("GEOMETRY REFERENCE VALUE IS .......\(ref)")
                 
                 var legwalkDict = Walk(dist: distValue, hide: hideValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref)
                 // extract origin
                 //create temp origin object and send it to legWalk object
                 
                 let origin = leglist["Origin"] as! NSDictionary
                 //trip.from_time = origin["time"]! as! String
                 let originNameVal = origin["name"]! as! String
                 let originTypeVal = origin["type"]! as! String
                 let originIdVal = origin["id"]! as! String
                 let originLonVal = origin["lon"]! as! String
                 let originLatVal = origin["lat"]! as! String
                 let originTimeVal = origin["time"]! as! String
                 let originDateVal = origin["date"]! as! String
                 print("-12----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                 originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal)
                 print("---12--originNameVal-\(originNameVal)")
                 print("--12---originDetail.name-\(originDetail.name)")
                 
                 print("---12--Origin- originNameVal-\(originNameVal)")
                 
                 
                 print("-12----Origin- originNameVal-\(originNameVal)")
                 
                 //                    let destination = leglist["Destination"] as! NSDictionary
                 print("nested loop current index \(forMain11)")
                 
                 //                    trip.to_time = originTimeVal
                 //                    trip.to_Station = originNameVal
                 ////
                 
                 
                 
                 // extract Destination
                 //create temp origin object and send it to legWalk object
                 
                 let destination = leglist["Destination"] as! NSDictionary
                 // trip.from_time = origin["time"]! as! String
                 let destinNameVal = destination["name"]! as! String
                 let destinTypeVal = destination["type"]! as! String
                 let destinIdVal = destination["id"]! as! String
                 let destinLonVal = destination["lon"]! as! String
                 let destinLatVal = destination["lat"]! as! String
                 let destinTimeVal = destination["time"]! as! String
                 let destinDateVal = destination["date"]! as! String
                 
                 destinDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal)
                 // DECIDED TO KEEP WALK AS IT IS , before it was being saved with key but there is no use of having key and saving it because then it is hard to access as well as below you can see it is being saved as LEGWALK
                 // let legWalkDict = ["WALK": legwalkDict] as NSDictionary
                 //    var legWalk = LegWalk(journeyType: journeyType, legWalk: legWalkDict as! Dictionary<String, Walk, originValue: originDetail , destinationValue: destinDetail)
                 
                 var legWalk = LegWalk(journeyType: journeyType, legWalk: legwalkDict, originValue: originDetail , destinationValue: destinDetail)
                 
                 
                 trip.LegList.addObject(legWalk)
                 
                 }
                 // else if leg type is travel then create legtravel object populate it and then add it to trip
                 else if (journeyType != "WALK"){
                 
                 print("-----TRAVEL HAS BEEN CAUGHT")
                 print("------ journey Type\(journeyType)")
                 
                 let dirValue = leglist["dir"]! as! String
                 print("------ dirValue\(dirValue)")
                 print("--------\(leglist.allKeys)")
                 
                 let lineValue = leglist["line"]! as! String
                 let nameValue = leglist["name"]! as! String
                 let idxValue = leglist["idx"]! as! String
                 // extract Geometry Reference
                 let geomRef = leglist["GeometryRef"]
                 let ref_geom = geomRef!!["ref"] as! String
                 //
                 //                    let geomRef = leglist["GeometryRef"]
                 //                    let ref = geomRef!!["ref"] as! String
                 //
                 
                 print("GEOMETRY REFERENCE VALUE IS .......\(ref_geom)")
                 
                 
                 let journeyDetailRefValue = leglist["JourneyDetailRef"]
                 let ref_jdr = journeyDetailRefValue!!["ref"] as! String
                 
                 print("------ref jdr \(ref_jdr)")
                 
                 
                 
                 let legTravelDict = Travel(dir: dirValue, journeyDetailRef: ref_jdr, line: lineValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref_geom)
                 
                 //Walk(dist: distValue, hide: hideValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref)
                 // extract origin
                 //create temp origin object and send it to legWalk object
                 
                 
                 let origin = leglist["Origin"] as! NSDictionary
                 //trip.from_time = origin["time"]! as! String
                 let originNameVal = origin["name"]! as! String
                 let originTypeVal = origin["type"]! as! String
                 let originIdVal = origin["id"]! as! String
                 let originLonVal = origin["lon"]! as! String
                 let originLatVal = origin["lat"]! as! String
                 let originTimeVal = origin["time"]! as! String
                 let originDateVal = origin["date"]! as! String
                 
                 originDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal)
                 
                 print("-----originNameVal-\(originNameVal)")
                 print("-----originDetail.name-\(originDetail.name)")
                 
                 print("-----Origin- originNameVal-\(originNameVal)")
                 print("-----Origin-  origin['name']! as! String-\( origin["name"]! as! String)")
                 //                    let destination = leglist["Destination"] as! NSDictionary
                 //                    trip.to_time = destination["time"]! as! String
                 //                    trip.to_Station = destination["name"]! as! String
                 //
                 
                 
                 
                 // extract Destination
                 //create temp origin object and send it to legWalk object
                 
                 let destination = leglist["Destination"] as! NSDictionary
                 // trip.from_time = origin["time"]! as! String
                 let destinNameVal = destination["name"]! as! String
                 let destinTypeVal = destination["type"]! as! String
                 let destinIdVal = destination["id"]! as! String
                 let destinLonVal = destination["lon"]! as! String
                 let destinLatVal = destination["lat"]! as! String
                 let destinTimeVal = destination["time"]! as! String
                 let destinDateVal = destination["date"]! as! String
                 destinDetail = Address(name: destinNameVal, type: destinTypeVal, id: destinIdVal, lon: destinLonVal, lat: destinLatVal, time: destinTimeVal, date: destinDateVal)
                 // changing the way LegTravel is going to be added.Before it was dictionary based but now direct saving technique is being used to access it directly moreover the journeytype key is being saved below already so redundancy reported
                 
                 //let LegTravelDict = ["Travel": legTravelDict] as NSDictionary
                 
                 let legTravel = LegTravel(journeyType: journeyType, legTravel: legTravelDict, originValue: originDetail, destinationValue: destinDetail)
                 trip.LegList.addObject(legTravel)
                 
                 }

 
                */
                
                
                //----------------if condition walk & travel----------end
                
                
                
                
                print("--End--------------End------------------forMain11  \(forMain11)-----")
                print("leglist count is---head--=\(legListCount)")
                print("--logic main---forMain11  is = \(forMain11 + 1)-----Leglist count is =\(legListCount)")
                // check the value of count
                print("()---originDetail.name= \(originDetail.name)")
                print("()---destinDetail.name= \(destinDetail.name)")
             
                // extracting origin and destination for Trip (complete journey)
                // extracting origin and destination for trip each leg
                
                if (legListCount == 1){
                    print("leglist count is-----=\(legListCount)")
                    trip.originDetail = originDetail.mutableCopy() as! Address
                    trip.destinationDetail = destinDetail.mutableCopy() as! Address
                    print("---A------------------originDetail= \(originDetail.name)")
                    print("----A-----------------originDetail= \(trip.originDetail.name)")
                }
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
                                
                
                forMain11 += 1
                
            }
            
            print("---LegList.allKeys----duration being entered is :\(dur)")
            self.newTrip.add(trip)
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1 += 1
            
        }
        
        
        
    }
    
    //----webservice end
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newTrip.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripSuggestionsCell", for: indexPath as IndexPath) as! TripSuggestionsCell_new
    //    let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
        print("cell-header cell---\(cell)")
        
        
        
          //      label.text = data[indexPath.row]
        
        // function getLabel(cell: dequeReusable as ! tripSugg,current index: int, legListPictorialSummary: some array)
        
//        drawLeg()
        // try to run a for loop as all info is inside tripcell.
        
        let xy = CGPoint(x: 10.0,y: 0.0)
        let size = CGSize(width:10,height:10)
        
        let spacingFloat = CGPoint(x: size.width,y: size.height )
        
        
        //  let tripCell = trips[indexPath.row]
        //let tripCell = newTrip[indexPath.row]
        
        
        let tripCell = newTrip[indexPath.row] as! Trip
        
        //drawLeg(xy, size: size, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, indexPath: <#T##NSIndexPath#>, orientation: <#T##Character#>, spacingFactor: <#T##Float#>)
    
        
        let startingPoint = CGPoint(x: 5.0,y: 2.0)
        let startingSize = CGSize(width:12.0,height:12.0)
        let orientation = "x"  // x, y, or xy
        let innerSpacing = CGPoint(x:10,y:0)
        let innerLegSpacing = CGPoint(x:25,y:0)
        let sizeFactor = CGSize(width: 0.0,height: 0.0)
        
        
        SlifeMethods.drawLegs(startingPoint: startingPoint, startingSize: startingSize, legs: tripCell.LegList, cell: cell, orientation: orientation, innerLegSpacingFactor: innerSpacing, interLegSpacingFactor: innerLegSpacing, sizeFactor: sizeFactor,indexValueFromSectionOrRow: 0,indexValueFromCurrentLeg: 0,iconTagIntValue: 0,lineNoIntValue: 0)
        
//        SlifeMethods.drawLegs(startingPoint: <#T##CGPoint#>, startingSize: <#T##CGSize#>, legs: <#T##NSMutableArray#>, cell: <#T##UITableViewCell#>, orientation: <#T##String#>, innerLegSpacingFactor: <#T##CGPoint#>, interLegSpacingFactor: <#T##CGPoint#>, sizeFactor: <#T##CGSize#>, indexValueFromSectionOrRow: <#T##Int#>, indexValueFromCurrentLeg: <#T##Int#>, iconTagIntValue: <#T##Int#>, lineNoIntValue: <#T##Int#>)
//        
        print("------from station = \(tripCell.originDetail.name)")
        print("------from time = \(tripCell.originDetail.time)")
        
        print("------to station = \(tripCell.destinationDetail.name)")
        print("------to time = \(tripCell.destinationDetail.time)")
        
        cell.from_station.text = tripCell.originDetail.name
        cell.from_time.text = tripCell.originDetail.time
       
        cell.to_station.text = tripCell.destinationDetail.name
                cell.to_time.text = tripCell.destinationDetail.time
        cell.duration.text = tripCell.dur
        print("tripcell.duration is =)")
        
//        cell.showTripRouteOnMapOutlet.tag = 10 + indexPath.row
//        print("-----Trip Suggestions------------------------------------cell for row at index path")
//        print(cell.showTripRouteOnMapOutlet.tag)
        
        
        
        return cell
    }
    
    
    
    
    
}


//   SlifeMethods.drawLeg(xy, size: size, legs: tripCell.LegList, cell: cell, indexPath: indexPath, orientation: "x", spacingFactor: spacingFloat)


//        SlifeMethods.drawLeg(xy, size: size, legs: tripCell.LegList, cell: cell, indexPath: indexPath, orientation: "x", spacingFactor: spacingFloat)


/*
 cell.from_time.text =
 cell.from_station.text =
 cell.to_time.text =
 cell.to_station.text =
 */
// configure the LegList VisualList Summary

// trips[indexPath.row].leglistSummary

// Configure the cell...


//
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        print("section---\(section)")
//
//        print("tableView.visibleCells----\(tableView.visibleCells.count)")
//        let t = tableView.dequeueReusableCellWithIdentifier("headerCell")
//
//        print("----9898---\(t)")
//
//        print()
//
//        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! TripSuggestionsCell_new
//        headerCell.backgroundColor = UIColor.cyanColor()
//
//
//        headerCell.from_time.text = "Header cell is here "
////        switch (section) {
////        case 0:
////            headerCell.headerLabel.text = "Europe";
////        //return sectionHeaderView
////        case 1:
////            headerCell.headerLabel.text = "Asia";
////        //return sectionHeaderView
////        case 2:
////            headerCell.headerLabel.text = "South America";
////        //return sectionHeaderView
////        default:
////            headerCell.headerLabel.text = "Other";
////        }
//
//        return headerCell
//    }
//
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

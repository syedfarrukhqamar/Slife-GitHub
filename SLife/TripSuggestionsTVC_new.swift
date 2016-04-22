//
//  TripSuggestionsTVC_new.swift
//  SLife
//
//  Created by syed farrukh Qamar on 13/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
var convertedJsonIntoNSDict = NSDictionary()


class TripSuggestionsTVC_new: UITableViewController {
    //    var newTrip = [Trip]()
    var newTrip = NSMutableArray()
    
    //    var trips = [Trips]()
    
    var from = String()
    var to = String()
    var searchForArrivals = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var searchTrips = WebServiceHandler()
        let url = searchTrips.constructURL("Trip", origin: from.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), destination: to.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), returnContentType: jsonType, searchForArrival: "0")
        
        print("-------------------url----\(url)")
        
        get_data_from_url(url)
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
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        print("---json step 1------")
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            print("---json step 2------")
            dispatch_async(dispatch_get_main_queue(), {
                self.extract_json(data!)
                print("---7.1--about to return after parsing")
                
                let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                
                self.getTrips(convertedJsonIntoNSDict)
                //--for-1--------------------------------------------------------------------------------------------------
                
                print("---7.2--about to return after parsing")
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
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            print("json just downloaded.......5........\(json?.allKeys)")
            print("json just downloaded.......5........\(json?["TripList"]!!.description)")
            
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
        
        let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
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
            let newAddress = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "")
            
            var trip = Trip(dur: "", chg: "", co2: "", tariffRemark: "", tariffZones: "", LegList: NSMutableArray(), originDetail: newAddress , destinationDetail: newAddress)
            
            
            let dur = tripArray.valueForKey("dur")!
            print("tripArray----all Keys \(tripArray.allKeys)")
            
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
            
            trip.dur = tripArray.valueForKey("dur")! as! String
            trip.chg = tripArray.valueForKey("chg")! as! String
            
            trip.co2 = tripArray.valueForKey("co2")! as! String
            
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
            
            let priceInfo = tripArray.valueForKey("PriceInfo")! as! NSDictionary
            
            print("Price Info -----\(priceInfo.allKeys)")
            trip.tariffRemark = (priceInfo["TariffRemark"] as! NSDictionary)["$"] as! String
            trip.tariffZones = (priceInfo["TariffZones"] as! NSDictionary)["$"] as! String
            // trip.tariffZones =  priceInfo["TariffZones"] as! NSDictionary
            
            //--Priceinfo--End--------gather legs inside LegList-----start
            
            var forMain11 = 0
            // create a leglist as an array to add the legs in the leglist
            var leglist = NSMutableArray()
            if (change == "0") {
                leglist.addObject(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                // leglist.append(tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary)
                 print("tripArray.valueForKey('LegList')--- \(tripArray.valueForKey("LegList")?.count)")
            }
            else {
                let tempLegList = tripArray.valueForKey("LegList")!["Leg"] as! NSArray
                var i = 0
                    print("forMain1---- \(forMain1)")
                    print("forMain11---- \(forMain11)")
                for (tempLegList) in tempLegList {
                    leglist.addObject(tempLegList)
                     print("tempLegList.count is---- \(tempLegList.count)")
                    print("i---- \(i)")
                i++
                }
            }
            var legs = NSMutableArray()
            let legListCount = leglist.count
            
            print("leglist.count-b4--- \(leglist.count)")
//--for-1------------------------------------------------------------------------------from 11
            for leglist in leglist {
                
                // type could be "METRO" or "WALK"
                
                let legCount = leglist["Leg"]!
                print("leglist.count---- \(leglist.count)")
                print("forMain 1---- \(forMain11)")
                print("forMain 2---- \(forMain11)")
                let journeyType = leglist["type"]! as! String
// if leg type is WALK then create a legwalk object populate it and then add it to trip
                
                var destinDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "")
                var originDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "")
                
                print("-----journey type = \(journeyType)")
                if (journeyType == "WALK"){
                    print("------ journey Type\(journeyType)")
                    
                    let distValue = leglist["dist"]! as! String
                    print("------ distValue\(distValue)")
                    print("--------\(leglist.allKeys)")
                    let hideValue = leglist["hide"]! as! String
                  
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
                    
                    let destination = leglist["Origin"] as! NSDictionary
                   // trip.from_time = origin["time"]! as! String
                    let destinNameVal = origin["name"]! as! String
                    let destinTypeVal = origin["type"]! as! String
                    let destinIdVal = origin["id"]! as! String
                    let destinLonVal = origin["lon"]! as! String
                    let destinLatVal = origin["lat"]! as! String
                    let destinTimeVal = origin["time"]! as! String
                    let destinDateVal = origin["date"]! as! String
                    
                    destinDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal)
                    
                    let legWalkDict = ["WALK": legwalkDict] as NSDictionary
                    var legWalk = LegWalk(journeyType: journeyType, legWalk: legWalkDict as! Dictionary<String, Walk>, originValue: originDetail , destinationValue: destinDetail)
                    
                    
                    trip.LegList.addObject(LegWalk)
                    
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
                    
                    
                    
                    var legTravelDict = Travel(dir: dirValue, journeyDetailRef: ref_jdr, line: lineValue, name: nameValue, type: journeyType, idx: idxValue, geomRef: ref_geom)
                        
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
                    
                    let destination = leglist["Origin"] as! NSDictionary
                    // trip.from_time = origin["time"]! as! String
                    let destinNameVal = origin["name"]! as! String
                    let destinTypeVal = origin["type"]! as! String
                    let destinIdVal = origin["id"]! as! String
                    let destinLonVal = origin["lon"]! as! String
                    let destinLatVal = origin["lat"]! as! String
                    let destinTimeVal = origin["time"]! as! String
                    let destinDateVal = origin["date"]! as! String
                    
                    destinDetail = Address(name: originNameVal, type: originTypeVal, id: originIdVal, lon: originIdVal, lat: originLatVal, time: originTimeVal, date: originDateVal)
                   
                    let LegTravelDict = ["Travel": legTravelDict] as NSDictionary

                    let legTravel = LegTravel(journeyType: journeyType, legTravel: LegTravelDict as! Dictionary<String, Travel>, originValue: originDetail, destinationValue: destinDetail)
                 
                    trip.LegList.addObject(legTravel)
                    
                    
                }
                print("--End--------------End------------------forMain11  \(forMain11)-----")
                print("leglist count is---head--=\(legListCount)")
                print("--logic main---forMain11 - 1 is )\(forMain11-1)-----Leglist count is =\(legListCount)")
                
                // check the value of count
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
                else if (legListCount > 1 && ((forMain11+1) == legListCount))
                {
                    print("leglist count is-88-destin--\(legListCount)")

                                trip.destinationDetail = destinDetail.mutableCopy() as! Address
                                print("---C------------------originDetail= \(originDetail.name)")
                                print("---C------------------originDetail= \(trip.originDetail.name)")

                           print("legListCount > 1 && ((forMain11-1) == count ---------")
                }
                                
                
                
                
                forMain11++
                
            }
            
          
            //newTrip[forMain1].LegList = legs

            //----old below before 15th of april
            
            //var tripOneByOne = Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: dur as! String, tripsJson: tripArray as! NSDictionary, type: "", name: "", dir: "", line: "", idx: "")
            
            
            
            //print ("---------\(self.trips[forMain1].legs)")
            //self.trips.append(tripOneByOne!)
            
            // printing index from 0 to 4 (count is 5)
            
            //                    print("--Trip =---\(forMain1)--Duration=\(tripArray.valueForKey("dur")! )")
            //                    print("----LegList--\(tripArray.valueForKey("LegList")!["Leg"]!!.count)")
            //---Nested for Loop to print Trip---------------Nested-for-Loop---1-1--i
            
            //                    let leg = tripArray.valueForKey("LegList")!["Leg"] as! NSDictionary
            //                    self.trips[forMain1].legs = tripArray.valueForKey("LegList")!["Leg"] as! NSArray
            
            //                print("-----------------080-0-\(self.trips[forMain1].legs.allKeys)")
            //                    print("----count---of leg is\(self.trips[forMain1].legs["Origin"])")//--for-1.1-------------------------------------------------------------------------------------------------
            // Moved to end -------1-- might be major impact (14th april 0900)
            
            // Moved to end -------1
            
            print("---LegList.allKeys----duration being entered is :\(dur)")
            self.newTrip.addObject(trip)
            print("--End--------------End------------------forMain1  \(forMain1)-----")
            forMain1++
            
        }
        
        
        
    }
    
    //----webservice end
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newTrip.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tripSuggestionsCell", forIndexPath: indexPath) as! TripSuggestionsCell_new
        
        //  let tripCell = trips[indexPath.row]
        //let tripCell = newTrip[indexPath.row]
        
        
        let tripCell = newTrip[indexPath.row] as! Trip
        
        
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
        
        
        /*
         cell.from_time.text =
         cell.from_station.text =
         cell.to_time.text =
         cell.to_station.text =
         */
        // configure the LegList VisualList Summary 
        
        // trips[indexPath.row].leglistSummary
        
        // Configure the cell...
        
        
        
        
        return cell
    }
    
    
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

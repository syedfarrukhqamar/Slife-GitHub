//
//  TripSuggestionsTVC.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit




class TripSuggestionsTVC: UITableViewController {
    
 var trips = [Trips]()
  var convertedJsonIntoNSDict = NSDictionary()
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
                // MARK XML Loading : for table view
                // table vier data
                
                //  print("printing json= \(convertedJsonIntoNSDict)" )
                // MARK Data Extraction is started
                //                 print("Trip List is\(convertedJsonIntoNSDict["TripList"]!["Trip"]!![0])")
                //                 print("Trip List is\(convertedJsonIntoNSDict["TripList"]!["Trip"]!![1])")
                //                 print("Trip List is\(convertedJsonIntoNSDict["TripList"]!["Trip"]!![2])")
                //                 print("Trip List is\(convertedJsonIntoNSDict["TripList"]!["Trip"]!![3])")
                //
                // iterate through ["TripList"]!["Trip"]!!.[]
                
                //self.trips.append(Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: "90")!)
                //                print("....8989888...\(self.trips[0].duration)")
                let tripArray = self.convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                //--for-1--------------------------------------------------------------------------------------------------
                var forMain1 = 0
                for tripArray in tripArray {
                    //  print("--Start--[TripList]-[Trip]-for Loop-1-------------------------------------------forMain1 \(forMain1)-----")
                    print("--------------------------------------------------------------------------------forMain1 \(forMain1)-----")
                    
                    let dur = tripArray.valueForKey("dur")!
                    //    var tripOneByOne = Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: tripArray.valueForKey("dur") as! String)
                    //                         print("--tripArray is \(tripArray.allKeys)")
                    //                     print("--tripArray.leglist is \(tripArray["LegList"])")
                    //                    print("--tripArray.leglist is \(tripArray["LegList"])")
                    //
                    
                    let LegList = tripArray.valueForKey("LegList") as! NSDictionary
                    print("---LegList.allKeys--LegList is \(LegList.allKeys)")
                    print("---LegList.allKeys----duration being entered is :\(dur)")
                    
                    
//                    var tripOneByOne = Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: dur as! String, tripsJson: tripArray as! NSDictionary, type: "", name: "", dir: "", line: "", idx: "")
//                    
                    
                    
                    //print ("---------\(self.trips[forMain1].legs)")
                   // self.trips.append(tripOneByOne!)
                    
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
                    print("--End----------------------------------------------End------------------forMain1  \(forMain1)-----")
                    forMain1++
                    
                }
                
                
                // Moved to end -------2
                
                
                print("---7--about to return after parsing")
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
            print("json just downloaded.......5........")
        } catch {
            json = nil
            return
        }
        
        convertedJsonIntoNSDict = (json as? NSDictionary)!
        
        print("---6-----convertedJSON is being printed = \(convertedJsonIntoNSDict)")
    }
    
    
    
    //----webservice end
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trips.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tripSuggestionsCell", forIndexPath: indexPath) as! TripSuggestionsCell
        
        
        // Fetches the appropriate meal for the data source layout.
       
        
        
        let tripCell = trips[indexPath.row]
        // load the journey legs
        
        let journeyLegs = tripCell
        
        print("-----journey legs all keys--\(journeyLegs.tripsJson.count)")
        
        for (key,value) in journeyLegs.tripsJson
        {
            
            // go into LegList and find out Leg
            if (key as! String == "LegList")
            {
                var leglist = value as! NSDictionary
             
                for (key,value) in leglist {
                print("keys inside leglist are = \(key) ")
                    
                    // go into Leg and find out Journey number of Legs
                    if (key as! String == "Leg")
                    {
                     var legs = value as! NSArray
                       
                        //each leg printing mechanism in belows for
                        // Total Legs are below
                        
                        
                        
                        // Iterating through All Legs in Journey
                        var legsIndex = 0
                       
                        for legs in legs {
                        print("-legs.key---legs.key--\(legs.allKeys)")
                        print("-legs.key---legs.key-d-\(legs["Destination"])")
                            
                            print("legs \(legs)")

                            print("leglist.count = \(leglist["Leg"]!.count)")

                            print("Legs.count = \(legs.count)")
                            
                            print("legsIndex = \(legsIndex)")
                            // iterating through all the keys in journey Leg
                            if (legsIndex == 0 && (leglist["Leg"]!.count == 1))
                            {
                            
                                                        // get OriginTime()
                                let origin = legs["Origin"] as! NSDictionary
                                for (key,value) in origin {
                                
                                if (key as! String == "time")
                                {
                                    cell.from_time.text = value as! String
                                    
                                    }
                                
                                }
                            // get DestinationTime
                                let destination = legs["Destination"] as! NSDictionary
                                for (key,value) in destination {
                                    
                                    if (key as! String == "time")
                                    {
                                        cell.to_time.text = value as! String
                                        
                                    }
                                }
  
                                
                                
                            }
                            // get the first leg to extract from time
                            else if (legsIndex == 0 && (leglist["Leg"]!.count > 1))
                            {
                                // get OriginTime()
                                let origin = legs["Origin"] as! NSDictionary
                                for (key,value) in origin {
                                    print("101--1----101")
                                    if (key as! String == "time")
                                    {
print("101--2----101---legs index is \(legsIndex)")
                                        cell.from_time.text = value as! String
                                        
                                    }
                                    
                                }

                            
                            }
                            // get the last leg to extract to time
                            else if ( legsIndex == (leglist["Leg"]!.count - 1)){
                                print("101--3----101")
                                // get OriginTime()
                                // get DestinationTime
                                // get DestinationTime
                                let destination = legs["Destination"] as! NSDictionary
                                for (key,value) in destination {
                                    print("-----a-----")
                                    if (key as! String == "time")
                                    {
                                        print("-----b-----")
                                        cell.to_time.text = value as! String
                                        
                                    }
                                }
                            
                            }
                            print("------legs index value----\(legsIndex)")
                            print("------total count is ----\(legs.count)")
                      legsIndex++
//                            if (legs.count == 1) {
//                            
//                                // extract the destination and origin's time
//                            
//                            
//                            }
//                            else if (legs.index == 0){
//                            
//                            
//                            
//                            }
//                             else if (legs.indexPath == (legs.count-1))
//                            {
//                            
//                            
//                            }
                        
                        
                        }
                        // Level 1 extract the From Time and To Time
                        // check the total count of legs. if leg count is 1 then extract destination and origino time from the same leg
                        // if the leg count is more than 1 then extract from time and to time from the first and last leg respectively
//                        if (legs.count == 1){
//                        // extract the from and to time from origin and destination objects respectively
//                        
//                        
//                        }
                        
                        
                        
//                        for legs in legs {
//                            var leg = legs as! NSDictionary
//                            // Accessing each Leg in Leglist
//                            
//                            for (key,value) in leg {
//                            
//                                print("legs.key = \(key) ")
//                                
//                                
//                                // Leg-Origin
//                                if (key == "Origin") {
//                                
//                                
//                                
//                                }
//                            
//                            }
//                            
//
//                        
//                        }
                    
                    }

                
                }
            }
          //  print("key is ")
            
       }
        
//        for (key,value) in journeyLegs {
//        
//        print("-----key inside tvc--\(key)")
//        }
         // load the journey legs
        
                  cell.from_station.text = self.from
          //      cell.from_time.text = self.to
                  cell.to_station.text = self.to
        //        cell.to_time.text = tripCell.to_time
                  cell.duration.text = tripCell.duration
                  print("tripcell.duration is = \(tripCell.duration)")
        
        
        // Leg
        // -L0-L1-LN-----Origin (from time) - and other variables
        //
        // --L0-L1-LN----Destination (to time) - and other variables
        
        
        
        
    
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



//----------------------
/*
-----here.-.--.-.
---------------------------1---------------Optional("tripSuggestions")--
---------------------------2-----------------
---webservice handler------0--------
---webservice handler------2--------
----------------finalised URL To Connect Construct is --------------Start---
https://api.sl.se/api2/TravelplannerV2/Trip.json?key=92cbcaa8387c44e3be686f7dd4a1fd32&originId=kista&destId=centralen&searchForArrival=0
----------------finalised URL To Connect Construct is --------------End---
-------------------url----https://api.sl.se/api2/TravelplannerV2/Trip.json?key=92cbcaa8387c44e3be686f7dd4a1fd32&originId=kista&destId=centralen&searchForArrival=0
---json step 1------
-----------------------ended--090
---json step 2------
---json step 3------
json downloading in progres........4........
json just downloaded.......5........
--------------------------------------------------------------------------------forMain1 0-----
--Trip =---0--Duration=18
----LegList--9
-Trip=0-------------------------------------forMain11 0-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-0-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-0-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-0-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-0-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-0-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-0-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-0-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-0-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-0-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 0-----
-Trip=1-------------------------------------forMain11 1-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-1-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-1-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-1-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-1-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-1-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-1-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-1-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-1-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-1-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 1-----
-Trip=2-------------------------------------forMain11 2-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-2-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-2-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-2-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-2-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-2-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-2-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-2-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-2-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-2-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 2-----
-Trip=3-------------------------------------forMain11 3-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-3-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-3-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-3-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-3-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-3-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-3-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-3-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-3-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-3-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 3-----
-Trip=4-------------------------------------forMain11 4-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-4-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-4-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-4-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-4-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-4-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-4-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-4-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-4-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-4-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 4-----
-Trip=5-------------------------------------forMain11 5-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-5-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-5-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-5-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-5-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-5-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-5-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-5-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-5-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-5-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 5-----
-Trip=6-------------------------------------forMain11 6-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-6-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-6-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-6-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-6-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-6-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-6-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-6-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-6-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-6-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 6-----
-Trip=7-------------------------------------forMain11 7-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-7-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-7-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-7-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-7-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-7-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-7-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-7-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-7-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-7-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 7-----
-Trip=8-------------------------------------forMain11 8-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------0-8-4-0
-key in-origin-type
-value in-origin-ST
.------------------0-8-4-1
-key in-origin-id
-value in-origin-400103252
.------------------0-8-4-2
-key in-origin-name
-value in-origin-Kista
.------------------0-8-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------0-8-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------0-8-4-5
-key in-origin-time
-value in-origin-18:49
.------------------0-8-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------0-8-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------0-8-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:49";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D838296%2F283260%2F337994%2F110436%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:07";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 8-----
--End----------------------------------------------End------------------forMain1  0-----
--------------------------------------------------------------------------------forMain1 1-----
--Trip =---1--Duration=18
----LegList--9
-Trip=0-------------------------------------forMain11 0-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-0-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-0-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-0-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-0-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-0-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-0-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-0-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-0-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-0-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 0-----
-Trip=1-------------------------------------forMain11 1-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-1-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-1-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-1-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-1-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-1-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-1-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-1-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-1-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-1-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 1-----
-Trip=2-------------------------------------forMain11 2-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-2-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-2-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-2-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-2-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-2-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-2-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-2-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-2-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-2-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 2-----
-Trip=3-------------------------------------forMain11 3-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-3-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-3-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-3-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-3-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-3-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-3-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-3-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-3-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-3-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 3-----
-Trip=4-------------------------------------forMain11 4-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-4-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-4-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-4-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-4-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-4-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-4-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-4-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-4-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-4-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 4-----
-Trip=5-------------------------------------forMain11 5-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-5-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-5-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-5-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-5-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-5-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-5-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-5-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-5-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-5-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 5-----
-Trip=6-------------------------------------forMain11 6-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-6-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-6-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-6-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-6-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-6-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-6-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-6-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-6-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-6-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 6-----
-Trip=7-------------------------------------forMain11 7-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-7-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-7-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-7-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-7-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-7-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-7-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-7-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-7-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-7-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 7-----
-Trip=8-------------------------------------forMain11 8-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------1-8-4-0
-key in-origin-type
-value in-origin-ST
.------------------1-8-4-1
-key in-origin-id
-value in-origin-400103252
.------------------1-8-4-2
-key in-origin-name
-value in-origin-Kista
.------------------1-8-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------1-8-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------1-8-4-5
-key in-origin-time
-value in-origin-18:59
.------------------1-8-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------1-8-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------1-8-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "18:59";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D223086%2F78190%2F516372%2F183826%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:17";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 8-----
--End----------------------------------------------End------------------forMain1  1-----
--------------------------------------------------------------------------------forMain1 2-----
--Trip =---2--Duration=18
----LegList--9
-Trip=0-------------------------------------forMain11 0-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-0-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-0-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-0-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-0-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-0-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-0-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-0-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-0-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-0-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 0-----
-Trip=1-------------------------------------forMain11 1-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-1-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-1-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-1-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-1-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-1-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-1-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-1-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-1-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-1-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 1-----
-Trip=2-------------------------------------forMain11 2-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-2-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-2-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-2-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-2-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-2-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-2-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-2-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-2-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-2-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 2-----
-Trip=3-------------------------------------forMain11 3-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-3-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-3-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-3-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-3-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-3-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-3-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-3-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-3-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-3-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 3-----
-Trip=4-------------------------------------forMain11 4-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-4-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-4-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-4-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-4-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-4-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-4-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-4-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-4-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-4-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 4-----
-Trip=5-------------------------------------forMain11 5-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-5-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-5-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-5-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-5-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-5-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-5-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-5-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-5-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-5-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 5-----
-Trip=6-------------------------------------forMain11 6-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-6-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-6-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-6-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-6-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-6-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-6-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-6-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-6-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-6-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 6-----
-Trip=7-------------------------------------forMain11 7-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-7-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-7-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-7-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-7-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-7-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-7-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-7-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-7-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-7-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 7-----
-Trip=8-------------------------------------forMain11 8-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------2-8-4-0
-key in-origin-type
-value in-origin-ST
.------------------2-8-4-1
-key in-origin-id
-value in-origin-400103252
.------------------2-8-4-2
-key in-origin-name
-value in-origin-Kista
.------------------2-8-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------2-8-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------2-8-4-5
-key in-origin-time
-value in-origin-19:09
.------------------2-8-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------2-8-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------2-8-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:09";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D334209%2F115231%2F477306%2F127253%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:27";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 8-----
--End----------------------------------------------End------------------forMain1  2-----
--------------------------------------------------------------------------------forMain1 3-----
--Trip =---3--Duration=18
----LegList--9
-Trip=0-------------------------------------forMain11 0-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-0-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-0-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-0-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-0-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-0-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-0-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-0-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-0-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-0-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 0-----
-Trip=1-------------------------------------forMain11 1-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-1-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-1-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-1-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-1-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-1-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-1-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-1-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-1-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-1-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 1-----
-Trip=2-------------------------------------forMain11 2-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-2-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-2-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-2-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-2-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-2-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-2-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-2-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-2-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-2-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 2-----
-Trip=3-------------------------------------forMain11 3-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-3-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-3-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-3-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-3-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-3-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-3-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-3-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-3-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-3-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 3-----
-Trip=4-------------------------------------forMain11 4-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-4-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-4-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-4-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-4-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-4-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-4-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-4-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-4-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-4-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 4-----
-Trip=5-------------------------------------forMain11 5-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-5-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-5-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-5-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-5-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-5-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-5-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-5-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-5-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-5-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 5-----
-Trip=6-------------------------------------forMain11 6-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-6-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-6-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-6-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-6-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-6-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-6-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-6-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-6-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-6-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 6-----
-Trip=7-------------------------------------forMain11 7-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-7-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-7-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-7-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-7-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-7-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-7-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-7-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-7-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-7-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 7-----
-Trip=8-------------------------------------forMain11 8-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------3-8-4-0
-key in-origin-type
-value in-origin-ST
.------------------3-8-4-1
-key in-origin-id
-value in-origin-400103252
.------------------3-8-4-2
-key in-origin-name
-value in-origin-Kista
.------------------3-8-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------3-8-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------3-8-4-5
-key in-origin-time
-value in-origin-19:19
.------------------3-8-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------3-8-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------3-8-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:19";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D810300%2F273929%2F556052%2F7926%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:37";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 8-----
--End----------------------------------------------End------------------forMain1  3-----
--------------------------------------------------------------------------------forMain1 4-----
--Trip =---4--Duration=18
----LegList--9
-Trip=0-------------------------------------forMain11 0-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-0-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-0-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-0-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-0-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-0-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-0-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-0-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-0-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-0-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 0-----
-Trip=1-------------------------------------forMain11 1-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-1-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-1-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-1-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-1-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-1-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-1-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-1-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-1-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-1-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 1-----
-Trip=2-------------------------------------forMain11 2-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-2-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-2-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-2-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-2-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-2-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-2-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-2-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-2-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-2-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 2-----
-Trip=3-------------------------------------forMain11 3-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-3-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-3-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-3-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-3-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-3-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-3-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-3-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-3-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-3-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 3-----
-Trip=4-------------------------------------forMain11 4-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-4-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-4-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-4-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-4-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-4-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-4-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-4-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-4-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-4-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 4-----
-Trip=5-------------------------------------forMain11 5-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-5-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-5-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-5-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-5-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-5-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-5-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-5-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-5-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-5-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 5-----
-Trip=6-------------------------------------forMain11 6-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-6-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-6-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-6-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-6-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-6-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-6-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-6-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-6-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-6-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 6-----
-Trip=7-------------------------------------forMain11 7-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-7-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-7-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-7-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-7-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-7-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-7-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-7-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-7-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-7-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
---------------------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 7-----
-Trip=8-------------------------------------forMain11 8-----
--name------------------Optional(tunnelbanans blå linje 11)
---type------------------Optional(METRO)
----dir-----------------Optional(Kungsträdgården)
-----line----------------Optional(11)
0---Key=GeometryRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%26startIdx%3D2%26endIdx%3D11%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 0-----
-name-8
--End----------------------------forMain111 0-----
1---Key=type--value--METRO
---------------------------forMain111 1-----
-name-8
--End----------------------------forMain111 1-----
2---Key=line--value--11
---------------------------forMain111 2-----
-name-8
--End----------------------------forMain111 2-----
3---Key=name--value--tunnelbanans blå linje 11
---------------------------forMain111 3-----
-name-8
--End----------------------------forMain111 3-----
.------------------4-8-4-0
-key in-origin-type
-value in-origin-ST
.------------------4-8-4-1
-key in-origin-id
-value in-origin-400103252
.------------------4-8-4-2
-key in-origin-name
-value in-origin-Kista
.------------------4-8-4-3
-key in-origin-routeIdx
-value in-origin-2
.------------------4-8-4-4
-key in-origin-lon
-value in-origin-17.942685
.------------------4-8-4-5
-key in-origin-time
-value in-origin-19:29
.------------------4-8-4-6
-key in-origin-lat
-value in-origin-59.402939
.------------------4-8-4-7
-key in-origin-date
-value in-origin-2016-04-12
.---------4-8-4
4---Key=Origin--value--{
    date = "2016-04-12";
    id = 400103252;
    lat = "59.402939";
    lon = "17.942685";
    name = Kista;
    routeIdx = 2;
    time = "19:29";
    type = ST;
}
---------------------------forMain111 4-----
-name-8
--End----------------------------forMain111 4-----
5---Key=JourneyDetailRef--value--{
    ref = "ref%3D6762%2F6083%2F571948%2F283721%2F74%3Fdate%3D2016-04-12%26station_evaId%3D400103252%26station_type%3Ddep%26lang%3Dsv%26format%3Djson%26";
}
---------------------------forMain111 5-----
-name-8
--End----------------------------forMain111 5-----
6---Key=idx--value--0
---------------------------forMain111 6-----
-name-8
--End----------------------------forMain111 6-----
7---Key=dir--value--Kungsträdgården
---------------------------forMain111 7-----
-name-8
--End----------------------------forMain111 7-----
8---Key=Destination--value--{
    date = "2016-04-12";
    id = 400103052;
    lat = "59.332347";
    lon = "18.062008";
    name = "T-Centralen";
    routeIdx = 11;
    time = "19:47";
    type = ST;
}
-------------*/
/*
 --------------forMain111 8-----
-name-8
--End----------------------------forMain111 8-----
--End------------------------End---forMain11 8-----
--End----------------------------------------------End------------------forMain1  4-----
---7--about to return after parsing

*/


// Moved to end -------1-- might be major impact (14th april 0900)
/*
var forMain11 = 0
for (key,value) in leg {
    
    
    if (key as! String == "name")
    {
        
        self.trips[forMain1].name = value as! String
        
        print("---name found in leg--\(key)")
        print("-self.trips[forMain1].name----value of name is --\(self.trips[forMain1].name)")
    }
    
    
    
    
    // adding legs to the trip index 1 by 1
    //  self.trips[forMain1].legs = leg as! AnyObject
    
    // print("--leg.debugDescription----\(leg.debugDescription)")
    //self.trips[forMain1].name = leg["name"] as!String
    
    
    //print("--Start--[TripList]-[Trip]-[LegList]-[Leg]-for Loop-1.1--------------------------forMain11 \(forMain11)-----")
    print("-Trip=\(forMain11)-------------------------------------forMain11 \(forMain11)-----")
    
    print("--name------------------\(tripArray.valueForKey("LegList")!["Leg"]!!["name"]!)")
    print("---type------------------\(tripArray.valueForKey("LegList")!["Leg"]!!["type"]!)")
    print("----dir-----------------\(tripArray.valueForKey("LegList")!["Leg"]!!["dir"]!)")
    print("-----line----------------\(tripArray.valueForKey("LegList")!["Leg"]!!["line"]!)")
    // print("-origin>------\(tripArray.valueForKey("LegList")!["Leg"])")
    let legDict = tripArray.valueForKey("LegList")?["Leg"] as! NSDictionary
    //         print("-name-\(tripArray.valueForKey("LegList")!["Leg"]!!["Origin"]!!["name"])")
    //---Nested for Loop to print Trip---------------Nested-for-Loop----1-1--1--i
    
    //--for-1.1.1-----------------------------------------Origin & Destination----------------------
    var forMain111 = 0
    for (key,value) in legDict {
        
        if (key as! String == "Origin"){
            var origin = value as! NSDictionary
            var oCount = 0
            for (key,value) in origin {
                
                print(".------------------\(forMain1)-\(forMain11)-\(forMain111)-\(oCount)")
                
                print ("-key in-origin-\(key)")
                
                print ("-value in-origin-\(value)")
                oCount++
            }
            
            //print("--Origin---\(legDict["Origin"])")
            print(".---------\(forMain1)-\(forMain11)-\(forMain111)")
            //                            print(".11...inside Origin-11-\(forMain11)")
            //                                print(".111...inside Origin-111-\(forMain111)")
            
            
        }
        print("\(forMain111)---Key=\(key)--value--\(value)")
        
        // print("--Start--[TripList]-[Trip]-[LegList]-[Leg][Origin]-for Loop-1.1.1--------------------------forMain111 \(forMain111)-----")
        print("---------------------------forMain111 \(forMain111)-----")
        print("-name-\(tripArray.valueForKey("LegList")!["Leg"]!!["Origin"]!!.count!)")
        
        // print("--Origin= \(legDict)---")
        //   print("--End--[TripList]-[Trip]-[LegList]-[Leg][Origin]-for Loop-1.1.1--------------------------forMain111 \(forMain111)-----")
        print("--End----------------------------forMain111 \(forMain111)-----")
        forMain111++
    }
    
    // print("--End--[TripList]-[Trip]-[LegList]-[Leg]-for Loop-1.1-----------------------End---forMain11 \(forMain11)-----")
    print("--End------------------------End---forMain11 \(forMain11)-----")
    forMain11++
}
*/

// Moved to end -------1



// check the type of object here because it could be array or dict
//print ("-9098888-----\(tripArray.valueForKey("LegList")?.allKeys )")
// print ("-9098888-----\(tripArray.valueForKey("LegList")?["Leg"]!!.count)")
/*
 
 print("----Leglist(Dic)>Leg(Dic)>")
 print("..LegList..\(tripArray.valueForKey("LegList")!.count)")
 print("..Leg..\(tripArray.valueForKey("LegList")?["Leg"]!!.count)")
 let leg = tripArray.valueForKey("LegList")?["Leg"]
 print("----leg?.debugDescription----\(leg??.count)")
 print("..test tripArray.valueForKey(]...\(leg??.count)")
 print("..test tripArray.valueForKey(]...\(leg??.allKeys)")
 print("..type..\(leg!!["type"])")
 print("----Leg.count----\(leg!!.count)")
 print("----Leg--dir--\(leg!!["dir"])")
 print("----Leg--dir--\(leg!!["Destination"]!!["date"])")
 print("--------test-")
 print("-------tripArray---------\(index)--start")
 
 print("--test--\(tripArray.valueForKey("dur"))")
 print("-------tripArray-----------end")
 forMain++
 */
//  print ("some-----\(some!.count)")
//print("..test tripArray.valueForKey(]...\(leg?.debugDescription)")


//   print("..origin..\(leg!!["origin"] as? Dictionary)")



//                    if let legIsDict = leg as? Array <String> {
//                    print("array found ...........")
//                    }
//
//                    else {
//                        print("array found .....didnt......")
//
//
//                    }

//----------------------nested loop starts here to get Origin and Destination


// get duration from the triplist>trip>duration and assign it to array

//print("---self.trips[0].duration-----\(self.trips[0].duration)")

//   self.trips.append(Trips(from_time: "", from_station: "", to_time: "", to_station: "", duration: (tripArray.valueForKey("dur")?.string)!)!)
// print("....Duration is= \(forMain).=..\(self.trips[forMain].duration)")
// print("-------trips[i].duration =-----\(self.trips[i].duration)--")

// print("--End----------------------------------------------End------------------forMain1  \(forMain1)-----")


// Moved to end -------2
/* temp comment
 print("--self.trips.count---\(self.trips.count)")
 print("---self.trips[0].duration-----\(self.trips[0].duration)")
 print("---self.trips[1].duration-----\(self.trips[1].duration)")
 print("---self.trips[2].duration-----\(self.trips[2].duration)")
 print("---self.trips[3].duration-----\(self.trips[3].duration)")
 print("---self.trips[4].duration-----\(self.trips[4].duration)")
 */
//print("---self.trips[5].duration-----\(self.trips[5].duration)")
// MARK Data Extraction is ending here




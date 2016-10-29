//
//  TrafficStatusCentralProcessor.swift
//  SLife
//
//  Created by syed farrukh Qamar on 28/07/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

let EVENTGOOD_ICON = "EventGood"
let EVENTPLANNED_ICON = "EventPlanned"
let EVENTMINOR_ICON = "EventMinor"

let trafficStatusCode = "StatusCode"
let MESSAGE_TRAFFICSTATUS = "Message"
// var trafficStatusDict = NSMutableDictionary()
// MARK: Swift 3 change
var trafficStatusDict = NSDictionary()

var dataSourceTrafficStatus = NSMutableArray()
var dataSourceStatusCode = NSMutableDictionary()
var jsonTrafficStatusLoaded = false
var downloadingNotFinishedTrafficStatus = true

let trafficStatusURL = "https://api.sl.se/api2/trafficsituation.json?key=5f8ccb4f332f4b068d77d4230eb7300c"


class TrafficStatusCentralProcessor {
    
    static func get_data_from_url(url:String)
    {
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("Traffic Central Processor -INSIDE TRAFFIC STATUS--json step 1---real time--test real-")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print("-TRAFFIC STATUS Central----json step 2-----test-")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                print("TRAFFIC STATUS---in real time result--7.1--about to return after parsing")
                jsonTrafficStatusLoaded = true
               
                downloadingNotFinishedTrafficStatus = false
                
                // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                //self.getTrips(convertedJsonIntoNSDict)
                //--for-1-------------------------------------------------------------------------------------------------
                print("TRAFFIC STATUS-Central-in real time result-7.2--about to return after parsing")
                
                print(jsonTrafficStatusLoaded)
                // reload the table here
             //   self.tableView.reloadData()
                return
            })
        }
        task.resume()
    }
    
    //----call webservice-----........end
    
    //---extract data from json-.------start
    
    
   static func extract_json(jsonData:NSData)
    {
        print("--INSIDE TRAFFIC STATUS Central-----in real time result--json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("Central json downloading in progres........4......-INSIDE TRAFFIC STATUS--.")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            
            print("---5457--------")
            print(json?.description)
            print("Central in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
            
            
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
       
        print("--------test")
        trafficStatusDict = json as! NSDictionary
        
        //getTrips(convertedJsonIntoNSDict)
        print("-Central INSIDE TRAFFIC STATUS---6-----convertedJSON is being printed = \(trafficStatusDict.allKeys)")
        print("--Central INSIDE TRAFFIC STATUS--.....before----dataSourceTrafficStatus count before adding--= \(dataSourceTrafficStatus.count)")
        dataSourceTrafficStatus.removeAllObjects()
        
        if (trafficStatusDict.count == 0){
            print("taffic status Central dict count is 0----")
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
                print("traffic status Central : ResponseData. Traffic Types ")
                //=\((trafficStatusDict["ResponseData"]!["TrafficTypes"] as! NSArray).count)")
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
                
                print("--traffic status Central-going to leave from real time result view controller")
                
                // means every thing is fine so go ahead
                // tableData.setValue(StatusCode, forKey: "statusCode")
                print(trafficStatusDict.allKeys)
                print("---98789-Central---traffic statustrafficStatusDict.allKeys =\(trafficStatusDict.allKeys)-")
                
                print("--Central dataSourceTrafficStatususDict------")
                
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
       // self.tableView.reloadData()
        
        print("-after-Central---tabledata count AFTER-dataSourceTrafficStatus\(dataSourceTrafficStatus.count)")
        
        
        print("-after--Central--tabledata count AFTER-= \(trafficStatusDict.count)")
        
    }
}

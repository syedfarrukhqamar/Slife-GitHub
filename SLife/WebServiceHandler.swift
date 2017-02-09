//
//  WebServiceHandler.swift
//  SLife
//
//  Created by syed farrukh Qamar on 06/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//
import UIKit
import AVFoundation

//-------------there are four methods associated with this key
//Trip:
//Räknar ut en resa från en startpunkt till en destination. Dessa kan vara stations-id eller koordinater baserade på adresser eller ”intressepunkter.
//JourneyDetail:
//Returnerar detaljerad information om en del av en resa med ett fordon.
//Den returnerar en lista på alla stop/stationer inklusive alla ankomst- och avgångstider med realtidsdata(om det finns tillgängligt).
//Geometry:
//Returnerar en linje med WGS84 koordinater som kan användas för att rita ut en resa på en karta.
//XSD:
//Returnerar en xsd för ovanstående service-svar

let sl_Api_url = "https://api.sl.se/api2/TravelplannerV2/"
//---Methods
let tripMethod = "trip"
let journeyMethodMethod = "JourneyDetail"
let geometryMethod = "Geometry"
let xsdMethod = "XSD"

let xmlType = ".xml?"
let jsonType = ".json?"
let key = "92cbcaa8387c44e3be686f7dd4a1fd32"

// list of supporting parameters
let keyID = "key="
let originID = "&originId="
let destinationID = "&destId="
let searchForArrivalID = "&searchForArrival="

//---from/ to web handler constants or variables
let url_from_to_1 = "https://api.sl.se/api2/typeahead.json?key="
let keyID_SL_plats_from_to_2 = "0b0656ad5c1d4a47a79dd668cb5f9d79"
let searchString_from_to_3 = "&searchstring="
// then the parameter will be added here
let stationOnly_from_to_5 = "&stationsonly="

// URL variables for SL RealTidInformation
let urlRealTidInfo_URL_Start_A = "https://api.sl.se/api2/realtimedepartures"
let format_specifier_B = "<FORMAT>"
let key_keyWord_C = "key="
let key_RealTime_D = "d5e447f563d0462e8384f8ae7a133492"
let url_part_E = "&siteid="
let site_ID_F = "<SITEID>"
let url_part_G = "&timewindow="
let time_Window_parameter_H = "<TIMEWINDOW>"

//-------Advanced Parameters---will come here
//---------------------Via
let viaId_Param_Name = "&viaId="
let viaStopOverMinutes_Param_Name = "&viaStopOver="

//-----Search for arrival
let searchForArrival_Param_Name = "&searchForArrival="  // default value is 0 (possible values are 0/1)

//----Date & Time
let date_Param_Name = "&date="  // YYYY-MM-DD
let Time_Param_Name = "&Time=" // HH:MM

// Real Time Data
let realtime_Param_Name = "&realtime=" // Default value is false
//let realtime_Param_Value = "false"
//-- Allow Alternative Stops

let  allowAlternativeStops_Param_Name = "&unsharp="

// Transport Type (Modes) Exclude Traffic Types by 0/1
let useTrain_Param_Name = "&useTrain="
let useMetro_Param_Name = "&useMetro="
let useTram_Param_Name = "&useTram="
let useBus_Param_Name = "&useBus="
let useFerry_Param_Name = "&useFerry="
let useShip_Param_Name = "&useShip="

let useTrain_Param_Value = "1"
let useMetro_Param_Value = "1"
let useTram_Param_Value = "1"
let useBus_Param_Value = "1"
let useFerry_Param_Value = "1"
let useShip_Param_Value = "1"

// Line Choices

let lineChoices_Inc_Param_Name = "&lineInc="
let lineChoices_Exc_Param_Name = "&lineExc="

// WALK AWAY-- Walking Distance in Meters
let walkaway_Param_Name = "&maxWalkDist="

// Transport Changes 
let transportChanges_Param_Name = "&numChg="
let transportChangesTime_Param_Name = "&minChgTime="


class WebServiceHandler {

    // construct url for advanced parameter screens
    
    func constructAdvancedURL ( methodName: String , origin : String , destination : String , returnContentType : String , searchForArrival : String ,tripDate: String, tripTime: String)-> String
    {
        //var finalisedURLtoConnectConstruct = NSURL()
        print("---webservice handler------0--------")
        
        var finalisedURLtoConnectConstruct = String()
        finalisedURLtoConnectConstruct  = sl_Api_url
        finalisedURLtoConnectConstruct += methodName
        finalisedURLtoConnectConstruct += returnContentType
        finalisedURLtoConnectConstruct += keyID
        finalisedURLtoConnectConstruct += key
        // parameter static value- origin
        finalisedURLtoConnectConstruct += originID
        finalisedURLtoConnectConstruct += origin
        // parameter static value- destination id
        finalisedURLtoConnectConstruct += destinationID
        finalisedURLtoConnectConstruct += destination
        // parameter static value- search arrivals
        finalisedURLtoConnectConstruct += searchForArrivalID
        finalisedURLtoConnectConstruct += searchForArrival
        //------Advanced Options---Start
        // ----VIA + stop over minutes
        if (advancedOptionsFlag == true ){
            print("Advance flag is true.......")
        if (viaStationFlag == true){
            print("via station flag is true")
            print("via station id = \(via_StationId)")
            finalisedURLtoConnectConstruct += viaId_Param_Name
            finalisedURLtoConnectConstruct += via_StationId
            // check for stop over minutes if flag is yes then add it as well
            print("stop over flag = \(viaStopOverMinutesFlags)")
            print("stop over Minutes = \(stopOverMinutes)")
            if ( viaStopOverMinutesFlags == true){
            // stopOverMinutes add stop over minutes param name
            finalisedURLtoConnectConstruct += viaStopOverMinutes_Param_Name
                // add stop over minutes values
            finalisedURLtoConnectConstruct += String(stopOverMinutes)
            }
            }
        else {
            print("via station flag is false")
        }
        // MARK: Advance Date Options
        //------Depart Now/ Depart Earliest / Arrival At
            if (earliestDepartLatestArrival_flag == true){
            print("earliestDepartLatestArrival_Value = \(earliestDepartLatestArrival_Value)")
                if(earliestDepartLatestArrival_Value == 1){
                finalisedURLtoConnectConstruct += searchForArrival_Param_Name
                finalisedURLtoConnectConstruct += String(earliestDepartLatestArrival_Value)
                }
                finalisedURLtoConnectConstruct += date_Param_Name
                finalisedURLtoConnectConstruct += expectedTripDate
                finalisedURLtoConnectConstruct += Time_Param_Name
                finalisedURLtoConnectConstruct += expectedTripTime
                print("date_Param_Name==\(date_Param_Name)")
                print("expectedTripDate==\(expectedTripDate)")
                print("Time_Param_Name==\(Time_Param_Name)")
                print("Time_Param_Name==\(Time_Param_Name)")
                print("expectedTripTime==\(expectedTripTime)")
                
            } else {
            
            print("time/ Date is selected as NOW")
            }
        }
        print("Web service Advanced URL date time = \(finalisedURLtoConnectConstruct)")
        //----Realtime or time table
        
        print("Realtime Flag was: \(realTimeFlag)")
        if (realTimeFlag == true){
         finalisedURLtoConnectConstruct += realtime_Param_Name
          finalisedURLtoConnectConstruct += "true"
        
        } else {
        print("Time Table data required")
        
        }
        // Transport modes
        
        if (transportTypesFlag == true){
        
        // iterate through the dict and add it
            
            for (key,value) in transportModeDict {
                
                let str = value as! String
                finalisedURLtoConnectConstruct += "&" + str + "="
                finalisedURLtoConnectConstruct += "0"
                print("key = \(key)")
                print("Value = \(value)")
            }
        
        
        
        }
        
        // line numbers exclude and include
        
        if (lineChoicesFlag == true)
        {
        
            finalisedURLtoConnectConstruct += "&" + lineChoiceIncludeOrExclude + "="
            finalisedURLtoConnectConstruct += lineChoices
            
        print(":::::::line choices = \(lineChoices)")
            
            print(":::::::lineChoiceIncludeOrExclude  = \(lineChoiceIncludeOrExclude)")
        }
        // transport changes
        
        if (transportChangesFlag == true){
        
            if (maxTransportChanges == 0){
            // no restrictions if equals to 0
             // do nothing
            
            
            } else if (maxTransportChanges > 0 ){
            
            let changes = maxTransportChanges - 1
                
                finalisedURLtoConnectConstruct += transportChanges_Param_Name
            
                finalisedURLtoConnectConstruct += String(changes)
             }
            if (extraTimeFlag == true)
            {
            finalisedURLtoConnectConstruct += transportChangesTime_Param_Name
                if (extraTimeBetweenTransportChanges == 0){
                // 2
            finalisedURLtoConnectConstruct += "2"
                } else if (extraTimeBetweenTransportChanges == 1){
                // 5
                finalisedURLtoConnectConstruct += "5"
                }
                else if (extraTimeBetweenTransportChanges == 2){
                    
                   // 10
                    finalisedURLtoConnectConstruct += "10"
                    
                }

                else if (extraTimeBetweenTransportChanges == 3){
                    // 15
                    finalisedURLtoConnectConstruct += "15"
                    
                    
                }

            }
            
        }
        
        //-----Advanced Options------End
        print("---webservice handler------2--------")
        
        print("----------------finalised URL To Connect Construct is --------------Start---")
        print(finalisedURLtoConnectConstruct)
        print("----------------finalised URL To Connect Construct is --------------End---")
        
        return finalisedURLtoConnectConstruct
        //  return NSMutableURLRequest(URL: NSURL(String: finalisedURLtoConnectConstruct))
    }
    
    
    // function Construct URL
    // parameters will contain the parameter ids and their values. so the function will only concatenate them
    // construct URL function will be responsible for creating the URL
    
    //----SL Reseplanerare 2-------URL----1
    func constructURL ( methodName: String , origin : String , destination : String , returnContentType : String , searchForArrival : String )-> String
{
    //var finalisedURLtoConnectConstruct = NSURL()
    print("---webservice handler------0--------")
    var finalisedURLtoConnectConstruct = String()
       finalisedURLtoConnectConstruct  = sl_Api_url
       finalisedURLtoConnectConstruct += methodName
       finalisedURLtoConnectConstruct += returnContentType
    finalisedURLtoConnectConstruct += keyID
    
       finalisedURLtoConnectConstruct += key
    // parameter static value- origin
       finalisedURLtoConnectConstruct += originID
       finalisedURLtoConnectConstruct += origin
    
    // parameter static value- destination id
       finalisedURLtoConnectConstruct += destinationID
    finalisedURLtoConnectConstruct += destination
    // parameter static value- search arrivals
    finalisedURLtoConnectConstruct += searchForArrivalID
       finalisedURLtoConnectConstruct += searchForArrival
    print("---webservice handler------2------\(simple_earliestDepartLatestArrival_flag)--")

    // MARK: Simple Date Options
    //------Depart Now/ Depart Earliest / Arrival At
    
    if (simple_earliestDepartLatestArrival_flag == true){
        
        print("Simple----earliestDepartLatestArrival_Value = \(simple_earliestDepartLatestArrival_Value)")
        if(simple_earliestDepartLatestArrival_Value == 1){
            finalisedURLtoConnectConstruct += searchForArrival_Param_Name
            finalisedURLtoConnectConstruct += String(simple_earliestDepartLatestArrival_Value)
        }
        print("Departure time selected...........")
        print("\(date_Param_Name)")
         print("simple_expectedTripDate....\(simple_expectedTripDate)")
         print("Time_Param_Name...\(Time_Param_Name)")
         print("simple_expectedTripTime......\(simple_expectedTripTime)")
        finalisedURLtoConnectConstruct += date_Param_Name
        finalisedURLtoConnectConstruct += simple_expectedTripDate
        finalisedURLtoConnectConstruct += Time_Param_Name
        finalisedURLtoConnectConstruct += simple_expectedTripTime
        
    } else {
        
        print("Simple Screen: time/ Date is selected as NOW")
    }
    
    //----Realtime or time table
    print("RealTimeFlag values ie being received as = \(realTimeFlag)")
    if (realTimeFlag == false){
        print("Data Required from time Table:")
    } else {
        
        finalisedURLtoConnectConstruct += realtime_Param_Name
        finalisedURLtoConnectConstruct += "true"
        
        print("RealTime data is required:\(realTimeFlag)")
        
    }
    // checking ends of flags in the simple screen
    
    print("---Simple-------------finalised URL To Connect Construct is --------------Start---")
    print(finalisedURLtoConnectConstruct)
    print("----------------finalised URL To Connect Construct is --------------End---")
   
    return finalisedURLtoConnectConstruct
  //  return NSMutableURLRequest(URL: NSURL(String: finalisedURLtoConnectConstruct))
}
    
    //----SL Platsuppslag-------URL-----2
    //
   static func constructURL_Sl_plats ( searchString: String, stationOnly: Bool )-> String
    {
        //var finalisedURLtoConnectConstruct = NSURL()
        print("---webservice handler------111---from to-----")
        var finalisedURLtoConnectConstruct = String()
        finalisedURLtoConnectConstruct  = url_from_to_1
        finalisedURLtoConnectConstruct += keyID_SL_plats_from_to_2
        finalisedURLtoConnectConstruct += searchString_from_to_3
        finalisedURLtoConnectConstruct += searchString
        finalisedURLtoConnectConstruct += stationOnly_from_to_5
        
        finalisedURLtoConnectConstruct += String(stationOnly)
        // checking with flags in the simple screen
        
        
        
        print("from to url value is =\(finalisedURLtoConnectConstruct)")
        return finalisedURLtoConnectConstruct
        //  return NSMutableURLRequest(URL: NSURL(String: finalisedURLtoConnectConstruct))
    }
    // -------SL Realtidsinformation 3-----URL------3
    
    static func constructURL_SL_Realtidsinformation_3 ( siteID: String, timeWindow: String )-> String
    {
        //var finalisedURLtoConnectConstruct = NSURL()
        print("---webservice handler------111--------")
        var finalisedURLtoConnectConstruct = String()
        
        finalisedURLtoConnectConstruct  = urlRealTidInfo_URL_Start_A
        finalisedURLtoConnectConstruct += jsonType
        finalisedURLtoConnectConstruct += key_keyWord_C
        finalisedURLtoConnectConstruct += key_RealTime_D
        finalisedURLtoConnectConstruct += url_part_E
            
        finalisedURLtoConnectConstruct += siteID
        finalisedURLtoConnectConstruct += url_part_G
        
        finalisedURLtoConnectConstruct += timeWindow
        
        
        //finalisedURLtoConnectConstruct += String(stationOnly)
        print("--------SL Realtidsinformation 3--------=\(finalisedURLtoConnectConstruct)")
        return finalisedURLtoConnectConstruct
        //  return NSMutableURLRequest(URL: NSURL(String: finalisedURLtoConnectConstruct))
    }
    
    
    
    
    
    
    //--------getting data new way
    
    func get_data_from_url(url:String)
    {
        
        
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            
           // DispatchQueue.main.asynchronously(execute: {
           
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData)
                return
            })
            
        }
        
        task.resume()
        
    }
    
    
    func extract_json(jsonData:NSData)
    {
        let json: AnyObject?
        do {
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
        } catch {
            json = nil
            return
        }
    }

//
//        if let list = json as? NSArray
//        {
//            for (var i = 0; i < list.count ; i++ )
//            {
//                if let data_block = list[i] as? NSDictionary
//                {
//                    
//                    TableData.append(datastruct(add: data_block))
//                }
//            }
//            
////            do
////            {
////                try read()
////            }
////            catch
////            {
////            }
////            
////            do_table_refresh()
//            
//        }
//        
        
        
   // }

    
    
    
    //-----------getting data new way ended here
    // MARK Functions2: callSLService function will be the communication manager
    // responsibility includes contacting the sl website and get the response
    
 /*
     func getSLService(finalisedURLtoConnect_string: String)-> NSDictionary{
    var contentToParseConstruct = NSDictionary()
         var requestedResponse = NSDictionary()
        //----------request will be constructed and executed here
        
        var request = NSMutableURLRequest(URL: NSURL(string: finalisedURLtoConnect_string)!)
     
        
//        var request = NSMutableURLRequest(URL: NSURL(string: "https://api.sl.se/api2/TravelplannerV2/trip.json?key=92cbcaa8387c44e3be686f7dd4a1fd32&originId=9181&destId=3432&searchForArrival=0")!)
//     //   var request = NSMutableURLRequest(URL: NSur)
        //------temp
       // var request = finalisedURLtoConnect
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
           
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoNSDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    // Print out dictionary
                    print("-----------------convertedJsonIntoNSDict")
                    // print("descryption="+convertedJsonIntoDict.description)
                    
                    print(" converted json count-NS Dictionary= \(convertedJsonIntoNSDict["TripList"]?.count)")
                    
//                     print(" Accessing TripList Array's 2 members = \(convertedJsonIntoNSDict["TripList"]![0])")
//                    print(" Accessing TripList Array's 2 members = \(convertedJsonIntoNSDict["TripList"]![1])")
                    
                    let types = convertedJsonIntoNSDict["TripList"]!["Trip"] as? NSArray
                    print(" -99999-----------NS Array-------------------------------------99999-")
                    print(types?.count)
                    print("-----989-\(types?[0])")
                    print("-----676-\(types?[0].count)")
                    print("---dur--676-\(types?[0]["dur"])")
                    
                    
                    print(types?[0].allKeys)
                    print("dur=\(types?[0]["dur"])")
                    print("LegList.Duration=\(types?[0]["LegList"]!!["Leg"]!!.count)")
                    print(" -1111------------------------------------------------99999-")
                    print(types?[0].objectForKey("LegList")?.count)
                    print(" -1111------------------------------------------------99999-")
                    print(types?[0].objectForKey("LegList")?.objectForKey("Leg")?[0])
                    
                    print(" -1222------------------------------Destination------------------99999-")
                    //   print(types?[0].objectForKey("LegList")?.objectForKey("Leg")![0]swx hny)
                    print(" -3333------------------------------------------------99999-")
                    // Get value by key
                    print("---------------12343-------111")
                    // gaurd   let firstNameValue = convertedJsonIntoDict["TripList"] as? String
                  //  print(firstNameValue!)
                    
                    requestedResponse = convertedJsonIntoNSDict

                    print("--convertedJsonIntoNSDict.allKeys--------------\(convertedJsonIntoNSDict.allKeys)")
                 //   print("--requestedResponse.allkeys--------------\(requestedResponseRoman.allKeys)")
                    
                                    }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
       
        
        // temp code for asynch dispatching request
            dispatch_async(dispatch_get_main_queue(), {
                self.extract_json(data!)
                return
            })

            
            
        }
        
        
        
        
        task.resume()
        //______ request ended here. the response must be sent back
        print("--returning with --------requestedResponse.allkeys--------------\(requestedResponse.allKeys)")
        
    return requestedResponse
        
    }
 */
    // MARK Function3
    // parse the content by recieving content as xml or json object,recieve the format object so that the parsed data can be sent back in simple array two dimensional with key values pair coding
    func parseXMLorJSONtoArray (forView: String )-> [ String : String] {
    
    var dataSource = [ String : String]()
    
    
    return dataSource
    
    
    
    }
    
    
    
    

}

     

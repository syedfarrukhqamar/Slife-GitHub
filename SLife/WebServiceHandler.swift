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

class WebServiceHandler {

    
    // function Construct URL
    // parameters will contain the parameter ids and their values. so the function will only concatenate them
    // construct URL function will be responsible for creating the URL
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
    print("---webservice handler------2--------")

    print("----------------finalised URL To Connect Construct is --------------Start---")
    print(finalisedURLtoConnectConstruct)
    print("----------------finalised URL To Connect Construct is --------------End---")
   
    return finalisedURLtoConnectConstruct
  //  return NSMutableURLRequest(URL: NSURL(String: finalisedURLtoConnectConstruct))
}
    
    
    
    //--------getting data new way
    
    func get_data_from_url(url:String)
    {
        
        
        let url:NSURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.extract_json(data!)
                return
            })
            
        }
        
        task.resume()
        
    }
    
    
    func extract_json(jsonData:NSData)
    {
        let json: AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
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

     
//
//  tripSuggestions.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

class tripSuggestions: UIViewController{
var convertedJsonIntoNSDict = NSDictionary()
    
    
    var from = String()
    var to = String()
    var searchForArrivals = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var searchTrips = WebServiceHandler()
        let url = searchTrips.constructURL("Trip", origin: "kista", destination: "centralen", returnContentType: jsonType, searchForArrival: "0")
        
        print("-------------------url----\(url)")

        get_data_from_url(url)
        print("-----------------------ended--090")
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//----web service handler functions and parsing-----start

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
            extract_json(data!)
            print("-----about to return after parsing")
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
    
     convertedJsonIntoNSDict = (json as? NSDictionary)!
    print("--------convertedJSON is being printed = \(convertedJsonIntoNSDict)")
}

//----web service handler functions and parsing-----End


//func application(application: UIApplication!, performFetchWithCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
//    loadShows() {
//        completionHandler(UIBackgroundFetchResult.NewData)
//        print("Background Fetch Complete")
//    }
//}
//
//func loadShows(completionHandler: (() -> Void)!) {
//    //....
//    //DO IT
//    //....
//    completionHandler()
//}
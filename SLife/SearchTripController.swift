//
//  FirstViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

class SearchTripController: UIViewController {
    //    @IBAction func searchTrip(sender: UIButton) {
    //    }
    
    // to be implemented the ajax function later
    // implement the ajax function later
    @IBOutlet weak var from: UITextField!
    
    @IBOutlet weak var to: UITextField!
    
    var fromDestinationSearchTrip = "centralen"
    var toDestinationSearchTrip = "kista"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----here.-.--.-.")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("---------------------------1---------------\(segue.identifier)--")
        //--------------completion handler is coming
           //------tring with completion handler
        
        
//        typealias CompletionHandler = (success:Bool) -> Void
//        
//        func downloadFileFromURL(url: NSURL,completionHandler: CompletionHandler) {
        
            // download code.
            
            // Do any additional setup after loading the view, typically from a nib.
//            print("---------0--------")
//            var searchTrips = WebServiceHandler()
//        searchTrips.constructURL("Trip", origin: "kista", destination: "centralen", returnContentType: jsonType, searchForArrival: "0")
//            //            searchTrips.constructURL("Trip", origin: "kista", destination: "centralen", returnContentType: jsonType, searchForArrival: "")
//            print("---------2--------")
//            
//            var requestedResponse = searchTrips.getSLService(searchTrips.constructURL("Trip", origin: "kista", destination: "centralen", returnContentType: jsonType, searchForArrival: "0"))
//            print("---requestedResponse.count------------pringting the response from requested url---------")
//            // print("-90909090909---\(requestedResponse.allKeys)")
//            print("----------------pringting the response from requested url------90909---")
//            
        
            
//            let flag = true // true if download succeed,false otherwise
//            
//            completionHandler(success: flag)
//        }
//        
//        // How to use it.
//        
//        downloadFileFromURL(NSURL(string: "url_str")!, completionHandler: { (success) -> Void in
//            
//            // When download completes,control flow goes here.
//            if success {
//                // download success--if success then move to trip suggestions else move or show message of failure
        
        if (segue.identifier == "tripSuggestions" || segue.identifier == "tripSuggestionsNew"){
            
            
            print("---------------------------2-----------------")
                    
                    segue.destinationViewController.setValue(from.text!, forKey: "from")
                    segue.destinationViewController.setValue(to.text!, forKey: "to")
                    
                    segue.destinationViewController.setValue("0", forKey: "searchForArrivals")
                }
//                print("success-------")
//            } else {
//                // download fail
//                print("fail-------")
//                
//            }
//        })
        
       }
}



//
//  FirstViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

// old
/*
let FROM_ORIGIN = "From"
let TO_DESTINATION = "To"
let VIA_DESTINATION = "Via"
var from_to_flag = String()
var advancedOptionsFlag = false
var origin = "From"
var origin_StationId = String()
var destination = "To"
var destination_StationId = String()
var via = "Via"
var via_StationId = String()
*/



class SearchTripController: UIViewController,UITableViewDelegate,UISearchBarDelegate {
    var fromStation_SiteId = String()
    var toStation_SiteId = String()
    
    //let DEFAULT = "Default"
   

    @IBOutlet weak var from_Origin_Input: UIButton!
    
    @IBOutlet weak var to_destination_Input: UIButton!
    
//    @IBOutlet weak var From: UITextField!
//    @IBOutlet weak var To: UITextField!
 
    //@IBOutlet weak var Text: UITextField!
    
    
//    @IBOutlet weak var From: UILabel!
//    @IBOutlet weak var To: UILabel!
    
   // @IBOutlet weak var To: UIButton!
    //@IBOutlet weak var From: UIButton!
    //    @IBAction func searchTrip(sender: UIButton) {
    //    }
    
    // to be implemented the ajax function later
    // implement the ajax function later
   // @IBOutlet weak var from: UITextField!
    
    //@IBOutlet weak var to: UITextField!
    
    var fromDestinationSearchTrip = "centralen"
    var toDestinationSearchTrip = "kista"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-view did apear----here.-.--.-.")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear--------------")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("-selected index path-----viewWillAppear----)")
        print("from to flag = \(from_to_flag)")
        print("station.site_id= \(station.site_id)")
        
        print("from_to_value=\(from_to_value)")
       // print("from_Origin_Input.titleLabel = \(from_Origin_Input.titleLabel?.text!)")
      
        if (from_to_flag == FROM_ORIGIN){
            origin = from_to_value
        from_Origin_Input.setTitle(origin, for: .normal)
            
            // = from_to_value
            
            print("from value is = \(from_to_value)")
            origin_StationId = station.site_id
            
        
        } else if (from_to_flag == TO_DESTINATION){
     
            destination = from_to_value
            to_destination_Input.setTitle(destination, for: .normal)
            print("to value is in search trip controller = \(from_to_value)")
            destination_StationId = station.site_id
        }
        from_Origin_Input.setTitle(origin, for: .normal)
        to_destination_Input.setTitle(destination, for: .normal)
        
        print("1) from_Origin_Input.titleLabel = \(from_Origin_Input.titleLabel?.text!)")
        print("origin = \(origin.debugDescription)")
        print("-station.site_id-----\(station.site_id)")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("---------------------------1---------------\(segue.identifier)--")
        advancedOptionsFlag = false
        
        if (segue.identifier == "From") {
        print("from segue has been caught")
        from_to_flag = FROM_ORIGIN
        
        }
        else if (segue.identifier == "To"){
            from_to_flag = TO_DESTINATION
            print("to has been caught")


        }
        
       
        if (segue.identifier == "tripSuggestions" || segue.identifier == "tripSuggestionsNew") || (segue.identifier == "withHeader") {
            print("-----------fromStation_SiteId---\(origin_StationId)-------------2-----------------")
            print("-----------toStation_SiteId---\(destination_StationId)-------------2-----------------")
            segue.destination.setValue(origin_StationId, forKey: "from")
            segue.destination.setValue(destination_StationId, forKey: "to")
            // now reset the values of from and to
//            
//            fromStation_SiteId = ""
//            toStation_SiteId = ""
//            from_Origin_Input.setTitle("Test", forState: .Normal)
//            to_destination_Input.setTitle("", forState: .Normal)
//            from_to_value = ""
            
//                    segue.destinationViewController.setValue(from_Origin_Input.titleLabel, forKey: "from")
//                    segue.destinationViewController.setValue(to_destination_Input.titleLabel, forKey: "to")
//                    
                    segue.destination.setValue("0", forKey: "searchForArrivals")
                }
//                print("success-------")
//            } else {
//                // download fail
//                print("fail-------")
//                
//            }
//        })
        
       }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
     func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("some thing has been selected -------")
    }
    
}



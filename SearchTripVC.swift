//
//  FirstViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

class SearchTripVC: UIViewController {
//    @IBAction func searchTrip(sender: UIButton) {
//    }
    
    // to be implemented the ajax function later
    // implement the ajax function later
    
    
    var fromDestinationSearchTrip = "centralen"
    var toDestinationSearchTrip = "kista"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        print("---------------------------1-----------------")
        
        if (segue.identifier == "tripSuggestions"){
            print("---------------------------2-----------------")
     
            segue.destinationViewController.setValue("kista", forKey: "from")
            segue.destinationViewController.setValue("central", forKey: "to")
            
            segue.destinationViewController.setValue("0", forKey: "searchForArrivals")
        }
    }
}



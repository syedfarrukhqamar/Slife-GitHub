//
//  TripInfoCollectionViewCell.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-30.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit

class TripInfoCollectionViewCell: UICollectionViewCell {
    // dep related variables
    var sectionInfo = String()
    var rowInfo = String()
    var keyName = String()
    var showHideDepartureCell_Master = false
    var legTag = Int()
    var lineDistTag = Int()
    var departuresLoadedNext = false
    // OUTLETS
    
    @IBOutlet weak var nextDepartureCL: UIButton!
      @IBOutlet weak var intermediateStops: UIButton!
    @IBOutlet weak var nextDepTillDestination: UIButton!
     @IBOutlet weak var towards: UILabel!
    @IBOutlet weak var rtuMessage: UILabel!
    
    @IBOutlet weak var transportTypeOutlet: UILabel!
    
    @IBOutlet weak var legImage: UIImageView!
    @IBOutlet weak var from_time: UILabel!        // 1
    @IBOutlet weak var from_station: UILabel!
    
    
   // @IBOutlet weak var name: UILabel!             // 4
    // for Walk. "Walk will be the string" for travel "mot or towards" will be placed
   // @IBOutlet weak var towards_or_walk:UILabel!   // 4.5
    //----------for Walk. dist will be placed
    //----------for Travel.Line will be placed
    @IBOutlet weak var line_dist:UILabel!         // 5
    //    @IBOutlet weak var name: UILabel!
    //-----------------Destination
    @IBOutlet weak var to_time: UILabel!          // 6
    @IBOutlet weak var to_station: UILabel!
}

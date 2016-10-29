//
//  TripIntermediateStops.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class TripIntermediateStops : UITableViewCell {
    //-----------------Origin
   
@IBOutlet weak var intermediateStopsImage: UIImageView!
@IBOutlet weak var from_time: UILabel!        // 1
@IBOutlet weak var from_station: UILabel!     // 2
    
//
//    
//    // visual Leg                                 // 3
//    @IBOutlet weak var name: UILabel!             // 4
//    // for Walk. "Walk will be the string" for travel "mot or towards" will be placed
//    @IBOutlet weak var towards_or_walk:UILabel!   // 4.5
//    //----------for Walk. dist will be placed
//    //----------for Travel.Line will be placed
//    @IBOutlet weak var line_dist:UILabel!         // 5
//    //    @IBOutlet weak var name: UILabel!
//    //-----------------Destination
//    @IBOutlet weak var to_time: UILabel!          // 6
//    @IBOutlet weak var to_station: UILabel!       // 7
//    
//    // @IBOutlet weak var duration: UILabel!
//    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//
//  TripSuggestionsCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class TripSuggestionsCell_new: UITableViewCell {
    
    
    @IBOutlet weak var PriceInfo: UILabel!
    @IBOutlet weak var from_time: UILabel!
    @IBOutlet weak var from_station: UILabel!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var to_station: UILabel!
    
    @IBOutlet weak var to_time: UILabel!
    
   
    @IBOutlet weak var sectionSelected: UIButton!
    @IBOutlet weak var mapReference: UIButton!
    
    @IBOutlet weak var showTripRouteOnMapOutlet: UIButton!
    @IBOutlet weak var ZoneInfo: UILabel!
    @IBOutlet weak var stack_LegImage_Icons: UIStackView!
    
//    @IBOutlet weak var from_time: UILabel!
//    @IBOutlet weak var from_station: UILabel!
//    
//    
//    @IBOutlet weak var to_time: UILabel!
//    @IBOutlet weak var to_station: UILabel!
//    
//    @IBOutlet weak var duration: UILabel!
//
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//
//  TripHeaderTripInfoTableViewCell.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-20.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit

class TripHeaderTripInfoTableViewCell: UITableViewCell {
    // variables to show hide legs
    
    @IBOutlet weak var from_time: UILabel!
    
    @IBOutlet weak var to_time: UILabel!
    @IBOutlet weak var to_station: UILabel!
    
    @IBOutlet weak var from_station: UILabel!
    @IBOutlet weak var duration: UILabel!
  //  @IBOutlet weak var PriceInfo: UILabel!
    
    @IBOutlet weak var showTripRouteOnMapOutlet: UIButton!
    @IBOutlet weak var PriceInfo: UILabel!
     @IBOutlet weak var sectionSelected: UIButton!
   @IBOutlet weak var mapReference: UIButton!
    @IBOutlet weak var tripDate: UILabel!
    /*
    var showWalk = true
    
    @IBOutlet weak var refresh_top_navigation: UIButton!
    
    @IBOutlet weak var refresh_next_navigation: UIButton!
    //  @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var PriceInfo: UILabel!
    @IBOutlet weak var from_time: UILabel!
    @IBOutlet weak var from_station: UILabel!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var to_station: UILabel!
    
    @IBOutlet weak var to_time: UILabel!
    
    
   
    @IBOutlet weak var mapReference: UIButton!
    
    @IBOutlet weak var showTripRouteOnMapOutlet: UIButton!
    @IBOutlet weak var ZoneInfo: UILabel!
    @IBOutlet weak var stack_LegImage_Icons: UIStackView!
    */
    
    //   done  @IBOutlet weak var from_time: UILabel!
    //  done  @IBOutlet weak var from_station: UILabel!
    //
    //
    // done    @IBOutlet weak var to_time: UILabel!
    //  done  @IBOutlet weak var to_station: UILabel!
    //
    //    @IBOutlet weak var duration: UILabel!
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // Configure the view for the selected state
    
    
    // Collection view binding
    
    //MARK:- Setup collectionView datasource and delegate
    
    
}

//
//  TripSuggestionsCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class LegListCells: UITableViewCell {
    
   // @IBOutlet weak var myCollectionView: UICollectionView!
    var sectionInfo = String()
    var rowInfo = String()
    var keyName = String()
    @IBOutlet weak var nextDeparturesOutlet: UIButton!
    //@IBOutlet weak var nextdepartures_Outlet: UIButton!
    @IBOutlet weak var nextDeparturesCollectionView: UICollectionView!
    
    //-----------------Origin
    @IBOutlet weak var rtuMessage: UILabel!
    
    @IBOutlet weak var transportTypeOutlet: UILabel!
   
     @IBOutlet weak var legImage: UIImageView!
    @IBOutlet weak var from_time: UILabel!        // 1
    @IBOutlet weak var from_station: UILabel!     // 2
    
    
    // visual Leg                                 // 3
    @IBOutlet weak var name: UILabel!             // 4
    // for Walk. "Walk will be the string" for travel "mot or towards" will be placed
    @IBOutlet weak var towards_or_walk:UILabel!   // 4.5
    //----------for Walk. dist will be placed
    //----------for Travel.Line will be placed
    @IBOutlet weak var line_dist:UILabel!         // 5
//    @IBOutlet weak var name: UILabel!
    //-----------------Destination
    @IBOutlet weak var to_time: UILabel!          // 6
    @IBOutlet weak var to_station: UILabel!       // 7
    
   // @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        nextDeparturesCollectionView.delegate = dataSourceDelegate
        nextDeparturesCollectionView.dataSource = dataSourceDelegate
        nextDeparturesCollectionView.tag = row
        nextDeparturesCollectionView.reloadData()
    }

    
}

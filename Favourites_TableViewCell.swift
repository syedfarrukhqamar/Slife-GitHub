//
//  Favourites_TableViewCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 03/08/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class Favourites_TableViewCell: UITableViewCell {

  //  @IBOutlet weak var from_fav_station_name: UILabel!
    @IBOutlet weak var from_fav_station_name: UILabel!
    @IBOutlet weak var to_fav_station_name: UILabel!
    @IBOutlet weak var keyName: UILabel!
    @IBOutlet weak var currentIndex: UILabel!
    @IBOutlet weak var from_station_id: UILabel!
    @IBOutlet weak var to_station_id: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

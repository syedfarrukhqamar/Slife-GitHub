//
//  TripSuggestionsCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class TripSuggestionsCell: UITableViewCell {

    @IBOutlet weak var from_time: UILabel!
    @IBOutlet weak var from_station: UILabel!
    
    
    @IBOutlet weak var to_time: UILabel!
    @IBOutlet weak var to_station: UILabel!
    
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

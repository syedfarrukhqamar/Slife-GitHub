//
//  NextDepartureHeaderTableViewCell.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-21.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit

class NextDepartureHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var nextDepartureGrabber: UIButton!
    @IBOutlet weak var to_station: UILabel!
    @IBOutlet weak var leg_number: UILabel!
    
    @IBOutlet weak var from_station: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

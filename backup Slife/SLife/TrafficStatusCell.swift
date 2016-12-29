//
//  TrafficStatusCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 29/07/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit


class TrafficStatusCell : UITableViewCell {
    
    
    @IBOutlet weak var busesStatusIcon: UIImageView!
    @IBOutlet weak var metroStatusIcon: UIImageView!
    @IBOutlet weak var lightRailStatusIcon: UIImageView!
    @IBOutlet weak var railTrainStatusIcon: UIImageView!
    @IBOutlet weak var tramStatusIcon: UIImageView!
    @IBOutlet weak var ferryStatusIcon: UIImageView!
    
    @IBOutlet weak var showBuses: UIButton!
    @IBOutlet weak var showMetro: UIButton!
    @IBOutlet weak var showLightRail: UIButton!
    @IBOutlet weak var showRail: UIButton!
    @IBOutlet weak var showTram: UIButton!
    @IBOutlet weak var showFerry: UIButton!
}
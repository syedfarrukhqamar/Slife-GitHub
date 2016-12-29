//
//  StopPointDeviations.swift
//  SLife
//
//  Created by syed farrukh Qamar on 12/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class StopPointDeviations {
  
  // 1 Stop Info. Can be empty. "Stop Info" are below
    var StopInfo : String
    // 1 Deviation. Can be empty. "Deviation" is below.
    var Avvikelse : String
    // Impact assessment for the current deviation
    var Consequences : String
    // 0 to 9 where 9 is the most serious
    var ImportanceLevel: String
    // Descryption of current Deviation
    var Text : String
    init() {
    StopInfo = String()
        Avvikelse = String()
        Consequences = String()
        ImportanceLevel = String()
        Text = String()
    }
}

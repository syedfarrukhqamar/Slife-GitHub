//
//  PendalTag.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class Trains {
    
    var SecondaryDestinationName: String //  Namn på delmål.
    
    var StopPointDesignation: String //  Ytterligare identifierare för stoppställe, t.ex. bokstav för busskur eller spår för pendeltåg.
    var realTimeCommonTransportModeInfo: RealTimeCommonTransportModeInfo
    init() {
        
        SecondaryDestinationName = String()
        StopPointDesignation = String()
        realTimeCommonTransportModeInfo = RealTimeCommonTransportModeInfo()
    }
    
    
    
    
    
}
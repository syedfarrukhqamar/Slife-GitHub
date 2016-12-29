//
//  LokalBana.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class Trams {
    
    var GroupOfLine: String //Linjegrupp, t.ex. “Tvärbanan” eller “Roslagsbanan”.
    
    var StopPointDesignation: String //  Ytterligare identifierare för stoppställe, t.ex. bokstav för busskur eller spår för pendeltåg.
    var realTimeCommonTransportModeInfo: RealTimeCommonTransportModeInfo
    
     init() {
        
        GroupOfLine = String()
        StopPointDesignation = String()
     realTimeCommonTransportModeInfo = RealTimeCommonTransportModeInfo()
    }
    
    
    
    
    
}
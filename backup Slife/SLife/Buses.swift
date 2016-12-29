//
//  Buses.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class Buses {
 
    // common variables
    
    var realTimeCommonTransportModeInfo: RealTimeCommonTransportModeInfo
   
    
    // special variables for this mode only
    var GroupOfLine: String //  Indicates if it is a blue bus. If there is a blue bus says "blåbuss", otherwise the string is empty.
    
    var StopPointDesignation: String //  Additional identifier for stopping point, eg letter for bus shelter or tracks for commuter trains.
   
    init() {
    
    realTimeCommonTransportModeInfo = RealTimeCommonTransportModeInfo()
    GroupOfLine = String()
    StopPointDesignation = String()
    
        //super.init()
    }
    


}
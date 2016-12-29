
//  TrafficType.swift
//  SLife
//
//  Created by syed farrukh Qamar on 16/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
class TrafficType {

    
    var trafficEvents: [TrafficEvent]
    var expanded: Bool //Hjälpinformation som indikerar om informationen har hög prioritet eller inte.
    var hasPlannedEvent: Bool //Hjälpinformation som indikerar om det finns planerade händelser.
    var id: Int
    var name: String //  Namn på trafikslag: "Tunnelbana", "Pendeltåg", etc.
    var statusIcon: String // Hjälpinformation som indikerar vilken ikon som ska visas i webben.
    var trafficStatus: String
    var type: String // "metro", "train", "local", "tram", "bus" eller "fer".
    
    
    init() {
        trafficEvents = [TrafficEvent]()
        expanded = Bool()
        hasPlannedEvent = Bool()
        id = Int()
        name = String()
        statusIcon = String()
        trafficStatus = String()
        type = String()
     
    
    }
// MARK Function to extract Traffic Type
    
    

}
//
//  TrafficEvent.swift
//  SLife
//
//  Created by syed farrukh Qamar on 16/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
class TrafficEvent {

    var eventId: Int //Löpnummer på händelsen.
    
    var message: String // Meddelande gällande störningen/händelsen.
    
    var expanded: Bool // Hjälpinformation som indikerar om informationen har hög prioritet eller inte.
    
    var planned: Bool //Hjälpinformation som indikerar om händelsen är planerad eller inte.
    
    var sortIndex: Int // Sorteringsordning på händelsen.
    
    var statusIcon: String //Hjälpinformation som indikerar vilken ikon som ska visas i webben.
    
    var lineNumbers: String //nLinjenummer som händelsen berör, en kommaseparerad String t.ex. ”177, 69K, 508”.
    
    var lineNumbersInputDataIsOptional: LineNumbersInputDataIsOptional //Är alltid satt till True och indikerar att linjenummer är frivilligt.
    
    var trafficLine: String // Namn på den bana som händelsen påverkar. Kan saknas, om händelsen påverkar hela trafikslaget eller banor inte finns (typ bussar).
    var eventInfoUrl: String //Länk till storningsinformation.sl.se, eller till specifik sida med information om händelsen.
    var status: String // not mentioned in the API
    
    
    init(){
    eventId = Int()
    message = String()
    expanded = Bool()
    planned = Bool()
    sortIndex = Int()
    sortIndex = Int()
    statusIcon = String()
    lineNumbers = String()
    lineNumbersInputDataIsOptional = LineNumbersInputDataIsOptional()
    trafficLine = String()
    eventInfoUrl = String()
    status = String()
        
    
    
    
    }
    
    
    // function extract traffic
}

//

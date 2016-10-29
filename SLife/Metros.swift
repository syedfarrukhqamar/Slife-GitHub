//
//  Tunnelbana.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation


class Metros {
    //Gruppering av metroavgångar per fysisk färdriktningsskylt på en plattform. T.ex. grön linje vid tcentralen har två riktningar. Denna parameter kommer ha 1 eller 2 för de olika riktningarna. Samma för röd och blå.
    var DepartureGroupId: Int
    
    //Destination för aktuell avgång.
    var Destination: String
    //Beräknad avgång från hållplatsen.
    
    var DisplayTime : String
    
    //Linjegruppering. Röd/grön/blå linje.
    var GroupOfLine : String
    
    
    // Linjegrupperingsid. Grön = 1. Röd = 2. Blå = 3.
    
    var GroupOfLineId : Int
    
    // Reseriktnings-id. Fungerar som DepartureGroupId.
    
    var JourneyDirection : String
    
    //Linjenummer för aktuell avgång.
    
    var LineNumber : String
    
    //     Informationsmeddelande för aktuell linjegrupp. Detta är det som syns på en riktig skylt på en plattform. T.ex. ”Vänligen lämna plats för avstigande..”.
    
    var PlatformMessage : String
    
    // Id för sökt hållplatsområde.
    
    var SiteId : Int
    
    
    // Hållplatsnamn.
    
    //TransportMode
    
    var StopAreaName : String
    
    
    // Trafikslag: ”METRO”.
    
    var TransportMode : String
    
    init() {
        DepartureGroupId = Int()
        Destination = String()
        DisplayTime =  String()
        GroupOfLine = String()
        GroupOfLineId = Int()
        JourneyDirection = String()
        LineNumber = String()
        PlatformMessage = String()
        SiteId = Int()
        StopAreaName = String()
        TransportMode = String()
        
    }
    
}

//
//  RealTimeCommonTransportModeInfo.swift
//  SLife
//
//  Created by syed farrukh Qamar on 05/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit

class RealTimeCommonTransportModeInfo: NSObject, NSCopying {

    var SiteID : Int //  Id pending stop area.
    var TransportMode :  String // Mode of operation: "BUS", "Train", "tram" or "Store"
    var StopAreaName :   String // Stop name
    var StopAreaNumber : Int            //The ID of the current station
    var StopPointNumber : Int       // Id current stopping point
    var LineNumber : String         // Line Designation / number
    var Destination :String         // End station of departure.
    var TimeTabledDateTime :String //Out on schedule.
    var ExpectedDateTime : String  //dateTime
   // var  ExpectedDeparture: String //If there is interference associated with a sufficiently high priority so this may have null / empty value. This produced a couple of minutes before departure.
    var DisplayTime: String // Out of presentation. Can adopt formats x min, HH: mm or now. If there is interference associated with a sufficiently high priority as this can have the value "-". This produced a couple of minutes before departure.
    var deviations : [Deviations] // watch our for List could be : Contains the type "Deviation" below. This can be empty or contain one of several deviations
    var JourneyDirection: Int // Travel directional Id.
   
//    init(TransportMode: String,StopAreaName: String,StopAreaNumber : Int,StopPointNumber: Int,LineNumber : String,Destination: String,TimeTabledDateTime :String,ExpectedDateTime : String,DisplayTime : String,Deviations : NSArray,JourneyDirection : Int )
//    {
    override init(){
        SiteID = Int()
    TransportMode = String()
    StopAreaName = String()
    StopAreaNumber = Int()
    StopPointNumber = Int()
    LineNumber = String()
    Destination = String()
    TimeTabledDateTime = String()
    ExpectedDateTime = String()
  //  ExpectedDeparture = String()
    DisplayTime = String()
    deviations = [Deviations]()
    JourneyDirection = Int()
    }
//    func copy(with zone: NSZone? = nil) -> Any {
//        code
//    }
         func copy(with zone: NSZone?) -> Any {

        var copy = RealTimeCommonTransportModeInfo()
        copy.SiteID = self.SiteID
        copy.TransportMode = self.TransportMode
        copy.StopAreaName = self.StopAreaName
        copy.StopPointNumber = self.StopPointNumber
        copy.LineNumber = self.LineNumber
        copy.Destination = self.Destination
        copy.TimeTabledDateTime = self.TimeTabledDateTime
        copy.ExpectedDateTime = self.ExpectedDateTime
        copy.DisplayTime = self.DisplayTime
        copy.deviations = self.deviations
        copy.JourneyDirection = self.JourneyDirection
        
        
//        let copy = RealTimeCommonTransportModeInfo(TransportMode: TransportMode, StopAreaName: StopAreaName, StopAreaNumber: StopAreaNumber, StopPointNumber: StopPointNumber, LineNumber: LineNumber, Destination: Destination, TimeTabledDateTime: TimeTabledDateTime, ExpectedDateTime: ExpectedDateTime, DisplayTime: DisplayTime, Deviations: Deviations, JourneyDirection: JourneyDirection)
//        
//        (SiteID: SiteID, TransportMode: TransportMode,StopAreaName :StopAreaName,StopAreaNumber:StopAreaNumber,StopPointNumber:StopPointNumber,LineNumber:LineNumber,Destination:Destination,TimeTabledDateTime:TimeTabledDateTime,DisplayTime:DisplayTime,Deviations:JourneyDirection)
        return copy
    }
}

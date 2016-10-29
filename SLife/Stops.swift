//
//  Stops.swift
//  SLife
//
//  Created by syed farrukh Qamar on 16/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//


class Stops
{
    
    var arrDate: String
    var arrTime: String
    var depDate: String
    var depTime: String
    var id : Int
    var lat: String
    var long: String
    var name: String
    var originOrDestination: String
    var routeIdx: Int
    var legIndex: String
    // adding highLevel info to be shown in the annotation
    var directionName: String
    var line: String
    var lineName: String
    
    init ()
    {
    
    self.arrDate = ""
    self.arrTime = ""
    self.depDate = ""
    self.depTime = ""
    self.id = 0
    self.lat = ""
    self.long = ""
    self.name = ""
    self.routeIdx = 0
    self.legIndex = ""
    self.originOrDestination = "Stop"
    self.directionName = ""
    self.line  = ""
    self.lineName = ""
        
        
    }
}
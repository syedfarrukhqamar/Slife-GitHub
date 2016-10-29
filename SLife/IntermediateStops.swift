//
//  IntermediateStops.swift
//  SLife
//
//  Created by syed farrukh Qamar on 16/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import AVFoundation
import UIKit

class IntermediateStops {
    
//    var directions = Directions(directionName: "", routeIdFrom: 0, routeIdTo: 0)
//    var GeometryRef = String()
//    var line_and_name = Lines(lineNumber: 0, lineName: "", routeIdFrom: 0, routeIdTo: 0)
//    var originStop = Stops(arrDate: "", arrTime: "", depDate: "", depTime: "", id: 0, lat: "", long: "", name: "", routeIdx: 0)
//    var destinationStop = Stops(arrDate: "", arrTime: "", depDate: "", depTime: "", id: 0, lat: "", long: "", name: "", routeIdx: 0)
//    var intermediateStops =  Stops(arrDate: "", arrTime: "", depDate: "", depTime: "", id: 0, lat: "", long: "", name: "", routeIdx: 0)
    var directions: Directions
    var geometryRef : String
    var line_and_name : Lines
    var originStop : Stops
    var destinationStop : Stops
    var intermediateStops : [Stops]
    var legIndex : Int
    init(){
        
        self.directions = Directions()
        self.geometryRef = ""
        self.line_and_name = Lines()
        self.originStop = Stops()
        self.destinationStop = Stops()
        self.intermediateStops = [Stops]()
        self.legIndex = Int()
        
    }
    
}
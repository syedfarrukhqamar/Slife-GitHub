//
//  StationsLocation.swift
//  SLife
//
//  Created by syed farrukh Qamar on 13/08/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//
import UIKit
import MapKit


class StationsLocation: NSObject, MKAnnotation {
    var identifier = "Station Locations"
    var title: String?
    var direction: String?
    var line: String?
    var departureTime: String?
    var annotationIndex: Int?
    var lineName: String?
    var lat: Double?
    var long: Double?

var coordinate: CLLocationCoordinate2D
    init(annotationIndex: Int, name:String,direction: String,line: String,lineName: String,departureTime: String , lat: Double, long: Double){
    self.annotationIndex = annotationIndex
    title = name
    self.direction = direction
        self.line = line
        self.departureTime = departureTime
        self.lineName = lineName
        self.lat = lat
        self.long = long
    coordinate = CLLocationCoordinate2DMake(lat, long)
    
    
    }



}

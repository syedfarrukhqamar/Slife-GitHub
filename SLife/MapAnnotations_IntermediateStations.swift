//
//  MapAnnotations_IntermediateStations.swift
//  SLife
//
//  Created by syed farrukh Qamar on 19/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import MapKit

class MapAnnotations_IntermediateStations: NSObject, MKAnnotation {
    
    let title: String?
    let stationName: String
    let transportType: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, stationName: String, transportType: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.stationName = stationName
        self.transportType = transportType
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return stationName
    }
}
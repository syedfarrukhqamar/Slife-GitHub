//
//  StationsLocationList.swift
//  SLife
//
//  Created by syed farrukh Qamar on 13/08/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//
import UIKit

class StationLocationLists: NSObject {
    var stationsLocation = [StationsLocation]()
    
    init(stationsLocation: [StationsLocation]){
         self.stationsLocation = stationsLocation
    
    
    }
}
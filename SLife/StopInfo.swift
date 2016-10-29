//
//  StopInfo.swift
//  SLife
//
//  Created by syed farrukh Qamar on 14/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class StopInfo {

    var groupOfLine: String
    var stopAreaName: String
    var stopAreaNumber: String
    var transportMode: String
    
    init (groupOfLine: String, stopAreaName: String,stopAreaNumber: String ,transportMode: String)
    
    {
    
    self.groupOfLine = groupOfLine
    self.stopAreaName = stopAreaName
    self.stopAreaNumber = stopAreaNumber
    self.transportMode = transportMode
        
    
    
    }
}
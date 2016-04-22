//
//  LegInfo.swift
//  SLife
//
//  Created by syed farrukh Qamar on 16/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation


class LegInfo {

    var name: String
    var type: String
    var idx: String
    var geometryRef: String
    
    init(name: String, type: String, idx: String,geomRef: String){
    
        self.name = name
        self.type = type
        self.idx = idx
        self.geometryRef = geomRef
    
    }


}
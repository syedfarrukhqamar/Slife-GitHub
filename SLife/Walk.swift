//
//  Walk.swift
//  SLife
//
//  Created by syed farrukh Qamar on 16/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class Walk: LegInfo {
    var dist: String
    var hide: String
    
    init(dist: String, hide: String, name: String, type: String, idx: String, geomRef: String) {
        self.dist = dist
        self.hide = hide
        super.init(name: name, type: type, idx: idx, geomRef: geomRef)
    }

}
//
//  LegTravel.swift
//  SLife
//
//  Created by syed farrukh Qamar on 20/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//


import Foundation

class LegTravel:LegDetail {
    
    var journeyType: String
    var travel : Travel
    
    //var travel: Dictionary<String,Travel> 
    // changing from dicitonary to direct saving technique because of redundancy
    
// journey type is being saved already so why to save again in trip suggestions tvc
    
    init(journeyType: String, legTravel:Travel, originValue: Address ,destinationValue: Address){
        
        self.journeyType = journeyType
        self.travel = legTravel
        
        super.init(origin: originValue, destination: destinationValue)
        
        
//init (origin: Address, destination: Address
    }
    
        
}




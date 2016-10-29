//
//  Deviations.swift
//  SLife
//
//  Created by syed farrukh Qamar on 14/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class Deviations {
    
    var consequences: String
    var improtanceLevel: Int
    var text: String
    init(consequences:String,importanceLevel:Int,text:String)
    {
        self.consequences = consequences
        self.improtanceLevel = importanceLevel
        self.text = text
    }






    func extractDeviations (deviations: NSArray)-> [Deviations] {
    
        var deviationsObjectsArray = [Deviations]()
        
        for deviations in deviations {
            
            let consequences = (deviations  as? [String:Any])? ["Consequences"] as! String
        let importanceLevel = (deviations  as? [String:Any])?["ImportanceLevel"] as! Int
        let text = (deviations  as? [String:Any])?["Text"] as! String
           
        let deviationsObject = Deviations(consequences: consequences, importanceLevel: importanceLevel, text: text)
        deviationsObjectsArray.append(deviationsObject)
        
        }
        
        return deviationsObjectsArray
    
    
    }
}

//
//  TrafficStatusMethods.swift
//  SLife
//
//  Created by syed farrukh Qamar on 17/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class TrafficStatusMethods {
    
    static func extractTrafficType (trafficTypes: NSArray)
        
    {
        let test = "Hi"
        var trafficTypeArray = trafficTypes as! NSArray
        
        for trafficTypeArray in trafficTypeArray
        {
            
            print("traffic types array being iterated = ")
            let trafficType = TrafficType()
            let traffictypeJsonDict = trafficTypeArray as! NSDictionary
            trafficType.expanded = traffictypeJsonDict["Expanded"] as! Bool
            
            print("trafficType.expanded--------\(trafficType.expanded)")
            
            if (trafficType.expanded == true){
                // iteration through Events
                
                let trafficEventsArray = traffictypeJsonDict["Events"] as! NSArray
                print("--trafficEventsArray.count--\(trafficEventsArray.count)")
                for trafficEventsArray in trafficEventsArray {
                    let trafficEventObject = TrafficEvent()
                    let trafficeventJsonDict = trafficEventsArray as! NSDictionary
                  
                    trafficEventObject.eventId = trafficeventJsonDict["EventId"] as! Int
                    
                    // check for Null
                    
                    trafficEventObject.eventInfoUrl = RealTidMethods.checkNullForString(someValue: trafficeventJsonDict, keyName: "EventInfoUrl")
                    
                    trafficEventObject.expanded = trafficeventJsonDict["Expanded"] as! Bool
                    if (trafficEventObject.expanded == true){
                    // extract line number
                        let lineNumberDict = trafficeventJsonDict["LineNumbers"] as! NSDictionary
                        trafficEventObject.lineNumbersInputDataIsOptional.inputDataIsOptional = RealTidMethods.checkNullForBool(someValue: trafficeventJsonDict, keyName: "InputDataIsOptional")
                        
                        print("----optional null lineNumbersInputDataIsOptional.inputDataIsOptional = \(trafficEventObject.lineNumbersInputDataIsOptional.inputDataIsOptional) ")
                        trafficEventObject.lineNumbersInputDataIsOptional.text = RealTidMethods.checkNullForString(someValue: trafficeventJsonDict, keyName: "Text")
                                        }
                    trafficEventObject.message = trafficeventJsonDict["Message"] as! String
                    trafficEventObject.planned = trafficeventJsonDict["Planned"] as! Bool
                    trafficEventObject.sortIndex = trafficeventJsonDict["SortIndex"] as! Int
                    // checking status for NULL value
                    trafficEventObject.status = RealTidMethods.checkNullForString(someValue: trafficeventJsonDict, keyName: "Status")
                    
                    trafficEventObject.statusIcon = trafficeventJsonDict["StatusIcon"] as! String
                  
                    print("---------message -.....---- = \(trafficEventObject.message)")
                    print("---------1010----statusIcon = \(trafficEventObject.statusIcon)")
                    
                    trafficEventObject.trafficLine = RealTidMethods.checkNullForString(someValue: trafficeventJsonDict, keyName: "TrafficLine")
                    
                    //trafficEventObject.eventId = trafficeventJsonDict["EventId"] as! Int
                    
                    print("trafficEventObject.eventId-----------\(trafficEventObject.eventId)")
                
                print("trafficEventObject.count = \(trafficEventObject)")
                // append trafficEventObject to the traffictype.trafficeventArray
                    
                    trafficType.trafficEvents.append(trafficEventObject)
                }
            }
            trafficType.hasPlannedEvent = traffictypeJsonDict["HasPlannedEvent"] as! Bool
            trafficType.id = traffictypeJsonDict["Id"] as! Int
            trafficType.name = traffictypeJsonDict["Name"] as! String
            
        //    trafficType.statusIcon = traffictypeJsonDict["StatusIcon"] as! String
            trafficType.statusIcon = RealTidMethods.checkNullForString(someValue: traffictypeJsonDict, keyName: "StatusIcon")
            print("-----trafficType.statusIcon--\(trafficType.statusIcon)")
            // check for null
            
            trafficType.trafficStatus = RealTidMethods.checkNullForString(someValue: traffictypeJsonDict, keyName: "TrafficStatus")
            
            trafficType.type = traffictypeJsonDict["Type"] as! String
            trafficType.hasPlannedEvent = traffictypeJsonDict["HasPlannedEvent"] as! Bool
            dataSourceTrafficStatus.add(trafficType)
            
           // dataSourceTrafficStatus.setValue(trafficType, forKey: trafficType.type)
           print("---dataSourceTrafficStatus-TYPE is = \(trafficType.type)-& Events count is -\(trafficType.trafficEvents.count)")
            print("------dataSourceTrafficStatus---all keys----\(dataSourceTrafficStatus.count)")
            print ("data source table data count is = \(dataSourceTrafficStatus.count)")
            
        }
    }

}

//
//  RealTidMethods.swift
//  SLife
//
//  Created by syed farrukh Qamar on 12/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

class RealTidMethods: AnyObject {
    // MARK Buses
    static func extractBuses    (jsonObject: NSArray){
        
        let busesArray = NSMutableArray()
        print("json buses count is =\(jsonObject.count)")
            if (jsonObject.count == 0){
        let buses = Buses()
                busesArray.add(buses)
        tableData.setValue(busesArray, forKey: BUSES)
        }
        else {
       let bus = jsonObject
       for bus in bus {
            let buses = Buses()
        let realTimeInfoCommonVariables = extractRealTimeCommonTransportInfo(realTimeCommonTransportDict: bus as! NSDictionary)
        buses.realTimeCommonTransportModeInfo = realTimeInfoCommonVariables.copy() as! RealTimeCommonTransportModeInfo
        print("buses.realtime common = \(realTimeInfoCommonVariables.Destination)")
        
        print("copied values = \(buses.realTimeCommonTransportModeInfo.Destination)")
        print(buses)
        
        if let stopPointDevCheckForNul = (bus as! NSDictionary)["StopPointDesignation"] as? String{
            buses.StopPointDesignation = stopPointDevCheckForNul
            
        }
        
        print("---buses-1-buses--\(buses)")
        busesArray.add(buses)
        
                }
        tableData.setValue(busesArray, forKey: BUSES)
        }
        print("root bus count would be = \(busesArray.count)")
        
    }
    
    
    // MARK Buses
    static func extractRealTimeCommonTransportInfo    (realTimeCommonTransportDict: NSDictionary)-> RealTimeCommonTransportModeInfo {
     let realTimeCommonVariables = RealTimeCommonTransportModeInfo()
            for (key,value) in realTimeCommonTransportDict {
                realTimeCommonVariables.SiteID = realTimeCommonTransportDict["SiteId"] as! Int
                realTimeCommonVariables.TransportMode = realTimeCommonTransportDict["TransportMode"] as! String
                realTimeCommonVariables.StopAreaName = realTimeCommonTransportDict["StopAreaName"] as! String
                realTimeCommonVariables.StopAreaNumber = realTimeCommonTransportDict["StopAreaNumber"] as! Int
                realTimeCommonVariables.StopPointNumber = realTimeCommonTransportDict["StopPointNumber"] as! Int
                realTimeCommonVariables.LineNumber = realTimeCommonTransportDict["LineNumber"] as! String
                realTimeCommonVariables.Destination = realTimeCommonTransportDict["Destination"] as! String
                realTimeCommonVariables.TimeTabledDateTime = realTimeCommonTransportDict["TimeTabledDateTime"] as! String
                realTimeCommonVariables.ExpectedDateTime = realTimeCommonTransportDict["ExpectedDateTime"] as! String
                realTimeCommonVariables.DisplayTime = realTimeCommonTransportDict["DisplayTime"] as! String
                print("Display time in buses = \(realTimeCommonVariables.DisplayTime )")
                
                // check null for array will return array eigther empty or full
                // extract to deviations will take that array and return deviations' array
                
                realTimeCommonVariables.deviations = extractDeviations(deviations: checkNullForNSArray(someValue: realTimeCommonTransportDict, keyName: "Deviation"))
                
                print("-------------Deviations Count = -------------\(realTimeCommonVariables.deviations.count)")
                
                realTimeCommonVariables.JourneyDirection = realTimeCommonTransportDict["JourneyDirection"] as! Int
               
//                if let stopPointDevCheckForNul = realTimeCommonTransportDict["StopPointDesignation"] as? String{
//                    realTimeCommonVariables.StopPointDesignation = stopPointDevCheckForNul
//                    
//                }
//                
                print("---buses-1-buses--\(realTimeCommonVariables)")
               return realTimeCommonVariables
            }
        
        return realTimeCommonVariables
    }


    // Mark Metros
    static func extractMetros    (jsonObject: NSArray){
       
        let metrosArray = NSMutableArray()
        
        if (jsonObject.count == 0){
            let metrosFound = Metros()
            metrosArray.add(metrosFound)
            tableData.setValue(metrosArray, forKey: METROS)
            
        }
        else {
            let metros = jsonObject
            for metros in metros {
                let metrosFound = Metros()
                 
                  metrosFound.DepartureGroupId = (metros as! NSDictionary)["DepartureGroupId"] as! Int
                  metrosFound.Destination = (metros as! NSDictionary)["Destination"] as! String
                metrosFound.DisplayTime = (metros as! NSDictionary)["DisplayTime"] as! String
                metrosFound.GroupOfLine = (metros as! NSDictionary)["GroupOfLine"] as! String
               
                metrosFound.JourneyDirection = String ((metros as! NSDictionary)["JourneyDirection"] as! Int)
                metrosFound.LineNumber = (metros as! NSDictionary)["LineNumber"] as! String

               
                if let pMessage = (metros as! NSDictionary)["PlatformMessage"] as? String {
                    metrosFound.PlatformMessage = pMessage
                }
                //metrosFound.PlatformMessage = (metros["PlatformMessage"] as? String)!

                //metrosFound.PlatformMessage = checkNull(metros["PlatformMessage"])
               
                metrosFound.SiteId = (metros as! NSDictionary)["SiteId"] as! Int
                metrosFound.StopAreaName = (metros as! NSDictionary)["StopAreaName"] as! String
                metrosFound.TransportMode = (metros as! NSDictionary)["TransportMode"] as! String

                
//             print("---metros---1-\(metros["SiteID"])")
                
            metrosArray.add(metrosFound)
                
                
            }
            tableData.setValue(metrosArray, forKey: METROS)
            
            
        }
        
        
        
        
    }
    
    
    //Ships
    static func extractShips    (jsonObject: NSArray){
        
        let shipsArray = NSMutableArray()
        

if (jsonObject.count == 0){
            let shipsFound = Ships()
            shipsArray.add(shipsFound)
            tableData.setValue(shipsArray, forKey: SHIPS)
            
        }
    
        else {
            let ships = jsonObject
//let shipsFound = Ships()
            
    for ships in ships {
                let shipsFound = Ships()
                
        // commons
        let realTimeInfoCommonVariables = extractRealTimeCommonTransportInfo(realTimeCommonTransportDict: ships as! NSDictionary)
        shipsFound.realTimeCommonTransportModeInfo = realTimeInfoCommonVariables.copy() as! RealTimeCommonTransportModeInfo
        print("trains.realtime common trains = \(realTimeInfoCommonVariables.Destination)")
        
        print("copied values trains = \(shipsFound.realTimeCommonTransportModeInfo.Destination)")
        
        
        
        //       shipsFound.Deviations = ships["Deviations"] as! String
       // MARK special variables for ship
        
        
      //  shipsFound.GroupOfLine = ships["GroupOfLine"] as! String
        shipsFound.GroupOfLine = checkNullForString(someValue: ships as! NSDictionary,keyName: "GroupOfLine")
        
              //  shipsFound.StopPointDesignation = ships["StopPointDesignation"] as! String
             //   print("---ships--1--\(ships["SiteID"])")
//                // others
//                shipsFound.GroupOfLine = ships["GroupOfLine"]
//                
        shipsArray.add(shipsFound)

            }
     tableData.setValue(shipsArray, forKey: SHIPS)
    
        }
      }
    // Trains
    
    static func extractTrains    (jsonObject: NSArray){
        let trainsArray = NSMutableArray()
        if (jsonObject.count == 0){
            let trainsFound = Trains()
            trainsArray.add(trainsFound)
            tableData.setValue(trainsArray, forKey: TRAINS)
            
        }
        else {
            let trains = jsonObject
            for trains in trains {
                let trainsFound = Trains()
                let realTimeInfoCommonVariables = extractRealTimeCommonTransportInfo(realTimeCommonTransportDict: trains as! NSDictionary)
                trainsFound.realTimeCommonTransportModeInfo = realTimeInfoCommonVariables.copy() as! RealTimeCommonTransportModeInfo
                print("trains.realtime common trains = \(realTimeInfoCommonVariables.Destination)")
                
                print("copied values trains = \(trainsFound.realTimeCommonTransportModeInfo.Destination)")
                
                
                
                
                trainsFound.StopPointDesignation = (trains as! NSDictionary)["StopPointDesignation"] as! String
               
                // extra variables in Trains
              //  trainsFound.SecondaryDestinationName = trains["SecondaryDestinationName"] as! String
                
            //    print("-------\(trains["SiteID"])")
                trainsArray.add(trainsFound)
            }
            
            tableData.setValue(trainsArray, forKey: TRAINS)
            
        }
        
        
        
        
    }
    
    // Trams
    static func extractTrams    (jsonObject: NSArray){
        var tramsArrays = NSMutableArray()
        if (jsonObject.count == 0){
            let tramsFound = Trams()
            
            tramsArrays.add(tramsFound)
            tableData.setValue(tramsArrays, forKey: TRAMS)
            
        }
        else {
            let trams = jsonObject
            for trams in trams {
                let tramsFound = Trams()

                // common variables
                let realTimeInfoCommonVariables = extractRealTimeCommonTransportInfo(realTimeCommonTransportDict: trams as! NSDictionary)
                tramsFound.realTimeCommonTransportModeInfo = realTimeInfoCommonVariables.copy() as! RealTimeCommonTransportModeInfo
                print("tramsFound.realtime common trains = \(realTimeInfoCommonVariables.Destination)")
                
                print("copied values tramsFound = \(tramsFound.realTimeCommonTransportModeInfo.Destination)")
                
                
               // tramsFound.Deviations = trams["Deviations"] as! String
                
                tramsFound.GroupOfLine = (trams as! NSDictionary)["GroupOfLine"] as! String
                tramsFound.StopPointDesignation = (trams as! NSDictionary)["StopPointDesignation"] as! String
                
                // extra variables

                tramsFound.GroupOfLine = (trams as! NSDictionary)["GroupOfLine"] as! String
                tramsFound.StopPointDesignation = (trams as! NSDictionary)["StopPointDesignation"] as! String

                
              //  print("---StopPointDesignation----\(trams["SiteID"])")
                
                
                tramsArrays.add(tramsFound)
                            }
            tableData.setValue(tramsArrays, forKey: TRAMS)
            

        }
        
        
        
        
    }
    
    static  func checkNullForString(someValue: NSDictionary,keyName:String)-> String{
        
        var valueString = String()
        print("going to check for string = \(keyName)")
        if (someValue[keyName] is NSNull) {
            valueString = ""
        } else if ( someValue[keyName] == nil){
        
             valueString = ""
        
        
        }
        
        
        else {
            
            valueString = someValue[keyName] as! String
        }
        return valueString
    }
    
    
    static  func checkNullForInt(someValue: NSDictionary,keyName:String)-> Int{
        
        var valueInt = Int()
        print("going to check for string = \(keyName)")
        if (someValue[keyName] is NSNull) {
            valueInt = 0
        } else if ( someValue[keyName] == nil){
            
            valueInt = 0
            
            
        }
            
            
        else {
            
            print("converting dict value to int: :::::: in realtid method.check for null....")
            valueInt = someValue[keyName] as! Int
        }
        
        return valueInt
    }

    
    static  func checkNullForBool(someValue: NSDictionary,keyName:String)-> String {
        
        var valueString = String()
        print("going to check for string = \(valueString)")
        if (someValue[keyName] is NSNull) {
            valueString = "null"
            
        } else if ( someValue[keyName] == nil){
        
            valueString = "null"
        }
        else {
            valueString = String(someValue[keyName] as! Bool)
        
        }
        
        return valueString
    }
    
    
    static  func checkNullForNSArray(someValue: NSDictionary,keyName:String)-> NSArray {
        print("going to check for NSARRAY = \(keyName)")

        var arrayObject = NSArray()
        
        if (someValue[keyName] is NSNull) {
            print("-----found a NSNULL---in NSArray()")
            arrayObject = NSArray()
        }
        else if (someValue[keyName] == nil){
            print("found nil---in NSArray()")
            
            arrayObject = NSArray()
            
        
        }
        
        else {
            print("--Deviations---found ---in NSArray()")
            
            arrayObject = someValue[keyName] as! NSArray
        }
        return arrayObject
    }
   
    static func extractDeviations (deviations: NSArray)-> [Deviations]{
    
    var deviationsArray = [Deviations]()
        
        print("Deviations Extraction in progress and its count is = \(deviations.count)")
        
        for deviations in deviations {
       let deviationObject = Deviations(consequences: "", importanceLevel: 10, text: "")
            
        deviationObject.consequences = (deviations as! NSDictionary)["consequences"] as! String
            
        deviationObject.improtanceLevel = (deviations as! NSDictionary)["ImportanceLevel"] as! Int
            
        deviationObject.text = (deviations as! NSDictionary)["Text"] as! String
            
        
        deviationsArray.append(deviationObject)
            
        }
     
        
        return deviationsArray
    }
    
/*
    static func extractStopPointDeviations    (jsonObject: NSArray){
        if (jsonObject.count == 0){
            let stopPointDeviationsFound = StopPointDeviations()
            tableData.setValue(stopPointDeviationsFound, forKey: "stopPointDeviationsFound")
            
        }
        else {
            let stopPointDeviations = jsonObject
            for stopPointDeviations in stopPointDeviations {
                let stopPointDeviationsFound = StopPointDeviations()
                
                // common variables
                stopPointDeviationsFound.StopInfo = stopPointDeviations["StopInfo"]
                stopPointDeviationsFound.Avvikelse = stopPointDeviations["Avvikelse"]
                stopPointDeviationsFound.Consequences = stopPointDeviations["StopInfo"]
                stopPointDeviationsFound.StopInfo = stopPointDeviations["StopInfo"]
                
                
                print("---StopPointDesignation----\(trams["SiteID"])")
                
                tableData.setValue(tramsFound, forKey: "TramsFound")
                
            }
        }
     }
  */
    
   static func checkIfDict (objectToCheck: AnyObject) -> Bool {
        
        var result = Bool()
        
        if let a = objectToCheck as? NSArray {
            result = true
            print("true")
            
        } else {
            result = false
            print("false")
            
        }
        return result
    }
    
    static func checkIfKeyExists (objectToCheck: AnyObject, keyName: String) -> Bool {
        
        
        if let a = objectToCheck[keyName] as? NSDictionary
        {
            
            print("dict caught.......for key \(keyName).............8787")
            print(a.allKeys)
            return true
        }
            
        else {
            
            print("nothing nothing nothing. .no dict caught \(keyName). . . . .. .")
                return false
        }

    }

    
    //-------------------------------------------------
    
    
    
    //------------------
    
    static func checkIfArray (objectToCheck: AnyObject) -> Bool {
        
        var result = Bool()
        
        if let a = objectToCheck as? NSArray {
            result = true
            print("true")
            
        } else {
            result = false
            print("false")
            
        }
        return result
    }
    
   }

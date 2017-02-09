
import UIKit

// Trip with Leglist
class Trip: NSObject, NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
    //<#code#>
        return Any.self
    }
    var showHideCell = true
    var dur : String
    var chg : String
    var co2 : String
    
    var tariffRemark : String
    var tariffZones : String
//    var LegList = [Leg]()
    
//  LegList will have all the legs of journey as LegWalk or LegTravel
// they are being added in TripSuggestionsTVC_news.swift
    
    var LegList : NSMutableArray
    var depExpand: Bool
    // some variables which will be populated by external functions
    var originDetail: Address
    var destinationDetail: Address

//    var from_time : String
//    var from_station : String
//    var to_Station : String
//    var to_time : String
    
   // init(duration: String, change: String, emission: String, tariffRemark : String , tariffZones : String, LegListLegs: NSMutableArray,from_time: String, from_station: String, to_time: String, to_station: String  ) {
    override init(){
        self.dur = "dur"
        self.chg = "chg"
        self.co2 = "co2"
        self.depExpand = false
        // <PriceInfo>
        
        self.tariffRemark = "tariffRemark"
        self.tariffZones = "tariffZones"
       
        self.LegList = NSMutableArray()
        
        self.originDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
        self.destinationDetail = Address(name: "", type: "", id: "", lon: "", lat: "", time: "", date: "", routeIdx: "")
        
        
    
    }
    init(dur: String, chg: String, co2: String, tariffRemark : String , tariffZones : String, LegList: NSMutableArray,originDetail: Address, destinationDetail:Address  ) {
        self.depExpand = false
    self.dur = dur
    self.chg = chg
    self.co2 = co2
    
    // <PriceInfo> 
        
    self.tariffRemark = tariffRemark
    self.tariffZones = tariffZones
    
   // <LegList>
        
        // The following Origin and Destination is containing the high level informaion of journey of origin to destination. do not confuse it with legs' origin and destination. they are different and contains the leg's origin and destinations to complete a journey
        
    self.LegList = LegList
   self.originDetail = originDetail
   self.destinationDetail = destinationDetail
        
//    self.from_time = from_time
//    self.from_station = from_station
//    self.to_time = to_time
//    self.to_Station = to_station
    
        
//    self.LegList = LegListLegs
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = Trip(dur: dur, chg: chg, co2: co2, tariffRemark: tariffRemark, tariffZones: tariffZones, LegList: LegList, originDetail: originDetail, destinationDetail: destinationDetail)
        //        let copy = Trip(firstName: firstName, lastName: lastName, age: age)
        return copy
    }
}

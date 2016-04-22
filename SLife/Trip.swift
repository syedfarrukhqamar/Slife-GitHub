
import UIKit

// Trip with Leglist
class Trip: NSObject, NSCopying {
    var dur : String
    var chg : String
    var co2 : String
    
    var tariffRemark : String
    var tariffZones : String
//    var LegList = [Leg]()
    var LegList : NSMutableArray
    // some variables which will be populated by external functions
    var originDetail: Address
    var destinationDetail: Address
    
//    var from_time : String
//    var from_station : String
//    var to_Station : String
//    var to_time : String
    
   // init(duration: String, change: String, emission: String, tariffRemark : String , tariffZones : String, LegListLegs: NSMutableArray,from_time: String, from_station: String, to_time: String, to_station: String  ) {
   
    init(dur: String, chg: String, co2: String, tariffRemark : String , tariffZones : String, LegList: NSMutableArray,originDetail: Address, destinationDetail:Address  ) {
        
    self.dur = dur
    self.chg = chg
    self.co2 = co2
    
    // <PriceInfo> 
        
    self.tariffRemark = tariffRemark
    self.tariffZones = tariffZones
    
   // <LegList>
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

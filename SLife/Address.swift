import Foundation


class Address: NSObject, NSMutableCopying {
    
    var date : String
    var id : String
    var lat : String
    var lon : String
    var name : String
    var time : String
    var type : String
    
    
    // at some later stage we may create two objecrs here (one dynamic with below info and one with static info above
   // var routeIdx = ""
    
    
    
    init(name: String,type: String, id:String , lon: String ,lat:String,time:String,date:String){
    
    self.name = name
    self.type = type
    self.id = id
    self.lon = lon
    self.lat = lat
  //  self.routeIdx = routeIdx
    self.time = time
    self.date = date
    
    }

    func mutableCopyWithZone(zone: NSZone) -> AnyObject {
        let copy = Address(name: name, type: type, id: id, lon: lon, lat: lat, time: time, date: date)

        return copy
        
    }

//    func copyWithZone(zone: NSZone) -> AnyObject {
//        let copy = Address(name: name, type: type, id: id, lon: lon, lat: lat, time: time, date: date)
//        
//        return copy
//    }
}

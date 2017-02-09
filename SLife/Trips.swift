
import UIKit

class Trips: NSObject, NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
       
        return Any.self
    }
    
//    check may be it is old one 
    // MARK: Properties
    
    var from_time: String       // 1
    var from_station: String    // 2
   
    var to_time: String         // 3
    var to_station: String      // 4
   
    var duration: String        // 5
    var tripsJson: NSDictionary  // for now let origin and destination remain here
    var type: String
    var name: String
    var dir: String
    var line: String
    var idx: String
    
    // where to store Origin values
    
    //var
// Transport Type Icons
//    var busIcon: UIImage        // 6
//    var greenTbanaIcon: UIImage
//    var redTbanaIcon: UIImage
//     var blueTbanaIcon: UIImage
//    var localBanaIcon: UIImage
//    var pendeltagIcon: UIImage
//    var sparvagnIcon: UIImage
//    var batIcon: UIImage
//    
//   // var photo: UIImage?
//    var rating: Int
//    
    // MARK: Initialization
    
    init?(from_time: String,from_station: String,to_time: String,to_station: String,duration: String,tripsJson: NSDictionary,type: String , name: String,dir: String, line: String,idx: String ) {
         
        
        self.from_time = from_time
        self.from_station = from_station
        self.to_time = to_time
        self.to_station = to_station
        self.duration = duration
        self.tripsJson = tripsJson
        self.type = type
        self.name = name
        self.dir = dir
        self.line = line
        self.idx = idx
        
        
        
     //    Initialization should fail if there is no name or if the rating is negative.
        if  from_time.isEmpty && from_station.isEmpty && to_time.isEmpty && to_station.isEmpty && duration.isEmpty {
            return nil
        }
    }
    
}


import Foundation

class LegWalk:LegDetail {
    
    var journeyType : String
    var walk: Dictionary<String,Walk>
    
//    init(journeyType: String,legWalk: Dictionary<String,Walk>,originValue: Address, destinationValue : Address){
//        self.journeyType = journeyType

    init(journeyType: String,legWalk: Dictionary<String,Walk>,originValue: Address, destinationValue : Address){
            self.journeyType = journeyType
    
        self.walk = legWalk

        super.init(origin: originValue, destination: destinationValue)
    }
    
    
    
    // leg detail will have information about destination and origin
    
    //    // we need two objects
    //    // LegInfo & Leg Detail Here
    //    var name = ""
    //    var type = ""
    //    var geometryRef = ""
    //    var idx = ""
    //
    //    var origin = TripsAddress()
    //    var destination = TripsAddress()
    //
    //    // not available in WALK Type leg------------start
    //    var dir = ""                    // dist
    //    var journeyDetailReference = "" // hide
    //    var line = ""                   // no line
    //    // not available in WALK Type leg------------end
    //
    //    // below variables are availble only in WALk
    //    var dist = ""
    //    var hide = ""
    //    
    
}


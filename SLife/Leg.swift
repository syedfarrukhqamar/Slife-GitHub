
import UIKit

class Leg:LegDetail {
    
//TransportType /Show/Hide Values + Line Show Hide for current Object/Leg
//    var METRO: String
//    var BUS: String
//    var
    
    
    // 22nd jan----start
    var legIndex: Int
    var nextDeparturesTrip: [Trip]
    var departureAvailable: Bool
    var depScope_fromLegIndex: Int
    var depScope_toLegIndex: Int
    var nextDepartType: String // CurrentLeg/ Multi
    var alternateDepartureForLegsDict: NSMutableDictionary // add all leg indexpath.row so that we know that this departure is an alternative option instead
    var currentLeg: Bool
    
    //-----22nd jan end
    var clickLevel: String
    var enabled_TransportType: Bool // Default True
    var enabled_LineNumber: Bool // Default true
    var showHideLeg: Bool // Default true means show all legs
    var filterLine: String
    var filterDepartures: Bool
  //  var showHide_Departures: Bool
    // ...:Common variables available in Travel /Walk
    var journeyType : String
// available via LegDetail
//    var origin: Address
//    var destination: Address
    var name: String
    var type: String
    var idx: String
    var geomRef: String
    var legImageName: String
    //-- Only found in --------Walk
    var dist: String
    var hide: String
    //-- Only found in --------Travel
    var dir: String
    var line: String
    var journeyDetailRef: String
    //---- 
    // Departure Related
    
    var rtu_Message_Flag: Bool
    var rtu_Message: String
    init(journeyType: String,name: String,type: String,idx: String,geomRef: String,dist: String,hide: String,dir:String,line:String,journeyDetailRef: String, origin: Address, destination: Address, legImageName: String, rtu_Message_Flag: Bool,rtu_Message: String,currentLegStatus: Bool){
        self.legIndex = 0
        self.currentLeg = currentLegStatus
        self.departureAvailable = false
        self.depScope_fromLegIndex = 1000
        self.depScope_toLegIndex = 1000
        self.nextDepartType = "DEFAULT"
        self.alternateDepartureForLegsDict = NSMutableDictionary()
        self.nextDeparturesTrip = [Trip]()
      //  self.showHide_Departures = false
        self.clickLevel = ""
        self.filterDepartures = false
        self.enabled_LineNumber = false
        self.enabled_TransportType = false
        self.filterLine = ""
        self.showHideLeg = false
        self.journeyType = journeyType
        self.name = name
        self.type = type
        self.idx = idx
        self.geomRef = geomRef
        self.dist = dist
        self.hide = hide
        self.dir = dir
        self.line = line
        self.journeyDetailRef = journeyDetailRef
        self.legImageName = legImageName
        self.rtu_Message_Flag = rtu_Message_Flag
        self.rtu_Message = rtu_Message
        super.init(origin: origin, destination: destination)
    }
    
//    init(walk:Dictionary<String,Walk> ,travel:Dictionary<String,Travel>){
//    
//        
//    self.walk = walk
//    self.travel = travel
//    
//    
//    }
//
//
//    
//     leg detail will have information about destination and origin
//    
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


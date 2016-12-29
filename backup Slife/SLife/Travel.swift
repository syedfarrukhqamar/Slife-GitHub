
import Foundation

class Travel: LegInfo {
    
    var dir: String
    var journeyDetailRef: String
    var line: String
    
    init(dir: String, journeyDetailRef: String,line: String, name: String, type: String, idx: String, geomRef: String) {
   
        self.dir = dir
        self.journeyDetailRef = journeyDetailRef
        self.line = line
        
        super.init(name: name, type: type, idx: idx, geomRef: geomRef)
    }
    
}
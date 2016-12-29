//
//  MapTripViewControllers.swift
//  SLife
//
//  Created by syed farrukh Qamar on 18/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.

 
import UIKit
import AVFoundation
import MapKit

var drawRootUrlsArray = NSMutableArray()
var lastLegFlag = false
 var downloadingNotFinished = true
//var rootLeg_setOrigin = Int()
//
//var rootLeg_setDestination = Int()

var selectedRootTripForMap = NSMutableArray()
var getDataCount = 0
var jsonExtractCount = 0
// https://api.sl.se/api2/TravelplannerV2/geometry.json?key=28650f61c688449cb9e87c13fbbf8b5b&

// webservice related variables
//var intermediateStops_Root_Dict = NSMutableDictionary()
var rootTrip_intermediateStops_MasterStocking = IntermediateStops()

// journey detail ref variables
var rootTrip_json_IntermediateStopsLoaded_flag = false
let rootTrip_MESSAGE_INTERMEDIATE_STOPS = "Message"
var rootTrip_intermediateStops_Dict = NSDictionary()
var rootTrip_intermediateStops_Array = NSMutableArray()
let rootTrip_intermediateStops_Status = Int()
var rootTrip_dataSource_intermediateStops_StatusCode = NSMutableDictionary()
var coordinatesToDrawRoot: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
let rootTrip_IntermediateStops_URL = "https://api.sl.se/api2/TravelplannerV2/journeydetail.json?key=28650f61c688449cb9e87c13fbbf8b5b&"

let rootTrip_URL = "https://api.sl.se/api2/TravelplannerV2/geometry.json?key=28650f61c688449cb9e87c13fbbf8b5b&"
// >> & ref=202422%2F82420%2F794926%2F329989%2F74%26startIdx%3D4%26endIdx%3D14%26lang%3Dsv%26format%3Dxml%26"


//let rootTrip_URL = "http//api.sl.se/api2/TravelplannerV2/geometry.<FORMAT>?key=<DIN API NYCKEL>& ref=202422%2F82420%2F794926%2F329989%2F74%26startIdx%3D4%26endIdx%3D14%26lang%3Dsv%26format%3Dxml%26"

class MapTripViewControllers: UIViewController, MKMapViewDelegate {
   
// all map variables 
    var rootTripJson_Loaded_Flag = false
    var rootTrip_Map_Message = String()
    var originLocation2D =  CLLocationCoordinate2D()
    var destinationLocation2D =  CLLocationCoordinate2D()
    
    var originCoordFlag = true
    var destCoordFlag = false
    
    var legLocationPointComplete = 0
    
    var originName = String()
    var destName = String()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
 //   @IBOutlet weak var tripMapShow: MKMapView!
    override func viewWillDisappear(_ animated: Bool) {
        print("view is dissappearing.........")
        // reset both intermediate stop variables
        print("intermediate stops.count = \(intermediateStops.intermediateStops.count)")
        print("intermediate stops.Master.count = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
        print("-B4---drawRootUrlsArray-----\(drawRootUrlsArray.count)")
        drawRootUrlsArray.removeAllObjects()
        print("-After---drawRootUrlsArray-----\(drawRootUrlsArray.count)")
        rootTrip_intermediateStops_MasterStocking.intermediateStops.removeAll()
        intermediateStops.intermediateStops.removeAll()
        
        print("After Removing:::intermediate stops.count = \(intermediateStops.intermediateStops.count)")
        print("After Removing::intermediate stops.Master.count = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
        
        
        if (self.isMovingToParentViewController)
        
        {
        
        print("self.isMovingToParent is true..............")
        
        }
        mapView.removeFromSuperview()
        let overlayMap = self.mapView.overlays
        print("overLay Map = \(overlayMap.count)")
//        mapView.removeOverlay(overlayMap)
        let mapAnnotations = self.mapView.annotations
        print("mapAnnotations.count is =\(mapAnnotations.count)")
      //  self.mapView.removeAnnotation(mapAnnotations)
        var t = 0
        for index in mapAnnotations {
            
        self.mapView.removeAnnotation(mapAnnotations[t])
        print("removing annotations........")
            t += 1
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        print("is it the one which is beain called.....")
        // check for the flag if request is from the trip view controller then 
        
        var finalURL = String()
        if(tripRootMapFlag == true){
        
            finalURL = rootTrip_IntermediateStops_URL + rootMap_Ref
            // finalURL = rootTrip_URL + rootMap_Ref
//            rootMap_Ref
//            
//            print("final URL Root Map = Geom Reference \(rootMap_Ref)")
//            print("final URL Root Map = \(finalURL)")
//            //get_data_from_url(finalURL)
            
            extractValuesToDrawRootLegListMap()
//            print("")
//            print("get data or Root Map:::::\(finalURL)")
//            print("Map Root Trip:: show route map has been called.........")
            
        }
            else if (intermediateStops_JSON_Loaded_Flag == true){
        
            showRouteOnMap(intermediateStopsObject: intermediateStops)
            print("intermediate Stops show route map has been called.........")
            
        }
        
        
    }
    
    
    
    
    func showRouteOnMap(intermediateStopsObject: IntermediateStops){
        
        var i = 0
        var midStation = intermediateStops.intermediateStops.count/2
        print("mid Station :::::::\(midStation)")
        print("intermediate stops status in MAP KIT = \(intermediateStopsObject.intermediateStops.count)")
        
        for index in intermediateStopsObject.intermediateStops {
            //            print("in intermediate stops stops")
            //
            print("------------i--------\(i)")
            //            print("name  = \(intermediateStops.intermediateStops[i].name)")
            //
            //            print("latitude value is = \(Double(intermediateStops.intermediateStops[i].lat)!)")
            //            print("longitude value is = \(Double(intermediateStops.intermediateStops[i].long)!)")
            
            //----show annotations --start
            
            
            //            let loc = CLLocationCoordinate2D(
            
            let lat = Double(intermediateStopsObject.intermediateStops[i].lat)!
            
            let long = Double(intermediateStopsObject.intermediateStops[i].long)!
            
            // show annotations on the map
            print("::::::S1::::::")
            showAnnotations(lat: lat, long:long, title: intermediateStopsObject.intermediateStops[i].name, stationsName: intermediateStopsObject.intermediateStops[i].name, transportType: intermediateStopsObject.intermediateStops[i].name)
            
            
            // set the span and region to mid station if reached
            if (midStation == i)
            {
                print("setting span and region :::::::")
                setSpanAndRegion(lat: lat, long: long, regionRadius: 5000)
                
            }
            
            // send the origin and destination to draw lines
            if (originCoordFlag == true){
                
                originName = intermediateStopsObject.intermediateStops[i].name
                
                
                originLocation2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                //let loc = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
                originCoordFlag = false
                destCoordFlag = true
                legLocationPointComplete = 1
                
                
            }
            else if (destCoordFlag == true)
                
            {
                
                destName = intermediateStopsObject.intermediateStops[i].name
                
                //                let lat = Double(intermediateStops.intermediateStops[i].lat)!
                //
                //                let long = Double(intermediateStops.intermediateStops[i].long)!
                //
                destinationLocation2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                //let loc = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
                originCoordFlag = true
                destCoordFlag = false
                if (legLocationPointComplete == 1 )
                {
                    legLocationPointComplete = 2
                } else {
                    
                    print ("Error reported in coordinattes compilation in mapt trip....")
                    
                    
                }
                //i++
                
            }
            
            
            if (legLocationPointComplete == 2){
                
                
                print(":::::::::::::::ORIGIN NAME: MAP: \(originName)")
                print("MAP : Origin = \(originLocation2D)")
                print(":::::::::::::::Dest NAME: MAP: \(destName)")
                
                print("MAP_ Destination = \(destinationLocation2D)")
                
                
                
                
                drawLineBetweenTwoStops(originLocation2D: originLocation2D, destinationLocation2D: destinationLocation2D)
                print("DRAWING LINE.....................")
                
            }
            i += 1
            
        }
        
        
    }
    
    // MARK: MKMapViewDelegate
    /*
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.alpha = 0.5
        renderer.strokeColor = UIColor.redColor()
        
        return renderer
    }
    */
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        
        
        print("inside map view route draw before if......")
        if overlay is MKPolyline {
            print("inside map view route inside if......")
            
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5
            
        }
        return polylineRenderer
    }

    func drawLineBetweenTwoStops(originLocation2D : CLLocationCoordinate2D,destinationLocation2D: CLLocationCoordinate2D) {
       
        
//        let origin = CLLocation(latitude: 33.9424955, longitude: -118.4080684)
//        let destination = CLLocation(latitude: 40.6397511, longitude: -73.7789256)
//        
        
        // incomplete: we need to figure out how to define span and region to see complete route
        
        let checkZeroLat = Double(originLocation2D.latitude) * 200
        
        if (checkZeroLat != 0.0){
        
        
        print("-----------------------0.0----------------------------")
        
        
        let location = CLLocationCoordinate2D(
            latitude: originLocation2D.latitude,
            longitude: originLocation2D.longitude
        )
        
        print("latitude originLocation2D.latitude\(originLocation2D.latitude) && Long = \(originLocation2D.longitude)")
        
        print("latitude destinationLocation2D.latitude \(destinationLocation2D.latitude) && Long = \(destinationLocation2D.longitude)")
        
//        let location = CLLocationCoordinate2D(
//            latitude: 33.9424955,
//            longitude: -118.4080684
//        )        // define span
        
       // let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        // define region
        
        //let region = MKCoordinateRegion(center: location, span: span)
        
        //mapView.setRegion(region, animated: true)
        var coordinates = [originLocation2D, destinationLocation2D]
        
        // var coordinates = [origin.coordinate, destination.coordinate]
        // MARK: Swift 3
     //   let geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
        
            
            let geodesicPolyline = MKGeodesicPolyline(coordinates: coordinates, count: 2)
            
        mapView.add(geodesicPolyline)
            
        }
        
    }
    
    func showAnnotations(lat: Double, long: Double , title: String, stationsName: String, transportType:String){
    
        // show artwork on map
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let stationBaloons = MapAnnotations_IntermediateStations(title: title, stationName: stationsName, transportType: transportType, coordinate: coordinates)
        
        print("temp:switch off annotations.......")
        //mapView.addAnnotation(stationBaloons)
        
        
//        let artwork = Artwork(title: "King David Kalakaua",
//                              stationName: "Waikiki Gateway Park",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//        
       // mapView.addAnnotation(artwork)
    
    
    
    }
    
    func setSpanAndRegion(lat: Double, long: Double, regionRadius: Int ){
    
    // set the span to provided coordinates
     let initialLocation = CLLocation(latitude: lat, longitude: long)
        
    // set the region
    
        let regionRadius: CLLocationDistance = CLLocationDistance(regionRadius)
       
    
        
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        
    
    }
    
    
    /*
     
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 4.0
        
        return renderer
    }
     */
    
    
    
    // temp from intermediate stops.......
    
    
    func get_data_from_url(rootTripDict: NSDictionary)
    {
        let url1 = rootTripDict.value(forKey: "finalRootLegIntermediateURL") as! String
        getDataCount += 1
        print("........get count = \(getDataCount)")
        let url:NSURL = NSURL(string: url1)!
        
       // let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        print("...url to get data from = \(url)")
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("-INSIDE intermediate stops--json step 1---real time--test real-")
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            print("-intermediate stops----json step 2-----test-")
            DispatchQueue.main.async(execute: {
                self.extract_json(jsonData: data! as NSData,rootTripDict: rootTripDict)
                print("intermediate stops---in real time result--7.1--about to return after parsing")
                jsonTrafficStatusLoaded = true
                // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                //self.getTrips(convertedJsonIntoNSDict)
                //--for-1-------------------------------------------------------------------------------------------------
                print("intermediate stops-in real time result-7.2--about to return after parsing")
                // reload the table here
             //   self.tableView.reloadData()
       

                return
            })
        }
        
        task.resume()
    }
    
    //----call webservice-----........end
    
    //---extract data from json-.------start
    
    // replacing with replacement
    
    
    func extract_json(jsonData:NSData,rootTripDict: NSDictionary)
    {
        //let legIndex = Int(legInd)!
        print("-test 12344..........------extract json test 1")
      let dict = rootTripDict as! NSDictionary
      print("test 12344..........\(rootTripDict.allKeys)")
        let fromIdx = dict.value(forKey: "rootLeg_setOrigin") as! Int
        let toIdx = dict.value(forKey: "rootLeg_setDestination") as! Int
        let legIndex = dict.value(forKey: "legIndex")  as! String
        let rootLeg_setOrigin = fromIdx
        let rootLeg_setDestination = toIdx
        jsonExtractCount += 1
        print("get json count ::::::::::\(jsonExtractCount)")
        print("--intermediate stops------in real time result--json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("json downloading in progres........4......intermediate stops--.")
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            
            print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
            rootTrip_json_IntermediateStopsLoaded_flag = true
            
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
        
        rootTrip_intermediateStops_Dict = (json as? NSMutableDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---intermediate stops---6-----convertedJSON is being printed = \(rootTrip_intermediateStops_Dict.allKeys)")
        //        print("--INSIDE TRAFFIC STATUS--.....before----dataSourceTrafficStatus count before adding--= \(dataSourceTrafficStatus.count)")
        //        dataSourceTrafficStatus.removeAllObjects()
        
        
        // define a journey detail variable in the view controller intermediate stops
        // extract 1 by 1 its objects and put them in the
        if (rootTrip_intermediateStops_Dict.count == 0){
            print("taffic status dict count is 0----")
            // check for message
            let message = "Please try again Later......"
            //            tableData.addObject(message)
            // check for station code
            print(message)
//            rootTrip_intermediateStops_Dict.setValue(message, forKey: "message")
            
            //            rootTrip_dataSource_rootTrip_intermediateStops_MasterStocking_StatusCode.setValue(statusCodeInt, forKey: rootTrip_intermediateStops_MasterStocking_StatusCode)
            //            dataSourceTrafficStatus.setValue(statusCode, forKey: "statusCode")
            
            
        }
            
        else {
            print("root trip intermediate url \(rootTrip_IntermediateStops_URL)")
            print("sc 1--.......\(rootTrip_intermediateStops_Dict.allKeys)")
            print("sc 1--.......\(rootTrip_intermediateStops_Dict.allValues)")
            
            // MARK: Swift 3
            
            let testDict = ( rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String: AnyObject])["Directions"] as! NSDictionary
            
            print("printing all keys = \(testDict.allKeys)")
            // extract directions
            print("sc 1--...a....")
            let directionsDict = ( rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String: AnyObject])["Directions"] as! NSDictionary
            print("sc 1--....b...")

            let directionsArrayTest = RealTidMethods.checkIfArray(objectToCheck: directionsDict["Direction"]! as AnyObject)
            
            print("sc 1--....c...")

            if (directionsArrayTest == false){
                
                print("Dict caught")
                
                rootTrip_intermediateStops_MasterStocking.directions.directionName = RealTidMethods.checkNullForString(someValue: (directionsDict["Direction"]! as! NSDictionary), keyName: "$")
                
                print("sc 2--.......")
                // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
                let routeIdfrm = RealTidMethods.checkNullForString(someValue: (directionsDict["Direction"] as! NSDictionary), keyName: "routeIdxFrom")
                
                rootTrip_intermediateStops_MasterStocking.directions.routeIdFrom = Int(routeIdfrm)!
                
                let routeIdto = RealTidMethods.checkNullForString(someValue: directionsDict["Direction"] as!
                    NSDictionary, keyName: "routeIdxTo")
                rootTrip_intermediateStops_MasterStocking.directions.routeIdTo = Int(routeIdto)!
                
            }
            else  {
                
                print("Array caught-.--......")
                
                let directionsArray = directionsDict["Direction"]! as! NSArray
                let directionsDictFromArray = directionsArray[0] as! NSDictionary
                
                rootTrip_intermediateStops_MasterStocking.directions.directionName = RealTidMethods.checkNullForString(someValue: (directionsArray[0] as! NSDictionary), keyName: "$")
                
                print("sc 2--.......")
                // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
                let routeIdfrm = RealTidMethods.checkNullForString(someValue: (directionsArray[0] as! NSDictionary), keyName: "routeIdxFrom")
                
                rootTrip_intermediateStops_MasterStocking.directions.routeIdFrom = Int(routeIdfrm)!
                
                let routeIdto = RealTidMethods.checkNullForString(someValue: (directionsArray[0] as! NSDictionary), keyName: "routeIdxTo")
                
                print("direction Arrya count = \(directionsArray.count)")
                
                rootTrip_intermediateStops_MasterStocking.directions.routeIdTo = Int(routeIdto)!
                
            }
            
            
            print("sc 3--.......")
            
            //  var test = rootTrip_rootTrip_intermediateStops_MasterStocking_Dict["Directions"]!["$"] as! String
            //print("VALUE RECEIVED FOR DIRECTIONS.$ in dict = \(test)")
            print("VALUE RECEIVED FOR DIRECTIONS.$ = \(rootTrip_intermediateStops_MasterStocking.directions.directionName)")
            
            // extract geom reference
            // let geomRefDict  = rootTrip_rootTrip_intermediateStops_MasterStocking_Dict["JourneyDetail"]!["GeometryRef"]  as! NSDictionary
            
            rootTrip_intermediateStops_MasterStocking.geometryRef = RealTidMethods.checkNullForString(someValue: ((rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String: AnyObject])["GeometryRef"]  as! NSDictionary), keyName: "ref")
            print("sc 4--.......Geom Ref\(rootTrip_intermediateStops_MasterStocking.geometryRef)")
            
            // extract Lines
            
            let linesDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String: AnyObject])["Lines"]!["Line"] as! NSDictionary
            let namesDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String: AnyObject])["Names"]!["Name"] as! NSDictionary
            let lineNo = RealTidMethods.checkNullForString(someValue: (linesDict), keyName: "$")
            rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber = Int(lineNo)!
            
            rootTrip_intermediateStops_MasterStocking.line_and_name.lineName = RealTidMethods.checkNullForString(someValue: namesDict, keyName: "$")
            
            let line_routeIdFrom = RealTidMethods.checkNullForString(someValue: linesDict, keyName: "routeIdxFrom")
            
            rootTrip_intermediateStops_MasterStocking.line_and_name.routeIdFrom = Int(line_routeIdFrom)!
            
            let line_routeIdTo = RealTidMethods.checkNullForString(someValue: linesDict, keyName: "routeIdxTo")
            
            rootTrip_intermediateStops_MasterStocking.line_and_name.routeIdFrom = Int(line_routeIdTo)!
            
            
            print("sc 5--.....rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber  = \(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber )..")
            // extract Stops
            let stopsDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String: AnyObject])["Stops"]!["Stop"] as! NSMutableArray
            
            print("---RoutIdx--From :: \(rootTrip_intermediateStops_MasterStocking.directions.routeIdFrom)")
            print("---RoutIdx--To :: \(rootTrip_intermediateStops_MasterStocking.directions.routeIdTo)")
            
            let realStopCount = rootTrip_intermediateStops_MasterStocking.directions.routeIdFrom - rootTrip_intermediateStops_MasterStocking.directions.routeIdTo
            
            print("Real Stop Count = = = = = \(realStopCount)")
            print("setOriginStop = = = = interMed stops = \(fromIdx))")
            print("setDestStop = = = = interMed stops = \(toIdx))")
            
            
            var i = 0
            for index in stopsDict {
                
                print("index = iii \(i)")
                print("leg index current value is = \(legIndex)")
              //  print("index = iii-legindex \(legIndex)")
                
                // arr date
                let arrDate = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "arrDate")
                // arr time
                
                let arrTime = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "arrTime")
                
                // dep date
                
                let depDate = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "depDate")
                
                
                // dep time
                
                let depTime = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "depTime")
                
                // id
                
                let id = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "id")
                
                // lat
                
                let lat = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "lat")
                
                // long
                
                let long = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "lon")
                
                // name
                
                let name = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "name")
                
                // route idx
                
                let routeIdx = RealTidMethods.checkNullForString(someValue: stopsDict[i] as! NSDictionary, keyName: "routeIdx")
                print("1ööööö")
                print("setOriginStop value is = Root Leg = \(rootLeg_setOrigin)")
                print("setDestStop value is = Root Leg= \(rootLeg_setDestination)")
                print("rootLeg_setOrigin")
                print(rootLeg_setOrigin.description)
                print("i = \(i)")
                 let stop = Stops()
                stop.arrDate = arrDate
                stop.arrTime = arrTime
                stop.depDate = depDate
                stop.depTime = depTime
                stop.id = Int(id)!
                stop.lat = lat
                stop.long = long
                stop.name = name
                
                stop.legIndex = legIndex
                
//                print(":::::::::name =\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name)) .......i =.\(i).......adding stops in master root trip = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
                
                
                // check for the origin route idx
                print("rootLeg Origin value is = \(fromIdx)")
                print("rootLeg Destination value is = \(toIdx)")
                print("i = \(i)")
                
                if (fromIdx == i){
                    print("in root leg Set origin = -------------------------------")
                    print("-----caught----\(setOriginStop))")
                    print(stopsDict)
                    // dep date
                    rootTrip_intermediateStops_MasterStocking.originStop.depDate = depDate
                    // dep time
                    rootTrip_intermediateStops_MasterStocking.originStop.depTime = depTime
                    // id
                    rootTrip_intermediateStops_MasterStocking.originStop.id = Int(id)!
                    // lat
                    rootTrip_intermediateStops_MasterStocking.originStop.lat  = lat
                    // long
                    rootTrip_intermediateStops_MasterStocking.originStop.long = long
                    // name
                    rootTrip_intermediateStops_MasterStocking.originStop.name = name
                    
                    // route idx
//                    rootTrip_intermediateStops_MasterStocking.originStop.routeIdx = Int(legIndex)
//                    rootTrip_intermediateStops_MasterStocking.originStop.legIndex  = Int(legIndex)
//                    
                    print("rootTrip_intermediateStops_MasterStocking.originStop.routeIdx = \(rootTrip_intermediateStops_MasterStocking.originStop.routeIdx)")

                    // show the Root Origin Leg name here
                    showAnnotations(lat: Double(rootTrip_intermediateStops_MasterStocking.originStop.lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.originStop.long)!, title: rootTrip_intermediateStops_MasterStocking.originStop.name, stationsName: String(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber), transportType: rootTrip_intermediateStops_MasterStocking.line_and_name.lineName)
                    
                }
                    // check for the destination route idx
                else if (toIdx == i ) {
                    
                    print("in root leg Set Destination = ------------------\(i)---")
                    
                    print("-----caught---setDestinationStop-interMed Stops-\(setDestinationStop))")
                    
                    // arr date
                    rootTrip_intermediateStops_MasterStocking.destinationStop.arrDate = arrDate
                    // arr time
                    rootTrip_intermediateStops_MasterStocking.destinationStop.arrTime = arrTime
                    // id
                    rootTrip_intermediateStops_MasterStocking.destinationStop.id = Int(id)!
                    // lat
                    rootTrip_intermediateStops_MasterStocking.destinationStop.lat  = lat
                    // long
                    rootTrip_intermediateStops_MasterStocking.destinationStop.long = long
                    // name
                    rootTrip_intermediateStops_MasterStocking.destinationStop.name = name
                    // route idx
                //    rootTrip_intermediateStops_MasterStocking.destinationStop.routeIdx = Int(legIndex)
                    
                //    rootTrip_intermediateStops_MasterStocking.destinationStop.legIndex  = Int(legIndex)
                    
                    print("rootTrip_intermediateStops_MasterStocking.destinationStop.routeIdx = \(rootTrip_intermediateStops_MasterStocking.destinationStop.routeIdx)")
                    print("Destination stop.name = \(rootTrip_intermediateStops_MasterStocking.destinationStop.name)")
                    // show the Root Destination Leg name here
                    showAnnotations(lat: Double(rootTrip_intermediateStops_MasterStocking.destinationStop.lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.destinationStop.long)!, title: rootTrip_intermediateStops_MasterStocking.destinationStop.name, stationsName: String(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber), transportType: rootTrip_intermediateStops_MasterStocking.line_and_name.lineName)
                }
                    
                else if (i > fromIdx  && i < toIdx) {
                    print("in root leg Set origin = --------------inter med stops-----------------")
                    
                    print(".......interMed stops index count = \(i)")
                    //print("intermediate stops = \(stopsDict.description)")
                    
                    let stop = Stops()
                    
                    print("10")
                    // dep date
                    
                    stop.arrDate = depDate
                    // dep time
                    
                    print("11")
                    stop.depTime = depTime
                    
                    // arr date
                    stop.arrDate = arrDate
                    // arr time
                    stop.arrTime = arrTime
                    // id
                    stop.id = Int(id)!
                    // lat
                    stop.lat  = lat
                    // long
                    stop.long = long
                    // name
                    stop.name = name
                    // route idx
                    stop.routeIdx = Int(routeIdx)!
                    stop.legIndex = legIndex
                    rootTrip_intermediateStops_MasterStocking.intermediateStops.append(stop)
                    
                }
                // check for the intermediate stops
 
                
                i += 1
                print("index value  intermediate stops = \(i)")
                
                
            }
            print("origin is =\(rootTrip_intermediateStops_MasterStocking.originStop.name)")
            print("count of intermediate stops is = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
            print("Destination is =\(rootTrip_intermediateStops_MasterStocking.destinationStop.name)")
            print("sc 6--.......")
            
            i = 0
            
            print("last leg flag value in extract json = \(lastLegFlag)")
            print("rootTrip_intermediateStops_MasterStocking.intermediateStops.count = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
            if (lastLegFlag == true){
            
               
                print("test 876.........")
                var originCoordinates = CLLocationCoordinate2D()
                var destinationCoordinates = CLLocationCoordinate2D()
               // var e = 0
//                for s in rootTrip_intermediateStops_MasterStocking.intermediateStops {
//                
//                print("------station name = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[e].name)")
//                
//                    print("-----Latitude =  \(rootTrip_intermediateStops_MasterStocking.intermediateStops[e].lat)")
//               
//                    print("------Longitude = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[e].long)")
//                    
//                    
//                    e++
//                }
                
                
            for index in rootTrip_intermediateStops_MasterStocking.intermediateStops {
            
            print("-Stop--name::Leg Index : \(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].legIndex)----i=\(i)---\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name)")

                
                let lat = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].lat)
                let long = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].long)
                let coordinate = CLLocationCoordinate2D(latitude: lat!,longitude: long!)
            
                
                
                
                showAnnotations(lat: lat!, long: long!, title: rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name, stationsName: rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name, transportType: String(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].routeIdx))
                
                coordinatesToDrawRoot.append(coordinate)
                
                
                let checkZeroLat = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].lat)! * 20
                if (checkZeroLat == 0.0){
                    print("----extract json check-------------------0.0------------------\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name)----------")
                    
                }
                

               
                if (originCoordFlag == true){
                
                    originCoordinates.latitude = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].lat)!
                    originCoordinates.longitude = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].long)!
                    
                    print("station Name :...... .\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name)")
                    print("-------------\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].lat)")
                    
                    print("----Double---------\(Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].lat)!)")
                    
                    print("-------------\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].long)")
                    print("-------Double------\(Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].long)!)")
                    
                  originCoordFlag = false
                
                } else if (originCoordFlag == false){
                
                    destinationCoordinates.latitude = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].lat)!
                    
                    destinationCoordinates.longitude = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].long)!
                    originCoordFlag = true
                    
                    print("--------i-----iiii-------(i)=")
                    print("calling draw Line Between Two Stops = Lat = \(originCoordinates)---Long = \(destinationCoordinates)")
                    
                    drawLineBetweenTwoStops(originLocation2D: originCoordinates, destinationLocation2D: destinationCoordinates)
                    print("values originCoordinates = \(originCoordinates)")
                    print("values destinationCoordinates = \(destinationCoordinates)")

                }
 
            i += 1
            }
                
                
//                 MARK:-  Draw root
                print("coordinates to draw status = \(coordinatesToDrawRoot.count)")
                
                var polyline = MKPolyline(coordinates: &coordinatesToDrawRoot, count: coordinatesToDrawRoot.count)
                
//                MKPolyline(coordinates: UnsafeMutablePointer<CLLocationCoordinate2D>, count: <#T##Int#>)
            
             mapView.add(polyline)
                
                var q = 0
                for index in rootTrip_intermediateStops_MasterStocking.intermediateStops {
                
                    print("termp:LEG INDEX = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].legIndex)::: index = \(q)--name = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].name)")
                    
//                    
//                    print("::::::::: root id = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].name)")
//                    
//                    print("::::::::: index = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].name)")
//                
                q += 1
                }
            }
            
            setSpanAndRegion(lat: Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[0].lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[0].long)!, regionRadius: 15000)
            // 1) extract origin stop
            // 2) extract last stop
            // 3) check for the destination to avoid printing the extra names
            // Extract Types
        }
        //else {
        // check for the status code
        
        // if it is zero
        
        //            ----AFTER MAGHRIB NAMAZ IN SHA ALLAH----
        
        // if it is not zero then do the rest of the processing
        print("inside else.................")
        
        
        
        //self.tableView.reloadData()
        
//        print("-intermediate stops:::::::after----tabledata count AFTER-dataSourceTrafficStatus\(rootTrip_dataSource_rootTrip_intermediateStops_MasterStocking_StatusCode.count)")
//        
//        
//        print("-after----tabledata count AFTER-= \(rootTrip_rootTrip_intermediateStops_MasterStocking_Dict.count)")
//        
//        showRouteOnMap(rootTrip_intermediateStops_MasterStocking)
//        
        
        
    }
    
    // write a function to draw Root LegList Map
    
    func extractValuesToDrawRootLegListMap (){
    
        // iterate through the leglist array and extract the following values for each Leg
        
       // let tripCell = rootLegsArray as! [Trip]
        
       // the following method will be called for as many times as the legs of each trip
       //
        var i = 0
        
// DispatchQueue.main.asynchronously(execute: {
        DispatchQueue.main.async(execute: {
//
//           let refetchGroup = dispatch_group_create()
//            dispatch_group_enter(refetchGroup)
//            
//           // dispatch_group_notify(<#T##group: dispatch_group_t##dispatch_group_t#>, <#T##queue: dispatch_queue_t##dispatch_queue_t#>, <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>)
            
            
            for index in selectedRootTripForMap {
               
                let totalLegs = i + 1
                if (totalLegs == selectedRootTripForMap.count){
                lastLegFlag = true
                    print("true:last leg flag value in extract json = \(lastLegFlag)")
                }
                else {
                
                lastLegFlag = false
                  print("false:::last leg flag value in extract json = \(lastLegFlag)")
                }
            //   if (i == 2){
                print("--start--------------start--------------start----i = \(i)")
                let legList = selectedRootTripForMap[i] as! Leg
                
                // extract the journey detail reference
                
                
                let journeyDetailReference = legList.journeyDetailRef
                
                // now construct the url
                // for intermediate url
                
                let finalRootLegIntermediateURL = intermediateStops_URL + legList.journeyDetailRef
                
                if (legList.journeyType != "WALK"){
                    
                 let    rootLeg_setOrigin = Int(legList.origin.routeIdx)!
                    
                    let rootLeg_setDestination = Int(legList.destination.routeIdx)!
                    
                    
                    
                    let rootTrip_MapValuesBucket = NSMutableDictionary()
                    
                    
                    rootTrip_MapValuesBucket.setValue(finalRootLegIntermediateURL, forKey: "finalRootLegIntermediateURL")
                    rootTrip_MapValuesBucket.setValue(rootLeg_setOrigin, forKey: "rootLeg_setOrigin")
                    rootTrip_MapValuesBucket.setValue(rootLeg_setDestination, forKey: "rootLeg_setDestination")
                    rootTrip_MapValuesBucket.setValue(rootLeg_setDestination, forKey: "rootLeg_setDestination")
                    rootTrip_MapValuesBucket.setValue(String(i), forKey: "legIndex")
                    
                    print("iiiiiiiii 1010 = \(i)")
                    let s = "legIndex"
                    print("dict leg index value is \(rootTrip_MapValuesBucket.value(forKey: s))")
                    drawRootUrlsArray.add(rootTrip_MapValuesBucket)
                    
                    //_______________________________::::: Start.....temp switching off
                    
                    /*
                   print("index value is = \(i)")
                    print("setting origin of the leg = \(rootLeg_setOrigin)")
                    print("setting Destination of the leg = \(rootLeg_setDestination)")
                    
                    print(".finalRoot LegIntermediateURL.........\(finalRootLegIntermediateURL)")
                    
                    print("Journey Type = legList.journeyType = \(legList.journeyType)")
                    print("legList.journeyType = NAME =  \(legList.name)")
                    let legIndex = i
                    
                    struct legIndexStruct { var legIndexValue: String!}
                   var legIndValue = legIndexStruct()
                    legIndValue.legIndexValue = String(i)
                    
                    print("------legIndValue.legIndexValue\(legIndValue.legIndexValue)--")
                    print("------i\(i)--")
                    
                     self.get_data_from_url(finalRootLegIntermediateURL,fromIdx: Int(legList.origin.routeIdx)!,toIdx: Int(legList.destination.routeIdx)!)
                    print(legIndValue.legIndexValue)
                    print(i.description)
                    */
                    //____________________________________ END.....temp switching off
                }
                print("returned from get data from url......finalRootLegIntermediateURL.........\(finalRootLegIntermediateURL)")
                
                print("--end--------------end--------------end----i = \(i)")
                print("::::::total count of intermediat stops = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
                //}
                    i += 1
            }
            var i = 0
            for index in drawRootUrlsArray {
            let dict = drawRootUrlsArray[i] as! NSDictionary
            print("url draw root = \(dict)")
            
//                while(downloadingFinished == false) {
               print("---------------------downloading Fininshed ? \(downloadingNotFinished)")
                    self.get_data_from_url(rootTripDict: dict)
                
//                }
                downloadingNotFinished == true
                print("dict count is ........\(drawRootUrlsArray.count)")
            i += 1
            }
            print("::::::total count of intermediat stops = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
        
            return
        })

        
        
        
    
    }
    
}


/*
 func extract_json(jsonData:NSData)
 {
 print("--intermediate stops------in real time result--json step 3----inside from/To--")
 let json: AnyObject?
 do {
 print("json downloading in progres........4......intermediate stops--.")
 json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
 print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
 intermediateStops_JSON_Loaded_Flag = true
 
 //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
 
 // load this json into Trip---start
 // load this json intro trip end here
 
 } catch {
 json = nil
 return
 }
 
 intermediateStops_Dict = (json as? NSMutableDictionary)!
 //getTrips(convertedJsonIntoNSDict)
 print("---intermediate stops---6-----convertedJSON is being printed = \(intermediateStops_Dict.allKeys)")
 //        print("--INSIDE TRAFFIC STATUS--.....before----dataSourceTrafficStatus count before adding--= \(dataSourceTrafficStatus.count)")
 //        dataSourceTrafficStatus.removeAllObjects()
 
 
 // define a journey detail variable in the view controller intermediate stops
 // extract 1 by 1 its objects and put them in the
 if (intermediateStops_Dict.count == 0){
 print("taffic status dict count is 0----")
 // check for message
 let message = "Please try again Later......"
 //            tableData.addObject(message)
 // check for station code
 
 dataSource_intermediateStops_StatusCode.setValue(message, forKey: "message")
 
 //            dataSource_intermediateStops_StatusCode.setValue(statusCodeInt, forKey: intermediateStops_StatusCode)
 //            dataSourceTrafficStatus.setValue(statusCode, forKey: "statusCode")
 
 
 }
 
 else {
 
 print("sc 1--.......")
 let testDict = intermediateStops_Dict["JourneyDetail"]!["Directions"] as! NSDictionary
 
 print("printing all keys = \(testDict.allKeys)")
 // extract directions
 print("sc 1--.......")
 let directionsDict = intermediateStops_Dict["JourneyDetail"]!["Directions"] as! NSDictionary
 
 let directionsArrayTest = RealTidMethods.checkIfArray(directionsDict["Direction"]!)
 
 
 if (directionsArrayTest == false){
 
 print("Dict caught")
 
 intermediateStops.directions.directionName = RealTidMethods.checkNullForString((directionsDict["Direction"]! as! NSDictionary), keyName: "$")
 
 print("sc 2--.......")
 // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
 let routeIdfrm = RealTidMethods.checkNullForString((directionsDict["Direction"] as! NSDictionary), keyName: "routeIdxFrom")
 
 intermediateStops.directions.routeIdFrom = Int(routeIdfrm)!
 
 let routeIdto = RealTidMethods.checkNullForString(directionsDict["Direction"] as!
 NSDictionary, keyName: "routeIdxTo")
 intermediateStops.directions.routeIdTo = Int(routeIdto)!
 
 }
 else  {
 
 print("Array caught-.--......")
 
 let directionsArray = directionsDict["Direction"]! as! NSArray
 let directionsDictFromArray = directionsArray[0] as! NSDictionary
 
 intermediateStops.directions.directionName = RealTidMethods.checkNullForString((directionsArray[0] as! NSDictionary), keyName: "$")
 
 print("sc 2--.......")
 // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
 let routeIdfrm = RealTidMethods.checkNullForString((directionsArray[0] as! NSDictionary), keyName: "routeIdxFrom")
 
 intermediateStops.directions.routeIdFrom = Int(routeIdfrm)!
 
 let routeIdto = RealTidMethods.checkNullForString((directionsArray[0] as! NSDictionary), keyName: "routeIdxTo")
 
 print("direction Arrya count = \(directionsArray.count)")
 
 intermediateStops.directions.routeIdTo = Int(routeIdto)!
 
 }
 
 
 print("sc 3--.......")
 
 //  var test = intermediateStops_Dict["Directions"]!["$"] as! String
 //print("VALUE RECEIVED FOR DIRECTIONS.$ in dict = \(test)")
 print("VALUE RECEIVED FOR DIRECTIONS.$ = \(intermediateStops.directions.directionName)")
 
 // extract geom reference
 // let geomRefDict  = intermediateStops_Dict["JourneyDetail"]!["GeometryRef"]  as! NSDictionary
 
 intermediateStops.geometryRef = RealTidMethods.checkNullForString((intermediateStops_Dict["JourneyDetail"]!["GeometryRef"]  as! NSDictionary), keyName: "ref")
 print("sc 4--.......Geom Ref\(intermediateStops.geometryRef)")
 
 // extract Lines
 
 let linesDict = intermediateStops_Dict["JourneyDetail"]!["Lines"]!!["Line"] as! NSDictionary
 let namesDict = intermediateStops_Dict["JourneyDetail"]!["Names"]!!["Name"] as! NSDictionary
 let lineNo = RealTidMethods.checkNullForString((linesDict), keyName: "$")
 intermediateStops.line_and_name.lineNumber = Int(lineNo)!
 
 intermediateStops.line_and_name.lineName = RealTidMethods.checkNullForString(namesDict, keyName: "$")
 
 let line_routeIdFrom = RealTidMethods.checkNullForString(linesDict, keyName: "routeIdxFrom")
 
 intermediateStops.line_and_name.routeIdFrom = Int(line_routeIdFrom)!
 
 let line_routeIdTo = RealTidMethods.checkNullForString(linesDict, keyName: "routeIdxTo")
 
 intermediateStops.line_and_name.routeIdFrom = Int(line_routeIdTo)!
 
 
 print("sc 5--.....intermediateStops.line_and_name.lineNumber  = \(intermediateStops.line_and_name.lineNumber )..")
 // extract Stops
 let stopsDict = intermediateStops_Dict["JourneyDetail"]!["Stops"]!!["Stop"] as! NSMutableArray
 
 print("---RoutIdx--From :: \(intermediateStops.directions.routeIdFrom)")
 print("---RoutIdx--To :: \(intermediateStops.directions.routeIdTo)")
 
 let realStopCount = intermediateStops.directions.routeIdFrom - intermediateStops.directions.routeIdTo
 
 print("Real Stop Count = = = = = \(realStopCount)")
 print("setOriginStop = = = = interMed stops = \(setOriginStop))")
 print("setDestStop = = = = interMed stops = \(setDestinationStop))")
 
 
 var i = 0
 for index in stopsDict {
 
 print("index = iii \(i)")
 
 
 // arr date
 let arrDate = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "arrDate")
 // arr time
 
 let arrTime = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "arrTime")
 
 // dep date
 
 let depDate = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "depDate")
 
 
 // dep time
 
 let depTime = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "depTime")
 
 // id
 
 let id = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "id")
 
 // lat
 
 let lat = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "lat")
 
 // long
 
 let long = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "lon")
 
 // name
 
 let name = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "name")
 
 // route idx
 
 let routeIdx = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "routeIdx")
 print("1ööööö")
 print("setOriginStop value is = \(setOriginStop)")
 print("setDestStop value is = \(setDestinationStop)")
 
 print("i = \(i)")
 
 // check for the origin route idx
 if (setOriginStop == i){
 print("-----caught----\(setOriginStop))")
 print(stopsDict)
 // dep date
 intermediateStops.originStop.depDate = depDate
 // dep time
 intermediateStops.originStop.depTime = depTime
 // id
 intermediateStops.originStop.id = Int(id)!
 // lat
 intermediateStops.originStop.lat  = lat
 // long
 intermediateStops.originStop.long = long
 // name
 intermediateStops.originStop.name = name
 // route idx
 intermediateStops.originStop.routeIdx = Int(routeIdx)!
 
 print("intermediateStops.originStop.routeIdx = \(intermediateStops.originStop.routeIdx)")
 }
 // check for the destination route idx
 else if (setDestinationStop == i ) {
 print("-----caught---setDestinationStop-interMed Stops-\(setDestinationStop))")
 
 // arr date
 intermediateStops.destinationStop.arrDate = arrDate
 // arr time
 intermediateStops.destinationStop.arrTime = arrTime
 // id
 intermediateStops.destinationStop.id = Int(id)!
 // lat
 intermediateStops.destinationStop.lat  = lat
 // long
 intermediateStops.destinationStop.long = long
 // name
 intermediateStops.destinationStop.name = name
 // route idx
 intermediateStops.destinationStop.routeIdx = Int(routeIdx)!
 
 print("intermediateStops.destinationStop.routeIdx = \(intermediateStops.destinationStop.routeIdx)")
 print("Destination stop.name = \(intermediateStops.destinationStop.name)")
 }
 
 else if (i > setOriginStop  && i < setDestinationStop) {
 
 print(".......interMed stops index count = \(i)")
 //print("intermediate stops = \(stopsDict.description)")
 
 let stop = Stops()
 
 print("10")
 // dep date
 
 stop.arrDate = depDate
 // dep time
 
 print("11")
 stop.depTime = depTime
 
 // arr date
 stop.arrDate = arrDate
 // arr time
 stop.arrTime = arrTime
 // id
 stop.id = Int(id)!
 // lat
 stop.lat  = lat
 // long
 stop.long = long
 // name
 stop.name = name
 // route idx
 stop.routeIdx = Int(routeIdx)!
 
 intermediateStops.intermediateStops.append(stop)
 
 }
 // check for the intermediate stops
 
 
 i++
 print("index value  intermediate stops = \(i)")
 
 
 }
 print("origin is =\(intermediateStops.originStop.name)")
 print("count of intermediate stops is = \(intermediateStops.intermediateStops.count)")
 print("Destination is =\(intermediateStops.destinationStop.name)")
 print("sc 6--.......")
 
 // 1) extract origin stop
 
 
 // 2) extract last stop
 // 3) check for the destination to avoid printing the extra names
 // Extract Types
 }
 //else {
 // check for the status code
 
 // if it is zero
 
 //            ----AFTER MAGHRIB NAMAZ IN SHA ALLAH----
 
 // if it is not zero then do the rest of the processing
 print("inside else.................")
 
 
 
 //self.tableView.reloadData()
 
 print("-intermediate stops:::::::after----tabledata count AFTER-dataSourceTrafficStatus\(dataSource_intermediateStops_StatusCode.count)")
 
 
 print("-after----tabledata count AFTER-= \(intermediateStops_Dict.count)")
 
 showRouteOnMap(intermediateStops)
 
 
 
 }
 */

// origin
// destination
// journey detail reference

// then constuct the URL for intermediate stop call

// call intermediate stops webservice

// start customising the function

// once lat, long, array is in hand as list then
// call the showRoutMap function




// temp from intermediate stops....
//--- JSON Connection for getting Trip lat & long
/* temp commented and replaced with intermediate stops same method
 
 func get_data_from_url(url:String)
 {
 
 let url:NSURL = NSURL(string: url)!
 let session = NSURLSession.sharedSession()
 
 let request = NSMutableURLRequest(URL: url)
 request.HTTPMethod = "GET"
 request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
 
 print("-INSIDE intermediate stops--json step 1---real time--test real-")
 
 let task = session.dataTaskWithRequest(request) {
 (
 let data, let response, let error) in
 
 guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
 print("error")
 return
 }
 print("-At root trip map----json step 2-----test-")
 dispatch_async(dispatch_get_main_queue(), {
 self.extract_json(data!)
 print("At root trip map-.....data from json raw = \(data)")
 print("At root trip map-in real time result--7.1--about to return after parsing")
 jsonTrafficStatusLoaded = true
 // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
 //self.getTrips(convertedJsonIntoNSDict)
 //--for-1-------------------------------------------------------------------------------------------------
 print("At root trip map-in real time result-7.2--about to return after parsing")
 // reload the table here
 // self.tableView.reloadData()
 
 return
 })
 }
 task.resume()
 }
 
 //----call webservice-----........end
 
 //---extract data from json-.------start
 
 
 func extract_json(jsonData:NSData)
 {
 print("-At root trip map---in real time result--json step 3----inside from/To--")
 let json: AnyObject?
 do {
 print("json downloading in progres........4......intermediate stops--.")
 json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
 print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
 rootTripJson_Loaded_Flag = true
 
 //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
 
 // load this json into Trip---start
 // load this json intro trip end here
 
 } catch {
 json = nil
 return
 }
 
 intermediateStops_Root_Dict = (json as? NSMutableDictionary)!
 //getTrips(convertedJsonIntoNSDict)
 print("---intermediate stops---6-----convertedJSON is being printed = \(intermediateStops_Dict.allKeys)")
 //        print("--INSIDE TRAFFIC STATUS--.....before----dataSourceTrafficStatus count before adding--= \(dataSourceTrafficStatus.count)")
 //        dataSourceTrafficStatus.removeAllObjects()
 
 
 // define a journey detail variable in the view controller intermediate stops
 // extract 1 by 1 its objects and put them in the
 if (intermediateStops_Root_Dict.count == 0){
 print("Root Trip Leg dict count is 0----")
 // check for message
 rootTrip_Map_Message = "Please try again Later......"
 //            tableData.addObject(message)
 // check for station code
 
 //dataSource_intermediateStops_StatusCode.setValue(message, forKey: "message")
 
 //            dataSource_intermediateStops_StatusCode.setValue(statusCodeInt, forKey: intermediateStops_StatusCode)
 //            dataSourceTrafficStatus.setValue(statusCode, forKey: "statusCode")
 
 
 }
 
 else {
 
 print("sc 1--.......")
 //let testDict = intermediateStops_Dict["JourneyDetail"]!["Directions"] as! NSDictionary
 
 let testDict = intermediateStops_Root_Dict["Geometry"]!["Points"] as! NSDictionary
 
 
 let root_Trip_coordinates_Array = testDict["Point"] as! NSArray
 print("root trip coordinates array count is = \(root_Trip_coordinates_Array.count)")
 
 
 // parse the lat and long
 var i = 0
 for index in  root_Trip_coordinates_Array {
 print("step 1 .....\(i) root leg map")
 
 
 let dict = root_Trip_coordinates_Array[i] as! NSDictionary
 let stops = Stops()
 print("------s-1----\(dict.allKeys)")
 stops.lat = dict["lat"] as! String
 stops.long = dict["lon"] as! String
 intermediateStops_RootTrip.intermediateStops.append(stops)
 //    intermediateStops.intermediateStops.append(stops)
 print("------s-2----")
 print("dict lat = \(dict["lat"] as! String)")
 print("dict long = \(dict["lon"] as! String)")
 print("------s-3----")
 
 i++
 
 }
 
 print("Root leg trip total stops = intermediateStops_RootTrip.intermediateStops. = \(intermediateStops_RootTrip.intermediateStops.count)")
 // draw the route
 showRouteOnMap(intermediateStops_RootTrip)
 
 //---------------------------------------------------------------intermediate stops parsing---start
 /*
 
 print("printing all keys-.-.. Root Trip Map = \(testDict.allKeys)")
 // extract directions
 print("sc 1--.......")
 let directionsDict = intermediateStops_Dict["JourneyDetail"]!["Directions"] as! NSDictionary
 
 let directionsArrayTest = RealTidMethods.checkIfArray(directionsDict["Direction"]!)
 
 
 if (directionsArrayTest == false){
 
 print("Dict caught")
 
 intermediateStops.directions.directionName = RealTidMethods.checkNullForString((directionsDict["Direction"]! as! NSDictionary), keyName: "$")
 
 print("sc 2--.......")
 // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
 let routeIdfrm = RealTidMethods.checkNullForString((directionsDict["Direction"] as! NSDictionary), keyName: "routeIdxFrom")
 
 intermediateStops.directions.routeIdFrom = Int(routeIdfrm)!
 
 let routeIdto = RealTidMethods.checkNullForString(directionsDict["Direction"] as!
 NSDictionary, keyName: "routeIdxTo")
 intermediateStops.directions.routeIdTo = Int(routeIdto)!
 
 }
 else  {
 
 print("Array caught-.--......")
 
 let directionsArray = directionsDict["Direction"]! as! NSArray
 let directionsDictFromArray = directionsArray[0] as! NSDictionary
 
 intermediateStops.directions.directionName = RealTidMethods.checkNullForString((directionsArray[0] as! NSDictionary), keyName: "$")
 
 print("sc 2--.......")
 // RealTidMethods.checkNullForString(<#T##someValue: NSDictionary##NSDictionary#>, keyName: <#T##String#>)
 let routeIdfrm = RealTidMethods.checkNullForString((directionsArray[0] as! NSDictionary), keyName: "routeIdxFrom")
 
 intermediateStops.directions.routeIdFrom = Int(routeIdfrm)!
 
 let routeIdto = RealTidMethods.checkNullForString((directionsArray[0] as! NSDictionary), keyName: "routeIdxTo")
 
 print("direction Arrya count = \(directionsArray.count)")
 
 intermediateStops.directions.routeIdTo = Int(routeIdto)!
 
 }
 
 
 print("sc 3--.......")
 
 //  var test = intermediateStops_Dict["Directions"]!["$"] as! String
 //print("VALUE RECEIVED FOR DIRECTIONS.$ in dict = \(test)")
 print("VALUE RECEIVED FOR DIRECTIONS.$ = \(intermediateStops.directions.directionName)")
 
 // extract geom reference
 // let geomRefDict  = intermediateStops_Dict["JourneyDetail"]!["GeometryRef"]  as! NSDictionary
 
 intermediateStops.geometryRef = RealTidMethods.checkNullForString((intermediateStops_Dict["JourneyDetail"]!["GeometryRef"]  as! NSDictionary), keyName: "ref")
 print("sc 4--.......Geom Ref\(intermediateStops.geometryRef)")
 
 // extract Lines
 
 let linesDict = intermediateStops_Dict["JourneyDetail"]!["Lines"]!!["Line"] as! NSDictionary
 let namesDict = intermediateStops_Dict["JourneyDetail"]!["Names"]!!["Name"] as! NSDictionary
 let lineNo = RealTidMethods.checkNullForString((linesDict), keyName: "$")
 intermediateStops.line_and_name.lineNumber = Int(lineNo)!
 
 intermediateStops.line_and_name.lineName = RealTidMethods.checkNullForString(namesDict, keyName: "$")
 
 let line_routeIdFrom = RealTidMethods.checkNullForString(linesDict, keyName: "routeIdxFrom")
 
 intermediateStops.line_and_name.routeIdFrom = Int(line_routeIdFrom)!
 
 let line_routeIdTo = RealTidMethods.checkNullForString(linesDict, keyName: "routeIdxTo")
 
 intermediateStops.line_and_name.routeIdFrom = Int(line_routeIdTo)!
 
 
 print("sc 5--.....intermediateStops.line_and_name.lineNumber  = \(intermediateStops.line_and_name.lineNumber )..")
 // extract Stops
 let stopsDict = intermediateStops_Dict["JourneyDetail"]!["Stops"]!!["Stop"] as! NSMutableArray
 
 print("---RoutIdx--From :: \(intermediateStops.directions.routeIdFrom)")
 print("---RoutIdx--To :: \(intermediateStops.directions.routeIdTo)")
 
 let realStopCount = intermediateStops.directions.routeIdFrom - intermediateStops.directions.routeIdTo
 
 print("Real Stop Count = = = = = \(realStopCount)")
 print("setOriginStop = = = = interMed stops = \(setOriginStop))")
 print("setDestStop = = = = interMed stops = \(setDestinationStop))")
 
 
 var i = 0
 for index in stopsDict {
 
 print("index = iii \(i)")
 
 
 // arr date
 let arrDate = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "arrDate")
 // arr time
 
 let arrTime = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "arrTime")
 
 // dep date
 
 let depDate = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "depDate")
 
 
 // dep time
 
 let depTime = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "depTime")
 
 // id
 
 let id = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "id")
 
 // lat
 
 let lat = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "lat")
 
 // long
 
 let long = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "lon")
 
 // name
 
 let name = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "name")
 
 // route idx
 
 let routeIdx = RealTidMethods.checkNullForString(stopsDict[i] as! NSDictionary, keyName: "routeIdx")
 print("1ööööö")
 print("setOriginStop value is = \(setOriginStop)")
 print("setDestStop value is = \(setDestinationStop)")
 
 print("i = \(i)")
 
 // check for the origin route idx
 if (setOriginStop == i){
 print("-----caught----\(setOriginStop))")
 print(stopsDict)
 // dep date
 intermediateStops.originStop.depDate = depDate
 // dep time
 intermediateStops.originStop.depTime = depTime
 // id
 intermediateStops.originStop.id = Int(id)!
 // lat
 intermediateStops.originStop.lat  = lat
 // long
 intermediateStops.originStop.long = long
 // name
 intermediateStops.originStop.name = name
 // route idx
 intermediateStops.originStop.routeIdx = Int(routeIdx)!
 
 print("intermediateStops.originStop.routeIdx = \(intermediateStops.originStop.routeIdx)")
 }
 // check for the destination route idx
 else if (setDestinationStop == i ) {
 print("-----caught---setDestinationStop-interMed Stops-\(setDestinationStop))")
 
 // arr date
 intermediateStops.destinationStop.arrDate = arrDate
 // arr time
 intermediateStops.destinationStop.arrTime = arrTime
 // id
 intermediateStops.destinationStop.id = Int(id)!
 // lat
 intermediateStops.destinationStop.lat  = lat
 // long
 intermediateStops.destinationStop.long = long
 // name
 intermediateStops.destinationStop.name = name
 // route idx
 intermediateStops.destinationStop.routeIdx = Int(routeIdx)!
 
 print("intermediateStops.destinationStop.routeIdx = \(intermediateStops.destinationStop.routeIdx)")
 print("Destination stop.name = \(intermediateStops.destinationStop.name)")
 }
 
 else if (i > setOriginStop  && i < setDestinationStop) {
 
 print(".......interMed stops index count = \(i)")
 //print("intermediate stops = \(stopsDict.description)")
 
 let stop = Stops()
 
 print("10")
 // dep date
 
 stop.arrDate = depDate
 // dep time
 
 print("11")
 stop.depTime = depTime
 
 // arr date
 stop.arrDate = arrDate
 // arr time
 stop.arrTime = arrTime
 // id
 stop.id = Int(id)!
 // lat
 stop.lat  = lat
 // long
 stop.long = long
 // name
 stop.name = name
 // route idx
 stop.routeIdx = Int(routeIdx)!
 
 intermediateStops.intermediateStops.append(stop)
 
 }
 // check for the intermediate stops
 
 
 i++
 print("index value  intermediate stops = \(i)")
 
 
 }
 print("origin is =\(intermediateStops.originStop.name)")
 print("count of intermediate stops is = \(intermediateStops.intermediateStops.count)")
 print("Destination is =\(intermediateStops.destinationStop.name)")
 print("sc 6--.......")
 */
 
 //----------------------------------------end of intermediate stops parsing..............end..
 // 1) extract origin stop
 
 
 // 2) extract last stop
 // 3) check for the destination to avoid printing the extra names
 // Extract Types
 }
 //else {
 // check for the status code
 
 // if it is zero
 
 //            ----AFTER MAGHRIB NAMAZ IN SHA ALLAH----
 
 // if it is not zero then do the rest of the processing
 print("inside else........root leg map.........")
 
 
 
 //self.tableView.reloadData()
 
 // print("-intermediate stops:::::::after----tabledata count AFTER-dataSourceTrafficStatus\(dataSource_intermediateStops_StatusCode.count)")
 
 
 //print("-after----tabledata count AFTER-= \(intermediateStops_Dict.count)")
 
 }
 */ // temp commented



// construct the
//                let origin = CLLocation(latitude: 33.9424955, longitude: -118.4080684)
//                let destination = CLLocation(latitude: 40.6397511, longitude: -73.7789256)
//
//        drawLineBetweenTwoStops(origin.coordinate, destinationLocation2D: destination.coordinate)

/*
 // 1.
 mapView.delegate = self
 
 // 2.
 let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
 let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
 
 // 3.
 let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
 let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
 
 // 4.
 let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
 let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
 
 // 5.
 let sourceAnnotation = MKPointAnnotation()
 sourceAnnotation.title = "Times Square"
 
 if let location = sourcePlacemark.location {
 sourceAnnotation.coordinate = location.coordinate
 }
 
 
 let destinationAnnotation = MKPointAnnotation()
 destinationAnnotation.title = "Empire State Building"
 
 if let location = destinationPlacemark.location {
 destinationAnnotation.coordinate = location.coordinate
 }
 
 // 6.
 self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
 
 // 7.
 let directionRequest = MKDirectionsRequest()
 directionRequest.source = sourceMapItem
 directionRequest.destination = destinationMapItem
 directionRequest.transportType = .Automobile
 
 // Calculate the direction
 let directions = MKDirections(request: directionRequest)
 
 // 8.
 directions.calculateDirectionsWithCompletionHandler {
 (response, error) -> Void in
 
 guard let response = response else {
 if let error = error {
 print("Error: \(error)")
 }
 
 return
 }
 
 let route = response.routes[0]
 self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
 
 let rect = route.polyline.boundingMapRect
 self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
 }
 */

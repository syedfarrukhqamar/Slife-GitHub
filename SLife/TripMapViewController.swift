//
//  TripMapViewController.swiftsetspan

//  SLife
//
//  Created by syed farrukh Qamar on 28/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation

//  MapTripViewControllers.swift
//  SLife
//
//  Created by syed farrukh Qamar on 18/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit
var draw = 0

// transportImages
let MORE_ICON_NAME = "MORELEGSDEP.png"
let BUS_ICON_NAME = "BUS.png"
let WALK_ICON_NAME = "WALK.png"
let TRAM_ICON_NAME = "TRAM.png"
let TRAIN_ICON_NAME = "TRAIN.png"
let METRO_ICON_NAME = "METRO.png"
let LIGHT_RAIL_ICON_NAME = "TRAM.png"
let SHIP_ICON_NAME = "SHIP.png"

let transportType = "TransportTypeIcon"
//------------------------
let tunnalBana = "METRO"
let commuterTrain = "COMMUTER RAIL"
let tramAndLightRail = "TRAM AND LIGHT RAIL"
let bus = "BUSES"
let ship = "SHIPS"


//MARK: Global Declarations
let chicagoCoordinate = CLLocationCoordinate2DMake(41.8832301, -87.6278121)// 0,0 Chicago street coordinates

//var drawRootUrlsArray = NSMutableArray()
//var lastLegFlag = false
//var downloadingFinished = false
////var rootLeg_setOrigin = Int()
////
////var rootLeg_setDestination = Int()
//
//var selectedRootTripForMap = NSMutableArray()
//var getDataCount = 0
//var jsonExtractCount = 0
//// https://api.sl.se/api2/TravelplannerV2/geometry.json?key=28650f61c688449cb9e87c13fbbf8b5b&
//
//// webservice related variables

////var intermediateStops_Root_Dict = NSMutableDictionary()
//var rootTrip_intermediateStops_MasterStocking = IntermediateStops()

//// journey detail ref variables
//var rootTrip_json_IntermediateStopsLoaded_flag = false
//let rootTrip_MESSAGE_INTERMEDIATE_STOPS = "Message"
//var rootTrip_intermediateStops_Dict = NSMutableDictionary()
//var rootTrip_intermediateStops_Array = NSMutableArray()
//let rootTrip_intermediateStops_Status = Int()
//var rootTrip_dataSource_intermediateStops_StatusCode = NSMutableDictionary()
//var coordinatesToDrawRoot: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
//let rootTrip_IntermediateStops_URL = "https://api.sl.se/api2/TravelplannerV2/journeydetail.json?key=28650f61c688449cb9e87c13fbbf8b5b&"
//
//let rootTrip_URL = "https://api.sl.se/api2/TravelplannerV2/geometry.json?key=28650f61c688449cb9e87c13fbbf8b5b&"
// >> & ref=202422%2F82420%2F794926%2F329989%2F74%26startIdx%3D4%26endIdx%3D14%26lang%3Dsv%26format%3Dxml%26"


//let rootTrip_URL = "http//api.sl.se/api2/TravelplannerV2/geometry.<FORMAT>?key=<DIN API NYCKEL>& ref=202422%2F82420%2F794926%2F329989%2F74%26startIdx%3D4%26endIdx%3D14%26lang%3Dsv%26format%3Dxml%26"

class TripMapViewControllers: UIViewController, MKMapViewDelegate, MKOverlay {
  
    @IBAction func back_action(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        print("back button has been pressed")
    
    }
    
     var boundingMapRect = MKMapRect()

     var coordinate = CLLocationCoordinate2D()

  
    var stationLocationArray = [StationsLocation]()
    let mapLegsBoundInfo = NSMutableArray()
    let DESTINATION = "DESTINATION"
    let ORIGIN = "ORIGIN"
    var lastLegFlagRootLevel = false
    var colorValue = UIColor()
    var transportTypeIconName = String()
    var mapBatchesToDraw = NSMutableArray()
    

    var transportInfo = NSMutableDictionary()
    
    let stationPin = UIImage(named: "stopsCircle.png")
    var c = 0
    var annotationIndex = 0
    // major dict
    var downloadedRawJsonDict = NSMutableDictionary()
    
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
//        print("is the one 9009")
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.bordered, target: self, action: "back:")
//        self.navigationItem.leftBarButtonItem = newBackButton
        
//        resetRegion()
        mapView.delegate = self
        // check for the flag if request is from the trip view controller then
        print(" trip map vc ...1= tripRootMapFlag = \(tripRootMapFlag) ")
        var finalURL = String()
        if(tripRootMapFlag == true){
            print(" trip map vc ... 2")
            finalURL = rootTrip_IntermediateStops_URL + rootMap_Ref
            print("TripMapViewController: final URL = \(finalURL)")
            // MARK: SWIFT 3
//             let serialQueue = dispatch_queue_create("com.appcoda.imagesQueue", DISPATCH_QUEUE_SERIAL)

            let serialQueue = DispatchQueue(label: "myQueue")
            
//            <#T##attr: __OS_dispatch_queue_attr?##__OS_dispatch_queue_attr?#>
            //MARK:- Extract Values to construct url
            serialQueue.async() { () -> Void in
            print("----------------------First------in que")
            self.extractValuesToDrawMapOfTrip()
            }
            //MARK:- Connect & Get Dictionary from WebServices
            serialQueue.async() { () -> Void in
                var b = 0
                for index in drawRootUrlsArray {
                let dictionary = drawRootUrlsArray[b] as! NSDictionary
                    print("leg index in draw root url = \(dictionary["legIndex"])")
                    b += 1
                }
            }
            serialQueue.async() { () -> Void in
            print("----------------------2------in que---start")
//            self.get_data_from_url((drawRootUrlsArray[0] as! NSDictionary))
            var u = 0
            for w in drawRootUrlsArray {
                print("after if last let flag root level = \(self.lastLegFlagRootLevel)")
                    print("drawRootUrlsArray[u] as! NSDictionary............... = \(drawRootUrlsArray[u] as! NSDictionary)")
                        
                self.get_data_from_url(rootTripDict: (drawRootUrlsArray[u] as! NSDictionary))
                print("---------------------")
                print((drawRootUrlsArray[u] as AnyObject).allKeys)
//                print("Leg index ==== \(drawRootUrlsArray[u]["legIndex"]!)")
//                print("Final Url to get data from  ==== \(drawRootUrlsArray[u]["finalRootLegIntermediateURL"]!)")
                print("total legs = \(drawRootUrlsArray.count)")
                print("w::::::::\(u)")
                u += 1
            }
                print("----------------------2------in que---end")
                print("finished after extracting values to draw map of trip")
}
            serialQueue.async() { () -> Void in
                print("----------------------3------in que---start")
                print("end end end end end")
            //            //MARK:- Parse Json
            
//            iterate through the drawRootUrlsArray[u]["legIndex"]
            var p = 0
            //print("going to print leg index")
                while(downloadingNotFinished){
                    print ("not finished")
                    
                }
                
                
                print("Downloading not finished ? =====\(downloadingNotFinished)")
                print("intermediateStops_JSON_Loaded_Flag  ? =====\(intermediateStops_JSON_Loaded_Flag)")
                
                
                for index in drawRootUrlsArray {
//            print("-111-------------------------------------start")
//            print("\(drawRootUrlsArray[p]["legIndex"])")
                print("-111-------------------------------------end")
                p += 1
            }
            }
               }
        else if (intermediateStops_JSON_Loaded_Flag == true){
            print(" trip map vc ...3 ")
            showRouteOnMap(intermediateStopsObject: intermediateStops)
            print("intermediate Stops show route map has been called.........")
           // self.mapView.delegate = self
        }
        
    }
     func resetRegion(){
        let region = MKCoordinateRegionMakeWithDistance(chicagoCoordinate, 5000, 5000)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    // MARK: MKMapViewDelegate
    // MARK: rendererForOverlay B
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
    /*
    func mapView(mapView: MKMapView!,
                 viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (annotation is MKUserLocation) { return nil }

        let reuseID = "stops"
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        
        if v != nil {
            v!.annotation = annotation
        } else {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            
            v!.image = UIImage(named:"stops.png")
            print("annotation........title.....\(v?.annotation?.title)")
            print("annotation........subtitle.....\(v?.annotation?.subtitle)")
            
        }
        
        return v
    }
    
    */
    //MARK: MapView
    
    
    
   
   
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        // MARK: MAP View draw
        
        print("inside map view route draw before if..2....")
        polylineRenderer.strokeColor = colorValue
        polylineRenderer.lineWidth = 5
        
        
        if overlay is MKPolyline {
            print("inside map view route inside if...2...-----794--\(colorValue)")
            
            polylineRenderer.strokeColor = colorValue
           
            let colorTrue = true
            
            if (colorTrue == true) {
            polylineRenderer.strokeColor = colorValue
                
                polylineRenderer.lineWidth = 5
                
            }
            else
            {
            
              //  polylineRenderer.strokeColor = UIColor.blueColor()
                polylineRenderer.strokeColor = colorValue
                
                polylineRenderer.lineWidth = 5
          
            }

        }
        return polylineRenderer
    }
    
 
    // MARK: DidSelectAnnotationView
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
        // Don't proceed with custom callout
            return
        }
        let stationLocationAnnotation = view.annotation as! StationsLocation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.title.text = stationLocationAnnotation.title
        calloutView.lineNo.text = stationLocationAnnotation.line
        calloutView.direction.text = stationLocationAnnotation.direction
        calloutView.depTime.text = stationLocationAnnotation.departureTime
        calloutView.annotationIndex.text = String(describing: stationLocationAnnotation.annotationIndex)
        calloutView.annotationIndex.isHidden = true
        // MARK: TransportType Icon Name Check
        print("............987")
        print(stationLocationAnnotation.line)
        print(stationLocationAnnotation.lineName)
        let transportModeDict = identifyTransportMode(lineNo: Int(stationLocationAnnotation.line!)!,LineName: stationLocationAnnotation.lineName!)
        print("annottion selected :: transportModeDict ==== all keys = \(transportModeDict.allKeys)")
        print("annottion selected :: Transport Icon Name :::TripMapViewController:: \(transportModeDict["TransportTypeIcon"] as! String)")
        colorValue = transportModeDict["lineColor"] as! UIColor
        transportTypeIconName = transportModeDict["TransportTypeIcon"] as! String
        
        print("line Name ::: select Annotation......")
        print(stationLocationAnnotation.lineName)
        print("transportTypeIconName value when annotation is selected = = \(transportTypeIconName)")
        calloutView.transportType.image = UIImage(named: transportTypeIconName)
    
        print("stationLocationAnnotation.title.......\(stationLocationAnnotation.title)")
        print("stationLocationAnnotation.line.......\(stationLocationAnnotation.line)")
        print("stationLocationAnnotation.direction.......\(stationLocationAnnotation.direction)")
        print("stationLocationAnnotation.departureTime.......\(stationLocationAnnotation.departureTime)")
//       print("Annotation has been selected ::::: \()")
        let selectedAnnotation = view.annotation as! StationsLocation
         print("Annotation has been selected ::index = ::: \(selectedAnnotation.annotationIndex)")
        
//        calloutView.starbucksAddress.text = starbucksAnnotation.address
//        calloutView.starbucksPhone.text = starbucksAnnotation.phone
//        let tapGesture = UITapGestureRecognizer(target: self, action: "CallPhoneNumber:")
//        calloutView.starbucksPhone.addGestureRecognizer(tapGesture)
//        calloutView.starbucksPhone.userInteractionEnabled = true
//        calloutView.starbucksImage.image = starbucksAnnotation.image
//        // 3
      //  calloutView.center = CGPointMake(view.bounds.size.width / 2, -calloutView.bounds.size.height*0.52)
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
    
        view.addSubview(calloutView)
        
        
    }
    // MARK: Annotation View
    /*
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? StationsLocation {
//            
            
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier){
                return view
            }else{
                
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)

                view.image = stationPin
                view.isEnabled = true
                view.canShowCallout = false
                view.leftCalloutAccessoryView = UIImageView(image: stationPin)
                view.backgroundColor = UIColor.black
                print("c =annotationIndex == current \(c)")
                
            let ind = Int(annotation.annotationIndex!)
                print("ind--------------------090 \(ind)")
                
                if (ind == 0){
                   print("annotation caught..........")
                 //   mapView.selectAnnotation(annotation, animated: true)
                print(annotation.identifier)
                    print(annotation.index(ofAccessibilityElement: annotation))
                
                    
                }
                
                print(annotation.title)
                
                print(annotation.line)
                
                print(annotation.direction)
                c += 1
                return view
            }
        }

        /*
        else{
            if let annotation = annotation as? ChicagoCenterCoordinate{
                if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier("center"){
                    return dequeuedView
                }else {
                    let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "center")
                    view.image = crossHairs
                    view.enabled = true
                    view.canShowCallout = true
                    return view
                }
            }
        }
        */
        return nil
    }
   */
    
 func drawLineBetweenTwoStops(originLocation2D : CLLocationCoordinate2D,destinationLocation2D: CLLocationCoordinate2D) {
 
    
    print("draw Line Between Two Stops..........")
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
        //    let geodesicPolyline = MKGeodesicPolyline(&coordinates: coordinates, count: 2)
            
            let geodesicPolyline = MKGeodesicPolyline(coordinates: coordinates, count: 2)
            
            mapView.add(geodesicPolyline)
            
        }
        
    }
    
    // MARK: Show Annotations
    /*
     func showAnnotations(lat: Double, long: Double , title: String, stationsName: String, transportType:String){
        // show artwork on map
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let stationBaloons = MapAnnotations_IntermediateStations(title: title, stationName: stationsName, transportType: transportType, coordinate: coordinates)
        mapView.addAnnotation(stationBaloons)
        
        //        let artwork = Artwork(title: "King David Kalakaua",
        //                              stationName: "Waikiki Gateway Park",
        //                              discipline: "Sculpture",
        //                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        //
        // mapView.addAnnotation(artwork)
     }
    */
    
    // MARK: Set Span and Region
    
    func setSpanAndRegion(lat: Double, long: Double, regionRadius: Int ){
        
        // set the span to provided coordinates
        let initialLocation = CLLocation(latitude: lat, longitude: long)
        
        // set the region
        
        let regionRadius: CLLocationDistance = CLLocationDistance(regionRadius)
       
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 1.1, regionRadius * 1.2)
            
            mapView.setRegion(coordinateRegion, animated: true)
        }
         print("centrering map based on the following lat and long = \(initialLocation)")
       centerMapOnLocation(location: initialLocation)
        
        
    }
    
    //MARK: rendererForOverlay a
    /*

     func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
     let renderer = MKPolylineRenderer(overlay: overlay)
     renderer.strokeColor = UIColor.redColor()
     renderer.lineWidth = 4.0
     
     return renderer
     }
     */
    
    
    
    // temp from intermediate stops.......
    // replacing get_data_from_url(rootTripDict) with the GCD based block function
    
    
    
    func get_data_from_url(rootTripDict: NSDictionary)
    {
        let url1 = rootTripDict.value(forKey: "finalRootLegIntermediateURL") as! String
        let legindxIngetDataURL = rootTripDict.value(forKey: "legIndex")
        print("legindxIngetDataURL--------:::: \(legindxIngetDataURL)")
        
                let url:NSURL = NSURL(string: url1)!
        // let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
//   MARK:- final url for map draw
        print("...url to get data from = \(url)")
        let request = NSMutableURLRequest(url: url as URL)
        //---------------------------
         //---------------------------
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        print("-INSIDE intermediate stops--json step 1---real time--test real-")
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            print(" about to download data ::: 1")
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
             //------------------------------------
            print("------------get data from url-----------start")
            print(data)
           

            // MARK: Swift 3 temp 
            // uncommented below three lines
            
//            if (data != nil){
//            
////                self.extract_json(data!,rootTripDict: rootTripDict)
//            
//            }
//            
            let legIndex = rootTripDict.value(forKey: "legIndex") as! String
            
            self.downloadedRawJsonDict.setValue(data, forKey: legIndex)
            print("---getDataCount = \(getDataCount)---------get data from url-----------start \(self.downloadedRawJsonDict.allKeys)")
          getDataCount += 1
            let totalCount = drawRootUrlsArray.count
            print("get data count && total count ==== =\(getDataCount) &&&& \(totalCount)")
            if (getDataCount == totalCount){
            
                print("downloadedddddd....\(getDataCount)..\(totalCount)..")
                print("-downloadedddddd-getDataCount = \(getDataCount)---------get data from url-----------start \(self.downloadedRawJsonDict.allKeys)")
                self.extractAllDownloadedJson(rawJson: self.downloadedRawJsonDict,rootTripDict: rootTripDict)
              //  print("self.downloadedRawJsonDict = \(self.downloadedRawJsonDict.debugDescription)")
                downloadingNotFinished = false
                
        // write a function to call ex
            
            }
            
        }
        task.resume()
    }
    // MARK:- currently working
    func extractAllDownloadedJson(rawJson: NSMutableDictionary,rootTripDict: NSDictionary ){
        var q = 0
//        dispatch_get_main_queue().asynchronously(execute: {
        DispatchQueue.main.async(execute: {

        print("rootTripDict.allKeys=====\(rootTripDict.allKeys)")
            print("drawRootUrlsArray.count=====\(drawRootUrlsArray.count)")
            
        for index in drawRootUrlsArray {
            
            let totalLegCounts = q + 1
            print("------totalLegCounts = \(totalLegCounts)----drawrooturlsArrays \(drawRootUrlsArray.count)")
            print("before if last let flag root level = \(self.lastLegFlagRootLevel)")
            if (drawRootUrlsArray.count == totalLegCounts){
                //MARK:- current working 2
                
                print("last leg has been caught....... in extract ...")
                self.lastLegFlagRootLevel = true
            }
             let rootTripDictToSend = drawRootUrlsArray[q] as! NSDictionary
            
            let legIdx = ( drawRootUrlsArray[q] as! [String: AnyObject])["legIndex"] as! String
            
            
            
        print("legidx ====== \(legIdx)")
       
         let nsdata =    rawJson.value(forKey: legIdx) as! NSData
       self.extract_json(jsonData: nsdata, rootTripDict: rootTripDictToSend,legIndx: legIdx)
            print("------rawjson rawjson.-----Line661--")
         //   print(rawJson.description)
            
        q += 1
        }
            return
        })
    }
    func showRouteOnMap(intermediateStopsObject: IntermediateStops){
        
        var i = 0
        var midStation = intermediateStops.intermediateStops.count/2
        print("mid Station :::::::\(midStation)")
        print("intermediate stops status in MAP KIT = \(intermediateStopsObject.intermediateStops.count)")
        
        var firstLat = Double()
        var firstLong = Double()
        var lastLat = Double()
        var lastLong = Double()
        
        var Long = Double()

        for index in intermediateStopsObject.intermediateStops {
            //            print("in intermediate stops stops")
            //
            print("------------i--------\(i)")
           
            let lat = Double(intermediateStopsObject.intermediateStops[i].lat)!
            
            let long = Double(intermediateStopsObject.intermediateStops[i].long)!
            if (i == 0){
            
            firstLat = lat
            firstLong = long
                
            } else if ((i + 1) == intermediateStopsObject.intermediateStops.count) {
            
            lastLat = lat
            lastLong = long
            
            }
            // show annotations on the map
            print("::::::S1::::::")
            // Mark: populate Annotations Array
            
           // showAnnotations(lat, long:long, title: intermediateStopsObject.intermediateStops[i].name, stationsName: intermediateStopsObject.intermediateStops[i].name, transportType: intermediateStopsObject.intermediateStops[i].name)
            
            
            // set the span and region to mid station if reached
            // MARK: Mid Station Stop On Map
            if (midStation == i)
            {
                print("setting span and region :::::::")
                print("\(lat),\(long)")
                setSpanAndRegion(lat: lat, long: long, regionRadius: 30000)
                
                
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
            
            print("test 101019")
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

    /*
    func get_data_from_url(rootTripDict: NSDictionary)
    {
        let url1 = rootTripDict.valueForKey("finalRootLegIntermediateURL") as! String
        
        print("........get count = \(getDataCount++)")
        let url:NSURL = NSURL(string: url1)!
        
        // let url:NSURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        print("...url to get data from = \(url)")
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        print("-INSIDE intermediate stops--json step 1---real time--test real-")
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            print(" about to download data ::: 1")
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            print("-intermediate stops----json step 2-----test-")
            dispatch_async(dispatch_get_main_queue(), {
                self.extract_json(data!,rootTripDict: rootTripDict)
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
    */
    
    //----call webservice-----........end
    
    //---extract data from json-.------start
    
    // replacing with replacement
    
    
    func extract_json(jsonData:NSData,rootTripDict: NSDictionary,legIndx: String)
    {
        //let legIndex = Int(legInd)!
        print("-test 12344..........------extract json test 1")
        let dict = rootTripDict as! NSDictionary
        print("test 12344..........\(rootTripDict.allKeys)")
        let fromIdx = dict.value(forKey: "rootLeg_setOrigin") as! Int
        let toIdx = dict.value(forKey: "rootLeg_setDestination") as! Int
         let legIndex = dict.value(forKey: "legIndex")  as! String
        //let legIndex = legIndx
        let rootLeg_setOrigin = fromIdx
        let rootLeg_setDestination = toIdx
        print("leg index in extract json = ::::\(legIndex)")
       // print("get json count ::::::::::\(jsonExtractCount++)")
        print("--intermediate stops------in real time result--json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("json downloading in progres........4......intermediate stops--.")
            // MARK: Swift 3
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! AnyObject
            print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
            print("in real time result-------json just downloaded.......5...from/To.....\(json!["JourneyDetail"])")
            
            rootTrip_json_IntermediateStopsLoaded_flag = true
            
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
        
        print("json::::::1010:\(json)")
        rootTrip_intermediateStops_Dict = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---intermediate stops---6-----convertedJSON is being printed = \(rootTrip_intermediateStops_Dict.allKeys)")
        //        print("--INSIDE TRAFFIC STATUS--.....before----dataSourceTrafficStatus count before adding--= \(dataSourceTrafficStatus.count)")
        //        dataSourceTrafficStatus.removeAllObjects()
        
        
        // define a journey detail variable in the view controller intermediate stops
        // extract 1 by 1 its objects and put them in the
       
        // MARK: MAP intermediateStops not found
        
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
            
            // MARK: checking intermediate stops
        else {
            print("root trip intermediate url \(rootTrip_IntermediateStops_URL)")
            print("sc 1--.......\(rootTrip_intermediateStops_Dict.allKeys)")
            print("sc 1--.......\(rootTrip_intermediateStops_Dict.allValues)")
            // Mark: Swift 3
            // MARK: Nil
            let testDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]! as! NSDictionary)["Directions"] as! NSDictionary
            
            print("printing all keys = \(testDict.allKeys)")
            // extract directions
            print("sc 1--...a....")
            let directionsDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String:AnyObject]) ["Directions"] as! NSDictionary
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
            rootTrip_intermediateStops_MasterStocking.geometryRef = RealTidMethods.checkNullForString(someValue: ((rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String:AnyObject]) ["GeometryRef"]  as! NSDictionary), keyName: "ref")
            print("sc 4--.......Geom Ref\(rootTrip_intermediateStops_MasterStocking.geometryRef)")
            
            // extract Lines
            let linesDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]! as! [String:AnyObject])["Lines"]!["Line"] as! NSDictionary
            let namesDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]!  as! [String:AnyObject])["Names"]!["Name"] as! NSDictionary
            let lineNo = RealTidMethods.checkNullForString(someValue: (linesDict), keyName: "$")
            print("line no check ..linesDict...\(linesDict)")
            
            print("line no check ..lineNo...\(lineNo)")
            rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber = Int(lineNo)!
            
            rootTrip_intermediateStops_MasterStocking.line_and_name.lineName = RealTidMethods.checkNullForString(someValue: namesDict, keyName: "$")
            
            let line_routeIdFrom = RealTidMethods.checkNullForString(someValue: linesDict, keyName: "routeIdxFrom")
            
            rootTrip_intermediateStops_MasterStocking.line_and_name.routeIdFrom = Int(line_routeIdFrom)!
            
            let line_routeIdTo = RealTidMethods.checkNullForString(someValue: linesDict, keyName: "routeIdxTo")
            
            rootTrip_intermediateStops_MasterStocking.line_and_name.routeIdFrom = Int(line_routeIdTo)!
            print("sc 5--.....rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber  = \(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber )..")
            
            print("sc 5--.....rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber  = \(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber )..")
            
            
            // extract Stops
            let stopsDict = (rootTrip_intermediateStops_Dict["JourneyDetail"]!  as! [String:AnyObject])["Stops"]!["Stop"] as! NSArray
            
            print("---RoutIdx--From :: \(rootTrip_intermediateStops_MasterStocking.directions.routeIdFrom)")
            print("---RoutIdx--To :: \(rootTrip_intermediateStops_MasterStocking.directions.routeIdTo)")
            
            let realStopCount = rootTrip_intermediateStops_MasterStocking.directions.routeIdFrom - rootTrip_intermediateStops_MasterStocking.directions.routeIdTo
            
            print("Real Stop Count = = = = = \(realStopCount)")
            print("setOriginStop = = = = interMed stops = \(fromIdx))")
            print("setDestStop = = = = interMed stops = \(toIdx))")
            var i = 0
            // MARK: Populating Stops 
            
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
                
                let direction = rootTrip_intermediateStops_MasterStocking.directions.directionName
                let line = rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber
                let lineName = rootTrip_intermediateStops_MasterStocking.line_and_name.lineName
            
                // MARK: Setting Origin Stop 
                // MARK: route idx
                
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
                stop.directionName = direction
                stop.lineName = lineName
                stop.line = String(line)
                
                print("----------------------------stop- base values--------")
                print("stop.name \(stop.name)")
                print("stop.directionName \(stop.directionName)")
                print("stop.line \(stop.line)")
                print("stop.lineName \(stop.lineName)")
                print("stop.legIndex \(stop.legIndex)")
                print("stop.name \(stop.name)")
              //                print(":::::::::name =\(rootTrip_intermediateStops_MasterStocking.intermediateStops[i].name)) .......i =.\(i).......adding stops in master root trip = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
                // check for the origin route idx
                print("rootLeg Origin value is = \(fromIdx)")
                print("rootLeg Destination value is = \(toIdx)")
                print("i = \(i)")
                
                if (fromIdx == i){
                    print("in root leg Set origin = -------------------------------")
                    print("-----caught----\(setOriginStop))")
                    print(stopsDict)
                    stop.originOrDestination = ORIGIN
                    print("1::::: setOriginStop::stop.arrTime: \(stop.arrTime)")
                    print("1::::: setOriginStop::stop.depTime: \(stop.depTime)")
                    print("1::::: setOriginStop::stop.depTime: \(stop.name)")
                    
                    
                    // MARK: MAP Route Making
                    
                     rootTrip_intermediateStops_MasterStocking.intermediateStops.append(stop)
                    
                    // switch off ------------------
                    
            //        showAnnotations(Double(rootTrip_intermediateStops_MasterStocking.originStop.lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.originStop.long)!, title: rootTrip_intermediateStops_MasterStocking.originStop.name, stationsName: String(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber), transportType: rootTrip_intermediateStops_MasterStocking.line_and_name.lineName)
                    
                }
                    // MARK: Setting Stop.Destination
                    // MARK: Destination Route Idx
                    // check for the destination route idx
                else if (toIdx == i ) {
                    
                    print("in root leg Set Destination = ------------------\(i)---")
                  //  let stop = Stops()
                    
                    print("-----caught---setDestinationStop-interMed Stops-\(setDestinationStop))")
                    
                    stop.originOrDestination = DESTINATION
                    print("---------------leg index in destination is = \(stop.legIndex)")
                     rootTrip_intermediateStops_MasterStocking.intermediateStops.append(stop)
                                    // show the Root Destination Leg name here
            
                    // switch off ------------------
                 //   showAnnotations(Double(rootTrip_intermediateStops_MasterStocking.destinationStop.lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.destinationStop.long)!, title: rootTrip_intermediateStops_MasterStocking.destinationStop.name, stationsName: String(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber), transportType: rootTrip_intermediateStops_MasterStocking.line_and_name.lineName)
                   
                    
                }
                    
                    // MARK: Setting Intermediate stops
                    
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
                    print("Set Origin...stop.name ===== \(stop.name)")
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
           // MARK: Origin & Destination if available then draw line in route
            
            if (lastLegFlag == true){
                var originCoordinates = CLLocationCoordinate2D()
                var destinationCoordinates = CLLocationCoordinate2D()
                
             //                 MARK:-  Draw root
 
                
                var q = 0
                var counter = 0
                for index in rootTrip_intermediateStops_MasterStocking.intermediateStops {
                    counter += 1
                    
                    if (q == 0){
                        
                     print("-------------------origin no---------------------------counter value = \(counter)-------")
                        print(rootTrip_intermediateStops_MasterStocking.originStop.name)
                        print("------------------line number----------------------------\(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber)-----")
                        
                        print("\(rootTrip_intermediateStops_MasterStocking.originStop.name)")
                        
                        print("\(rootTrip_intermediateStops_MasterStocking.originStop.arrTime)")
                        
                        print("::::::depDate\(rootTrip_intermediateStops_MasterStocking.originStop.depDate)")
                        print("::::::name = \(rootTrip_intermediateStops_MasterStocking.originStop.name)")
                        print("::::::originOrDest = \(rootTrip_intermediateStops_MasterStocking.originStop.originOrDestination)")
                       
                     //    print(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber)
                        // MARK: color change map work
                        
//                        if (rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber == 401){
//                        
//                    print("-----1-----line no 401 caught------794--")
//                            
//                            
//                            colorValue = UIColor.blackColor()
//                        
//                        }
//                        
//                        else
//                        {
//                            print("---1.5----no---line no 401 caught------794--")
//                            
//                        colorValue = UIColor.redColor()
//                        }
                    }
                    print("termp:LEG INDEX = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].legIndex)::: index = \(q)--name = \(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].name)")
                    print("----------------testing...............§§§")
                    print("1\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].arrDate)")
                    print("2\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].arrTime)")
                    print("3\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].name)")
//                    print("\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].)")
                    print("4\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].arrDate)")
                    print("5\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].originOrDestination)")
                    print("6\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].legIndex)")
                      print("7\(rootTrip_intermediateStops_MasterStocking.directions.directionName)")
                    
                        print("8\(rootTrip_intermediateStops_MasterStocking.line_and_name.lineName)")
                        print("9\(rootTrip_intermediateStops_MasterStocking.destinationStop.name)")
                    print("10\(rootTrip_intermediateStops_MasterStocking.originStop.name)")
                    print("11\(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber)")
//                    print("\(rootTrip_intermediateStops_MasterStocking.intermediateStops[q].)")

//                    print("-------------------destination----------------\(rootTrip_intermediateStops_MasterStocking.intermediateStops.count )----& q = \()--------------")
                    var t = 1 + q
                    if (rootTrip_intermediateStops_MasterStocking.intermediateStops.count == t){
                        print("-------------------destination no----------------------------\(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber)-------------")
                        //----------------------------temp.....start
                        
                        let mapLegDictionary = NSMutableDictionary()
//                      mapLegDictionary.setValue(<#T##value: AnyObject?##AnyObject?#>, forKey: <#T##String#>)
                        mapLegDictionary.setValue(counter, forKey: "counter")
                        mapLegDictionary.setValue(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber, forKey: "LineNo")
                        mapLegDictionary.setValue(rootTrip_intermediateStops_MasterStocking.line_and_name.lineName, forKey: "LineName")
                        
//                        print("rootTrip_intermediateStops_MasterStocking.destinationStop.name::::\()")
                        
                        counter == 0
                        
                        mapLegsBoundInfo.add(mapLegDictionary)
                        //----------------------------temp------end
                        
                        print(rootTrip_intermediateStops_MasterStocking.destinationStop.name)
                   
                        // MARK: Map testing
                    var mapBatchDict = NSMutableDictionary()
                     mapBatchDict.setValue(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber, forKey: "LineNo")
                    mapBatchDict.setValue(rootTrip_intermediateStops_MasterStocking, forKey: "BatchToDraw")
                        
                        mapBatchesToDraw.add(mapBatchDict)
                        print("mapBatchesToDraw = \(mapBatchesToDraw.count)")
                        print("---MasterStocking-----intermediate stops------\(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
   
                    }
                
                    
                    q += 1
                }
            }
            
            //------show annotations
            // MARK:- Draw Root and Annotations
            print("lastLegFlagRootLevel === last value = \(lastLegFlagRootLevel)")
            if (lastLegFlagRootLevel == true){
            var g = 0
            print("draw root called = \(draw)")
                 var checkIndex = 0
                //-----------temp start
                var u = 0
                for check in mapLegsBoundInfo {
                let dictCheck = mapLegsBoundInfo[u] as! NSDictionary
                print("dictCheck line number value is = \(dictCheck["LineNo"])")
                print("dictCheck counter value is = \(dictCheck["counter"])")
                u += 1
                }
                var mapLegBoundInfoIndex = 0
                
                print("1-----stationLocationArray total count is = \(stationLocationArray.count)")
                // ------------temp end
                
                // MARK: Annoitation population and show 
              
                for index in rootTrip_intermediateStops_MasterStocking.intermediateStops {
                    
                print("temp test map :090 \(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber)")
                print("temp test map 909...: \(rootTrip_intermediateStops_MasterStocking.intermediateStops[g].id)")
//                    if (checkIndex != rootTrip_intermediateStops_MasterStocking. ){
//                    
//                    print("------check index value = \(checkIndex)-------&& \(rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber)------")
//                    }
                    
                    checkIndex = rootTrip_intermediateStops_MasterStocking.line_and_name.lineNumber
                    
         print("rootTrip_intermediateStops_MasterStocking.originStop.name: \(rootTrip_intermediateStops_MasterStocking.originStop.name)")
            let lat = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[g].lat)
            let long = Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[g].long)
            let title = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].originOrDestination
            let stationName = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].name
            let transportType = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].name
            let arrTime = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].arrTime
           // = String(annotationIndex)
                    let arrDate = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].arrDate
                     let lineNo = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].line
                    let lineName = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].lineName
                    let directionName = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].directionName
//                    let lat = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].lat
//                    let long = rootTrip_intermediateStops_MasterStocking.intermediateStops[g].long
            // Mark: SwitchingOff Annotations temp
            // MARK: ANNOTATIONS Population
                    print("-------Annotations info is being printed...index = \(annotationIndex).............")
                    print("stationName")
                    print(stationName)
                    print("transportType---======-\(transportType)")
                    print("title======\(title)")
                    print("direction name \(directionName)")
                    print("::::Title  = \(title)")
                    print("::::line No = \(lineNo)")
                    print("::::line Name = \(lineName)")
                    print(arrTime)
                    print("Arrival Date ::: \(arrDate)")
           
//                    var stationLocation = StationsLocation(name: stationName, lat: lat!, long: long!)
                    // MARK: Annotations Info being populated
                    var stationLocation = StationsLocation(annotationIndex: annotationIndex,name: "stationName", direction: directionName, line: lineNo,lineName: lineName, departureTime: arrTime, lat: lat!, long: long!)
                    annotationIndex += 1
                    print("adding ..............................u \(u)")
                    stationLocationArray.append(stationLocation)
                    print("stationLocationArray.count ==\(stationLocationArray.count)")
         //  showAnnotations(lat!, long: long!, title: title, stationsName: stationName, transportType: transportType)
            let coord = CLLocationCoordinate2D(latitude: lat!,longitude: long!)
                coordinatesToDrawRoot.append(coord)
                print("-101 202----lat long   \(lat!),\(long!)")
            g += 1
            
                    if (mapLegsBoundInfo.count != 0 && mapLegBoundInfoIndex <= mapLegsBoundInfo.count ){
                    
                    let legBoundInfo = mapLegsBoundInfo[mapLegBoundInfoIndex] as! NSDictionary
                        print("all keys ______legboundinfo \(legBoundInfo.allKeys)")
                        
                        if (g == legBoundInfo["counter"] as! Int ){
                           print("g is equal to legboundInfo =counter== \(legBoundInfo["counter"])")
                            print("g is equal to legboundInfo =line no== \(legBoundInfo["LineNo"])")
                            // take the line no and call getlineno color method
                            // MARK: Transport Mode Color Assigning
                            
                            let transportModeDict = identifyTransportMode(lineNo: legBoundInfo["LineNo"] as! Int,LineName: legBoundInfo["LineName"] as! String) as! NSMutableDictionary
                            print("transportModeDict ==== all keys = \(transportModeDict.allKeys)")
                            print("Transport Icon Name :::TripMapViewController:: \(transportModeDict["TransportTypeIcon"] as! String)")
                            colorValue = transportModeDict["lineColor"] as! UIColor
                            transportTypeIconName = transportModeDict["TransportTypeIcon"] as! String

                            // MARK: Map Augest 12 testing
                            mapLegBoundInfoIndex += 1
                            print("mapLegBoundInfoIndex == \(mapLegBoundInfoIndex)")
                       print("coordinatesToDrawRoot====00=")
                            print(coordinatesToDrawRoot.count)
                            // MARK: Draw Route via Polyline
                            
                            print("polyline is being constructed to show on the map........")
                            // MARK: Draw Route Temp Off
                            print("coordinatesToDrawRoot::::: \(coordinatesToDrawRoot.count)")
                            
                            var polyline = MKPolyline(coordinates: &coordinatesToDrawRoot, count: coordinatesToDrawRoot.count)
                            
                           // let polyRend = MKPolylineRenderer(overlay: polyline)
                           // polyRend.lineWidth = 2.0
                            
                      //     mapView.add(polyline)
                            
                     
                            mapView.add(polyline, level: MKOverlayLevel.aboveRoads)
                            
                  // MARK: Map Route Mid Point
                            
                            let midPointStation = rootTrip_intermediateStops_MasterStocking.intermediateStops.count / 2
                        print(" total count intermediate stops = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
                        print("counter value is \(midPointStation)")
                            
//                            setSpanAndRegion(Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[midPointStation].lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[midPointStation].long)!, regionRadius: 15000)
                            coordinatesToDrawRoot.removeAll()
                        }
                    }
                    
                // temp attempt to draw map as legs
                // ------------------------------- end
                }
            draw += 1
            }
            print("aaa----stationLocationArray.count ==\(stationLocationArray.count)")
            print("2-----stationLocationArray.count ==\(stationLocationArray.count)")
      print("coordinates to draw status = \(coordinatesToDrawRoot.count)")
           
            var station_location_list = StationLocationLists(stationsLocation: stationLocationArray)
          
            // MARK: Annotation being added
            mapView.addAnnotations(station_location_list.stationsLocation)
            
            print("station_location_list.stationsLocation =====\(station_location_list.stationsLocation.count)")
            print("stationLocationArray.count  =====\(stationLocationArray.count)")
            print("mapView.annotations.count  =====\(mapView.annotations.count)")
            
            //My location
            var myLocation = CLLocation(latitude: 59.244696, longitude: 17.813868)
            
            let locartion0 = CLLocationCoordinate2D(latitude: 59.244696, longitude: 17.813868)
            let locartion1 = CLLocationCoordinate2D(latitude: 59.326354, longitude: 18.072310)
            
            //My buddy's location
            var myBuddysLocation = CLLocation(latitude: 59.326354, longitude: 18.072310)
            
           drawLineBetweenTwoStops(originLocation2D: locartion0, destinationLocation2D: locartion1)
            
            // MARK: Annotation Show By Default
            var p = 0
            if (stationLocationArray.count != 0){
                 for index in mapView.annotations {
                 let iteratedAnnotation = mapView.annotations[p] as! StationsLocation
                    print("real Annotation Index =p === \(p)-iter ind-\(iteratedAnnotation.annotationIndex)---\(iteratedAnnotation.title)")
                    let iteratedAnnotationFirstIndex = Int(iteratedAnnotation.annotationIndex!)
                    print("iteratedAnnotationFirstIndex = == \(iteratedAnnotationFirstIndex)")
                    if (iteratedAnnotationFirstIndex == 0){
                        print("first index caught really = \(iteratedAnnotationFirstIndex) && p val is = \(p)")
                        print("lat first coordinate = \(iteratedAnnotation.lat)")
                        print("long first coordinate = \(iteratedAnnotation.long)")
                      
                        myLocation = CLLocation(latitude: iteratedAnnotation.lat!, longitude: iteratedAnnotation.long!)
                        
                        mapView.selectAnnotation(mapView.annotations[p],animated: true)
                        
                    }
                    else if ((iteratedAnnotationFirstIndex + 1) == station_location_list.stationsLocation.count){
                        
                        print(station_location_list.stationsLocation.count)
                        print("Last index caught really = \(iteratedAnnotationFirstIndex + 1) && p val is = \(p)")
                        print("lat last coordinate = \(iteratedAnnotation.lat)")
                        print("long last coordinate = \(iteratedAnnotation.long)")
                        myBuddysLocation = CLLocation(latitude: iteratedAnnotation.lat!, longitude: iteratedAnnotation.long!)
                        
                        mapView.selectAnnotation(mapView.annotations[p],animated: true)
                     
                    }
                p += 1
                }
//                mapView.selectAnnotation(mapView.annotations.last!,animated: true)
                print("Mapview. Annotation has been selected.......")

                               //Measuring my distance to my buddy's (in km)
                
                print("------my location----------")
                print(myLocation)
                print("my buddy location------")
                print(myBuddysLocation)
                var distance = myLocation.distance(from: myBuddysLocation) / 1000
                
                //Display the result in km
                print(String(format: "090900 The distance to my buddy is %.01fkm", distance))
                
                print("total count of station location list = \(station_location_list.stationsLocation.count)")
                let midPointStation = station_location_list.stationsLocation.count / 2
//                print(station_location_list.stationsLocation[midPointStation].)
                
                
                setSpanAndRegion(lat: Double(station_location_list.stationsLocation[midPointStation].lat!), long: Double(station_location_list.stationsLocation[midPointStation].long!), regionRadius:Int(distance * 1000) )

                
//              setSpanAndRegion(Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[midPointStation].lat)!, long: Double(rootTrip_intermediateStops_MasterStocking.intermediateStops[midPointStation].long)!, regionRadius:Int(distance * 1000) )
            }
            else{
            print("couldnt find annotation to select by default......")
             
            }
     var t = 0
            for index in stationLocationArray {
            var stationLocation = stationLocationArray[t] as! StationsLocation
                print("t--annotation----------\(t)")
                print("annotation.count = \(mapView.annotations.count)")
                print("identifier ==== \(stationLocation.identifier)")
                print("coordinate ==== \(stationLocation.coordinate)")
                print("title ==== \(stationLocation.title)")
                print("line no\(stationLocation.line)")
                print("direction.-...\(stationLocation.direction)")
                print("stationLocation.lat.-...\(stationLocation.lat)")
                print("stationLocation.long.-...\(stationLocation.long)")
                t += 1
            }
        }

        print("inside else................Line 1497 = \(stationLocationArray.count).")
       /*
         var stationLocation0 = stationLocationArray[0] as! StationsLocation
       var stationLocation1 = stationLocationArray[0] as! StationsLocation
        
        
        
        let clLocationCoo2D0 = CLLocationCoordinate2D(latitude:  stationLocation0.lat!, longitude:  stationLocation0.long!)
        let clLocationCoo2D1 = CLLocationCoordinate2D(latitude:  stationLocation1.lat!, longitude:  stationLocation1.long!)
        
        drawLineBetweenTwoStops(originLocation2D: clLocationCoo2D0, destinationLocation2D: clLocationCoo2D1)
        */
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
    // latest addition to replace the extractValuesToDrawRootLegListMap to
   // MARK:- extractValuesToDrawMapOfTrip
    
    func extractValuesToDrawMapOfTrip() {
    
        
        // iterate through the leglist array and extract the following values for each Leg
        
        // let tripCell = rootLegsArray as! [Trip]
        
        // the following method will be called for as many times as the legs of each trip
        //
        var i = 0
        
//        dispatch_async(dispatch_get_main_queue(), {
//            
            //
            //           let refetchGroup = dispatch_group_create()
            //            dispatch_group_enter(refetchGroup)
            //
            //           // dispatch_group_notify(<#T##group: dispatch_group_t##dispatch_group_t#>, <#T##queue: dispatch_queue_t##dispatch_queue_t#>, <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>)
            
            for index in selectedRootTripForMap {
                let totalLegs = i + 1
                print("-------t1----")
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
                print("Trip Map View Controller journey type = \(legList.journeyType)")
                if (legList.journeyType != "WALK"){
                    
                    let    rootLeg_setOrigin = Int(legList.origin.routeIdx)!
                    
                    let rootLeg_setDestination = Int(legList.destination.routeIdx)!
                     let rootTrip_MapValuesBucket = NSMutableDictionary()
                   
                    rootTrip_MapValuesBucket.setValue(finalRootLegIntermediateURL, forKey: "finalRootLegIntermediateURL")
                    rootTrip_MapValuesBucket.setValue(rootLeg_setOrigin, forKey: "rootLeg_setOrigin")
                    
//                    rootTrip_MapValuesBucket.setValue(rootLeg_setDestination, forKey: "rootLeg_setDestination")
                    rootTrip_MapValuesBucket.setValue(rootLeg_setDestination, forKey: "rootLeg_setDestination")
                    rootTrip_MapValuesBucket.setValue(String(i), forKey: "legIndex")
                    
                    print("iiiiiiiii 1010 = \(i)")
                    let s = "legIndex"
                    print("dict leg index value is \(rootTrip_MapValuesBucket.value(forKey: s))")
                    print("")
                    
                    drawRootUrlsArray.add(rootTrip_MapValuesBucket)
                    print("after adding value to root url array:\(drawRootUrlsArray.count)")
                    //_______________________________::::: Start.....temp switching off
                    
                    //____________________________________ END.....temp switching off
                }
//                print("returned from get data from url......finalRootLegIntermediateURL.........\(finalRootLegIntermediateURL)")
//                
//                
//                print("--end--------------end--------------end----i = \(i)")
//                print("::::::total count of intermediat stops = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
//                //}
                i += 1
            }
            
            
            
           // var i = 0
            
            ///------move to new function to extract values---start
            
           /*
                for index in drawRootUrlsArray {
                let dict = drawRootUrlsArray[i] as! NSDictionary
                print("url draw root = \(dict)")
                
                //                while(downloadingFinished == false) {
                print("---------------------downloading Fininshed ? \(downloadingFinished)")
                self.get_data_from_url(dict)
                
                
                //                }
                downloadingFinished == false
                print("dict count is ........\(drawRootUrlsArray.count)")
                i++
            }
            print("::::::total count of intermediat stops = \(rootTrip_intermediateStops_MasterStocking.intermediateStops.count)")
            */
            //------move to new function to extract values------end
            
            
//            return
//        })
//        
       
//    }
    }
    
    
    func extract_json1(data:NSData)
    {
        var parseError: NSError?
        
        //------------
        let json: AnyObject?
        do {
            print("json downloading in progres........4......intermediate stops--.")
            json = try JSONSerialization.jsonObject(with: data as Data, options: []) as! AnyObject
            print("in real time result-------json just downloaded.......5...from/To.....\(json?.allKeys)")
            print("in real time result-------json just downloaded.......5...from/To.....\(json!["JourneyDetail"])")
            
            rootTrip_json_IntermediateStopsLoaded_flag = true
            
            //            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }

        //--------------
        
//        
//        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
//        let json: AnyObject?
//        do {
//            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
//        } catch let error as NSError {
//            parseError = error
//            json = nil
//        }
//        if (parseError == nil)
//        {
//            if let list = json as? NSArray
//            {
//                print("//------------------------start----------//")
//                print(list)
//                
//                print("//--------------------------end--------//")
////                for (var i = 0; i < list.count ; i++ )
////                {
////                    if let data_block = list[i] as? NSDictionary
////                    {
////                        
////                 //       TableData.append(datastruct(add: data_block))
////                    }
////                }
////                
////                do
////                {
////                   // try read()
////                   // do_table_refresh()
////                }
////                catch
////                {
////                    
////                }
////                
//            }
//            
//        }
    }
    
     func extractValuesToDrawRootLegListMap (){
        
        // iterate through the leglist array and extract the following values for each Leg
        
        // let tripCell = rootLegsArray as! [Trip]
        
        // the following method will be called for as many times as the legs of each trip
        //
        var i = 0
     
        
//        dispatch_get_main_queue().asynchronously(execute: {
//            
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
            print("ddddddgg \(drawRootUrlsArray.count)")
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
        func blueBusCheck(lineName: String )-> Bool {
    var status = Bool()
        
       // MARK: Swift 3 
    //if (lineName.lowercaseString.rangeOfString("blå") != nil ) {
            if (lineName.lowercased().contains("blå") == true ) {
        print("Blå Buss Exists............\(lineName).")
        
            return true
        }
        else  {
        
        
            print("Do we have red bus???? \(lineName)")
            
            return false
        }
    
    
   // return status
    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        print("last : trip root map glag button value is .........\(tripRootMapFlag)...")
        
       /// tripRootMapFlag = false
        print("new : trip root map glag button value is .........\(tripRootMapFlag)...")
        getDataCount=0
        print("setting getDataCount to 0 , new value of get Data Count = \(getDataCount)")
        print("back button is pressed ...................")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func identifyTransportMode (lineNo: Int,LineName: String)-> NSMutableDictionary {
        print("param received LineNo =  \(lineNo)")
        print("param received Line Name = \(LineName)")
        
        var lineColor = UIColor()
        
        // check for the lineColor Values in the data source dict
        let R = "R"
        let G = "G"
        let B = "B"
        let LineNo = "LineNo"
        
        var lineColorValuesDict = NSMutableDictionary()
        // MARK: Tunnelbana LINE COLOR INFO
        // type is Transport Type
        
        // MARK: LINE # 599 // MORE LEGS
        let rgb_599 = [R:244,G:244,B:77,transportType:MORE_ICON_NAME,LineNo :599] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_599, forKey: "599")
        

        // MARK: LINE # 10 11 T
        let rgb_10 = [R:0,G:112,B:192,transportType:METRO_ICON_NAME,LineNo :10] as [String : Any]
        let rgb_11 = [R:0,G:112,B:192,transportType:METRO_ICON_NAME,LineNo :11] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_10, forKey: "10")
        lineColorValuesDict.setValue(rgb_11, forKey: "11")
        
        
        // MARK: LINE # 13 14 T
        let rgb_13 = [R:160,G:0,B:0,transportType:METRO_ICON_NAME,LineNo :13] as [String : Any]
        let rgb_14 = [R:160,G:0,B:0,transportType:METRO_ICON_NAME,LineNo :14] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_13, forKey: "13")
        lineColorValuesDict.setValue(rgb_14, forKey: "14")
        
        // MARK: LINE # 17 18 19 T
        let rgb_17 = [R:0,G:148,B:90,transportType:METRO_ICON_NAME,LineNo :17] as [String : Any]
        let rgb_18 = [R:0,G:148,B:90,transportType:METRO_ICON_NAME,LineNo :18] as [String : Any]
        let rgb_19 = [R:0,G:148,B:90,transportType:METRO_ICON_NAME,LineNo :19] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_17, forKey: "17")
        lineColorValuesDict.setValue(rgb_18, forKey: "18")
        lineColorValuesDict.setValue(rgb_19, forKey: "19")
        
        // MARK: Pendaltåg LINE COLOR INFO
        // MARK: LINE # 35  P
        let rgb_35 = [R:150,G:57,B:160,transportType:TRAIN_ICON_NAME,LineNo :35] as [String : Any]
        lineColorValuesDict.setValue(rgb_35, forKey: "35")
        
        // MARK: LINE # 36 37 38  P
        let rgb_36 = [R:125,G:181,B:60,transportType:TRAIN_ICON_NAME,LineNo :36] as [String : Any]
        let rgb_37 = [R:125,G:181,B:60,transportType:TRAIN_ICON_NAME,LineNo :37] as [String : Any]
        let rgb_38 = [R:125,G:181,B:60,transportType:TRAIN_ICON_NAME,LineNo :38] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_36, forKey: "36")
        lineColorValuesDict.setValue(rgb_37, forKey: "37")
        lineColorValuesDict.setValue(rgb_38, forKey: "38")
        
        // MARK: LINE # 7 TRAM & LIGHT TRAIN
        let rgb_7 = [R:80,G:106,B:116,transportType:TRAM_ICON_NAME,LineNo :7] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_7, forKey: "7")
        // MARK: LINE # 12 TLR
        let rgb_12 = [R:159,G:102,B:4,transportType:TRAM_ICON_NAME,LineNo :12] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_12, forKey: "12")
        
        // MARK: LINE # 21 TLR
        let rgb_21 = [R:121,G:99,B:40,transportType:TRAM_ICON_NAME,LineNo :21] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_21, forKey: "21")
        
        // MARK: LINE # 22 TLR
        let rgb_22 = [R:102,G:63,B:58,transportType:TRAM_ICON_NAME,LineNo :22] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_22, forKey: "22")
        
        // MARK: LINE # 25 26 TLR
        let rgb_25 = [R:0,G:139,B:160,transportType:TRAM_ICON_NAME,LineNo :25] as [String : Any]
        let rgb_26 = [R:0,G:139,B:160,transportType:TRAM_ICON_NAME,LineNo :26] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_25, forKey: "25")
        lineColorValuesDict.setValue(rgb_26, forKey: "26")
        
        // MARK: LINE # 27 28 29 TLR
        
        let rgb_27 = [R:107,G:60,B:146,transportType:TRAM_ICON_NAME,LineNo :27] as [String : Any]
        let rgb_28 = [R:107,G:60,B:146,transportType:TRAM_ICON_NAME,LineNo :28] as [String : Any]
        let rgb_29 = [R:107,G:60,B:146,transportType:TRAM_ICON_NAME,LineNo :29] as [String : Any]
        
        lineColorValuesDict.setValue(rgb_27, forKey: "27")
        lineColorValuesDict.setValue(rgb_28, forKey: "28")
        lineColorValuesDict.setValue(rgb_29, forKey: "29")
        
        //------------------------------------------------------
        //        lineColorValuesDict.setValue(rgb_13, forKey: "13")
        //        lineColorValuesDict.setValue(rgb_14, forKey: "14")
        //
        //        lineColorValuesDict.setValue(rgb_17, forKey: "17")
        //        lineColorValuesDict.setValue(rgb_18, forKey: "18")
        //        lineColorValuesDict.setValue(rgb_19, forKey: "19")
        
        //  for (key,value) in lineColorValuesDict {
        let lineNoStr = String(lineNo)
        
        var r = CGFloat()
        var g = CGFloat()
        var b = CGFloat()
        var transportTypeIconName = String()
        if (lineColorValuesDict[lineNoStr] != nil){
            let lineColorInfo = lineColorValuesDict[lineNoStr] as! NSDictionary
            r = CGFloat(lineColorInfo[R] as! Int)
            g = CGFloat(lineColorInfo[G] as! Int)
            b = CGFloat(lineColorInfo[B] as! Int)
            transportTypeIconName = lineColorInfo[transportType] as! String
            
            print("Line numer has been found ::::: \(lineNoStr)")
            print("::::::returning LineName is = \(LineName)")
            //print("Color which is going to be returned ::::: \()")
            
        }
        else
            
        {
            print("else has been caught in line color ..............\(lineNoStr)..")
            print("else::::::returning LineName is = \(LineName)")
            
            
            let statusBlueBuss = blueBusCheck(lineName: LineName)
            
            if (statusBlueBuss == true){
                
                //                print("statusBlueBuss")
                lineColor = UIColor(red: 0/255, green: 134/255, blue: 205/255, alpha: 1)
                transportTypeIconName = BUS_ICON_NAME
                
                transportInfo.setValue(lineColor, forKey: "lineColor")
                transportInfo.setValue(transportTypeIconName, forKey: transportType)
                print("all keys = == 1010 A= \(transportInfo.allKeys)")
                print("count = == 1010 A= \(transportInfo.count)")
                print("bus blue sending back value for transport icon name = \(transportTypeIconName)")
                
                return transportInfo
                
            } else {
                
                lineColor = UIColor(red: 236/255, green: 0/255, blue: 0/255, alpha: 1)
                
                transportTypeIconName = BUS_ICON_NAME
                transportInfo.setValue(lineColor, forKey: "lineColor")
                transportInfo.setValue(transportTypeIconName, forKey: transportType)
                
                print("bus red sending back value for transport icon name = \(transportTypeIconName)")
                print("all keys = == 1010 B= \(transportInfo.allKeys)")
                print("count = == 1010 B= \(transportInfo.count)")
                
                return transportInfo
                
            }
            
            //            return
            
        }
        //}
        lineColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
        transportInfo.setValue(lineColor, forKey: "lineColor")
        transportInfo.setValue(transportTypeIconName, forKey: transportType)
        
        print("returning color is = 1090 A = allKeys =  \(transportInfo.allKeys)")
        print("returning color is = 1090 A = count = \(transportInfo.count)")
        // print("else::::::returning LineName is = \(LineName)")
        // print("all keys === \(lineColorValuesDict.allKeys)")
        
        return transportInfo
        
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

}


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

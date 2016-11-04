//
//  SearchFrom_To_Controller.swift
//  SLife
//
//  Created by syed farrukh Qamar on 29/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit
var from_to_value = String()
var via_Station_value = String()

var tempDict = NSDictionary()
var station = Station(name: "", site_id: "", type: "", x: "", y: "")



class SearchFrom_To_Controller:UITableViewController,UISearchResultsUpdating {
    @IBAction func Back_move_Action(_ sender: AnyObject) {
        
        
        if (realTimeFlag == false){
        self.navigationController?.popViewController(animated: true)
        print("back button has been pressed.from search from to controller.....")
        }
        /*
        else {
        if (realTimeFlag == true)
        {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainSimpleSearchViewControllerTViewController")
           // let vc = MainSimpleSearchViewControllerTViewController(nibName: "MainSimpleSearchViewControllerTViewController", bundle: nil)
            
            navigationController?.present(vc!, animated: true, completion: nil)
            print("real time flag seems to be true")
            }
            
        }
        */
        
 
    }

    @IBOutlet weak var back_button_outlet: UIBarButtonItem!
    //let tableData = ["Current Location","AltaCentrum","Three","Twenty-One"]
    var tableData = NSMutableArray()

    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: "goBack")
//        navigationItem.leftBarButtonItem = backButton
//
//        func goBack(){
//            dismiss(animated: true, completion: nil)
//        }
        
        //self.navigationController?.setToolbarHidden(true, animated: true)
        
        print("---descryption navigation bar =\(self.navigationController.debugDescription)")
        
        print(self.navigationController?.isNavigationBarHidden)
        
        print("--top view controller-descryption navigation bar =\(self.navigationController?.topViewController?.description)")
        
        self.resultSearchController = ({
            
                       let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        if realTimeFlag == true {
            back_button_outlet.title = ""
        }
            
        else {
            
            back_button_outlet.title = "Back"
            
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return self.tableData.count
        
        /*
         if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return self.tableData.count
        }
        */
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! UITableViewCell
        
        // 3
        cell.textLabel?.text = tableData[indexPath.row] as! String
        
        return cell

        /*
         if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = tableData[indexPath.row] as! String
            
            return cell
        }
        */
    }
    
 func updateSearchResults(for searchController: UISearchController) {
    
//        <#code#>
//    }
//    
//    override func updateSearchResultsForSearchController(searchController: UISearchController)
//    {
        //---construct url start
        // http://api.sl.se/api2/typeahead.json?key=0b0656ad5c1d4a47a79dd668cb5f9d79&searchstring=a&stationsonly=true
        
        
        
        
        if(searchController.searchBar.text == "" )
        {
            print("empty string------")
        
        
        }
        
        else if (searchController.searchBar.text == nil) {
        
        print ("nilllllllllll")
        
        }
            
        else if ((searchController.searchBar.text?.characters.count)! > 2)
        {
            print("retStr---bef4-----------------\(searchController.searchBar.text!)")
            let retStr = SlifeMethods.stringToSlFormat(inputString: searchController.searchBar.text!)
            print("retStr---after-----------------\(retStr)")
            
      //  tableData.removeAllObjects()
        let url = WebServiceHandler.constructURL_Sl_plats(searchString: retStr, stationOnly: true)
        
        //--construct url-------------------end
        // call webservice
        
        get_data_from_url(url: url)
        //get_data_from_url(url)
            print("----------------------------------------")
            //tableData.removeAllObjects()
            print("table data count is = \(tableData.count)")
            print("----------------------------------------")

        }
        
        
        print("searchController.searchBar.text! == \(searchController.searchBar.text!)")
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    //----call webservice-----start
   
    /*
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
            
            
            //      if (data != nil){
            
            //  self.extract_json(data!,rootTripDict: rootTripDict)
            
            //    }
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
*/
    
     
    func get_data_from_url(url:String)
    {
        print()
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
       // request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print("---json step 1------")
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            /*
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:NSURLResponse = response;  , error = nil else {
                print("error")
                return
            }
            */
            print("---json step 2------")
            //DispatchQueue.main.asynchronously(execute: {
            DispatchQueue.main.async(execute: {

                self.extract_json(jsonData: data! as NSData)
                print("---7.1--about to return after parsing")
                
                // let tripArray = convertedJsonIntoNSDict["TripList"]!["Trip"] as! NSArray
                
                //self.getTrips(convertedJsonIntoNSDict)
                //--for-1--------------------------------------------------------------------------------------------------
                
                print("---7.2--about to return after parsing")
                // reload the table here
                self.tableView.reloadData()
                return
            })
        }
        task.resume()
    }
    
    //----call webservice-----........end
    
    //---extract data from json-.------start
    
    
    func extract_json(jsonData:NSData)
    {
        print("---json step 3----inside from/To--")
        let json: AnyObject?
        do {
            print("json downloading in progres........4....from/To....")
            // MARK: Swift 3
            //as! AnyObject
            json = try JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! [String:AnyObject] as AnyObject?
            //json = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions<#T##JSONSerialization.ReadingOptions#>)
            
            print("json just downloaded.......5...from/To.....\(json?.allKeys)")
//            print("json just downloaded.......5..from/To......\(json?["ResponseData"]!!.description)")
            
            // load this json into Trip---start
            
            
            
            // load this json intro trip end here
            
        } catch {
            json = nil
            return
        }
         tempDict = (json as? NSDictionary)!
        //getTrips(convertedJsonIntoNSDict)
        print("---6-----convertedJSON is being printed = \(tempDict.allKeys)")
         print("-before----tabledata count before adding--= \(tableData.count)")
        tableData.removeAllObjects()
        
        if (tempDict.count == 0){
        // check for message
             let message = "Message" + (tempDict["Message"] as! String)
            tableData.add(message)
        // check for station code
            let statusCode = "Status Code:" + (tempDict["StatusCode"] as! String)
             tableData.add(message)
        } else {
        
            // MARK:- Error some times 1
        let responseData = tempDict["ResponseData"] as! NSArray
            // MARK: Swift 3
            // responseData -> (responseData as? [[String:Any]])
            
            for responseData in (responseData as? [[String:Any]])! {
                
        let platsName = responseData["Name"]!
            
        print("station is = \(platsName)")
        tableData.add(platsName)
        }
        }
        self.tableView.reloadData()
        print("-after----tabledata count AFTER-= \(tableData.count)")
    }
    //--extract data from json ........end
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("last value of advancedOptionsFlag is = \(advancedOptionsFlag)")
        self.dismiss(animated: true, completion: nil)
        print("current row is selected = search from to Controller \(tableData[indexPath.row])")
        from_to_value = tableData[indexPath.row] as! String
        // get all the values and return
       print("tempDict count is = \(tempDict.count)")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       // let vc = RealTimeResult_ViewController(nibName: "RealTimeResult_ViewController", bundle: nil)
        if (tempDict.count == 4){
          // MARK: Nil / casting problem
            //Traffic status > write sluss
            //click slumnäsvägen
            //            Could not cast value of type '__NSDictionaryI' (0x1a87d40d8) to 'NSArray' (0x1a87d3d18).
            //            2016-10-28 10:00:48.080142 SLife[1846:416931] Could not cast value of type '__NSDictionaryI' (0x1a87d40d8) to 'NSArray' (0x1a87d3d18).
//            (lldb)
            // when searched for Slussen may be
            let responseData = tempDict["ResponseData"] as! NSArray
            let dictResponseData = responseData[indexPath.row] as! [String:AnyObject]
            station.name = dictResponseData["Name"] as! String
            station.type = dictResponseData["Type"] as! String
            station.site_id = dictResponseData["SiteId"] as! String
            station.x = dictResponseData["X"] as! String
            station.y = dictResponseData["Y"] as! String
            print("------tempDict.Count = 4 = \(station.name)")
            print("---------_Row Selected:::::::::")
            print("---station.name--\(station.name)")
            print("---station.type--\(station.type)")
            print("---station.name--\(station.site_id)")
            print("---station.x--\(station.x)")
            print("---station.y--\(station.y)")
            
            
        }
        else if (tempDict.count == 2) {
            print("tableData name = \(tableData[indexPath.row])")
            print("station.name = \(station.name)")
        }
         //--------------------------------------------------------------
        
       // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if (advancedOptionsFlag == false && real_time_flag == false){
            print("---step 1--")
            
        // go back to simple screen
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainSimpleSearchViewControllerTViewController") as! MainSimpleSearchViewControllerTViewController
            
            // let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SearchTripController") as! SearchTripController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            print("moving towards real time controller------SearchTripController--------------")
            
        
        }
        else if (advancedOptionsFlag == true){
        
        // go back to Advanced Screen
    
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchTripsTableViewController") as! SearchTripsTableViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            print("moving towards real time controller---------SearchTripsTableViewController-----------")
           
        }
        
        else if (real_time_flag == true){
        
            // Real Time Screen
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RealTimeResult_ViewController") as! RealTimeResult_ViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            print("moving towards real time controller--------------------")
            
            
        }
        
        
        
        
        //--------------------------------------------------------------
        /*
        if (real_time_flag == false){
        
            navigationController?.popToRootViewControllerAnimated(true)
        
           }
        
           else if (real_time_flag == true){
           // else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
           // let vc = RealTimeResult_ViewController(nibName: "RealTimeResult_ViewController", bundle: nil)
           
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RealTimeResult_ViewController") as! RealTimeResult_ViewController
          
            // self.addChildViewController(nextViewController)
            //  nextViewController.view.frame = view.addSubview(nextViewController.view)
            
            print("---123--child--navigation count index =\(self.childViewControllers.count)")
            
            print("---123----navigation count index =\(self.navigationController?.viewControllers.count)")
            
            self.navigationController?.pushViewController(nextViewController, animated: true)

        print("moving towards real time controller--------------------")
        }
        */
        
    }
    
}

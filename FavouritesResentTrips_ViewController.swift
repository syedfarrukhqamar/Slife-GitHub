//
//  FavouritesResentTrips_ViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 03/08/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

var from_fav_rec_station_id : String = ""
var to_fav_rec_station_id : String = ""


class FavouritesResentTrips_ViewController: UITableViewController {
var favHistory_array = NSArray()
var recentTrips_History_array = NSMutableArray()
    var fav_Row_Count : Int = 0
    var rec_Row_Count : Int = 0
// index row check for favourite or recentr trips
    
    var fav_start_index : Int = 0
    var fav_end_index : Int = 0
    var recTrips_start_index: Int = 0
    var recTrips_end_index: Int = 0
// saving values for Trip Suggestions i.e. origin and destination
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside favourites recent trips................")
        let fav_array = SlifeMethods.deSerializeObject(objectKeyNameToDeserialize: FAVOURITES)
        let rec_array = SlifeMethods.deSerializeObject(objectKeyNameToDeserialize: RECENTTRIPS)
        
        
        print("fav_array.count..............")
        print(fav_array.count)
        print("rec_array.count..............")
        print(rec_array.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        
//        return 1
//    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // return atleast two rows 
        // heading favourite
        // heading recentr trips
        
        var totalRowCountToReturn = 2
        
      //  if (section == 1){
          
       favHistory_array = SlifeMethods.deSerializeObject(objectKeyNameToDeserialize: FAVOURITES) as! NSArray
        
            print("FAVOURITES = favHistory_array.count = \(favHistory_array.count)")
        
            totalRowCountToReturn += favHistory_array.count
            fav_Row_Count = favHistory_array.count
        
      //  }
       // else if (section == 2){
        // MARK: Release problem casting
        // MARK:NIL Found 
        // previously nsarray was mutable but problem came 
        // Could not cast value of type '__NSArrayI' (0x107e01c08) to 'NSMutableArray' (0x107e01cd0).
        recentTrips_History_array = SlifeMethods.deSerializeObject(objectKeyNameToDeserialize: RECENTTRIPS) as! NSMutableArray 
        
            print("RECENTTRIPS = favHistory_array.count = \(recentTrips_History_array.count)")
        totalRowCountToReturn += recentTrips_History_array.count
        rec_Row_Count = recentTrips_History_array.count
        
      //  return recentTrips_History_array.count
            
     //   }
        print("totalRowCountToReturn = = = = = = \(totalRowCountToReturn)")
            return totalRowCountToReturn
    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        print("-----------------fav_Row_Count")
        print(fav_Row_Count)
        print("fav rec cell. index Path.row == \(indexPath.row)")
        if (indexPath.row == 0){
           // MARK: SWIFT 3 Changes
            let favouriteCell_heading = tableView.dequeueReusableCell(withIdentifier: "headingFavourite", for: indexPath)
//            
//         let favouriteCell_heading = tableView.dequeueReusableCellwithIdentifier: forWithIdentifier("headingFavourite", forIndexPath: indexPath as IndexPath) as! FavouriteHeading_Cell
        
            
            print("--------Fav Heading Cell Printing........IR Value = \(indexPath.row)...")
            
            return favouriteCell_heading
        }
        else if (indexPath.row <= fav_Row_Count){
            print("fav index Path row val = \(indexPath.row)")
            
            let fav_row_index = indexPath.row - 1
            print("fav_row_index = \(fav_row_index)")
            
            if (fav_row_index == 0){
            // first index for the fav cell
                fav_start_index = indexPath.row
                if(fav_Row_Count == 1){
                    print("assigning fav end index value = \(indexPath.row)")
                fav_end_index = indexPath.row
                
                }
            
            } else {
            
            // assign new value for end index. once real end comes then the value it contains would be the last index value
                fav_end_index = indexPath.row
            
            }
            let favouriteCell = tableView.dequeueReusableCell(withIdentifier: "favourite", for: indexPath as IndexPath) as! Favourites_TableViewCell
            // favouriteCell.backgroundColor = UIColor.greenColor()
            let favDict = favHistory_array[fav_row_index] as! NSMutableDictionary
            
            favouriteCell.from_fav_station_name.text = favDict[FROM_STATION_NAME_obj_ser] as? String
            favouriteCell.from_station_id.text = favDict[FROM_STATION_ID_obj_ser] as? String
            favouriteCell.to_station_id.text = favDict[TO__STATION_ID_obj_ser] as? String
            
            
            favouriteCell.to_station_id.isHidden = true
            favouriteCell.from_station_id.isHidden = true
            
            
            print("fromStationName:::::::=:::::")
            print(favDict["fromStationName"] as! String)
            
            //= favDict["fromStationName"] as! String
            favouriteCell.to_fav_station_name.text = favDict[TO_STATION_NAME_obj_ser] as? String
            favouriteCell.keyName.text = FAVOURITES
            favouriteCell.currentIndex.text = String(fav_row_index)
            print("Fav: From Station Name = \(favouriteCell.from_fav_station_name.text)")
            print("Fav: To Station Name = \(favouriteCell.to_fav_station_name.text)")
            print("Fav: From Station id = \(favouriteCell.from_station_id.text)")
            print("Fav: To Station id = \(favouriteCell.to_station_id.text)")
            
            // MARK: Hidden_Cells_Favourite
            let cellsHide = true
            favouriteCell.keyName.isHidden = cellsHide
            favouriteCell.currentIndex.isHidden = cellsHide
//            favouriteCell.from_station_id.hidden = cellsHide
//            favouriteCell.to_station_id.hidden = cellsHide
            
            print("--------Fav  Cell Printing...tot count fav = \(fav_Row_Count)..ir = \(indexPath.row) .....current index  Value= \(fav_row_index).")
             return favouriteCell
        } else if (indexPath.row == (fav_Row_Count + 1)) {
        
            let recentTrips_heading = tableView.dequeueReusableCell(withIdentifier: "headingRecentrTrips", for: indexPath as IndexPath) as! RecentrTripsHeading_CellTableViewCell
            
            print("--------Recentr Trips Heading Cell Printing........IR Value = \(indexPath.row)...")
            
            
            return recentTrips_heading
    
        }
        else {
            let recentTripsCell = tableView.dequeueReusableCell(withIdentifier: "previousTrips", for: indexPath as IndexPath) as! RecentTrips_TableViewCell
            
        recentTripsCell.test = String (indexPath.row)
            print("fav row count ==== \(fav_Row_Count)")
            print("rec row count ==== \(rec_Row_Count)")
        let i = indexPath.row - (fav_Row_Count + 2)
            print("rec index path.row == \(indexPath.row)")
            print("Rec- index path.row =i= \(i)")
            
            
            print("fav row count ==== \(fav_Row_Count)")
            print("i ==== \(i)")
            
            
            if (i == 0){
                // first index for the fav cell
                recTrips_start_index = indexPath.row
                if(rec_Row_Count == 1){
                    print("assigning recTrips_end_index  = \(indexPath.row)")
                    recTrips_end_index = indexPath.row
                    
                }
            } else {
                
                // assign new value for end index. once real end comes then the value it contains would be the last index value
                recTrips_end_index = indexPath.row
                
            }
            
            print("----------------i value is === \(i)")
            print(i)
            let recTripsDict = recentTrips_History_array[i] as! NSMutableDictionary
            
            recentTripsCell.from_rec_station_name.text = recTripsDict[FROM_STATION_NAME_obj_ser] as? String
            recentTripsCell.to_rec_station_name.text = recTripsDict[TO_STATION_NAME_obj_ser] as? String
            
            recentTripsCell.from_station_id.text = recTripsDict[FROM_STATION_ID_obj_ser] as? String
            recentTripsCell.to_station_id.text = recTripsDict[TO__STATION_ID_obj_ser] as? String
            
            recentTripsCell.keyName.text = RECENTTRIPS
            recentTripsCell.currentIndex.text = String(i)
            
            recentTripsCell.from_station_id.isHidden = true
            recentTripsCell.to_station_id.isHidden = true
            print("Rec: From Station Name = \(recentTripsCell.from_rec_station_name.text)")
            print("Rec: To Station Name = \(recentTripsCell.to_rec_station_name.text)")
            print("Rec: From Station id = \(recentTripsCell.from_station_id.text)")
            print("Rec: To Station id = \(recentTripsCell.to_station_id.text)")
            
            
            // MARK: Hidden Cells Recentr Trips
            let hideCells = true
//            recentTripsCell.from_station_id.hidden = hideCells
//            recentTripsCell.to_station_id.hidden = hideCells
            recentTripsCell.keyName.isHidden = hideCells
            recentTripsCell.currentIndex.isHidden = hideCells
            
//           recentTripsCell.from_rec_station_name.text = recTripsDict["toStation_Name"] as! String
            
            
            print("testing......\(recTripsDict["fromStationName"] as! String)")
            
         //   recentTripsCell.backgroundColor = UIColor.yellowColor()
            
            print("--------Recet Trips  Cell Printing...tot count fav = \(rec_Row_Count)......ir = \(indexPath.row)..current rt ind = \(i).")

            return recentTripsCell
        
        }
        
       // print("section id is = \(indexPath.section) && row id is = \(indexPath.row))")
        
      //  print("section id is = \(indexPath.section))")
        
        // Configure the cell...
    }
 
  // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
         // Return false if you do not want the specified item to be editable.
        return true
    }
  
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
//   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
   
   {
        if editingStyle == .delete {
            // Delete the row from the data source
            // check the range
           // MARK: OBJ Ser Current Index
            
            if (indexPath.row >= fav_start_index && indexPath.row <= fav_end_index){
            // assign keyname to favourite 
                // get the current index after accessing the cell
            
               let cell = tableView.cellForRow(at: indexPath as IndexPath) as! Favourites_TableViewCell
                let deleteFromIndex = cell.currentIndex.text
                
                print(" ....fav cell is found ")
                print("...about to delete_index = \(deleteFromIndex)")
                print("...about to delete_index = \(FAVOURITES)")
                
                SlifeMethods.deleteFromserializeObject(deleteIndex: deleteFromIndex!, keyName: cell.keyName.text!)
              
            } else if (indexPath.row >= recTrips_start_index && indexPath.row <= recTrips_end_index){
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! RecentTrips_TableViewCell
                
                let deleteFromIndex = cell.currentIndex.text
                
                print(" ....Rec Cell is found ")
                print("...about to delete_index = \(deleteFromIndex)")
                print("...about to delete_index = \(cell.keyName)")
                
                SlifeMethods.deleteFromserializeObject(deleteIndex: deleteFromIndex!, keyName: cell.keyName.text!)
            
            
            }
            
//            SlifeMethods.deleteFromserializeObject(<#T##deleteIndex: String##String#>, keyName: <#T##String#>)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        code
//    }
//   // MARK: didselectRow
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: OBJ Ser Current Index
        print("fav rec didSelectRowAt Selected Index Path= \(indexPath.row)")
        print("fav_start_index= \(fav_start_index)")
        print("fav_end_index= \(fav_end_index)")
        print("------------------------------------------")
        print("recTrips_start_index= \(recTrips_start_index)")
        print("recTrips_end_index= \(recTrips_end_index)")
        
    
        if (indexPath.row >= fav_start_index && indexPath.row <= fav_end_index){
            // assign keyname to favourite
            // get the current index after accessing the cell
            
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! Favourites_TableViewCell
         //   let deleteFromIndex = cell.currentIndex.text
            from_fav_rec_station_id =  cell.from_station_id.text!
            to_fav_rec_station_id = cell.to_station_id.text!
            
             print(" ....fav cell is found ")
            print(".fav_trips..from_fav_rec_station_id = \(from_fav_rec_station_id)")
            print(".fav_trips..to_fav_rec_station_id = \(to_fav_rec_station_id)")
            
//            SlifeMethods.deleteFromserializeObject(deleteFromIndex!, keyName: cell.keyName.text!)
            
        } else if (indexPath.row >= recTrips_start_index && indexPath.row <= recTrips_end_index){
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! RecentTrips_TableViewCell
       
            // let deleteFromIndex = cell.currentIndex.text
            from_fav_rec_station_id =  cell.from_station_id.text!
            to_fav_rec_station_id = cell.to_station_id.text!
            
            print(" ....rec cell is found ")
            print(".REC_TRIP..from_fav_rec_station_id = \(from_fav_rec_station_id)")
            print(".REC_TRIP..to_fav_rec_station_id = \(to_fav_rec_station_id)")
            

        //    SlifeMethods.deleteFromserializeObject(deleteFromIndex!, keyName: cell.keyName.text!)
            
            
        }
        
   
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // first extract the cell values which have been pressed and then move to next view controller
        // MARK: OBJ Ser Current Index
        print("Prepare segue identifier = \(segue.identifier)")
        let indexPath = tableView.indexPathForSelectedRow
        
        if (indexPath!.row >= fav_start_index && indexPath!.row <= fav_end_index){
            // assign keyname to favourite
            // get the current index after accessing the cell
            
            let cell = tableView.cellForRow(at: indexPath!) as! Favourites_TableViewCell
            //   let deleteFromIndex = cell.currentIndex.text
            from_fav_rec_station_id =  cell.from_station_id.text!
            to_fav_rec_station_id = cell.to_station_id.text!
            
            print(" ....fav cell is found ")
            print(".fav_trips..from_fav_rec_station_id = \(from_fav_rec_station_id)")
            print(".fav_trips..to_fav_rec_station_id = \(to_fav_rec_station_id)")
            
            //            SlifeMethods.deleteFromserializeObject(deleteFromIndex!, keyName: cell.keyName.text!)
            
        } else if (indexPath!.row >= recTrips_start_index && indexPath!.row <= recTrips_end_index){
            let cell = tableView.cellForRow(at: indexPath!) as! RecentTrips_TableViewCell
            
            // let deleteFromIndex = cell.currentIndex.text
            from_fav_rec_station_id =  cell.from_station_id.text!
            to_fav_rec_station_id = cell.to_station_id.text!
            
            print(" ....fav cell is found ")
            print(".REC_TRIP..from_fav_rec_station_id = \(from_fav_rec_station_id)")
            print(".REC_TRIP..to_fav_rec_station_id = \(to_fav_rec_station_id)")
            
}
            
        if (segue.identifier == "TripSuggesionsVC"){
        
            
            print("values being dispatched = = = from \(from_fav_rec_station_id)")
            print("values being dispatched = = = to \(to_fav_rec_station_id)")
            
            
            segue.destination.setValue(from_fav_rec_station_id, forKey: "from")
            segue.destination.setValue(to_fav_rec_station_id, forKey: "to")
            segue.destination.setValue("0", forKey: "searchForArrivals")
        
            }
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
}

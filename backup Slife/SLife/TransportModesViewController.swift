//
//  TransportModesViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 01/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class TransportModesViewController: UITableViewController {

    @IBOutlet weak var useMetroCell: UITableViewCell!
    @IBOutlet weak var useBusCell: UITableViewCell!
    @IBOutlet weak var useRailCell: UITableViewCell!
    
    @IBOutlet weak var useTramCell: UITableViewCell!
    
    @IBOutlet weak var useFerryCell: UITableViewCell!
  //   @IBOutlet weak var useFerryCell: UITableViewCell!
    
    @IBOutlet weak var useLocalTrafficCell: UITableViewCell!
    
    
  //  @IBOutlet weak var useRailCell: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("transportTypesFlag (viewWillAppear) = \(transportTypesFlag)")
        if (transportTypesFlag == true){

            print("......bus dict\(transportModeDict.value(forKey: useBus))")

           if  (transportModeDict.value(forKey: useBus) != nil){
            if ((transportModeDict.value(forKey: useBus) as! String) == useBus ){
            
                print("useBus selected")
                
                useBusCell.backgroundColor = UIColor.lightGray
                print("useBus selected after")
            }
            }
            // useMetro
            print("checking for metro")
            
            
            if  (transportModeDict.value(forKey: useMetro) != nil){
            
            if ((transportModeDict.value(forKey: useMetro) as! String) == useMetro ){
                
                print("useMetro selected")
            useMetroCell.backgroundColor =  UIColor.lightGray
                
                }
            
            }
            
            // useRail
            
             print("checking for Rail")
            if  (transportModeDict.value(forKey: useTrain) != nil){
                
            if ((transportModeDict.value(forKey: useTrain) as! String) == useTrain ){
                useRailCell.backgroundColor =  UIColor.lightGray
                
                print("useTrain selected")
            }
            }
            //useTram
          
             print("checking for Tram")
            if  (transportModeDict.value(forKey: useTram) != nil){
                
            if ((transportModeDict.value(forKey: useTram) as! String) == useTram ){
                useTramCell.backgroundColor =  UIColor.lightGray
                
                print("useTram selected")
            }
            
            }
            
            //useFerry
          
            if  (transportModeDict.value(forKey: useFerry) != nil){
                
            if ((transportModeDict.value(forKey: useFerry) as! String) == useFerry ){
                useFerryCell.backgroundColor =  UIColor.lightGray
                
                print("useFerry selected")
            }
            }
            
            //use LocalTraffic
            if  (transportModeDict.value(forKey: useShip) != nil){
                
            if ((transportModeDict.value(forKey: useShip) as! String) == useShip ){
                useLocalTrafficCell.backgroundColor =  UIColor.lightGray
                print("useLocal Traffic selected")
            }
            
            }
            
//
//
//        
//            useBusCell?.backgroundColor = UIColor.orangeColor()
//            print("useBus cell has been caught----\(useBusCell?.accessibilityIdentifier)")
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        print("index path row value is = \(indexPath.row)")
        //let labelTransportMode = super.tableView.cellForRowAtIndexPath(indexPath)?.viewWithTag(indexPath.row + 1) as! UILabel
        
        let labelTransportMode = super.tableView.cellForRow(at: indexPath as IndexPath)
        
         print("------------tag value is \(labelTransportMode?.tag)----------")
        let valueTransportMode = labelTransportMode!.accessibilityIdentifier
        
        print("-----------------------label's identifier---------------")
        print(labelTransportMode!.accessibilityIdentifier)
        
        
        if (transportModeDict[valueTransportMode!] != nil){
            
            // remove code and change background color
            
            // REMOVE the identifier value of the label to the transport mode dict
            transportModeDict.removeObject(forKey: valueTransportMode!)
            
            // print complete dictionary
            
            print("TRANSPORT MODE DICTIONARY AFTER REMOVING CELLS = \(transportModeDict)")
            
            
            super.tableView.cellForRow(at: indexPath as IndexPath)?.backgroundColor = UIColor.white
            print("last value of transportTypesUIColor.lightGrayColor() = \(transportTypesFlag)")
            
            if (transportModeDict.count == 0){
                
                transportTypesFlag = false
                print("transportTypesFlag = false \(transportTypesFlag)")
            }
            
            
        }
        
        
        else {
        
            transportModeDict.setValue(valueTransportMode, forKey: valueTransportMode!)
            
            // print complete dictionary
         
            transportTypesFlag = true
            print("transportTypesFlag = true \(transportTypesFlag)")
            print("TRANSPORT MODE DICTIONARY AFTER SELECTION = \(transportModeDict)")
            super.tableView.cellForRow(at: indexPath as IndexPath)?.backgroundColor = UIColor.lightGray
          
        }
        
        /*
        if ( super.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor == UIColor.lightGrayColor()){
        
        }
            else if ( super.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor == UIColor.whiteColor())
            {
             // get the label by tag from the cell
        // get the identifiers value from the label
        
        // add the identifier value of the label to the transport mode dict
            transportModeDict.setValue(valueTransportMode, forKey: valueTransportMode!)
            
        // print complete dictionary
            
            print("TRANSPORT MODE DICTIONARY AFTER SELECTION = \(transportModeDict)")
                
                super.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.lightGrayColor()
            }
        */ 
        
        
//        else if (super.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor == UIColor.whiteColor()){
//        
//            
//            // get the label by tag from the cell
//            
//            // get the identifiers value from the label
//            
//            // REMOVE the identifier value of the label to the transport mode dict
//            transportModeDict.removeObjectForKey(valueTransportMode!)
//            
//            // print complete dictionary
//            
//            print("TRANSPORT MODE DICTIONARY AFTER REMOVING CELLS = \(transportModeDict)")
//            
//        
//        
//        
//        }
//        
        
        //MARK TRANSPORTMODE CHANGE transport mode flag
        if (transportModeDict.count > 0){
            transportModeFlag = true
        } else if (transportModeDict.count == 0){
            transportModeFlag = false
        }
    }
    // MARK: - Table view data source
   /*
 override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

}

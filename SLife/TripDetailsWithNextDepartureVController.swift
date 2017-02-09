//
//  TripDetailsWithNextDepartureVControllerCollectionViewController.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-18.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TripDetailsWithNextDepartureVController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }

var selectedTrip = Trip()
var currentSelectedTripIndexPath = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Lind  : 26: newTripReceived = \(selectedTrip.originDetail.name)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
     //   self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = selectedTrip.LegList.count
        print("Line 49: current selected trip .count = \(sectionCount)")
        return sectionCount
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TEST TITLE"
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let legList_Leg_HeaderCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! TripDetail_LegList_Leg_CellsTableViewCell
        // copy code from tripsuggestion: cell for tableView 
    legList_Leg_HeaderCell.from_station.text = "Temp"
    legList_Leg_HeaderCell.from_time.text = "00:00"
        legList_Leg_HeaderCell.to_station.text = "Temp"
        legList_Leg_HeaderCell.to_time.text = "00:00"
        
        
        
        return legList_Leg_HeaderCell
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = selectedTrip.LegList.count
        
        return count
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DeparturesCellTableViewCell
        
        let receivedCell = cellToShow[0] as! DeparturesCellTableViewCell
        
        cell.from.text = receivedCell.t
        // Configure the cell...
        
        return cell
    }*/
    

//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//       // number of sections is equal to LegList Count
//        
//        let legListCount = selectedTrip.LegList.count
//        print("Selected Trip selectedTrip Count = \(legListCount)")
//        return 0
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//    
//        return cell
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

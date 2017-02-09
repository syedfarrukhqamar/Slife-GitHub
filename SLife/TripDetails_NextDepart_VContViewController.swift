//
//  TripDetails_NextDepart_VContViewController.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-18.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit



var currentSelectedTripIndex = 0
var selectedTrip = Trip()

class TripDetails_NextDepart_VContViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }

    
    
    
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
        let count = 0 // selectedTrip.LegList.count
        
        return count
    }
}

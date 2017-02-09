//
//  TripInfoTableViewCell.swift
//  Slife
//
//  Created by syed farrukh Qamar on 2017-01-20.
//  Copyright © 2017 Be My Competence AB. All rights reserved.
//

import UIKit

class TripInfoTableViewCell: UITableViewCell {
    
    // @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    @IBOutlet weak var showCurrentLegDep_outlet: UIButton!
   // @IBOutlet weak var nextDeparturesOutlet: UIButton!
    // @IBOutlet weak var nextDeparturesLatest: UIButton!
    var sectionInfo = String()
    var rowInfo = String()
    var keyName = String()
    var showHideDepartureCell_Master = false
    var legTag = Int()
    var lineDistTag = Int()
    var departuresLoadedNext = false
    //    @IBOutlet weak var legIcon: UIButton!
    //    @IBOutlet weak var legIconImageButton: UIButton!
    //    @IBOutlet weak var lineNumber: UIButton!
    //
    @IBOutlet weak var nextDepartureTillCurrLeg_Outlet: UIButton!
    // @IBOutlet weak var nextDeparturesOutlet: UIButton!
    //@IBOutlet weak var nextdepartures_Outlet: UIButton!
    // @IBOutlet weak var legIconButton: UIButton!
    
    
    //-----------------Origin
    @IBOutlet weak var rtuMessage: UILabel!
    
    @IBOutlet weak var transportTypeOutlet: UILabel!
    
    @IBOutlet weak var legImage: UIImageView!
    @IBOutlet weak var from_time: UILabel!        // 1
    @IBOutlet weak var from_station: UILabel!     // 2
    @IBOutlet weak var ine_dist: UILabel!
    
    
    // visual Leg                                 // 3
 //   @IBOutlet weak var name: UILabel!             // 4
    // for Walk. "Walk will be the string" for travel "mot or towards" will be placed
 //   @IBOutlet weak var towards_or_walk:UILabel!   // 4.5
    //----------for Walk. dist will be placed
    //----------for Travel.Line will be placed
 //   @IBOutlet weak var line_dist:UILabel!         // 5
    //    @IBOutlet weak var name: UILabel!
    //-----------------Destination
    @IBOutlet weak var to_time: UILabel!          // 6
    @IBOutlet weak var to_station: UILabel!       // 7
    
    // @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.contentView.willRemoveSubview(showCurrentLegDep_outlet)
        
        self.contentView.willRemoveSubview(nextDepartureTillCurrLeg_Outlet)
        print("Prepare for reUse:self.legTag=\(self.legTag) & self.LineDistTag\(self.lineDistTag)")
        let legTagToRemove = self.legTag
        let lineDist_TagToRemove  = self.lineDistTag
        
        /*
        if (self.viewWithTag(legTagToRemove) != nil){
            let someButton = self.viewWithTag(legTagToRemove) as! UIButton
            
            print("somebutton check = \(someButton.accessibilityIdentifier)")
            print("Before some button hidden or not = 1000= \(someButton.isHidden)")
            someButton.backgroundColor = UIColor.yellow
            someButton.setTitle("2", for:UIControlState.normal)
            someButton.isHidden = true
            print("After some button hidden or not = \(someButton.isHidden)")
            self.contentView.willRemoveSubview(someButton)
            
            someButton.removeFromSuperview()
            
        }
        */
        
        
        /*
        if (self.viewWithTag(lineDist_TagToRemove) != nil){
            
            let someButton = self.viewWithTag(lineDist_TagToRemove) as! UIButton
            
            print("somebutton check = 1001 = \(someButton.accessibilityIdentifier)")
            print("Before some button hidden or not = \(someButton.isHidden)")
            someButton.backgroundColor = UIColor.yellow
            someButton.setTitle("999", for:UIControlState.normal)
            someButton.isHidden = true
            print("After some button hidden or not = \(someButton.isHidden)")
            self.contentView.willRemoveSubview(someButton)
            someButton.removeFromSuperview()
            
            
            
        }
        */
        /*
         let tagDepButton = 450
         if (self.viewWithTag(450) != nil){
         
         let someButton = self.viewWithTag(tagDepButton) as! UIButton
         
         print("somebutton check tagDepButton 450 = \(someButton.accessibilityIdentifier)")
         print("Before some button hidden or not = 1000= \(someButton.isHidden)")
         someButton.backgroundColor = UIColor.blue
         someButton.setTitle("2", for:UIControlState.normal)
         someButton.isHidden = true
         print("After some button hidden or not = \(someButton.isHidden)")
         self.contentView.willRemoveSubview(someButton)
         
         someButton.removeFromSuperview()
         
         }
         */
        
        // self  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LegListCells
        
    }
    
    //

}

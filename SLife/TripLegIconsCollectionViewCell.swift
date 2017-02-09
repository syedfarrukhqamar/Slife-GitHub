//
//  TripLegIconsCollectionViewCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 2016-11-21.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class TripLegIconsCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var from_station: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var to_station: UILabel!
    @IBOutlet weak var from_time: UILabel!
    @IBOutlet weak var to_time: UILabel!
    
    var tripLevel = true // True if Trip level , false if Leg Level
   // @IBOutlet weak var line_number: UILabel!
    override func prepareForReuse() {
       
        let count = self.contentView.subviews.count
       // print("Line3568: Before:\(count): \(indexPath)")
        
        var p = 0
        print("Line3568: Before:\(self.subviews.count)")
        for index in 0...count {
            
           super.prepareForReuse()
            
            //print("Line 33.......\(self.contentView.subviews[p])")
            
            print("Line 33.... \(p) & \(self.contentView.subviews.count)")
            if (p == self.contentView.subviews.count){
        
            
            }
            else {
                self.backgroundColor =  UIColor.init(patternImage: UIImage())

                print("Line 41:::\(self.backgroundColor)")
            if let checkButton =  self.contentView.subviews[p] as? UIButton
            {
                p -= 1
                checkButton.backgroundColor = UIColor.red
                checkButton.setBackgroundImage(nil, for: .normal)
                print("Line 3579: checkButton Caught:b4:\(self.contentView.subviews.count)")
                checkButton.removeFromSuperview()
             //   self.contentView.willRemoveSubview(checkButton)
                
                print("Line 3579: checkButton Caught:aft::\(self.contentView.subviews.count)")
                //self.contentView.willRemoveSubview(nextDepartureTillCurrLeg_Outlet)
                
                
            
                }}
            p += 1
            
        }
        
    }
}

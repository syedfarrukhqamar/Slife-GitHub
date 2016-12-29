//
//  WalkAwayVController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 02/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

class WalkAwayVController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @available(iOS 2.0, *)
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 10
//    }

// data source for picker is in the main screen
    
    
    @IBAction func doneWalkAway(sender: UIBarButtonItem) {
          super.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var canWalkOutlet: UIButton!
    @IBAction func canWalk(sender: UIButton) {
        // enable button and change flag to true
        print("can walk button has been pressed........")
        
        print("\(canWalkOutlet.backgroundColor.debugDescription)")
        if (canWalkOutlet.backgroundColor == UIColor.white || canWalkOutlet.backgroundColor == nil){
        walkawayFlag = true
            print ("flag is set =====walkawayFlag \(walkawayFlag)")
        walkAwayFlagStatusLabel.text = CHANGED
        canWalkOutlet.backgroundColor = UIColor.blue
        canWalkOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
       canWalkButtonEnabled = true
        }
        
        // disable button and change flag to false
        else if ( canWalkOutlet.backgroundColor == UIColor.blue){
            
        canWalkButtonEnabled = false
        walkawayFlag == false
       print ("flag is set =====walkawayFlag \(walkawayFlag)")
            canWalkOutlet.backgroundColor = UIColor.white
        canWalkOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
           
            distancePicker.selectRow(0, inComponent: 0, animated: true)
            walkAwayFlagStatusLabel.text = NOCHANGES
            walkAwaySelection = 0
        
        }
    }
    
    @IBAction func reset(sender: UIButton) {
        canWalkButtonEnabled = false
        walkawayFlag = false
        canWalkOutlet.backgroundColor = UIColor.white
        canWalkOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        print("Reset has been called.....")
        walkAwayFlagStatusLabel.text = NOCHANGES
        distancePicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    @IBOutlet weak var distancePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.distancePicker.delegate = self
        self.distancePicker.dataSource = self
        
        
        print(" Line Choices appeared-----")
    }
    override func viewWillAppear(_ animated: Bool) {
        distancePicker.selectRow(walkAwaySelection, inComponent: 0, animated: true)
        if (canWalkButtonEnabled == true){
        
        canWalkOutlet.backgroundColor = UIColor.blue
            canWalkOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
    }
    @IBOutlet weak var walkAwayFlagStatusLabel: UILabel!
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("data source distance picker count is = \(dataSourceDistancePicker.count)")
        return dataSourceDistancePicker.count
    }
    
    
    //titlefor
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        print("title for row is == \(dataSourceDistancePicker[row])")
        return dataSourceDistancePicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        walkAwaySelection = row
        
        
        print("walk away Selection :::: \(walkAwaySelection)")
        print("selected option from the picker is here = \(dataSourceDistancePicker[row])")
        
        // if button is enabled then what ever you select will be regarded as changed
        
        if (canWalkOutlet.backgroundColor == UIColor.blue){

            
            print("walk away flag is true (didSelectRow)-----")
        }
        else
        {
            // if button is disabled then 2km will be regarded as no changes
            if (row == 0){
            
                walkawayFlag = false
                walkAwayFlagStatusLabel.text = NOCHANGES
            } else  {
                walkawayFlag = true
                
                walkAwayFlagStatusLabel.text = CHANGED
            
            }
        
        
        }
        
        // if button is disabled and selection contains any thing other than 2km then changes will be applied
    }
    
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("prepare for seguq has been called from walk away")
//    }
}

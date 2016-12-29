//
//  TransportationChangesVController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 02/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit


class TransportationChangesVController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("number of compnonents have been called......")

        return 1
    }
  //    var  timeBetweenChangesDataSource = [0,2,3,4,5,10,15,20,25,30,35,40,45,50,55,60,75,90,]
    
    // data source for changesPicker
    
    
    @IBOutlet weak var timeBetweenChanges: UIPickerView!
    
    @IBOutlet weak var changesPicker: UIPickerView!
    
  //  @IBOutlet weak var dontWantToMakeChanges: UIButton!
    
    @IBOutlet weak var noNeedOfExtraTimeOutLet: UIButton!
    
    @IBOutlet weak var extraTimeBetweenChanges: UIButton!
   
    @IBOutlet weak var reset: UIButton!
    @IBAction func resetAction(sender: UIButton) {
    
        
        transportChangesFlag = false
        maxTransportChanges = 0
        extraTimeBetweenTransportChanges = 0
        noNeedOfExtraTimeOutLet.backgroundColor = UIColor.white
        noNeedOfExtraTimeOutLet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        extraTimeBetweenChanges.backgroundColor = UIColor.white
        extraTimeBetweenChanges.setTitleColor(UIColor.blue, for: UIControlState.normal)
        timeBetweenChanges.selectRow(maxTransportChanges, inComponent: 0, animated: true)
        changesPicker.selectRow(extraTimeBetweenTransportChanges, inComponent: 0, animated: true)
        
    }
 
 /*
 @IBAction func dontWantToMakeChangesAction(sender: UIButton) {
        
        
        
        changesPicker.selectRow(0, inComponent: 0, animated: true)
        transportChangesFlag = false
        print("current changes flag = \(transportChangesFlag)")
        maxTransportChanges = 0
        
        dontWantToMakeChanges.backgroundColor = UIColor.blueColor()
        dontWantToMakeChanges.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        print("UiButton Pressed::current changes value int = \(maxTransportChanges)")
        
        
        //
        //        // if background is nil or white then change to blue
        //        if (dontWantToMakeChanges.backgroundColor == nil || dontWantToMakeChanges.backgroundColor == UIColor.whiteColor())
        //        {
        //
        //            dontWantToMakeChanges.backgroundColor = UIColor.blueColor()
        //            dontWantToMakeChanges.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //
        //            extraTimeBetweenChanges.backgroundColor = UIColor.whiteColor()
        //            extraTimeBetweenChanges.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        //           }
        
    }
     */

    @IBAction func noNeedOfExtraTimeAction(sender: UIButton) {
   extraTimeFlag = false
        timeBetweenChanges.selectRow(0, inComponent: 0, animated: true)
    print("extra time flag is set to false")
    
        extraTimeBetweenChanges.backgroundColor = UIColor.white
        extraTimeBetweenChanges.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        noNeedOfExtraTimeOutLet.backgroundColor = UIColor.blue
        noNeedOfExtraTimeOutLet.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        transportChangesFlag = false
    }
    @IBAction func extraTimeBetweenChangesAction(sender: UIButton) {
      
//        if (extraTimeFlag == false){
//        
//            extraTimeBetweenChanges.backgroundColor = UIColor.blueColor()
//            extraTimeBetweenChanges.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            extraTimeBetweenChanges.setTitle("Do Not Need Extra Time", forState: UIControlState.Normal)
//        print("extra time flag is set to true now")
//            extraTimeFlag = true
//        }
//        
//        else
        transportChangesFlag = true
        extraTimeFlag = true
        timeBetweenChanges.selectRow(0, inComponent: 0, animated: true)
        print("extra time flag is set to true now")
        
        extraTimeBetweenChanges.backgroundColor = UIColor.blue
        extraTimeBetweenChanges.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        noNeedOfExtraTimeOutLet.backgroundColor = UIColor.white
        noNeedOfExtraTimeOutLet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        /*
        timeBetweenChanges.selectRow(0, inComponent: 0, animated: true)
        transportExtraMinutesFlag = false
        print("transportExtraMinutesFlag flag = \(transportExtraMinutesFlag)")
        extraTimeBetweenTransportChanges = 0
        
        extraTimeBetweenChanges.backgroundColor = UIColor.blueColor()
        extraTimeBetweenChanges.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
         extraTimeBetweenChanges.setTitle("No time is required between changes", forState: UIControlState.Normal)
        print("current extraTimeBetweenTransportChanges = \(extraTimeBetweenTransportChanges)")

        */
        //        if (extraTimeBetweenChanges.backgroundColor == nil || extraTimeBetweenChanges.backgroundColor == UIColor.whiteColor())
//        {
//            
//        dontWantToMakeChanges.backgroundColor = UIColor.whiteColor()
//        dontWantToMakeChanges.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        extraTimeBetweenChanges.backgroundColor = UIColor.blueColor()
//        extraTimeBetweenChanges.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        
//        
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changesPicker.delegate = self
        self.timeBetweenChanges.delegate = self
        
        print("view did load.....")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("transport Mode Flag= \(transportChangesFlag)")
        
        if ( transportChangesFlag == true ){
        
        changesPicker.selectRow(maxTransportChanges, inComponent: 0, animated: true)
        
            timeBetweenChanges.selectRow(extraTimeBetweenTransportChanges, inComponent: 0, animated: true)
        }
        
    }
    // timeBetweenChanges picker loading
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//     
//        print("number of compnonents have been called......")
////        if (pickerView.tag == 1 )
////        {
////            print("timeBetweenChangesDataSource: FIRST PICKER VIEW")
////            
////            return timeBetweenChangesDataSource.count
////        } else if (pickerView.tag == 2){
////        print("changesPickerDataSource:: SECOND PICKER VIEW")
////            
////        return changesPickerDataSource.count
////        }
//        return 1
//    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     print("number of rows in component has been called.-----")
        if (pickerView.tag == 1 )
        {
            print("timeBetweenChangesDataSource: FIRST PICKER VIEW")
            
            return changesPickerDataSource.count
        } else if (pickerView.tag == 2){
            print("c")
            
            return timeBetweenChangesDataSource.count
            
        }

        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1 )
        {
            
          //  print("changesPickerDataSource:: SECOND PICKER VIEW")
            print("picker view tag 1 is here 1")
            return String(changesPickerDataSource[row])
       
            
        } else if (pickerView.tag == 2){
            
            
            print("picker view tag 2 is here 2")
            //print("timeBetweenChangesDataSource: FIRST PICKER VIEW")
            
            return String(timeBetweenChangesDataSource[row])
             }

        
        return "Default"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("selected option from the picker is here = \(dataSourceDistancePicker[row])")

        if (pickerView.tag == 1 )
        {
            // changes
 
            if(row == 0){
                maxTransportChanges = row
                transportChangesFlag = false
                print("tag 1 ::::::No Restrictions")
            }
            // if index is 0 then nochange and flag is false
            else {
                maxTransportChanges = row
                print("tag::::mex transport changes index is = \(maxTransportChanges)")
            transportChangesFlag = true
            }
            // for rest the flag is true
            
/*            transportChangesFlag = true
            maxTransportChanges = changesPickerDataSource[row]
            print("changesPickerDataSource:: selected = \(changesPickerDataSource[row]) ")
            
            print("Picker Value extra Minutes::current changes value int = \(maxTransportChanges)")
            dontWantToMakeChanges.backgroundColor = UIColor.whiteColor()
            dontWantToMakeChanges.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
  */
            
            
            
            
//            return timeBetweenChangesDataSource.count
        } else if (pickerView.tag == 2){
            
            // time between changes
         //   transportExtraMinutesFlag = true
            if (extraTimeFlag == true)
            {
            
            extraTimeBetweenTransportChanges = row
            print("Tag 2 extra time value is = \(row)")
            }
            /*
            extraTimeBetweenTransportChanges = timeBetweenChangesDataSource[row]
            
            print("timeBetweenChangesDataSource:: selected = \(timeBetweenChangesDataSource[row]) ")
            
            print("extraTimeBetweenTransportChanges:picker value Number of Changes::current changes value int = \(extraTimeBetweenTransportChanges)")
            
            extraTimeBetweenChanges.backgroundColor = UIColor.whiteColor()
            extraTimeBetweenChanges.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            extraTimeBetweenChanges.setTitle("Reset Time", forState: UIControlState.Normal)
            
          */
        }

    }

    
    // changesPicker picker loading
    

}

//
//  HelpingMethods.swift
//  SLife
//
//  Created by syed farrukh Qamar on 09/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit

class HelpingMethods: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    // current date and time method
    static func currentDateTime () -> String {
        
        let date = NSDate()
        let dateFormat = DateFormatter()
        let timeFormat = DateFormatter()
        
        
        dateFormat.dateFormat = "yyyy:MM:dd"
        timeFormat.dateFormat = "HH:mm"
        let strDate = dateFormat.string(from: date as Date)
    //    let strtime = timeFormat.stringFromDate(date as Date)
    let strtime = timeFormat.string(from: date as Date)
        let now = strDate + " " + strtime

        
        return now
    
    }
    
    // current date method
    
    static func currentDate () -> String {
        
        let date = NSDate()
        let dateFormat = DateFormatter()
       // let timeFormat = NSDateFormatter()
        
        dateFormat.dateFormat = "yyyy:MM:dd"
       // timeFormat.dateFormat = "HH:mm"
        let strDate = dateFormat.string(from: date as Date)
        //let strtime = timeFormat.stringFromDate(date)
        let now = strDate // + " " + strtime
        
        
        return now
        
    }

    
    // current time method
    
    
    static func currentTime24Hour () -> String {
        
        let date = NSDate()
        //let dateFormat = NSDateFormatter()
         let timeFormat = DateFormatter()
        
      //  dateFormat.dateFormat "yyyy:MM:dd"
         timeFormat.dateFormat = "HH:mm"
        //let strDate = dateFormat.stringFromDate(date)
        let time = timeFormat.string(from: date as Date)
        let nowTime =  time // + " " + strtime
        
        
        return nowTime
        
    }
    
    

    
    
}

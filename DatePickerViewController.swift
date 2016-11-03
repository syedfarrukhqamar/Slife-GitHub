//
//  DatePickerViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 11/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import AVFoundation
import UIKit
var date_value_simple = String()
protocol popOverValue: class {
    func receiveValueFromPopOver(Date: String, Time: String)
}
var dateAndTimeSelection = String()
class DatePickerViewController: UIViewController {
    @IBAction func Done(_ sender: UIBarButtonItem) {
        
        simple_earliestDepartLatestArrival_flag = true
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let dateSelected = dateFormatter.string(from: date)
        let time = timeFormatter.string(from: date)
        dateAndTimeSelection = dateSelected + "-" + time
        //print()
        delegate?.receiveValueFromPopOver(Date: dateSelected, Time: time)
        self.dismiss(animated: true, completion: nil)
        
        presentedViewController?.dismiss(animated: true, completion: nil)
        print("--date picker done has been pressed-------dismissed--\(datePicker.date)")
        
    }
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        
          self.dismiss(animated: true, completion: nil)
    }
   // @IBOutlet weak var Cancel: UIBarButtonItem!
   weak var delegate:popOverValue?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.preferredContentSize = CGSizeMake(400, 400)
       
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: "dismiss:")
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonSystemItem#>, target: <#T##Any?#>, action: <#T##Selector?#>)
  //      self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: Selector("cancel:"))
    }
    
    
//    func dismiss(sender: AnyObject) {
//        
//         
//     let date = datePicker.date
//     let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//      let timeFormatter = DateFormatter()
//        
//        timeFormatter.dateFormat = "HH:mm"
//        
//        let dateSelected = dateFormatter.string(from: date)
//        let time = timeFormatter.string(from: date)
//        
//         dateAndTimeSelection = dateSelected + "-" + time
//        
//        print(datePicker.date)
//        
//        delegate?.receiveValueFromPopOver(Date: dateSelected, Time: time)
//        
//        self.dismiss(animated: true, completion: nil)
//       presentedViewController?.dismiss(animated: true, completion: nil)
//        print("---------dismissed")
//    }
    
//    func cancel (sender: AnyObject) {
//        self.dismiss(animated: true, completion: nil)
//        
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare for segue has been called")
    }
}

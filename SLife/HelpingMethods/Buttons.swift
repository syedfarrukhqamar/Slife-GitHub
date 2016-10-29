//
//  Buttons.swift
//  SLife
//
//  Created by syed farrukh Qamar on 09/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

class Buttons: UIViewController {
    
    
 // enable button
    
    static func enableButton (button:UIButton,title: String )    {
    
        // change background color of button
        button.backgroundColor = UIColor.blue
        button.isUserInteractionEnabled = true
        // change title color
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        // change title if not empty
        if (title != ""){
        button.setTitle(title, for: UIControlState.normal)
        }
    // enable text field
    }

    static func enableTextField (textField:UITextField,textFieldText: String )
        {
            
            // change background color of Text Field
            
            textField.isUserInteractionEnabled = true
            
            // change title if not empty
            if (textFieldText != ""){
                
                textField.text = textFieldText
            }
    }
    // change text of Label
            
            static func changeTextUILabel (labelObject  :UILabel ,labelText: String )
            {
                
                // lebelObject Text Change
                labelObject.text = labelText
            }
    
    // disbale button
        
    static func disableButtonWithGrey (button:UIButton,title: String )    {
        
        // change background color of button
        button.backgroundColor = UIColor.gray
        // change title color
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.isUserInteractionEnabled = false
        // change title if not empty
        if (title != ""){
            button.setTitle(title, for: UIControlState.normal)
        }
    }
    
            static func disableButton (button:UIButton,title: String )    {
                
                // change background color of button
                button.backgroundColor = UIColor.white
                button.isUserInteractionEnabled = true 
                // change title color
                button.setTitleColor(UIColor.blue, for: UIControlState.normal)
                // change title if not empty
                if (title != ""){
                    button.setTitle(title, for: UIControlState.normal)
                }
            
    // disable text field
    }
    
            static func disableTextField (textField:UITextField,textFieldText: String )
                {
                    
                    // disable user interaction of text field
                    
                    textField.isUserInteractionEnabled = false
                    
                    // change title if not empty
                    if (textFieldText != ""){
                        
                        textField.text = textFieldText
                    }

    
    }
    // enable one and disable other two buttons
    
    static func enableOneAndDisableTwoButtons (enableButtonFirst: UIButton, disableButtonSecond: UIButton,disableButtonThird: UIButton){
    
        // enable button
        
        enableButtonFirst.backgroundColor = UIColor.blue
        enableButtonFirst.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        // disable first button
        
        disableButtonSecond.backgroundColor = UIColor.white
        disableButtonSecond.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        // disable second button
        disableButtonThird.backgroundColor = UIColor.white
        disableButtonThird.setTitleColor(UIColor.blue, for: UIControlState.normal)
    
    }
    
    // enable one and disable other two buttons
    
    static func enableOneAndDisableOneButton (enableButtonFirst: UIButton, disableButtonSecond: UIButton){
        
        // enable button
        
        enableButtonFirst.backgroundColor = UIColor.blue
        enableButtonFirst.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        // disable first button
        
        disableButtonSecond.backgroundColor = UIColor.white
        disableButtonSecond.setTitleColor(UIColor.blue, for: UIControlState.normal)
        

//        // disable second button
//        disableButtonThird.backgroundColor = UIColor.whiteColor()
//        disableButtonThird.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        
        
        
        
    }
    
    // Enable one button and disable the rest of the buttons based on the received tag range
    
    static func selectButton_AndResetRest (selectedButtonTag: Int, buttonRangeFromTag: Int, buttonRangeToTag: Int,currentCell: UITableViewCell){
    print("----selectButton_AndResetRest-------------")
    var tagRange = (buttonRangeToTag - buttonRangeFromTag)
     
        
        var startIndex = buttonRangeFromTag
        var stopIndex = buttonRangeToTag
        var i = 0
        // MARK: SWIFT 3 FOR LOOP
        for index in startIndex...stopIndex {
        
        
        
        i += 1
//        }
//        
//        for (var i = buttonRangeFromTag ; i <= buttonRangeToTag ; i += 1) {

            print("----inside for loop before condition= \(index)")
            
            if (selectedButtonTag == index){
                // enable selected Button Tag
                
                var selectedButton = currentCell.viewWithTag(selectedButtonTag) as? UIButton
                print("enabling button : with tag = \(index)")
                enableButton(button: selectedButton!, title: "")
            } else {
                // reset the rest of the buttons
                print("Resetting button : with tag = \(index)")
                var resetButtons = currentCell.viewWithTag(index) as? UIButton
                
                disableButton(button: resetButtons!, title: "")
                
            }
            
            
//            if (i != 12){
//            }
         }
    
    
    }
    
}

//
//  LineChoicesVController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 02/06/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import AVFoundation

// Each button will have a tag
// All = 0
// Include = 1
// Exclude = 2

var lineChoicesDetails = ["LineNumbers","All","lineInc","lineExc"]

var lineChoiceSelection = 1
let allLinesTag = 1
let includeLinesTag = 2
let excludeLinesTag = 3

class LineChoicesVController: UIViewController {
   
    
    @IBAction func lineChoicesBeingEntered(sender: UITextField) {
        
        lineChoices = lineNumbersTextBox.text!
        print("last line choices value is = \(lineChoices)")
    }
    @IBAction func resetLineNumbers(sender: UIButton) {
        
        print("reset has been pressed")
        
        lineChoiceIncludeOrExclude = ""
    
        
        // reset selected button
        
//        let oldSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
//        oldSelection.backgroundColor = UIColor.whiteColor()
//        oldSelection.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        // rest the flag
        lineChoicesFlag = false
        // reset the array string
        lineChoicesDetails[0] == ""
        
        // reset the line Tags
    
        lineChoiceSelection = 0
        
        lineNumbersTextBox.text = ""
        includeAllLinesOutlet.backgroundColor = UIColor.blue
        includeAllLinesOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        includeLinesOutlet.backgroundColor = UIColor.white
        includeLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        doNotIncludeLinesOutlet.backgroundColor = UIColor.white
        doNotIncludeLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
          
        lineNumbersTextBox.isUserInteractionEnabled = false
        
        
    }
    @IBAction func done(sender: UIBarButtonItem) {
        print("done has been called")
        super.navigationController?.popViewController(animated: true)
        
        //if (lineNumbersTextBox.text?.endIndex)
        print("lineNumbersTextBox.text? = \(lineNumbersTextBox.text)")
        print("test = \(String(describing: lineNumbersTextBox.text!))")
        let lineNumbersEntered = Int(String(describing: lineNumbersTextBox.text!))
        
        print("lineChoices value last = (lineChoices)")
        print("lineChoices Include or Exclude value last = \(lineChoiceIncludeOrExclude)")
        
        print("lineNumbersEntered = \(lineNumbersEntered)")
        if ( lineNumbersEntered! >= 1){
        lineChoicesFlag = true
         lineChoices = lineNumbersTextBox.text!
        
        }
        print("Line Numbers Flags are = \(lineChoicesFlag)")
        
        lineChoicesDetails[0] = lineNumbersTextBox.text!
        
    }
    @IBOutlet weak var includeAllLinesOutlet: UIButton!
    @IBOutlet weak var includeLinesOutlet: UIButton!
    @IBOutlet weak var doNotIncludeLinesOutlet: UIButton!
    @IBOutlet weak var lineNumbersTextBox: UITextField!
  
    @IBAction func includeAllLinesAction(sender: UIButton) {
        print(".pressed all lines")
        
        radioButton(buttonSelected: sender.tag)
        
 // reset every thing and disable editing
 /*
        lineNumbersTextBox.userInteractionEnabled = false
        lineNumbersTextBox.text = ""
        lineChoicesFlag = false
        lineChoices = ""
          // includeAllLine tag is 1
        // reset the previous selection
        
        let oldSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
        oldSelection.backgroundColor = UIColor.whiteColor()
        oldSelection.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // set the tag for current selection
            lineChoiceSelection = includeAllLinesOutlet.tag
        // set the background color for the current selection
        let newSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
        newSelection.backgroundColor = UIColor.blueColor()
        newSelection.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        print("Current LineNumberTag is (should=All Lines)=\(lineChoiceSelection) ")
 */
        
    }
    
    @IBAction func includeLinesAction(sender: UIButton) {
        radioButton(buttonSelected: sender.tag)
        lineChoiceIncludeOrExclude = ""
        
        lineChoiceIncludeOrExclude = "lineInc"
      
        /*
 lineNumbersTextBox.userInteractionEnabled = true
        lineNumbersTextBox.becomeFirstResponder()
        
        // includeLines tag is 2
        // reset the previous selection
        
        print("Line Choice Selection = \(lineChoiceSelection)")
        let oldSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
        if (lineChoiceSelection == includeLinesOutlet.tag){
        
            
        
            // remove it from current & Set it for AllLines
            
            // remove it from current & Set it for AllLines
            oldSelection.backgroundColor = UIColor.whiteColor()
            oldSelection.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            lineChoiceSelection = includeAllLinesOutlet.tag
            
            let newSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
            newSelection.backgroundColor = UIColor.blueColor()
            newSelection.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
           // print("Current LineNumberTag is (should=All )=\(lineChoiceSelection) ")
            
        print("Current LineNumberTag is (should=All)=\(lineChoiceSelection) ")
        }
        
        else {
        let oldSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
        oldSelection.backgroundColor = UIColor.whiteColor()
        oldSelection.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // set the tag for current selection
        lineChoiceSelection = includeLinesOutlet.tag
        // set the background color for the current selection
        let newSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
        newSelection.backgroundColor = UIColor.blueColor()
        newSelection.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        print("Current LineNumberTag is (should=include Lines)=\(lineChoiceSelection) ")
            
            
        }
 */
        
        }
    @IBAction func doNotIncludeLinesAction(sender: UIButton) {
        radioButton(buttonSelected: sender.tag)

        lineChoiceIncludeOrExclude = ""
        lineChoiceIncludeOrExclude = "lineExc"
        
        // includeLines tag is 3
        // reset the previous selection
        
    /*
 lineNumbersTextBox.userInteractionEnabled = true
        lineNumbersTextBox.becomeFirstResponder()
        
        let oldSelection = view.viewWithTag(lineChoiceSelection) as! UIButton

        if (lineChoiceSelection == doNotIncludeLinesOutlet.tag){
            
            // remove it from current & Set it for AllLines
            oldSelection.backgroundColor = UIColor.whiteColor()
            oldSelection.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            
            lineChoiceSelection = includeAllLinesOutlet.tag
            let newSelection = view.viewWithTag(sender.tag) as! UIButton
            newSelection.backgroundColor = UIColor.blueColor()
            newSelection.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
           
            print("Current LineNumberTag is (should=All )=\(lineChoiceSelection) ")
        }

        else {
                oldSelection.backgroundColor = UIColor.whiteColor()
        oldSelection.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // set the tag for current selection
        lineChoiceSelection = doNotIncludeLinesOutlet.tag
        
        // set the background color for the current selection
        let newSelection = view.viewWithTag(lineChoiceSelection) as! UIButton
        newSelection.backgroundColor = UIColor.blueColor()
        newSelection.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        
        print("Current LineNumberTag is (should=exclude)=\(lineChoiceSelection) ")

        }
 */
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" Line Choices appeared-----")
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        print("view Will Appear <LineNumbers> =\(lineChoicesFlag) ")
        
        print("view Will Appear <LineNumbers> line choices =\(lineChoices) ")
        
        if (lineChoicesFlag == true ){
         
            lineNumbersTextBox.text = lineChoices
            
        }
        radioButton(buttonSelected: lineChoiceSelection)
        /*
        if (lineChoicesFlag == false)
        {
            print("Line Choices Flag Value FALSE = \(lineChoicesFlag)")
            // Include all should be blue and title should be white
            
            includeAllLinesOutlet.backgroundColor = UIColor.blueColor()
            includeAllLinesOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            
            // rest of them should be white
                includeLinesOutlet.backgroundColor = UIColor.whiteColor()
                includeLinesOutlet.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            
            // text box should be disabled
            lineNumbersTextBox.userInteractionEnabled = false
        }
        else if (lineChoicesFlag == true){
            
            lineNumbersTextBox.text = lineChoices
            let selectedOption = view.viewWithTag(lineChoiceSelection) as! UIButton
            
            if (lineChoiceSelection == 1){
           
            // enable 1
                includeAllLinesOutlet.backgroundColor = UIColor.blueColor()
                includeAllLinesOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                lineNumbersTextBox.becomeFirstResponder()
                
            // disable 0 & 2
            
              includeAllLinesOutlet.backgroundColor = UIColor.whiteColor()
              includeAllLinesOutlet.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
              doNotIncludeLinesOutlet.backgroundColor = UIColor.whiteColor()
                doNotIncludeLinesOutlet.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                
                
                
            } else if (lineChoiceSelection == 2){
            
                // enable 2
                doNotIncludeLinesOutlet.backgroundColor = UIColor.blueColor()
                doNotIncludeLinesOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                lineNumbersTextBox.becomeFirstResponder()
                

                
                
                // disable 0 & 1
                
                includeAllLinesOutlet.backgroundColor = UIColor.whiteColor()
                includeAllLinesOutlet.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                
                includeAllLinesOutlet.backgroundColor = UIColor.whiteColor()
                includeAllLinesOutlet.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                

                
                
            
            }
            
            
            // enable the one which was selected
            // rest of them should be white
            // text box should show the value which was entered last

            
            
            print("Line Choices Flag Value TRUE = \(lineChoicesFlag)")
            
        }
    */
        
    }

    func radioButton(buttonSelected: Int) {
    print("button selected ......\(buttonSelected)")
        // if all include is pressed
        if (buttonSelected == 1){
        // enable all includes
          includeAllLinesOutlet.backgroundColor = UIColor.blue
            includeAllLinesOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
            
        // reset all variables
          lineChoicesFlag = false
          lineChoiceSelection = 1
          lineChoices = ""
           lineNumbersTextBox.text = ""
            
        // disable include lines
            
            includeLinesOutlet.backgroundColor = UIColor.white
            includeLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
        // disable do not include lines
            
            doNotIncludeLinesOutlet.backgroundColor = UIColor.white
        doNotIncludeLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
            
        // disable text field to enter text
                lineNumbersTextBox.text = ""
                lineNumbersTextBox.isUserInteractionEnabled = false
        
        }
        
        // if include line is pressed
        if (buttonSelected == 2){
        
            // if all include is pressed
            
            //if (buttonSelected == 1){
            
            // disable all includes
                includeAllLinesOutlet.backgroundColor = UIColor.white
                includeAllLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
                
                // flag should be true
                lineChoicesFlag = true
                lineChoiceSelection = 2
                 lineChoices = lineNumbersTextBox.text!
                
                // enable include lines
                
                includeLinesOutlet.backgroundColor = UIColor.blue
                includeLinesOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
                
                
                // disable do not include lines
                
                doNotIncludeLinesOutlet.backgroundColor = UIColor.white
                doNotIncludeLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
                
                // disable text field to enter text
            
                lineNumbersTextBox.text = lineChoices
                lineNumbersTextBox.isUserInteractionEnabled = true
                lineNumbersTextBox.becomeFirstResponder()
            
            
    }
        
        // if exclude line is pressed
        
        if (buttonSelected == 3){
            
            // if all include is pressed
            
            //if (buttonSelected == 1){
            
            // disable all includes
            includeAllLinesOutlet.backgroundColor = UIColor.white
            includeAllLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
            
            // flag should be true
            lineChoicesFlag = true
            lineChoiceSelection = 3
            
            lineChoices = lineNumbersTextBox.text!
            
            // disable include lines
            
            includeLinesOutlet.backgroundColor = UIColor.white
            includeLinesOutlet.setTitleColor(UIColor.blue, for: UIControlState.normal)
            
            
            // enable do not include lines
            
            doNotIncludeLinesOutlet.backgroundColor = UIColor.blue
            doNotIncludeLinesOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            // enable text field to enter text
            lineNumbersTextBox.text = lineChoices
            lineNumbersTextBox.isUserInteractionEnabled = true
            lineNumbersTextBox.becomeFirstResponder()
            
        }
    
    
}
}

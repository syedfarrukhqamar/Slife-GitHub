//
//  CustomTextFieldClass.swift
//  SLife
//
//  Created by syed farrukh Qamar on 2016-11-03.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class CustomTextFieldClass: UITextField {

    func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == Selector("paste:") || action == Selector("copy:") {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

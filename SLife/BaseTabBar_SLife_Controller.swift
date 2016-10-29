//
//  BaseTabBar_SLife_Controller.swift
//  SLife
//
//  Created by syed farrukh Qamar on 04/05/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit

// real time flag info
var real_time_flag = false


class BaseTabBar_SLife_Controller: UITabBarController,UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       print("base bar controller view will appear has been called")
    }

    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
         print("--tabBar.selectedItem----\(tabBar.selectedItem?.accessibilityIdentifier)")
       //  print("--tab bar item----\(item.title!)")
         print("--tab bar item----\(item.tag)")
        
         print("--tab bar item----\(item.accessibilityIdentifier)")
         print("--tab bar item----\(tabBarController?.selectedIndex)")
        print("--real time flag before moving is ------------\(real_time_flag)")
        if (item.tag == 1){
        real_time_flag = true
        advancedOptionsFlag = false
            print("--new real time flag value ------------\(real_time_flag)")

        }
        
    }
    
    

}

//
//  SlifeMethods.swift
//  SLife
//
//  Created by syed farrukh Qamar on 23/04/16.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import Foundation
import UIKit
// transport types

let BUS = "BUS"
let METRO = "METRO"
let TRAIN_PENDALTAG = "TRAIN"
let FERRY = "FERRY"
let BOAT_SHIP = "SHIP"
let TRAM = "TRAM"
let DEFAULT = "Default"
// object serialization key names

let FROM_STATION_NAME_obj_ser = "fromStationName"
let FROM_STATION_ID_obj_ser = "fromStationId"
let TO_STATION_NAME_obj_ser = "toStation_Name"
let TO__STATION_ID_obj_ser = "toStationId"


class SlifeMethods {
    
    // static func drawLegs
    // The following method will be responsible for all textual calculation for leg info extraction and the other method which will be called by it draw.... would be used to draw one leg visual info.
    
    // starting point: ( it  will be the starting point to draw the labels
    // after one iteration they will hold the starting position of next leg
    // startingSize: size of the labels or icons
    // legs: will contain all legs to print the info for, 1 or many
    // innerSpacingFactor: this is the spacing between icon and labels inside one leg
    // innerLegSpacingFactor: this is the spacing factor between two legs
    // sizeFactor: it is the factor if for any reason one image is required to be bigger than other.
    
//    let startingPoint = CGPoint(x: 5.0,y: 2.0)
//    let startingSize = CGSize(width:10.0,height:10.0)
//    let orientation = "x"  // x, y, or xy
//    let innerSpacing = CGPoint(x:10,y:0)
//    let innerLegSpacing = CGPoint(x:25,y:0)
//    let sizeFactor = CGSize(width: 0.0,height: 0.0)
    

    // use this function on trip suggestion level or trip info level to draw all legs info summary or for one leg
    static func drawLegs(startingPoint: CGPoint,startingSize:CGSize,legs: NSMutableArray,cell: UITableViewCell,orientation: String,innerLegSpacingFactor: CGPoint, interLegSpacingFactor: CGPoint, sizeFactor: CGSize ){
    //        getVisualLeg(legs)
         var  i = 0
        //------------
        // starting position= s
//        var startingPosition_x = startingPoint.x
//        var startingPosition_y = startingPoint.y
        var legStartingPoint = startingPoint
        //CGPoint(x:startingPosition_x,y:startingPosition_y)
        // icon size = s
        var iconSize = startingSize
        var labelSize = startingSize
//        var iconSize_w = startingSize.width
//        var iconSize_h = startingSize.height
//        
        // inner leg spacing = ils
        var innerLegSpacing = innerLegSpacingFactor
//        var innerLegSpacing_x = innerLegSpacingFactor.x
//        var innerLegSpacing_y = innerLegSpacingFactor.y
        // sizeFactor (used to increase size of one of the box. plus it to the box size whoose size is required to be increased
        let sizeFactor = sizeFactor
//        let sizeFactor_w = sizeFactor.width
//        let sizeFactor_h = sizeFactor.height
        // Leg Spacing Factor
        let legSpacingFactor = interLegSpacingFactor
        //let legSpacingFactor_x = interLegSpacingFactor.x
        //let legSpacingFactor_y = interLegSpacingFactor.y
        
        //------------
        print("leg count is ::legs.count:\(legs.count)")
        print("starting x = \(startingPoint.x)")
        print("starting y = \(startingPoint.y)")
        
        var yPosition = CGFloat()
        var counter = 0
        
        
        for legs in legs {
//            (legs as! Leg).allKeys
//            print("legs.allKeys === \((legs as ).count)")
    
            
//            if (RealTidMethods.checkIfDepartureObject(objectToCheck: legs as AnyObject)){
//            print("Departure CEll Found = \(legs)")
//                print("current value of i= dep cell = \(i)")
//            i += 1
//            }
//            else {
//                print("Normal icons beings printed")
                
                print("current value of i= norm cell = \(i)")
                
            let leg = legs as! Leg
            print("leg.name =name== \(leg.name)")
            print("leg.name =jtype== \(leg.journeyType)")
            print("leg.name =type== \(leg.type)")
            if (leg.journeyType != "WALK")
            
            {
                let labelText = leg.line
                let iconName = leg.type
                print("--in loop----start position-.....\(startingPoint)")
//              print("------size-.....\(size)")
                print("print name ::::: in draw Visual Leg = \(leg.name)")
                drawVisualLeg(startingPoint: legStartingPoint, labelText: labelText, labelTag: i, innerLegSpacing: innerLegSpacingFactor, startingSize: startingSize, sizeFactor: sizeFactor, iconName: iconName, cell: cell, lineName: leg.name)

            
            } else if (leg.journeyType == "WALK"){
            
//                let legsTemp = legs as! LegWalk
//                
                // for example line is 801 then it will be 801
                //  let label = "Dist"
                let labelText = leg.dist
                let iconName = leg.type
                
                drawVisualLeg(startingPoint: legStartingPoint, labelText: labelText, labelTag: i, innerLegSpacing: innerLegSpacingFactor, startingSize: startingSize,sizeFactor: sizeFactor, iconName: iconName, cell: cell, lineName: leg.name)
                
            
            }
           //gather all x axis and width data
            
            var sx = legStartingPoint.x + sizeFactor.width + innerLegSpacing.x + labelSize.width + sizeFactor.width + legSpacingFactor.x
            var sy = legStartingPoint.y + yPosition // + sizeFactor.height + innerLegSpacing.y + labelSize.height + sizeFactor.height + legSpacingFactor.y
             legStartingPoint = CGPoint(x: sx,y: sy)
            
            // MARK: Leg Y Position Change when Leg>3
            if (counter == 1){
            
            yPosition -= 0
                counter = 0
            
            }
            counter += 1
            print("-------------legStartingPoint:-------<<<<<<<---\(i)-\(legStartingPoint)")
            
            print("-------------x---\(legStartingPoint.x)")
            print("-------------y---\(i)-\(legStartingPoint.y)")
            print("------yPosition = \(yPosition)")
            print("-------------counter---\(i)-\(counter)")
            
            //gather all y-axis and height data
            
            
          // calculate and pack them in starting point
        
            
//           spoint.x = spoint.x + size.width + spaceFactor.x
        //spoint.y = spoint.y + size.height + spaceFactor.y
//            spoint.y = spoint.y  + spaceFactor.y
            i += 1
    }
   // }
        }
    
    
    static func drawLegsCollectionView(startingPoint: CGPoint,startingSize:CGSize,legs: NSMutableArray,collectionViewCell: UICollectionViewCell,orientation: String,innerLegSpacingFactor: CGPoint, interLegSpacingFactor: CGPoint, sizeFactor: CGSize ){
        //        getVisualLeg(legs)
        var  i = 0
        //------------
        // starting position= s
        //        var startingPosition_x = startingPoint.x
        //        var startingPosition_y = startingPoint.y
        var legStartingPoint = startingPoint
        //CGPoint(x:startingPosition_x,y:startingPosition_y)
        // icon size = s
        var iconSize = startingSize
        var labelSize = startingSize
        //        var iconSize_w = startingSize.width
        //        var iconSize_h = startingSize.height
        //
        // inner leg spacing = ils
        var innerLegSpacing = innerLegSpacingFactor
        //        var innerLegSpacing_x = innerLegSpacingFactor.x
        //        var innerLegSpacing_y = innerLegSpacingFactor.y
        // sizeFactor (used to increase size of one of the box. plus it to the box size whoose size is required to be increased
        let sizeFactor = sizeFactor
        //        let sizeFactor_w = sizeFactor.width
        //        let sizeFactor_h = sizeFactor.height
        // Leg Spacing Factor
        let legSpacingFactor = interLegSpacingFactor
        //let legSpacingFactor_x = interLegSpacingFactor.x
        //let legSpacingFactor_y = interLegSpacingFactor.y
        
        //------------
        print("leg count is ::legs.count:\(legs.count)")
        print("starting x = \(startingPoint.x)")
        print("starting y = \(startingPoint.y)")
        
        var yPosition = CGFloat()
        var counter = 0
        
        
        for legs in legs {
            //            (legs as! Leg).allKeys
            //            print("legs.allKeys === \((legs as ).count)")
            let leg = legs as! Leg
            print("leg.name =name== \(leg.name)")
            print("leg.name =jtype== \(leg.journeyType)")
            print("leg.name =type== \(leg.type)")
            if (leg.journeyType != "WALK")
                
            {
                let labelText = leg.line
                let iconName = leg.type
                print("--in loop----start position-.....\(startingPoint)")
                //              print("------size-.....\(size)")
                print("print name ::::: in draw Visual Leg = \(leg.name)")
                drawVisualLegForCollectionView(startingPoint: legStartingPoint, labelText: labelText, labelTag: i, innerLegSpacing: innerLegSpacingFactor, startingSize: startingSize, sizeFactor: sizeFactor, iconName: iconName, cell: collectionViewCell, lineName: leg.name)
                
                
            } else if (leg.journeyType == "WALK"){
                
                //                let legsTemp = legs as! LegWalk
                //
                // for example line is 801 then it will be 801
                //  let label = "Dist"
                let labelText = leg.dist
                let iconName = leg.type
                
                drawVisualLegForCollectionView(startingPoint: legStartingPoint, labelText: labelText, labelTag: i, innerLegSpacing: innerLegSpacingFactor, startingSize: startingSize,sizeFactor: sizeFactor, iconName: iconName, cell: collectionViewCell, lineName: leg.name)
                
                
            }
            //gather all x axis and width data
            
            var sx = legStartingPoint.x + sizeFactor.width + innerLegSpacing.x + labelSize.width + sizeFactor.width + legSpacingFactor.x
            var sy = legStartingPoint.y + yPosition // + sizeFactor.height + innerLegSpacing.y + labelSize.height + sizeFactor.height + legSpacingFactor.y
            legStartingPoint = CGPoint(x: sx,y: sy)
            
            // MARK: Leg Y Position Change when Leg>3
            if (counter == 1){
                
                yPosition -= 0
                counter = 0
                
            }
            counter += 1
            print("-------------legStartingPoint:-------<<<<<<<---\(i)-\(legStartingPoint)")
            
            print("-------------x---\(legStartingPoint.x)")
            print("-------------y---\(i)-\(legStartingPoint.y)")
            print("------yPosition = \(yPosition)")
            print("-------------counter---\(i)-\(counter)")
            
            //gather all y-axis and height data
            
            
            // calculate and pack them in starting point
            
            
            //           spoint.x = spoint.x + size.width + spaceFactor.x
            //spoint.y = spoint.y + size.height + spaceFactor.y
            //            spoint.y = spoint.y  + spaceFactor.y
            i += 1
        }
    }
    
    
    static  func drawVisualLegForCollectionView(startingPoint: CGPoint,labelText: String,labelTag: Int,innerLegSpacing: CGPoint,startingSize: CGSize,sizeFactor:CGSize,iconName: String,cell: UICollectionViewCell,lineName: String)
    {
        //  var label3 = UILabel(frame: CGRectMake(0.0, 100.0, 320.0, 80.0))
        
        // create and tag uilabel
        
        // set the text for label
        // change backgroun color
        // set the back ground
        // starting point is for icon
        
        
        // icong & label position will be calculated
        print("lineName :::::: drawVisualLeg = \(lineName)")
        
        //-----------------------------------------------icon point, size, UILable Creation
        var iconPoint = startingPoint // icon position
        var iconSize = startingSize
        
        // MARK:Leg Size Set
        //--------------------------------------------------- starting position
        var sx = startingPoint.x
        var sy = startingPoint.y
        // ---------------------------------------------------starting size
        var sw = startingSize.width
        var sh = startingSize.height
        
        //-----------------------------------------------icon point, size, UILable Creation
        // inner leg spacing
        
        var innerLegSpacing = innerLegSpacing
        var innerLegSpacing_x = innerLegSpacing.x
        var innerLegSpacing_y = innerLegSpacing.y
        // label size is
        
        var labelSize_w = startingSize.width
        var labelSize_h = startingSize.height
        
        var labelPoint_x = sx + sw + innerLegSpacing_x
        var labelPoint_y = sy //+ sh + innerLegSpacing_y
        
        var labelSize = CGSize(width: labelSize_w , height: labelSize_h)
        
        // var legIcon = CGRect(x: sx, y: sy, width: sw, height: sh)
        //var legLabel = CGRect(x: labelPoint_x, y: labelPoint_y, width: labelSize_w, height: labelSize_h)
        //-----------------------------------------------iCon Label Creation
        //var legIcon = UILabel(frame: CGRectMake(sx ,sy, sw,sh))
        //let legIcon = UIButton(frame: CGRectMake(sx ,sy, sw,sh))
        let legIcon = UIButton(frame: CGRect(origin: CGPoint(x:sx,y:sy), size: CGSize(width:(sw),height:(sh))))
        
        legIcon.backgroundColor = UIColor.cyan
        // MARK: Resize Image default sizes
        let iconSize_SubtractionConstant = CGFloat(10)
        
        let resizedWidth = sw - iconSize_SubtractionConstant
        let resizedHeight = sh  - iconSize_SubtractionConstant
        
        
        //var legLabel = UILabel(frame: CGRectMake(labelPoint_x,labelPoint_y , labelSize.width,labelSize.height))
        var legLabel_Button = UIButton(frame: CGRect(origin: CGPoint(x:labelPoint_x,y:labelPoint_y), size: CGSize(width:labelSize.width,height:labelSize.height )))
        var legLabel = UILabel(frame: CGRect(origin: CGPoint(x:labelPoint_x,y:labelPoint_y), size: CGSize(width:resizedWidth,height:resizedHeight)))
        legLabel.font = UIFont(name: "Arial", size: 12)
        legLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        print("icon Point::::::::: size :::: \(iconSize)")
        print("legLabel:::::::::  :::: \(legLabel)")
        print("legIcon:::::::::  :::: \(legIcon)")
        print("legIcon.accessibilityActivationPoint:::::::::  :::: \(legIcon.accessibilityActivationPoint)")
        //        legIcon.text = "I"
        //        legLabel.text = "L"
        //
        print("indeside test.........")
        print("-----feeded value--\(startingPoint)---icon size---\(startingSize)")
        
        //        var legIcon = UILabel(frame: CGRectMake(iconPoint.x ,iconPoint.y, size.width,size.height))
        //        var legLabel = UILabel(frame: CGRectMake(iconPoint.x,iconPoint.y , size.width,size.height))
        
        //  var legIcon = UILabel(frame: CGRectMake(iconPoint.x ,iconPoint.y, size.width,size.height))
        // var legLabel = UILabel(frame: CGRectMake(iconPoint.x,iconPoint.y , size.width,size.height))
        var icon = UIImage()
        //        print("--------image size is \(icon.scal)")
        // image
        if let image = UIImage.init(named: iconName)
        {
            print("-----iconName value is \(iconName)")
            // TEMP chAanged with resizedwidth and height
            
            icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:resizedWidth,height: resizedHeight))
            
            
            //icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:20.0,height: 20.0))
            //           ResizeImage(<#T##image: UIImage##UIImage#>, targetSize: <#T##CGSize#>)
            
            //   // MARK: Transport Type
            print("iconName is \(iconName)")
        }
            
        else if let image = UIImage.init(named: "Default")
        {
            print("-Default----iconName value is \(iconName)")
            
            icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width: resizedWidth,height:resizedHeight))
            
            
            // MARK: Temp size chaged with default resizewidth and height
            
            //icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:20.0,height: 20.0))
            
            //           ResizeImage(<#T##image: UIImage##UIImage#>, targetSize: <#T##CGSize#>)
            //   icon = image            print("iconName is--Default \(iconName)")
        }
        print("--------image size is \(icon.size)")
        print("--labelText------ is \(labelText)")
        
        // set label text
        legLabel.text = labelText
        legLabel.font = UIFont(name: legLabel.font.fontName, size: 14)
        //        legLabel.adjustsFontSizeToFitWidth = true
        //        legLabel.font
        //        legLabel.minimumScaleFactor = 0.2
        //legLabel.sizeToFit()
        legLabel.adjustsFontSizeToFitWidth = true
        legLabel.textAlignment = NSTextAlignment.center
        // var image = UIImage.init(named: DEFAULT)
        var iconImage = UIImage.init(named: )
        // MARK: Line Color
        print("leg name :::legLabel: \(legLabel.text)")
        print("leg name :::lineName: \(lineName)")
        let tripMap = TripMapViewControllers()
        // MARK: Nil
        
        //        let alphabetPart = legLabel.text.
        let checkAlphabet = Int(legLabel.text!)
        
        var lineNoForColor = Int()
        if (checkAlphabet == nil){
            
            print("nil found in the bus line ")
            
            lineNoForColor = 1
            
        }
        else {
            
            lineNoForColor = Int(legLabel.text!)!
            print("no nil found in the bus line ")
        }
        let lineDictColorInfo = tripMap.identifyTransportMode(lineNo: lineNoForColor, LineName: lineName)
        
        print("-----------------trip map identify map line color info in custom class methods.......")
        
        let lineColorInfo = lineDictColorInfo["lineColor"] as! UIColor
        
        //print("TransportTypeIcon :::::: \("TransportTypeIcon")")
        
        //   print(lineDictColorInfo.allKeys)
        
        //      let linecColorInfoDict = TripMapViewControllers.identifyTransportMode(<#T##TripMapViewControllers#>)
        //MARK: Leg Image Setting
        legIcon.setImage(icon, for: .normal)
        legIcon.setBackgroundImage(UIImage(named: "LegBorderStart.png")!, for: .normal)
        //legIcon.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
        // legIcon.backgroundColor = UIColor.init(patternImage: icon)
        //        print("1-legLabel.text = \(legLabel.text)")
        //        print("2-legLabel.bounds.width== \(legLabel.bounds.width)")
        //        print("3-legLabel.bounds.height== \(legLabel.bounds.height)")
        //        print("4-legLabel.bounds.width== \( legLabel_Button.bounds.width)")
        //
        
        print("1-legLabel.text = \(legLabel.text)")
        print("2-label width = \( legLabel.bounds.width) && height = \(legLabel.bounds.height)")
        print("3-Button width = \( legLabel_Button.bounds.height) && height = \(legLabel_Button.bounds.width)")
        
        
        var innerColor =  UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        // var borderColor = UIColor(red: 247.0, green: 247.0, blue: 247.0, alpha: 1.0)
        
        legLabel.backgroundColor = lineColorInfo
        //        legLabel.highlightedTextColor = UIColor.white
        //
        //        legLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        //        legLabel.layer.shadowOpacity = 1
        //        legLabel.layer.shadowRadius = 6
        //
        legLabel.textColor = UIColor.white
        
        
        let legLabel_image = imageWithLabel(label: legLabel)
        print("leglabel_image before resizing = \(legLabel_image.size)")
        print("resized to w-h =               = (\(resizedWidth) , (\(resizedHeight))")
        
        let legLabel_resized_image = ResizeImage(image: legLabel_image, targetSize: CGSize(width:resizedWidth,height: resizedHeight))
        print("leglabel_image after resizing = \(legLabel_resized_image.size)")
        
        print("1-legLabel.text = \(legLabel.text)")
        print("resized width is = \(resizedWidth) && resized height = \(resizedHeight)")
        print("2-legLabel_resized_image.size= \( legLabel_resized_image.size.width) && height = \(legLabel_resized_image.size.height)")
        print("3-Button width = \( legLabel_Button.bounds.height) && height = \(legLabel_Button.bounds.width)")
        print("4-icon = \( icon.size.width) && height = \(icon.size.width)")
        
        if (lineName.contains("Walk")){
            
            legIcon.backgroundColor = UIColor.orange
        }
        
        
        legLabel_Button.setImage(legLabel_resized_image, for: .normal)
        legLabel_Button.backgroundColor = innerColor
        legIcon.backgroundColor = innerColor
        legLabel_Button.setBackgroundImage(UIImage(named: "LegBorderStop.png")!, for: .normal)
        //creat a new button with same values as of leglabel and then add leglabel in that button
        // MARK: Adding Image
        
        print("--------------------------------------------------")
        //        print("stack view === in cell = \(cell.viewWithTag(15))")
        print("--------------------------------------------------")
        print("cell.view with tag ======--------after------------")
        cell.contentView.addSubview(legIcon)
        cell.contentView.addSubview(legLabel_Button)
        //Temp switching off to test new way
        //cell.contentView.addSubview(legLabel)
        // add it to subview
        
    }
    
    
    static  func drawVisualLeg(startingPoint: CGPoint,labelText: String,labelTag: Int,innerLegSpacing: CGPoint,startingSize: CGSize,sizeFactor:CGSize,iconName: String,cell: UITableViewCell,lineName: String)
    {
                //  var label3 = UILabel(frame: CGRectMake(0.0, 100.0, 320.0, 80.0))
        
       // create and tag uilabel
        
        // set the text for label
         // change backgroun color
                // set the back ground
       // starting point is for icon
       
        
       // icong & label position will be calculated
      print("lineName :::::: drawVisualLeg = \(lineName)")
        
        //-----------------------------------------------icon point, size, UILable Creation
        var iconPoint = startingPoint // icon position
        var iconSize = startingSize
       
        // MARK:Leg Size Set
        //--------------------------------------------------- starting position
        var sx = startingPoint.x
        var sy = startingPoint.y
        // ---------------------------------------------------starting size
        var sw = startingSize.width
        var sh = startingSize.height
        
        //-----------------------------------------------icon point, size, UILable Creation
        // inner leg spacing
        
        var innerLegSpacing = innerLegSpacing
        var innerLegSpacing_x = innerLegSpacing.x
        var innerLegSpacing_y = innerLegSpacing.y
        // label size is
        
        var labelSize_w = startingSize.width
        var labelSize_h = startingSize.height
        
        var labelPoint_x = sx + sw + innerLegSpacing_x
        var labelPoint_y = sy //+ sh + innerLegSpacing_y
        
        var labelSize = CGSize(width: labelSize_w , height: labelSize_h)

       // var legIcon = CGRect(x: sx, y: sy, width: sw, height: sh)
       //var legLabel = CGRect(x: labelPoint_x, y: labelPoint_y, width: labelSize_w, height: labelSize_h)
        //-----------------------------------------------iCon Label Creation
        //var legIcon = UILabel(frame: CGRectMake(sx ,sy, sw,sh))
        //let legIcon = UIButton(frame: CGRectMake(sx ,sy, sw,sh))
        let legIcon = UIButton(frame: CGRect(origin: CGPoint(x:sx,y:sy), size: CGSize(width:(sw),height:(sh))))
        
        legIcon.backgroundColor = UIColor.cyan
        // MARK: Resize Image default sizes
        let iconSize_SubtractionConstant = CGFloat(10)
        
        let resizedWidth = sw - iconSize_SubtractionConstant
        let resizedHeight = sh  - iconSize_SubtractionConstant
        
        
         //var legLabel = UILabel(frame: CGRectMake(labelPoint_x,labelPoint_y , labelSize.width,labelSize.height))
        var legLabel_Button = UIButton(frame: CGRect(origin: CGPoint(x:labelPoint_x,y:labelPoint_y), size: CGSize(width:labelSize.width,height:labelSize.height )))
        var legLabel = UILabel(frame: CGRect(origin: CGPoint(x:labelPoint_x,y:labelPoint_y), size: CGSize(width:resizedWidth,height:resizedHeight)))
         legLabel.font = UIFont(name: "Arial", size: 12)
           legLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
         print("icon Point::::::::: size :::: \(iconSize)")
         print("legLabel:::::::::  :::: \(legLabel)")
         print("legIcon:::::::::  :::: \(legIcon)")
         print("legIcon.accessibilityActivationPoint:::::::::  :::: \(legIcon.accessibilityActivationPoint)")
//        legIcon.text = "I"
//        legLabel.text = "L"
//        
        print("indeside test.........")
  print("-----feeded value--\(startingPoint)---icon size---\(startingSize)")
        
//        var legIcon = UILabel(frame: CGRectMake(iconPoint.x ,iconPoint.y, size.width,size.height))
//        var legLabel = UILabel(frame: CGRectMake(iconPoint.x,iconPoint.y , size.width,size.height))
   
      //  var legIcon = UILabel(frame: CGRectMake(iconPoint.x ,iconPoint.y, size.width,size.height))
       // var legLabel = UILabel(frame: CGRectMake(iconPoint.x,iconPoint.y , size.width,size.height))
        var icon = UIImage()
//        print("--------image size is \(icon.scal)")
        // image
        if let image = UIImage.init(named: iconName)
        {
            print("-----iconName value is \(iconName)")
            // TEMP chAanged with resizedwidth and height
            
            icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:resizedWidth,height: resizedHeight))
            
            
            //icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:20.0,height: 20.0))
//           ResizeImage(<#T##image: UIImage##UIImage#>, targetSize: <#T##CGSize#>)
    
         //   // MARK: Transport Type
            print("iconName is \(iconName)")
        }
            
        else if let image = UIImage.init(named: "Default")
        {
            print("-Default----iconName value is \(iconName)")
           
            icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width: resizedWidth,height:resizedHeight))
            
            
            // MARK: Temp size chaged with default resizewidth and height
            
            //icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:20.0,height: 20.0))
            
             //           ResizeImage(<#T##image: UIImage##UIImage#>, targetSize: <#T##CGSize#>)
            //   icon = image            print("iconName is--Default \(iconName)")
         }
        print("--------image size is \(icon.size)")
        print("--labelText------ is \(labelText)")
        
     // set label text
        legLabel.text = labelText
        legLabel.font = UIFont(name: legLabel.font.fontName, size: 14)
//        legLabel.adjustsFontSizeToFitWidth = true
//        legLabel.font
//        legLabel.minimumScaleFactor = 0.2
        //legLabel.sizeToFit()
        legLabel.adjustsFontSizeToFitWidth = true
        legLabel.textAlignment = NSTextAlignment.center
              // var image = UIImage.init(named: DEFAULT)
        var iconImage = UIImage.init(named: )
        // MARK: Line Color
        print("leg name :::legLabel: \(legLabel.text)")
        print("leg name :::lineName: \(lineName)")
        let tripMap = TripMapViewControllers()
        // MARK: Nil
        
//        let alphabetPart = legLabel.text.
        let checkAlphabet = Int(legLabel.text!)
        
        var lineNoForColor = Int()
        if (checkAlphabet == nil){
        
            print("nil found in the bus line ")
        
            lineNoForColor = 1
        
        }
        else {
            
            lineNoForColor = Int(legLabel.text!)!
            print("no nil found in the bus line ")
        }
        let lineDictColorInfo = tripMap.identifyTransportMode(lineNo: lineNoForColor, LineName: lineName)
        
        print("-----------------trip map identify map line color info in custom class methods.......")
        
        let lineColorInfo = lineDictColorInfo["lineColor"] as! UIColor
        
        //print("TransportTypeIcon :::::: \("TransportTypeIcon")")
        
     //   print(lineDictColorInfo.allKeys)
        
//      let linecColorInfoDict = TripMapViewControllers.identifyTransportMode(<#T##TripMapViewControllers#>)
        //MARK: Leg Image Setting
        legIcon.setImage(icon, for: .normal)
        legIcon.setBackgroundImage(UIImage(named: "LegBorderStart.png")!, for: .normal)
        //legIcon.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
        // legIcon.backgroundColor = UIColor.init(patternImage: icon)
//        print("1-legLabel.text = \(legLabel.text)")
//        print("2-legLabel.bounds.width== \(legLabel.bounds.width)")
//        print("3-legLabel.bounds.height== \(legLabel.bounds.height)")
//        print("4-legLabel.bounds.width== \( legLabel_Button.bounds.width)")
//        
        
        print("1-legLabel.text = \(legLabel.text)")
        print("2-label width = \( legLabel.bounds.width) && height = \(legLabel.bounds.height)")
        print("3-Button width = \( legLabel_Button.bounds.height) && height = \(legLabel_Button.bounds.width)")
        
        
        var innerColor =  UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
       // var borderColor = UIColor(red: 247.0, green: 247.0, blue: 247.0, alpha: 1.0)
        
        legLabel.backgroundColor = lineColorInfo
//        legLabel.highlightedTextColor = UIColor.white
//        
//        legLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
//        legLabel.layer.shadowOpacity = 1
//        legLabel.layer.shadowRadius = 6
//        
        legLabel.textColor = UIColor.white
        
        
        let legLabel_image = imageWithLabel(label: legLabel)
        print("leglabel_image before resizing = \(legLabel_image.size)")
        print("resized to w-h =               = (\(resizedWidth) , (\(resizedHeight))")
        
        let legLabel_resized_image = ResizeImage(image: legLabel_image, targetSize: CGSize(width:resizedWidth,height: resizedHeight))
         print("leglabel_image after resizing = \(legLabel_resized_image.size)")
        
        print("1-legLabel.text = \(legLabel.text)")
        print("resized width is = \(resizedWidth) && resized height = \(resizedHeight)")
        print("2-legLabel_resized_image.size= \( legLabel_resized_image.size.width) && height = \(legLabel_resized_image.size.height)")
        print("3-Button width = \( legLabel_Button.bounds.height) && height = \(legLabel_Button.bounds.width)")
        print("4-icon = \( icon.size.width) && height = \(icon.size.width)")
        
        if (lineName.contains("Walk")){
        
        legIcon.backgroundColor = UIColor.orange
        }
        
        
        legLabel_Button.setImage(legLabel_resized_image, for: .normal)
        legLabel_Button.backgroundColor = innerColor
        legIcon.backgroundColor = innerColor
        legLabel_Button.setBackgroundImage(UIImage(named: "LegBorderStop.png")!, for: .normal)
        //creat a new button with same values as of leglabel and then add leglabel in that button
        // MARK: Adding Image
        
        print("--------------------------------------------------")
//        print("stack view === in cell = \(cell.viewWithTag(15))")
        print("--------------------------------------------------")
        print("cell.view with tag ======--------after------------")
        cell.contentView.addSubview(legIcon)
        cell.contentView.addSubview(legLabel_Button)
        //Temp switching off to test new way
        //cell.contentView.addSubview(legLabel)
       // add it to subview
    
    }
    
    
    
    /*
    static  func drawVisualLegOnCollectionView(startingPoint: CGPoint,labelText: String,labelTag: Int,innerLegSpacing: CGPoint,startingSize: CGSize,sizeFactor:CGSize,iconName: String,cell: UICollectionViewCell,lineName: String)
    {
        //  var label3 = UILabel(frame: CGRectMake(0.0, 100.0, 320.0, 80.0))
        
        // create and tag uilabel
        
        // set the text for label
        // change backgroun color
        // set the back ground
        // starting point is for icon
        
        
        // icong & label position will be calculated
        print("lineName :::::: drawVisualLeg = \(lineName)")
        
        //-----------------------------------------------icon point, size, UILable Creation
        var iconPoint = startingPoint // icon position
        var iconSize = startingSize
        
        // MARK:Leg Size Set
        //--------------------------------------------------- starting position
        var sx = startingPoint.x
        var sy = startingPoint.y
        // ---------------------------------------------------starting size
        var sw = startingSize.width
        var sh = startingSize.height
        
        //-----------------------------------------------icon point, size, UILable Creation
        // inner leg spacing
        
        var innerLegSpacing = innerLegSpacing
        var innerLegSpacing_x = innerLegSpacing.x
        var innerLegSpacing_y = innerLegSpacing.y
        // label size is
        
        var labelSize_w = startingSize.width
        var labelSize_h = startingSize.height
        
        var labelPoint_x = sx + sw + innerLegSpacing_x
        var labelPoint_y = sy //+ sh + innerLegSpacing_y
        
        var labelSize = CGSize(width: labelSize_w , height: labelSize_h)
        
        // var legIcon = CGRect(x: sx, y: sy, width: sw, height: sh)
        //var legLabel = CGRect(x: labelPoint_x, y: labelPoint_y, width: labelSize_w, height: labelSize_h)
        //-----------------------------------------------iCon Label Creation
        //var legIcon = UILabel(frame: CGRectMake(sx ,sy, sw,sh))
        //let legIcon = UIButton(frame: CGRectMake(sx ,sy, sw,sh))
        let legIcon = UIButton(frame: CGRect(origin: CGPoint(x:sx,y:sy), size: CGSize(width:(sw),height:(sh))))
        
        legIcon.backgroundColor = UIColor.cyan
        // MARK: Resize Image default sizes
        let iconSize_SubtractionConstant = CGFloat(10)
        
        let resizedWidth = sw - iconSize_SubtractionConstant
        let resizedHeight = sh  - iconSize_SubtractionConstant
        
        
        //var legLabel = UILabel(frame: CGRectMake(labelPoint_x,labelPoint_y , labelSize.width,labelSize.height))
        var legLabel_Button = UIButton(frame: CGRect(origin: CGPoint(x:labelPoint_x,y:labelPoint_y), size: CGSize(width:labelSize.width,height:labelSize.height )))
        var legLabel = UILabel(frame: CGRect(origin: CGPoint(x:labelPoint_x,y:labelPoint_y), size: CGSize(width:resizedWidth,height:resizedHeight)))
        legLabel.font = UIFont(name: "Arial", size: 12)
        legLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        print("icon Point::::::::: size :::: \(iconSize)")
        print("legLabel:::::::::  :::: \(legLabel)")
        print("legIcon:::::::::  :::: \(legIcon)")
        print("legIcon.accessibilityActivationPoint:::::::::  :::: \(legIcon.accessibilityActivationPoint)")
        //        legIcon.text = "I"
        //        legLabel.text = "L"
        //
        print("indeside test.........")
        print("-----feeded value--\(startingPoint)---icon size---\(startingSize)")
        
        //        var legIcon = UILabel(frame: CGRectMake(iconPoint.x ,iconPoint.y, size.width,size.height))
        //        var legLabel = UILabel(frame: CGRectMake(iconPoint.x,iconPoint.y , size.width,size.height))
        
        //  var legIcon = UILabel(frame: CGRectMake(iconPoint.x ,iconPoint.y, size.width,size.height))
        // var legLabel = UILabel(frame: CGRectMake(iconPoint.x,iconPoint.y , size.width,size.height))
        var icon = UIImage()
        //        print("--------image size is \(icon.scal)")
        // image
        if let image = UIImage.init(named: iconName)
        {
            print("-----iconName value is \(iconName)")
            // TEMP chAanged with resizedwidth and height
            
            icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:resizedWidth,height: resizedHeight))
            
            
            //icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:20.0,height: 20.0))
            //           ResizeImage(<#T##image: UIImage##UIImage#>, targetSize: <#T##CGSize#>)
            
            //   // MARK: Transport Type
            print("iconName is \(iconName)")
        }
            
        else if let image = UIImage.init(named: "Default")
        {
            print("-Default----iconName value is \(iconName)")
            
            icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width: resizedWidth,height:resizedHeight))
            
            
            // MARK: Temp size chaged with default resizewidth and height
            
            //icon = ResizeImage(image: UIImage(named: iconName)!, targetSize: CGSize(width:20.0,height: 20.0))
            
            //           ResizeImage(<#T##image: UIImage##UIImage#>, targetSize: <#T##CGSize#>)
            //   icon = image            print("iconName is--Default \(iconName)")
        }
        print("--------image size is \(icon.size)")
        print("--labelText------ is \(labelText)")
        
        // set label text
        legLabel.text = labelText
        legLabel.font = UIFont(name: legLabel.font.fontName, size: 14)
        //        legLabel.adjustsFontSizeToFitWidth = true
        //        legLabel.font
        //        legLabel.minimumScaleFactor = 0.2
        //legLabel.sizeToFit()
        legLabel.adjustsFontSizeToFitWidth = true
        legLabel.textAlignment = NSTextAlignment.center
        // var image = UIImage.init(named: DEFAULT)
        var iconImage = UIImage.init(named: )
        // MARK: Line Color
        print("leg name :::legLabel: \(legLabel.text)")
        print("leg name :::lineName: \(lineName)")
        let tripMap = TripMapViewControllers()
        // MARK: Nil
        
        //        let alphabetPart = legLabel.text.
        let checkAlphabet = Int(legLabel.text!)
        
        var lineNoForColor = Int()
        if (checkAlphabet == nil){
            
            print("nil found in the bus line ")
            
            lineNoForColor = 1
            
        }
        else {
            
            lineNoForColor = Int(legLabel.text!)!
            print("no nil found in the bus line ")
        }
        let lineDictColorInfo = tripMap.identifyTransportMode(lineNo: lineNoForColor, LineName: lineName)
        
        print("-----------------trip map identify map line color info in custom class methods.......")
        
        let lineColorInfo = lineDictColorInfo["lineColor"] as! UIColor
        
        //print("TransportTypeIcon :::::: \("TransportTypeIcon")")
        
        //   print(lineDictColorInfo.allKeys)
        
        //      let linecColorInfoDict = TripMapViewControllers.identifyTransportMode(<#T##TripMapViewControllers#>)
        //MARK: Leg Image Setting
        legIcon.setImage(icon, for: .normal)
        legIcon.setBackgroundImage(UIImage(named: "LegBorderStart.png")!, for: .normal)
        //legIcon.backgroundColor = UIColor.init(patternImage: UIImage(named: "LegBorderStart.png")!)
        // legIcon.backgroundColor = UIColor.init(patternImage: icon)
        //        print("1-legLabel.text = \(legLabel.text)")
        //        print("2-legLabel.bounds.width== \(legLabel.bounds.width)")
        //        print("3-legLabel.bounds.height== \(legLabel.bounds.height)")
        //        print("4-legLabel.bounds.width== \( legLabel_Button.bounds.width)")
        //
        
        print("1-legLabel.text = \(legLabel.text)")
        print("2-label width = \( legLabel.bounds.width) && height = \(legLabel.bounds.height)")
        print("3-Button width = \( legLabel_Button.bounds.height) && height = \(legLabel_Button.bounds.width)")
        
        
        var innerColor =  UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        // var borderColor = UIColor(red: 247.0, green: 247.0, blue: 247.0, alpha: 1.0)
        
        legLabel.backgroundColor = lineColorInfo
        //        legLabel.highlightedTextColor = UIColor.white
        //
        //        legLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        //        legLabel.layer.shadowOpacity = 1
        //        legLabel.layer.shadowRadius = 6
        //
        legLabel.textColor = UIColor.white
        
        
        let legLabel_image = imageWithLabel(label: legLabel)
        print("leglabel_image before resizing = \(legLabel_image.size)")
        print("resized to w-h =               = (\(resizedWidth) , (\(resizedHeight))")
        
        let legLabel_resized_image = ResizeImage(image: legLabel_image, targetSize: CGSize(width:resizedWidth,height: resizedHeight))
        print("leglabel_image after resizing = \(legLabel_resized_image.size)")
        
        print("1-legLabel.text = \(legLabel.text)")
        print("resized width is = \(resizedWidth) && resized height = \(resizedHeight)")
        print("2-legLabel_resized_image.size= \( legLabel_resized_image.size.width) && height = \(legLabel_resized_image.size.height)")
        print("3-Button width = \( legLabel_Button.bounds.height) && height = \(legLabel_Button.bounds.width)")
        print("4-icon = \( icon.size.width) && height = \(icon.size.width)")
        
        if (lineName.contains("Walk")){
            
            legIcon.backgroundColor = UIColor.orange
        }
        
        
        legLabel_Button.setImage(legLabel_resized_image, for: .normal)
        legLabel_Button.backgroundColor = innerColor
        legIcon.backgroundColor = innerColor
        legLabel_Button.setBackgroundImage(UIImage(named: "LegBorderStop.png")!, for: .normal)
        //creat a new button with same values as of leglabel and then add leglabel in that button
        // MARK: Adding Image
        
        print("--------------------------------------------------")
        //        print("stack view === in cell = \(cell.viewWithTag(15))")
        print("--------------------------------------------------")
        print("cell.view with tag ======--------after------------")
        cell.contentView.addSubview(legIcon)
        cell.contentView.addSubview(legLabel_Button)
        //Temp switching off to test new way
        //cell.contentView.addSubview(legLabel)
        // add it to subview
        
    }
    */
    
    
    static func lineCountsToDisplayIcons(availableWidth: CGFloat, iconsCount: Int, iconWidth: CGFloat) -> Int {
        var total_Lines = 1
        var widthSoFar = 0
        var availableWidth_int = Int(availableWidth) - 10
        var icon_Width_int = Int(iconWidth)
        for index in 1...iconsCount {
        widthSoFar += icon_Width_int
            print("current width so far = \(widthSoFar)")
            if(widthSoFar < availableWidth_int){
         print("width so far is = \(widthSoFar) & Total Width is \(availableWidth_int)")
            
            } else {
                total_Lines += 1
                print("total Lines ")
                widthSoFar = icon_Width_int
                
                print("Resetting the width of icons total Length to 0 = \(widthSoFar)")
                
            }
        }
        
        //--------------------
        
        return total_Lines
    
    }
    static func iconCountsToDisplayIcons(availableWidth: CGFloat, iconsCount: Int, iconWidth: CGFloat) -> (iconCount: Int,lineCount: Int) {
        
        
        var total_Lines = 1
       // var total_icons = 1
        var widthSoFar = 0
        var availableWidth_int = Int(availableWidth) - 10
        var icon_Width_int = Int(iconWidth)
        var totalICons = availableWidth_int / icon_Width_int
       
        var remainder = availableWidth_int % icon_Width_int
        var lineCount = iconsCount / totalICons
        
        var exactLineCount = iconsCount / totalICons
        var iconsRemained =  iconsCount % totalICons
        print("------Section---------above--------------------")
        print("IconWidth for one Leg = \(iconWidth)")
        print("Number of iconWidth can be printed = \(totalICons)")
        print("-----------------------------------------")
     
        print("Total iconsCount_Legs == \(iconsCount)")
        print("exactLineCount Available  == \(exactLineCount )")
        print("iconaRemained tobePrinted = \(iconsRemained)")
        
        if (iconsRemained != 0){
        
        exactLineCount = exactLineCount + 1
        
        }
        
        if (exactLineCount == 0){
        
        exactLineCount = 1
            
        }
    print("Exact total Number of lines = \(exactLineCount)")
        print("Exact icons in 1 leg = \(totalICons)")
       
        print("--------------------------------------------")
        print("Total Icons Count to display = \(iconsCount)")
        print("Total Icons printable in one line = \(totalICons)")
        print("remainder width in line = \(remainder)")
        print("Calculated Line Count = \(lineCount)")
        // number of lines
        
        
        
        
        if (lineCount == 0){
        
        
        }
        print("Number of lines = \(lineCount)")
        print("remainder..\(remainder)")
        print("available width of screen is = \(availableWidth_int)")
        print("icon Width  === =\(iconWidth)")
        print("icon Width Int === =\(icon_Width_int)")
        print("in slife methods. counting icons = \(totalICons)")
     
        var icon_counting  = 1
        var line_counting = 1
        for index in 1...iconsCount {
            
                
        
            if (icon_counting <= totalICons){
                
                print("Printing Icons:::::Total Icon Count = \(iconsCount)-&& Line Count= \(line_counting)-Icon_counting = \(icon_counting) && Printable Icons == \(totalICons)")
                
                icon_counting += 1
            } else {
            
                line_counting += 1
                icon_counting = 1
                print("Adding Line:::::Total Icon Count = \(iconsCount)-&& Line Count= \(line_counting)-Icon_counting = \(icon_counting) && Printable Icons == \(totalICons)")
                
               icon_counting += 1
                
            
         //   print("line counting is = \(line_counting)")
                
            
            }
            // number of icons fit in one line is 
            // totalICons
            
            /*
            widthSoFar += icon_Width_int
            print("current width so far = \(widthSoFar)")
            if(widthSoFar < availableWidth_int){
                print("width so far is = \(widthSoFar) & Total Width is \(availableWidth_int)")
                
            } else {
                
                total_Lines += 1
                print("total Lines ")
                widthSoFar = icon_Width_int
                
                print("Resetting the width of icons total Length to 0 = \(widthSoFar)")
                
            }
             */
            print("---end-------------------------------------------------")
            print("ICONS Count = \(iconsCount)--iconsCount=\(index)")
            print("line_counting = \(line_counting) && Icon Column:\(icon_counting)")
            
        }
        /*
        if (total_Lines == 1){
        total_icons += 1
        
        }
         */
        //--------------------
        
        print("inslide SLIFE_Method icon = Total Icons in 1 Line = \(totalICons) && Line_Counting== \(line_counting)")
        // Temp off line and icon returns
        
        //return (totalICons,line_counting)
        return (totalICons,exactLineCount)
        //return (totalICons,2)
        
    }

    static func stringToSlFormat(inputString: String)-> String{
        
        var returnedString = inputString.lowercased()
        
        //if ä , then return %/E4
        
       // print("returned string direct=ä=\(returnedString.stringByReplacingOccurrencesOfString("ä", withString: "%E4"))")
        
        //returnedString.stringByReplacingOccurrencesOfString(<#T##target: String##String#>, withString: <#T##String#>)
       
       // returnedString = returnedString.stringByReplacingOccurrencesOfString("ä", withString: "%E4")
        
        returnedString = returnedString.replacingOccurrences(of: "ä", with: "%E4")
        
        

        print("---ä--------returnedString===\(returnedString)")
        //if å , then return %/E5
        
       // returnedString = returnedString.stringByReplacingOccurrencesOfString("å", withString: "%E5")
        returnedString = returnedString.replacingOccurrences(of: "å", with: "%E5")
        
        
        
        print("---å--------returnedString===\(returnedString)")
        //if ö , then return %/f6
        
      //  returnedString = returnedString.stringByReplacingOccurrencesOfString("ö", withString: "%f6")
        returnedString = returnedString.replacingOccurrences(of: "ö", with: "%f6")
        
        print("---ö--------returnedString===\(returnedString)")
        //if " " , then return %20
       // returnedString = returnedString.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        returnedString = returnedString.replacingOccurrences(of: " ", with: "%20")
        
        print("--- --------returnedString===\(returnedString)")
        
        
        
        //
        
        return returnedString
    
    
    }
   static func getVisualLeg(leg: NSMutableArray)-> NSArray{
        
        let visualLegs = NSArray()
        
        
        var legWalk = [String: String]()
        
        
        
        
        // mark: swift 3
    /*
        for leg in leg {
            
            if ((leg as AnyObject).isKind(LegWalk)){
                print("----------LegWalk--------------")
                
                
                
                
            } else {
                
                print("-----------LegTravel----------")
                
                
            }
            
            
            
            
        }
      */
    
        
        return visualLegs
    }

   // static
    static func deSerializeObject (objectKeyNameToDeserialize: String)-> NSArray
        
    {
        
        
        print("---------1---- deserialize......")
        let defaults = UserDefaults.standard
        print("---------2---- deserialize......")
        if(defaults.object(forKey: objectKeyNameToDeserialize) == nil){
        let emptyArray = NSArray()
            
            return emptyArray
        }
        //MARK: Nill Found
//        //Could not cast value of type '__NSArrayI' (0x1b170bcc8) to 'NSMutableArray' (0x1b170bd90).
//        2016-10-11 14:48:42.954104 SLife[6521:2048130] Could not cast value of type '__NSArrayI' (0x1b170bcc8) to 'NSMutableArray' (0x1b170bd90).
      
        let deSerializedObject = (defaults.object(forKey: objectKeyNameToDeserialize) as! NSArray).mutableCopy() as! NSMutableArray
//        let deSerializedObject = defaults.object(forKey: objectKeyNameToDeserialize) as! NSMutableArray
        //).mutableCopy() as! NSMutableArray
        print("---------3---- deserialize......")
        return deSerializedObject
    }
    
        static func serializeObject (fromStationName: String, fromStationId: String,toStation_Name: String,toStationId: String, objectToSerialize_keyName: String)-> Bool  {
        
            
            // MARK: Object Serialization Check Null
        let char_from_station_id = FROM_STATION_ID_obj_ser.characters.count
        let char_to_station_id = TO__STATION_ID_obj_ser.characters.count
            
            if (char_from_station_id <= 3) || (char_from_station_id <= 3){
            // Null caught
            
                return false
                
            } else {
            
            // let it add
                let defaults = UserDefaults.standard
                let dictToAdd = NSMutableDictionary()
                let objectToSerialize = NSMutableArray()
                // from station
                dictToAdd.setValue(fromStationName, forKey: FROM_STATION_NAME_obj_ser)
                dictToAdd.setValue(fromStationId, forKey: FROM_STATION_ID_obj_ser)
                
                // to station
                
                dictToAdd.setValue(toStation_Name, forKey: TO_STATION_NAME_obj_ser)
                dictToAdd.setValue(toStationId, forKey: TO__STATION_ID_obj_ser)
                
                objectToSerialize.add(dictToAdd)
                
                // MARK: check for redundant object
                
                // check if the object exists already or not
                print("- checking if the object exists or not \(defaults.objectIsForced(forKey: objectToSerialize_keyName))")
                
                print(defaults.object(forKey: objectToSerialize_keyName))
                
                if (defaults.object(forKey: objectToSerialize_keyName) == nil){
                    
                    print("nil found in the old object array place..........")
                    defaults.set(objectToSerialize, forKey: objectToSerialize_keyName)
                    
                } else {
                    
                    let oldObjectArray = (defaults.object(forKey: objectToSerialize_keyName)! as! NSArray).mutableCopy() as! NSMutableArray
                    
                    print("-------old object array last count = \(oldObjectArray.count)")
                    
                    print("old object added ::::::::: with key name : \(objectToSerialize_keyName):")
                    
                    let recentTripLimits = 5
                    
                    if (oldObjectArray.count >= recentTripLimits){
                        print(" removing extra objects = oldObjectArray.count \(oldObjectArray.count)")
                        oldObjectArray.removeObject(at: 0)
                        
                    }
                    
                    print("dictToAdd =213=  \(dictToAdd.allKeys)")
                    print("dictToAdd = \(dictToAdd)")
                    // iterate through the oldObjectArray
                    var stationFlag = false
                    var i = Int(0)
                    for index in oldObjectArray {
                        let old_ObjectDict = oldObjectArray[i] as! NSDictionary
                        let old_from_StationId = old_ObjectDict.value(forKey: "fromStationId") as! String
                        let old_to_StationId = old_ObjectDict.value(forKey: "toStation_Name") as! String
                        let new_ObjectDict = dictToAdd as! NSDictionary
                        let new_from_StationId = new_ObjectDict.value(forKey: "fromStationId") as! String
                        let new_to_StationId = new_ObjectDict.value(forKey: "toStation_Name") as! String
                        let old_From_Station_id_alone = old_from_StationId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let old_to_Station_id_alone = new_from_StationId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let new_From_Station_id_alone = old_to_StationId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let new_to_Station_id_alone = new_to_StationId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        if (old_From_Station_id_alone == old_to_Station_id_alone && new_From_Station_id_alone == new_to_Station_id_alone){
                            
                            print("-------------------checking if from and to station are same........")
                            
                            print("old_From_Station_id_alone \(new_From_Station_id_alone)")
                            print("old_to_Station_id_alone\(old_to_Station_id_alone)")
                            print("old_From_Station_id_alone \(new_From_Station_id_alone)")
                            print("old_to_Station_id_alone\(old_to_Station_id_alone)")
                            stationFlag = true
                        }
                        i += 1
                        print("index in old object array is being printed == \(oldObjectArray)")
                    }
                    
                    if (stationFlag == false){
                        oldObjectArray.add(dictToAdd)
                        print("Just added stations because they are same.......")
                    }
                    else {
                        
                        print("not adding stations because they are same.......")
                    }
                    
                    print("-------check 1----")
                    
                    defaults.set(oldObjectArray, forKey: objectToSerialize_keyName)
                    print("-------check 2----")
                    
                }

                // added successfully
                return true
                
            }
            // couldnt add
            return false
            
    }
    
    
    // delete function , to delete index from mutable array for the given key name
    
    
    static func deleteFromserializeObject (deleteIndex: String,keyName: String)  {
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: keyName) == nil){
            
            print(".........object not found to be deleted Please check key name again........")
           // defaults.setObject(objectToSerialize, forKey: objectToSerialize_keyName)
            
        } else {
            
            let oldObjectArray = (defaults.object(forKey: keyName)! as! NSArray).mutableCopy() as! NSMutableArray
            
            print("-------old object array last count = \(oldObjectArray.count)")
           
            let deleteIndexInt = Int(deleteIndex)
            
            oldObjectArray.removeObject(at: deleteIndexInt!)
            
            
            defaults.set(oldObjectArray, forKey: keyName)
            print("-------new Count after deletion..for key: \(keyName).... Count is = \(oldObjectArray.count)")
            
//            print("old object added ::::::::: with key name : \(objectToSerialize_keyName):")
//            
//            oldObjectArray.addObject(dictToAdd)
//            
            
           
            
        }
         }
    
    
    //MARK: Function Check Error in Trip Suggestion check for generic Error
    
    static func checkForErrorMessage(jsonObjectDownloaded: NSDictionary)-> Bool {
        print("json object downloaded::::\(jsonObjectDownloaded.allKeys)")
        for (key,value) in jsonObjectDownloaded {
            let keyName = String(describing: key)
            
            if (keyName == "errorCode" || keyName == "errorText"){
                errorCode_generic_flag = true
                errorCode_generic = jsonObjectDownloaded["errorCode"] as! String // "Error Code generic"//
                errorMessage_generic = jsonObjectDownloaded["errorText"] as! String //"Error Code Message......."//
                
                print("error code flag==:: \(errorCode_generic_flag)")
                print("error code generic in check for errorCode_generic:: \(errorCode_generic)")
                print("error code generic in check for errorMessage_generic:: \(errorMessage_generic)")
                print("errorCode has been Caught BEEN CAUGHT CAUGHT CAUGHT CAUGHT............")
           
            }
            else
            {
                errorCode_generic_flag = false
                errorCode_generic = ""
                errorMessage_generic = ""

            print("key,value json key is here = \(key)")
         
            }
            print("no key found.....")
            }
        
        
        return errorCode_generic_flag
        
    }
    
    // MARK: Function Check Error in Intermediate Stops
    
    
    static func checkForErrorMessage_IntermediateStops(jsonObjectDownloaded: NSDictionary)-> Bool {
        print("json object downloaded::::\(jsonObjectDownloaded.allKeys)")
        for (key,value) in jsonObjectDownloaded {
            let keyName = String(describing: key)
            if (keyName == "erroCode" || keyName == "errorText"){
                errorCode_generic_flag = true
                errorCode_generic = jsonObjectDownloaded["errorCode"] as! String // "Error Code generic"//
                errorMessage_generic = jsonObjectDownloaded["errorText"] as! String //"Error Code Message......."//
                print("errorCode has been Caught BEEN CAUGHT CAUGHT CAUGHT CAUGHT............")
                
            }
            else
            {
                errorCode_generic_flag = false
                errorCode_generic = "test"
                errorMessage_generic = "765--------"
                
                print("key,value json key is here = \(key)")
                
            }
            print("no key found.....")
        }
        return errorCode_generic_flag
        
    }
}
// the function will take leglist.[index].legWalk/Travel as any object
// it will identifyt if it is LegWalk or LegTravel
// then it will return a generic array containing
func getLeg(leg: AnyObject)-> NSMutableArray {
let leg = NSMutableArray()
    return leg
}

// MARK: Convert label to image
func imageWithLabel(label: UILabel) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
    label.layer.render(in: UIGraphicsGetCurrentContext()!)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
}




func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    // mark: Swift 3
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width:size.width * heightRatio,height: (size.height * heightRatio))
    } else {
        newSize = CGSize(width:size.width * widthRatio, height: (size.height * widthRatio))
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    //let rect = CGRect(0, 0, newSize.width, newSize.height)
    let rect = CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width:newSize.width,height:newSize.height))
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}


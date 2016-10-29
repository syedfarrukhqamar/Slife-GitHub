//
//  ContactUsViewController.swift
//  SLife
//
//  Created by syed farrukh Qamar on 2016-10-18.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI


class ContactUsViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var mail_status: UILabel!
//    @IBOutlet weak var selectOption_picker: UIPickerView!
//    @IBOutlet weak var subject_outlet: UITextField!
//    @IBOutlet weak var message_body_outlet: UITextView!
    @IBAction func submit_action(_ sender: UIButton) {
        
        
        print("about to call sendMail :......")
       
        sendEmail()
        
        
        // data_request(lat: "from älta", long: "Testing")
    }
    @IBAction func reset(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//
//    func sendEmail() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["paul@hackingwithswift.com"])
//            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//            
//            present(mail, animated: true)
//        } else {
//            // show failure alert
//        }
//    }
//    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@hitnget.com"])
            mail.setSubject("BugReport/Suggestion/FeedBack/Other")
            mail.setMessageBody("<p>Please write your message here after mentioning your subject...!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            
            mail_status.text = "Mail cannot be sent this time.Please check your mail settings and try again....."
            mail_status.textColor = UIColor.red
            mail_status.textColor = UIColor.green
            
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        
        mail_status.text = "Mail has been sent...."
        mail_status.textColor = UIColor.green
        
        print("YOUR MAIL HAS BEEN SENT......")
    
    }
    
    
    /*
    func data_request(lat: String, long: String)
    {
        let lat = lat
        let long = long
        print("Step -------1....GAURD CALLED")
        //        let url_to_request = "www.hitnget.se/location/ReportPosition.php"
        let url_to_request = "http://www.hitnget.se/location/ReportPosition.php"
        let url:NSURL = NSURL(string: url_to_request)!
        let session = URLSession.shared
        print("Step -------2")
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        // request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        print("Step -------3")
        let lat_String = "lat=lat_.GAURD CALLED"
        let long_String = "long=long..GAURD CALLED"
        let deviceId_String = "deviceId=deviceId ios..GAURD CALLED"
        let timeStamp_String = "timeStamp=time Stamp ios.GAURD CALLED"
        
        let seperator = "&"
        let columnLat = "lat="
        let columnLong = "long="
        let columnDeviceId = "deviceId="
        let columnTimeStamp = "timeStamp="
        let valueDeviceId = "deviceID"
        let valueTimeStamp = Date()
        
        var httpBodyString = columnLat + lat + seperator
        httpBodyString += columnLong + long + seperator
        httpBodyString += columnDeviceId + valueDeviceId + seperator
        httpBodyString += columnTimeStamp + String(describing: valueTimeStamp)
        
        print("http body string =-------- \(httpBodyString)")
        
        let httpBody = "long=54long.GAURD CALLED&lat=54lat.GAURD CALLED&deviceId=54deviceId .GAURD CALLED&timeStamp=timeStamp.GAURD CALLED"
        print("Step -------4")
        
        //request.httpBody = httpBody.data(using: String.Encoding.utf8)
        
        request.httpBody = httpBodyString.data(using: String.Encoding.utf8)
        //request.httpBody = paramString.data(using: String.Encoding.utf8)
        //        request.httpBody?.append(deviceId_String.data(using: String.Encoding.utf8)!)
        
        
        // print(request.httpBody)
        print("Step -------5")
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            
            
            data, response, error) in
            print("Step -------6")
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error...........")
                print(response)
                print("error...........")
                return
            }
            print("Step -------7")
            
            
            //let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            // print(dataString)
            
        }
        
        task.resume()
        
    }
    
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

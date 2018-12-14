//
//  ViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-17.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, WCSessionDelegate {
    
    let getUserData = GetUserData()
    var timer: Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshPicker), userInfo: nil, repeats: true);
        
        
       getUserData.jsonparser()
      
    }
    
    
    @objc func refreshPicker() {
        if (getUserData.dbData != nil) {
            if ((getUserData.dbData?.count)! > 0) {
                self.userPickerView.reloadAllComponents()
                self.timer.invalidate()
            }
        }
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    //    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    //        var replyValues = Dictionary<String, AnyObject>()
    //        replyValues["status"] = "Program Received" as AnyObject?
    //        replyHandler(replyValues)
    //    }
    
    @IBOutlet weak var userPickerView: UIPickerView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var addUser: UIButton!
    
    var pickerData: [String] = [String]()
    
    func animateButton(sender: UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.90
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = Float(CGFloat.infinity)
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        let user = String(appDelegate.currentUser)
        let level = String(appDelegate.levelOfDifficulty)
        
        sendWatchMessage(user: user, level: level)
        
        sender.layer.add(pulse, forKey: "pulse")
        
    }
    
    
    
    @IBAction func close(_sender : AnyObject)
    {
        exit(0)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        if(getUserData.dbData != nil){
            return (getUserData.dbData?.count)!
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
         let rowData = (getUserData.dbData?[row])! as NSDictionary
        
        return rowData["username"] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let rowData = (getUserData.dbData?[row])! as NSDictionary
        var userName = rowData["username"] as! String
        var level = rowData["level"] as! String
        
        sendWatchMessage(user: userName, level: level)
        
        
    }
    
    func sendWatchMessage(user:String, level:String)
    {
       
        if WCSession.default.isReachable{
            print("is reachable")
            
            
            
            let message = ["user":user, "level":level] as [String : String]
            
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateButton(sender: button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
            if session.isPaired != true
            {
                print("Apple Watch not paired")
            }
            if session.isWatchAppInstalled != true
                
            {
                print("WatchKit app not installed")
            }
            
        }
        else{
            print("watch connectivity is not supported on this device")
        }
        
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue)
    {
    }
    
}


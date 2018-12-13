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
        
        sendWatchMessage()
        
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
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func sendWatchMessage()
    {
        print("in send message")
        if WCSession.default.isReachable{
            print("is reachable")
            let message = ["message" : "hello"]
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateButton(sender: button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerData = ["User 1", "User 2", "User 3", "User 4", "User 5", "User 6"]
        
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


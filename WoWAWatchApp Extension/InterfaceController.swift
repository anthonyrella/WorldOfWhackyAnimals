//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Xcode User on 2018-12-09.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var lblScore : WKInterfaceLabel!
    @IBOutlet var lblUser : WKInterfaceLabel!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
      
        var user = message["user"] as! String
        var level = message["level"] as! String
        lblUser.setText("User: \(user)")
        lblScore.setText("Level: \(level)")
    }
    
    //
    //    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    //        print("in did receive")
    //        var replyValues = Dictionary<String, AnyObject>()
    //        replyValues["status"] = "Program Received" as AnyObject?
    //        replyHandler(replyValues)
    //    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if(WCSession.isSupported()){
            print("is supported")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if(WCSession.isSupported()){
           
            
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}

//
//  InsertNewUser.swift
//  WorldofWhackyAnimals
//
//  Created by Raj on 2018-11-20.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class InsertNewUser: NSObject {
    var resp: String = ""
    
    func AddUser(uname: String) {
        let usernametext: String = uname
        let level: Int = 0
        // let passwordtext = "nice"
        let request = NSMutableURLRequest(url: NSURL(string: "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/InsertNewUser.php")! as URL)
        request.httpMethod = "POST"
        let postString = "uname=\(usernametext)&lvl=\(level)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error ?? "Error" as! Error)")
                return
            }
            
            // print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            // print("responseString = \(responseString)")
            
            self.resp = responseString! as String
        }
        task.resume()
    }
    
}

//
//  GetData.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-17.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class GetUserData: NSObject {
    
    var dbData: [NSDictionary]?
    let myUrl = "http://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/getAllUsers.php";
    
    enum JSONError : String, Error {
        case NoData = "Error: no Data"
        case ConversionFailed = "Error: conversion to JSON failed"
    }
    
    // add a JSON parser method that does all the work
    func jsonparser() {
        // guard is like a reverse if
        guard let endpoint = URL(string: myUrl) else {
            print ("Error Creating endpoint")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request) {
            // response handler
            (data, response, error) in
            // solely for debugging purposes
            do {
                let dataString = NSString(data: data! , encoding: String.Encoding.utf8.rawValue)
                print(dataString as Any)
                
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] else {
                    throw JSONError.ConversionFailed
                }
                
                print(json)
                self.dbData = json
            
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            
        }.resume() // if it gets suspended, it resumes the task
    }

}



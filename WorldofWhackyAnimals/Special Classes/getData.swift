//
//  getData.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-12-13.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class GetData: NSObject {
    
 
    var dbData : [NSDictionary]?
    var percData : [NSDictionary]?
    var attemptData : [NSDictionary]?
    var totalData : [NSDictionary]?
    let myUrl = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/getTopTenUsers.php" as String
    let percUrl = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/pecentageOfWins.php" as String
    let attemptsUrl = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/numberOfAttempts.php" as String
    let totalURL = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/totalGames.php" as String
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func jsonParser() {
        
        guard let endpoint = URL(string: myUrl) else {
            print("Error creating endpoint")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {

                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(datastring!)
                
             
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
            }.resume()
    }
    
    func getPercentage() {
        
        guard let endpoint = URL(string: percUrl) else {
            print("Error creating endpoint")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(datastring!)
                
                
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                self.percData = json
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
    }
    
    func getNumberOfAttempts() {
        
        guard let endpoint = URL(string: attemptsUrl) else {
            print("Error creating endpoint")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(datastring!)
                
                
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                self.attemptData = json
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
    }
    
    func getTotal() {
        
        guard let endpoint = URL(string: totalURL) else {
            print("Error creating endpoint")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(datastring!)
                
                
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                self.totalData = json
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
    }
   
    
}

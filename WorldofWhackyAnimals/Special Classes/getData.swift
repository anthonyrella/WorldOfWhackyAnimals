//
//  getData.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-12-13.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//
//  Primary Author: Anthony Rella
//
//  GetData class is used to perform multiple get requests to the data which is presented from the sql queries hosted on the remote database

import UIKit

class GetData: NSObject {
    
    // dictionarys set to house data retrieved
    var dbData : [NSDictionary]?
    var percData : [NSDictionary]?
    var attemptData : [NSDictionary]?
    var totalData : [NSDictionary]?
    
    // urls set to the various api's created for different statistical data
    let myUrl = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/getTopTenUsers.php" as String
    let percUrl = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/pecentageOfWins.php" as String
    let attemptsUrl = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/numberOfAttempts.php" as String
    let totalURL = "https://patel539.dev.fast.sheridanc.on.ca/prog39856/ios_project/totalGames.php" as String
    
    // json error enums
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    // jsonParser method retrieves the topTenUsers from our database
    func jsonParser() {
        
        guard let endpoint = URL(string: myUrl) else {
            print("Error creating endpoint")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        // asynchronous request used to retrieve data
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
    
    // getPercentage retrieves the percentage of wins vs total games played from sql database
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
    
    // getNumberOfAttempts retrieves the total number of level attempts per user from database
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
    
    // getTotal retrieves the total number of games played per user
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

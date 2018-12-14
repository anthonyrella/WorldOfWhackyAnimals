//
//  PlayerStatsViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-18.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//
//  Primary Author: Anthony Rella
//
//  PlayerStatsViewControlle enables the user to view game statistics. User can view their own personal level achievements, or see how they stand against the best 10 other players

import UIKit

class PlayerStatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let getData = GetData()
    var timer : Timer!
    var percTimer : Timer!
    var totalTimer : Timer!
    
    @IBOutlet var myTable : UITableView!
    @IBOutlet weak var numGamesOverallLabel: UILabel!
    
    @IBOutlet weak var numOfAttempsLabel: UILabel!
    @IBOutlet weak var percOfWinsLabel: UILabel!
    @IBOutlet weak var levelPicker: UIPickerView!
    
    
    // before view loads, timers are run on intervals to refresh the table, picker, and label with the statistic values they've received from the asynchronos calls
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshTable), userInfo: nil, repeats: true);
        self.percTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshPicker), userInfo: nil, repeats: true);
        self.totalTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshLabel), userInfo: nil, repeats: true);
        
        getData.jsonParser()
        getData.getPercentage()
        getData.getNumberOfAttempts()
        getData.getTotal()
        
    }
    // this will refresh the top 10 table until data is present
    @objc func refreshTable() {
        if (getData.dbData != nil) {
            if ((getData.dbData?.count)! > 0) {
                self.myTable.reloadData()
                self.timer.invalidate()
            }
        }
    }
    // this will refresh the level picker until data is present
    @objc func refreshPicker() {
        if (getData.percData != nil) {
            if ((getData.percData?.count)! > 0) {
                self.levelPicker.reloadAllComponents()
                self.timer.invalidate()
            }
        }
    }
    // this will set the total games played label when data is present
    @objc func refreshLabel() {
        if (getData.totalData != nil) {
            if ((getData.totalData?.count)! > 0) {
            
                    for x in getData.totalData!{
                        
                        if(x["user"] as! String == appDelegate.currentUser){
                            
                            let totalAttempts = x["TOTAL"] as? String
                            
                            self.numGamesOverallLabel.text = totalAttempts
                        }
                    }
                self.timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    // set the number of sections for the picker to 1 for level selection
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
 
    // sets the number of rows of the table to the top 10 users level achievements
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if getData.dbData != nil
        {
            return (getData.dbData?.count)!
        }
        else
        {
            return 0
        }
    }
    
    // sets the value of the tables rows to the top 10 users names and scores
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let tableCell : TopTenPlayerStatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "top10") as? TopTenPlayerStatTableViewCell ?? TopTenPlayerStatTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "top10")
        
        let row = indexPath.row
        let rowData = (getData.dbData?[row])! as NSDictionary
        tableCell.name.text = rowData["username"] as? String
        tableCell.score.text = rowData["level"] as? String
        
        
        return tableCell
    }
    
    // sets the height of the rows in the tabel
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    // sets the number of components in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // sets the number of rows of the picker to the attempted levels of the current user.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if getData.percData != nil
        {
            var count = 1
            for x in getData.percData!{
                
                if(x["user"] as! String == appDelegate.currentUser){
                    count = count + 1
                }
                
            }
            return count
        }
        else
        {
            return 0
        }
    }
    // sets the values of the rows of the picker to the attempted levels of the current user
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,forComponent component: Int) -> String? {
        
       
        let rowData = (getData.percData?[row])! as NSDictionary
        
        if(appDelegate.currentUser == rowData["user"] as! String){
            return rowData["level"] as? String
        }
        else{
            return nil
        }
        
    }
    
    // once a value of the picker has landed, will display statisic information in the labels
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // loop sets the percentage data
        for x in getData.percData!{
            
            if(x["level"] as! String == String(row)){
                
                if(x["user"] as! String == appDelegate.currentUser){
                    
                    var perc = x["PERC"] as? String
                    var mySubstring = String((perc?.prefix(4))!)
                    
                    
                    self.percOfWinsLabel.text = mySubstring
                }
                
                
            }
            
        }
        // loop sets the attempt data
        for x in getData.attemptData!{
            
            if(x["level"] as! String == String(row)){
                
                if(x["user"] as! String == appDelegate.currentUser){
                    
                    var attempts = x["TOTAL"] as? String
                  
                    self.numOfAttempsLabel.text = attempts
                }
                
                
            }
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

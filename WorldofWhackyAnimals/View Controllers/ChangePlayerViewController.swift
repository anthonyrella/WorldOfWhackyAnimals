//
//  ChangePlayerViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Raj on 2018-11-20.
//  Copyright © 2018 Raj. All rights reserved.
//

import UIKit

class ChangePlayerViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let getUserData = GetUserData()
    var timer: Timer!
    
    let responseNewUser = InsertNewUser()
    
    @IBOutlet var txtNewPlayer: UITextField!
    @IBOutlet var btnAddPlayer: UIButton!
    @IBOutlet var allUsersTable: UITableView!
    
    // when view appears start a timer to keep checking fror data in remote db
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.refreshTable), userInfo: nil, repeats: true)
        
        getUserData.jsonparser()
        
    }
    
    // keep checking for data until it is retrieved
    @objc func refreshTable() {
        if (getUserData.dbData != nil) {
            if ((getUserData.dbData?.count)! > 0) {
                self.allUsersTable.reloadData()
                self.timer.invalidate()
            }
        }
    }
    
    // MARK: - Table Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getUserData.dbData != nil {
            return (getUserData.dbData?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell ?? UserTableViewCell(style: .default, reuseIdentifier: "userCell")
        
        // Configure the cell...
        let row = indexPath.row
        let rowData = getUserData.dbData![row] as NSDictionary
        
        cell.lblUserName.text = rowData["username"] as? String
        cell.lblLevel.text = rowData["level"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add code for when a user is selected from table view
        let currentCell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
        //print(currentCell.lblUserName.text)
        let selectedUser = (currentCell.lblUserName.text)! as String
        let userLevel = (currentCell.lblLevel.text)! as String
        // set the app delegate user
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentUser = selectedUser
        appDelegate.levelOfDifficulty = Int(userLevel)!
        
        performSegue(withIdentifier: "segueToWelcome", sender: nil)
    }
    
    // MARK: - Button and Text field processing Methods
    
    @IBAction func addPlayerClicked(sender: UIButton) -> Void {
        let enteredVal = txtNewPlayer.text
        if enteredVal != "" {
            if getUserData.dbData != nil {
                // check for username against all usernames
                var isExist = false
                for existingName in getUserData.dbData! {
                    let existName = existingName["username"] as? String
                    if existName == enteredVal {
                        isExist = true
                    }
                }
                if isExist {
                    let alert = UIAlertController(title: "Username Exists", message: "This username already exists. Try again or select an existing user", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    present(alert, animated: true)
                } else {
                    // add logic to set player in app delegate
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.currentUser = enteredVal!
                    
                    // insert data to DB
                    responseNewUser.AddUser(uname: enteredVal!)
                    print("Response: \(responseNewUser.resp)")
                    performSegue(withIdentifier: "segueToWelcome", sender: nil)
                }
                
            } else {
                let alert = UIAlertController(title: "Error!", message: "NO data about existing users from database.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Invalid Entry", message: "Please enter a unique name in the username textbox.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    
    //function to hide keyboard after user hits the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

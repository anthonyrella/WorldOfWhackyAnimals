//
//  WelcomeViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-12-13.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var name : UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = appDelegate.currentUser
        

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
    
    @IBAction func unwindToWelcomeViewController(segue: UIStoryboardSegue)
    {
    }

}

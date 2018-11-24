//
//  ViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-17.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("Current user is: \(appDelegate.currentUser)")
    }

    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue)
    {
        
    }

}


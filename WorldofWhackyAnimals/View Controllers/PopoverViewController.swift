//
//  PopoverViewController.swift
//  WorldofWhackyAnimals
//
//  Created by DeJoun Robinson on 2018-12-13.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var btnContinue: UIButton!
    @IBOutlet var endGameView: UIView!
    @IBOutlet var btnMainMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endGameView.layer.cornerRadius = 10
        btnMainMenu.layer.cornerRadius = 10
        btnMainMenu.setTitle("Main Menu", for: UIControlState.normal)
        btnContinue.layer.cornerRadius = 10
        btnContinue.setTitle(appDelegate.btnTitle, for: UIControlState.normal)
        lblMessage.text = appDelegate.lblMessage
        lblScore.text = appDelegate.lblScore
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
//  SettingsViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-18.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var lblVol: UILabel!
    @IBOutlet var sliderVol: UISlider!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var sliderVolume = self.appDelegate.gameVol
        
        // Do any additional setup after loading the view.

        lblVol.text = String(sliderVolume)
        sliderVol.value = Float(sliderVolume)
    }
    
    @IBAction func sliderValueChanged (sender: UISlider) {
        self.appDelegate.gameVol = Int(sliderVol.value)
        lblVol.text = String(Int(sliderVol.value))
    }
    

}

//
//  SettingsViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Raj on 2018-11-20.
//  Copyright © 2018 Raj. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var lblVol: UILabel!
    @IBOutlet var sliderVol: UISlider!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       self.appDelegate.gameVol = Int(sliderVol.value)
        lblVol.text = String(Int(sliderVol.value))
    }
    
    @IBAction func sliderValueChanged (sender: UISlider) {
        self.appDelegate.gameVol = Int(sliderVol.value)
        lblVol.text = String(Int(sliderVol.value))
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

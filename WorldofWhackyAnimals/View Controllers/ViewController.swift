//
//  ViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-17.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var userPickerView: UIPickerView!
    @IBOutlet weak var button: UIButton!

    var pickerData: [String] = [String]()
    
    func animateButton(sender: UIButton) {
        
//        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//
//        UIView.animate(withDuration: 1.0,
//                       delay: 0,
//                       usingSpringWithDamping: CGFloat(0.20),
//                       initialSpringVelocity: CGFloat(6.0),
//                       options: [UIViewAnimationOptions.allowUserInteraction, .repeat],
//                       animations: {
//                        sender.transform = CGAffineTransform.identity
//        },
//                       completion: { Void in()  }
//        )
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.90
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = Float(CGFloat.infinity)
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        sender.layer.add(pulse, forKey: "pulse")
    }
    
    @IBAction func close(_sender : AnyObject)
    {
        exit(0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateButton(sender: button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerData = ["User 1", "User 2", "User 3", "User 4", "User 5", "User 6"]
    }

    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue)
    {
    }

}


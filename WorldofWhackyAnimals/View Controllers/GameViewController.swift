//
//  GameViewController.swift
//  WorldofWhackyAnimals
//
//  Created by DeJoun Robinson on 2018-12-11.
//  Copyright © 2018 DeJoun Robinson. All rights reserved.
//
//  Description: Connect and present the game scene with the view

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnMainMenu: UIButton!
    @IBOutlet var btnContinue: UIButton!
    @IBOutlet var popoverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the SKScene on the view and scale to fit
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.doaSegue), name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
        
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .fill
                view.presentScene(scene)
                scene.gameViewController = self
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
   @objc func doaSegue(){
        performSegue(withIdentifier: "toHome", sender: self)
        self.view.removeFromSuperview()
        self.view = nil
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        popoverView.removeFromSuperview()
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .fill
                view.presentScene(scene)
                scene.gameViewController = self
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
    }
    
    func loadPopover(lblMsg: String, btnTtl: String){
        
        //add view and center on screen
        self.view.addSubview(popoverView)
        popoverView.center = self.view.center
        //round corners of buttons and view
        popoverView.layer.cornerRadius = 10
        btnContinue.layer.cornerRadius = 10
        btnMainMenu.layer.cornerRadius = 10
        
        //Fill dynamic content for view
        btnMainMenu.setTitle("Main Menu", for: UIControlState.normal)
        btnContinue.setTitle(btnTtl, for: UIControlState.normal)
        lblMessage.text = lblMsg
        
        self.view.bringSubview(toFront: popoverView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the SKScene on the view and scale to fit
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .fill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

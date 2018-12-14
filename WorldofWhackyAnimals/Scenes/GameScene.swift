//
//  GameScene.swift
//  WorldofWhackyAnimals
//
//  Created by DeJoun Robinson on 2018-12-11.
//  Copyright © 2018 DeJoun Robinson. All rights reserved.
//
//  Description: Controls where scene objects are presented and the amount of objects required

import SpriteKit
import GameplayKit

//Protocol definition for accessing GameViewController function
//rotocol GameViewControllerDelegate: class {
//static func loadPopover(lblMsg: String, btnTtl: String)
//}

class GameScene: SKScene {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var gameScore: SKLabelNode!
    var slots = [WhackSlot]()
    var popupTime = 0.00
    var numRounds = 0
    var level = 8
    var lblMessage = ""
    var btnTitle = ""
    var gameViewController: GameViewController?
    public static var endScore = 0
    let postData = GetData()
    
    //Use of property observer to update score everytime the variable is set
    var totalEnemies = 0 {
        didSet {
            gameScore.text = "Score: \(score) / \(totalEnemies)"
        }
    }
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score) / \(totalEnemies)"
        }
    }
    
    //Adds all scenekit objects to the view
    override func didMove(to view: SKView) {
        //Checks for current difficulty settings
        if appDelegate.currentDifficultySelection != nil {
            level = appDelegate.currentDifficultySelection!
        }else{
            //Sets difficulty to user's highest unlocked level if difficulty setting is nil
            level = appDelegate.levelOfDifficulty
        }
        
        //Set enemy speed based on level
        switch level {
        case 1:
            popupTime = 2.00
        case 2:
            popupTime = 1.80
        case 3:
            popupTime = 1.60
        case 4:
            popupTime = 1.40
        case 5:
            popupTime = 1.20
        case 6:
            popupTime = 1.00
        case 7:
            popupTime = 0.80
        case 8:
            popupTime = 0.50
        default:
            break
        }
        
        //background image
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        //score label
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0 / 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        //generate positions for holes
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        //Asynchronously add first enemies to the screen after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy()
        }
    }
    
    //Adds holes, animals and masks at the positions generated
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position, level: level)
        addChild(slot)
        slots.append(slot)
    }
    
    //Function that calls itself to continue creating enemies with a delay until the game is over
    func createEnemy() {
        numRounds += 1
        
        //stops the game after creating a random number of enemies 45 times
        if numRounds >= 35 {
            for slot in slots {
                slot.hide()
            }
            
            //display game over image at the end of the game
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 650)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            
            //Based on game results dynamically adjusts the message and button title for the popover
            if score > totalEnemies {
                
                postData.postData(level: level, user: appDelegate.currentUser, win: 1, loss: 0)
                
                //Check if player has levels left to unlock
                if appDelegate.levelOfDifficulty < 8 {
                    
                    //check if the player won their highest level before unlocking the next level
                    if level == appDelegate.levelOfDifficulty{
                        appDelegate.levelOfDifficulty += 1
                    }
                    lblMessage = "You Win!"
                    btnTitle = "Next Level"
                }else{
                    lblMessage = "Congratulations! You beat every level!"
                    btnTitle = "Play Again"
                }
            }else{
                 postData.postData(level: level, user: appDelegate.currentUser, win: 0, loss: 1)
                lblMessage = "Better luck next time."
                btnTitle = "Try Again"
            }
            
            
            //Call loadPopover method from GameViewController
          //  gameViewController?.loadPopover(lblMsg: lblMessage, btnTtl: btnTitle)
            
            //exit method to stop createEnemy()
           
            GameScene.endScore = score
            if let scene = GameOverScene(fileNamed:"GameOverScene") {
                
                let skView = self.view! as SKView
                
                
                skView.ignoresSiblingOrder = true
                
                scene.scaleMode = .fill
                scene.size = skView.bounds.size
                
                skView.presentScene(scene, transition: SKTransition.fade(withDuration: 2))
            }
            
            
            return
        }
        
        //Randomly shuffles list of available slots
        slots.shuffle()
        //Guaranteed at least 1 enemy spawns per round
        slots[0].show(hideTime: popupTime)
        totalEnemies += 1
        
        //Randomly decides which slots to show animals with more slots being less likely to show at once
        if Int(arc4random_uniform(13)) > 4 {
            slots[1].show(hideTime: popupTime)
            totalEnemies += 1
        }
        if Int(arc4random_uniform(13)) > 9 {
            slots[2].show(hideTime: popupTime)
            totalEnemies += 1
        }
        if Int(arc4random_uniform(13)) > 10 {
            slots[3].show(hideTime: popupTime)
            totalEnemies += 1
        }
        if Int(arc4random_uniform(13)) > 11 {
            slots[4].show(hideTime: popupTime)
            totalEnemies += 1
        }
        
        //Generate random delay based on popupTime to add more enemies
        let minDelay = popupTime / 1.5
        let maxDelay = popupTime * 1.5
        let randomTime = UInt32(NSDate().timeIntervalSinceReferenceDate)
        srand48(Int(randomTime))
        let delay = minDelay + drand48() * (maxDelay-minDelay)
        
        //Queues the process of timing each recursion to continue generating enemies at a steady pace
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createEnemy()
        }
    }
    
    //Function to detect a Whack!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            for node in tappedNodes {
                if node.name == "charEnemy" {
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    //shrinks whacked enemies
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    
                    whackSlot.hit()
                    score += 1
                    
                    //play whack sound
                    run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
                }
            }
        }
    }
}

//Extension that adds shuffle function to collections like an array
extension MutableCollection {
    /// Shuffles the contents
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        //algorithm to randomly shuffle a collection
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
extension Sequence {
    /// Returns array with the contents shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

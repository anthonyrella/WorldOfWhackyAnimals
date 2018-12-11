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

class GameScene: SKScene {
    var gameScore: SKLabelNode!
    
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var slots = [WhackSlot]()
    var popupTime = 0.85
    var numRounds = 0
    
    //Adds all scenekit objects to the view
    override func didMove(to view: SKView) {
        //background image
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        //score label
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        //generate positions for holes
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        //Asynchronously add animals to the screen with a delay of 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.createEnemy()
        }
    }
    
    //Adds holes, animals and masks at the positions generated
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    //Function that calls itself to continue creating enemies with a delay until the game is over
    func createEnemy() {
        numRounds += 1
        
        //stops the game after generating enemies 30 times
        if numRounds >= 30 {
            for slot in slots {
                slot.hide()
            }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            return
        }
        
        //Animals stay above the hole for less time as the game progresses
        popupTime *= 0.991
        
        //Randomly shuffles list of available slots
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        //Randomly decides which slots to show animals
        if Int(arc4random_uniform(13)) > 4 { slots[1].show(hideTime: popupTime) }
        if Int(arc4random_uniform(13)) > 8 {  slots[2].show(hideTime: popupTime) }
        if Int(arc4random_uniform(13)) > 10 { slots[3].show(hideTime: popupTime) }
        if Int(arc4random_uniform(13)) > 11 { slots[4].show(hideTime: popupTime)  }
        
        //Generate random delay based popupTime to create more animals
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let randomTime = UInt32(NSDate().timeIntervalSinceReferenceDate)
        srand48(Int(randomTime))
        let delay = minDelay + drand48() * (maxDelay-minDelay)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.createEnemy()
        }
    }
    
    //Function to detect a Whack! and keep score
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            for node in tappedNodes {
                if node.name == "charFriend" {
                    //shouldn't whack
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.hit()
                    score -= 5
                    
                    run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion:false))
                } else if node.name == "charEnemy" {
                    //should whack
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    //shrinks whacked animals
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    
                    whackSlot.hit()
                    score += 1
                    
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

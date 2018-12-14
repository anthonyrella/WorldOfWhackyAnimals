//
//  WhackSlot.swift
//  WorldofWhackyAnimals
//
//  Created by DeJoun Robinson on 2018-12-11.
//  Copyright © 2018 DeJoun Robinson. All rights reserved.
//
//  Description: Controls creation and interaction of Nodes in the Scene and their animations.

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    var isVisible = false
    var isHit = false
    
    //Function to add hole, enemy and mask node based on screen location
    func configure(at position: CGPoint, level: Int) {
        self.position = position
        var animal = ""
        
        //Set enemy image based on level
        switch level {
        case 1:
            animal = "bear-northamerica"
        case 2:
            animal = "jaguar-southamerica"
        case 3:
            animal = "reindeer-europe"
        case 4:
            animal = "lion-africa"
        case 5:
            animal = "panda-asia"
        case 6:
            animal = "kangaroo-australia"
        case 7:
            animal = "penguin-antarctica"
        case 8:
            animal = "dragonfly-bonus"
        default:
            break
        }
        
        //Add sprite for hole
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        //Add crop to hide enemy when they are below the hole
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        //Add enemy sprite as child to cropNode and position below the hole
        charNode = SKSpriteNode(imageNamed: animal)
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        addChild(cropNode)
    }
    
    //function to randomly show enemies and hide them after the given hideTime
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        charNode.name = "charEnemy"
        
        //times how long to keep enemy shown asynchronously and hides it after the time runs out
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [unowned self] in
            self.hide()
        }
    }
    
    //Animates enemy going back into the whole before making it not visible
    func hide() {
        if !isVisible { return }
        charNode.run(SKAction.moveBy(x: 0, y:-80, duration:0.05))
        isVisible = false
    }
    
    //Animate enemy hiding after getting hit
    func hit() {
        isHit = true
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y:-80, duration:0.5)
        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        charNode.run(SKAction.sequence([delay, hide, notVisible]))
    }
}

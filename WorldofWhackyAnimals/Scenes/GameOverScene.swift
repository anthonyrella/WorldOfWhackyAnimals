//
//  GameScene.swift
//  Assignment2&3
//
//  Created by Anthony Rella on 2018-11-28.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//


import SpriteKit
import GameplayKit


class GameOverScene: SKScene, SKPhysicsContactDelegate {
    
    private var playAgainButton : SKLabelNode?
    private var homeButon : SKLabelNode?
    private var playAgainRect : SKShapeNode?
    private var homeRect : SKShapeNode?
    private var scoreLabel : SKLabelNode?
    
    
    
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        let bg = SKSpriteNode(imageNamed: "Loadingbg")
        bg.name = "Cloud"
        bg.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        bg.zPosition = -1
        //  bg.anchorPoint = CGPoint(x: 1, y: 1)
        //    bg.position = CGPoint(x: (self.frame.size.width), y: CGFloat(i) * bg.size.height)
        
        self.addChild(bg)
        
        
        self.playAgainButton = childNode(withName: "PlayAgain") as? SKLabelNode
        self.homeButon = childNode(withName: "Home") as? SKLabelNode
        self.playAgainRect = childNode(withName: "PlaySquare") as? SKShapeNode
        self.homeRect = childNode(withName: "HomeSquare") as? SKShapeNode
        self.scoreLabel = childNode(withName: "FinalScore") as? SKLabelNode
        
        self.scoreLabel?.text = "Final Score: \((GameScene.endScore) )"
        
        
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
            
        }
        
        if (self.playAgainButton?.contains(pos))!{
            
            if let scene = GameScene(fileNamed:"GameScene") {
                
                let skView = self.view! as SKView
                
                skView.ignoresSiblingOrder = true
                
                scene.scaleMode = .aspectFill
                scene.size = skView.bounds.size
                
                skView.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
            }
            
        }
        if (self.homeButon?.contains(pos))!{
            
            self.view?.removeFromSuperview()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
        if ((self.playAgainButton?.contains(pos))! || (self.playAgainRect?.contains(pos))!){
            
            
            if let scene = GameScene(fileNamed:"GameScene") {
                
                let skView = self.view! as SKView
                
                skView.ignoresSiblingOrder = true
                
                scene.scaleMode = .aspectFill
                scene.size = skView.bounds.size
                
                skView.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
            }
            
        }
        if ((self.homeButon?.contains(pos))! || (self.homeRect?.contains(pos))!){
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
        }
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}




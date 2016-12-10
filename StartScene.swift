//
//  StartScene.swift
//  Race_Game_altha
//
//  Created by xcode on 10.12.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    var SoundOn: Bool = true
    
    let playButton = SKSpriteNode(imageNamed: "Car;)")
    var settingsButton = SKSpriteNode(imageNamed: "settings")
    
    override func didMove(to view: SKView) {
        self.playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(self.playButton)
        self.settingsButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 80)
        self.addChild(self.settingsButton)
        self.backgroundColor = UIColor.black
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if self.atPoint(location) == self.playButton {
                if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    scene.isSound = SoundOn
                    // Present the scene
                    view!.presentScene(scene)
                }
            }
            if self.atPoint(location) == self.settingsButton {
                SoundOn = !SoundOn
                settingsButton.removeFromParent()
                if (SoundOn){
                    settingsButton = SKSpriteNode(imageNamed: "ball")}
                else{
                    settingsButton = SKSpriteNode(imageNamed: "car;)")}
                
                
                self.settingsButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 80)
                addChild(settingsButton)
                NSLog("\(SoundOn)")
            }
            
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

//
//  GameScene.swift
//  Race_Game_altha
//
//  Created by xcode on 08.10.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import SpriteKit
//import GameplayKit


struct PhysicsCategory{

    static let Enemy: UInt32 = 1
    static let Bullet: UInt32 = 2
    static let Player: UInt32 = 3

}




class GameScene: SKScene, SKPhysicsContactDelegate {

    var Player = SKSpriteNode(imageNamed: "Car;).png")
    
    var timer, timerE: Timer!
    
    override func didMove(to view: SKView) {
        
        Player.position = CGPoint(x:0, y: -self.size.height / 5)
        
        Player.physicsBody = SKPhysicsBody(rectangleOf: Player.size)
        Player.physicsBody?.affectedByGravity = false;
        Player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        Player.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        Player.physicsBody?.isDynamic = false
        
        
        
        
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(GameScene.SpawnBullets), userInfo: nil, repeats: true)
        
        timerE = Timer(timeInterval: 2.0, target: self, selector: #selector(GameScene.SpawnEnemies), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer, forMode: .commonModes)
        RunLoop.current.add(timerE, forMode: .commonModes)
        
        self.addChild(Player)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        <#code#>
    }
    
    
    
    
    
    func SpawnBullets(){
        let Bullet = SKSpriteNode(imageNamed: "ball.png")
        Bullet.zPosition = -5
        Bullet.position = CGPoint(x:Player.position.x, y: Player.position.y)
        let action = SKAction.moveTo(y: self.size.height + 32, duration: 1.2)
        let actionDone = SKAction.removeFromParent()
        
        Bullet.run(SKAction.sequence([action, actionDone]))
        Bullet.run(SKAction.repeatForever(action))
        
        Bullet.physicsBody = SKPhysicsBody(rectangleOf: Bullet.size)
        Bullet.physicsBody?.affectedByGravity = false;
        Bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        Bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        Bullet.physicsBody?.affectedByGravity = false
        
        
        self.addChild(Bullet)
    }
    
    func SpawnEnemies(){
    
        var Enemy = SKSpriteNode(imageNamed: "Car;).png")
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 80
        var SpawnPoint = UInt32(MaxValue - MinValue)
        
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)),
            y:self.size.height / 2.0)
        print(Enemy.position)
        let action = SKAction.moveTo(y: -size.height/2.0 - 70, duration: 1.2)
        
        let actionDone = SKAction.removeFromParent()
        
        
        
        Enemy.run(SKAction.sequence([action, actionDone]))
        
        Enemy.physicsBody = SKPhysicsBody(rectangleOf: Enemy.size)
        Enemy.physicsBody?.affectedByGravity = false;
        Enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        Enemy.physicsBody?.isDynamic = true
        
        
        
        
        
        self.addChild(Enemy)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches{
            let location = touch.location(in: self)
            
            // doSomethingFor
            // doSomething(for:
            
            Player.position.x = location.x
        }
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches{
            let location = touch.location(in: self)
            
            Player.position.x = location.x
        }

    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

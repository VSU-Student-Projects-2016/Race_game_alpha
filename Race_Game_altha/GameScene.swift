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

    var Score = Int()
    
    var HighScore = Int()
    
    var Player = SKSpriteNode(imageNamed: "Car;).png")
    
    
    let actionLeft = SKAction.moveTo(y: -110, duration: 2.2)
    let actionRight = SKAction.moveTo(y: +110, duration: 2.2)
    
    var ScoreLbl = UILabel()
    
    var HighScoreLbl = UILabel()
    
    
    var timer, timerE: Timer!
    
    override func didMove(to view: SKView) {
        
        var HighscoreDefaults = UserDefaults.standard
        if (HighscoreDefaults.value(forKey: "Highscore") != nil){
            HighScore = HighscoreDefaults.integer(forKey: "Highscore")
        }
        else
        {
            HighScore = 0
        }
        
        physicsWorld.contactDelegate = self
        
        self.scene?.backgroundColor = UIColor.darkGray
        self.scene?.size = CGSize(width: 1080, height: 1920)
    
        self.addChild(SKEmitterNode(fileNamed: "MyParticle")!)
        
        Player.position = CGPoint(x: -110, y: -self.size.height / 10)
        
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
        
        ScoreLbl.text = "\(Score)"
        ScoreLbl = UILabel(frame: CGRect(x: 600, y: 0, width: 100, height: 50))
        ScoreLbl.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        ScoreLbl.textColor = UIColor.white
        
        ScoreLbl.text = "Score:  " + "0"
        
        self.view?.addSubview(ScoreLbl)
        
        HighScoreLbl.text = "\(HighScore)"
        HighScoreLbl = UILabel(frame: CGRect(x: 10, y: 0, width: 150, height: 50))
        HighScoreLbl.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        HighScoreLbl.textColor = UIColor.white
        
        HighScoreLbl.text = "HighScore:  " + "0"
        
        self.view?.addSubview(HighScoreLbl)
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody = contact.bodyA
        var secondBody:SKPhysicsBody = contact.bodyB
        if ((firstBody.categoryBitMask == PhysicsCategory.Enemy) && (secondBody.categoryBitMask == PhysicsCategory.Player) ||
            (firstBody.categoryBitMask == PhysicsCategory.Player) && (secondBody.categoryBitMask == PhysicsCategory.Enemy)){
            
            if let a = firstBody.node as? SKSpriteNode{
                if let b = secondBody.node as? SKSpriteNode{
                    CollisionWithPerson(Enemy: a as! SKSpriteNode, Person: b as! SKSpriteNode)
                }
            }
        }
    }

    
    func  CollisionWithPerson(Enemy:SKSpriteNode, Person:SKSpriteNode){
        Enemy.removeFromParent()
        Person.removeFromParent()
        self.view?.presentScene(EndScene())
        ScoreLbl.removeFromSuperview()
        HighScoreLbl.removeFromSuperview()
        
        var ScoreDefault = UserDefaults.standard
        ScoreDefault.setValue(Score, forKey: "Score")
    }
    
    
    func SpawnBullets(){
        let Bullet = SKSpriteNode(imageNamed: "ball.png")
        Bullet.zPosition = -5
        Bullet.position = CGPoint(x: 0, y: 500)
        let action = SKAction.moveTo(y: -size.height/10 - 250, duration: 2.2)
        let actionDone = SKAction.removeFromParent()
        
        Bullet.run(SKAction.sequence([action, actionDone]))
        Bullet.run(SKAction.repeatForever(action))
        
        //Bullet.physicsBody = SKPhysicsBody(rectangleOf: Bullet.size)
        
        
        self.addChild(Bullet)
    }
    
    func SpawnEnemies(){
        var Enemy = SKSpriteNode(imageNamed: "Car;).png")
        var MinValue = 0
        var MaxValue = 1
        var SpawnPoint = UInt32(MaxValue - MinValue)
        
        Enemy.position = CGPoint(x: 200*CGFloat(arc4random_uniform(2)) - 110,
            y:self.size.height/2 )
        print(Enemy.position)
        
        let action = SKAction.moveTo(y: -100, duration: max(TimeInterval(Int32(10 - Score)),2))
        
        let actionDone = SKAction.removeFromParent()
        let actionCallBlock = SKAction.run {
            self.Score+=1
            
            NSLog("\(self.Score)")
            
            self.ScoreLbl.text = "Score:  " + "\(self.Score)"
            
            if (self.Score > self.HighScore){
                self.HighScoreLbl.text = "HighScore:  " + "\(self.Score)"
            }
        }
        
        Enemy.run(SKAction.sequence([action, actionCallBlock, actionDone]))
        
        
        
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
            
            
            if (location.x > 0){
                Player.position.x = 200*1 - 110
            }
            else {
                
                Player.position.x = 200*0 - 110
            }
        }
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

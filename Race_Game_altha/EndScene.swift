//
//  EndScene.swift
//  Race_Game_altha
//
//  Created by xcode on 29.10.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : SKScene{
    
    var RestartBtn : UIButton!
    var Highscore : Int!
    
    var Scorelbl : UILabel!
    var HighScorelbl : UILabel!
    
    
    override func didMove(to view: SKView) {
        scene?.backgroundColor = UIColor.white
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        RestartBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 7)
        
        
        RestartBtn.setTitle("Restart", for: UIControlState.normal)
        RestartBtn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
    
        RestartBtn.addTarget(self, action: #selector(EndScene.Restart), for: UIControlEvents.touchUpInside)
        self.view?.addSubview(RestartBtn)
        
        var ScoreDefault = UserDefaults.standard
        //warning!!!
        var Score = ScoreDefault.value(forKey: "Score") as! NSInteger
        NSLog("\(Score)")
        
        var HighscoreDefault = UserDefaults.standard
        Highscore = HighscoreDefault.value(forKey: "Highscore") as! NSInteger
        
        Scorelbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        Scorelbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 4)
        Scorelbl.text = "\(Score)"
        self.view?.addSubview(Scorelbl)
        
        HighScorelbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        HighScorelbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 5)
        HighScorelbl.text = "\("HighScore")"
        self.view?.addSubview(HighScorelbl)
        
        NSLog("\(Highscore)")
    }
    
    func Restart(){
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view!.presentScene(scene)
        }
        RestartBtn.removeFromSuperview()
        HighScorelbl.removeFromSuperview()
    }
    
}

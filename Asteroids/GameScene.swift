//
//  GameScene.swift
//  Asteroids
//
//  Created by Michael Vilabrera on 2/15/18.
//  Copyright © 2018 Michael Vilabrera. All rights reserved.
//

import SpriteKit
import GameplayKit

@objcMembers
class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player-rocket.png")
    
    override func didMove(to view: SKView) {
        // called when game scene is ready to run
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)
        
        if let particles = SKEmitterNode(fileNamed: "SpaceDust") {
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
        }
        
        player.position.x = -300
        player.zPosition = 1
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // called when user touchers screen
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // called when user stops touching screen
    }
    
    override func update(_ currentTime: TimeInterval) {
        // called before each frame is rendered
    }
}

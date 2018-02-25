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
    var touchingPlayer = false
    
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
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        if tappedNodes.contains(player) {
            touchingPlayer = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchingPlayer else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        player.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // called when user stops touching screen
        touchingPlayer = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // called before each frame is rendered
    }
}

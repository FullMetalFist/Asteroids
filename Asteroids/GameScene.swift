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
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "player-rocket.png")
    let scoreLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
    var touchingPlayer = false
    
    var gameTimer: Timer?
    var score = 0 {
        didSet {
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        // called when game scene is ready to run
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)
        
        scoreLabel.zPosition = 2
        scoreLabel.position.y = 200
        addChild(scoreLabel)
        
        score = 0
        
        if let particles = SKEmitterNode(fileNamed: "SpaceDust") {
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
        }
        
        player.position.x = -300
        player.zPosition = 1
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.affectedByGravity = false
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        physicsWorld.contactDelegate = self
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
    
    func createEnemy() {
        createBonus()
        let randomDistribution = GKRandomDistribution(lowestValue: -350, highestValue: 350)
        
        let sprite = SKSpriteNode(imageNamed: "asteroid")
        sprite.position = CGPoint(x: 1200, y: randomDistribution.nextInt())
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        sprite.physicsBody?.affectedByGravity = false
    }
    
    func createBonus() {
        let randomDistribution = GKRandomDistribution(lowestValue: -350, highestValue: 350)
        
        let sprite = SKSpriteNode(imageNamed: "energy")
        sprite.position = CGPoint(x: 1200, y: randomDistribution.nextInt())
        sprite.name = "bonus"
        sprite.zPosition = 1
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        sprite.physicsBody?.collisionBitMask = 0
        sprite.physicsBody?.affectedByGravity = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerHit(nodeB)
        } else {
            playerHit(nodeA)
        }
    }
    
    func playerHit(_ node: SKNode) {
        if node.name == "bonus" {
            score += 1
            node.removeFromParent()
            return
        }
        player.removeFromParent()
    }
}

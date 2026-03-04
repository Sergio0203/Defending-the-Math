//
//  Tower.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 06/02/25.
//
import SpriteKit
final class Castle: SKNode {
    let image = SKSpriteNode(imageNamed: "castle")
    override init() {
        super.init()
        addChild(image)
        setUpPhysics()
        self.setScale(NodesTools.scale)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(texture: image.texture!, size: image.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = NodesTools.tower
        self.physicsBody?.collisionBitMask = NodesTools.enemy
        self.physicsBody?.contactTestBitMask = NodesTools.enemy
    }
}

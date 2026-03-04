//
//  Ground.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 06/02/25.
//
import SpriteKit
final class Ground: SKNode {
    
    let image = SKSpriteNode(imageNamed: "ground")
    override init() {
        super.init()
        addChild(image)
        setUpPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(texture: image.texture!, size: image.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = NodesTools.ground
    }
}

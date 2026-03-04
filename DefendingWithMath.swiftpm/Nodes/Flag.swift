//
//  Flag.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 07/02/25.
//
import SpriteKit

final class Flag: SKNode {
    let image = SKSpriteNode(imageNamed: "Flag_1")
    private var animation: [SKTexture] = []
    override init() {
        super.init()
        addChild(image)
        runAnimation()
        self.setScale(NodesTools.scale)
        
    }
    
    func runAnimation(){
        for i in 1...3 {
            let frame = SKTexture(imageNamed: "Flag_\(i)")
            frame.filteringMode = .nearest
            animation.append(frame)
        }
        image.run(.repeatForever(.animate(with: animation, timePerFrame: 0.15)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

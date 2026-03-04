//
//  ResultButton.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 10/02/25.
//
import SpriteKit

final class ResultButton: SKNode {
    let image = SKSpriteNode(imageNamed: "resultButton")
    var action: (() -> Void)?
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init()
        addChild(image)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        action?()
        self.alpha = 0.7
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
}

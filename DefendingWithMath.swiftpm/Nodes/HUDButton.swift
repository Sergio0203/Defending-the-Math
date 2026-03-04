//
//  RestartButton.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 18/02/25.
//

import SpriteKit
final class HUDButton: SKNode {
    let back = SKSpriteNode(imageNamed: "backgroundButton")
    let symbol: SKSpriteNode
    var action: (() -> Void)
    init(name: String, action: @escaping () -> Void) {
        self.action = action
        self.symbol = SKSpriteNode(imageNamed: name)
        super.init()
        self.addChild(back)
        self.addChild(symbol)
        self.isUserInteractionEnabled = true
        self.setScale(0.5)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.7
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
        action()
    }
}


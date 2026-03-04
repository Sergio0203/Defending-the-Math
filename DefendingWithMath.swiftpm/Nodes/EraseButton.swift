//
//  EraseButton.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 11/02/25.
//
import SpriteKit

final class EraseButton: SKNode {
    var image = SKSpriteNode(imageNamed: "eraseButton")
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

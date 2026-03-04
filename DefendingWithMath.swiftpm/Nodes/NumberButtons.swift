//
//  NumberButtons.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 05/02/25.
//
import SpriteKit
final class NumberButtons: SKNode {
    var action: (() -> Void)?
    var label = SKLabelNode()
    let image = SKSpriteNode(imageNamed: "button")
    init(number: Int, action: @escaping (()-> Void)) {
        self.action = action
        self.label.fontName = TypesFont.bold.rawValue
        self.label.text = "\(number)"
        self.label.fontSize = 100
        self.label.fontColor = .black
        self.label.position =  .init(x: 0, y: -30)
        super.init()
        addChild(image)
        image.zPosition = 0
        addChild(label)
        label.zPosition = 1
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

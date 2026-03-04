//
//  Result.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 10/02/25.
//

import SpriteKit
import Foundation
final class ResultLabel: SKNode {
    private let image = SKSpriteNode(imageNamed: "resultLabel")
    private var text = ""
    private var label = SKLabelNode(text: "")
    
    override init() {
        super.init()
        addChild(image)
        image.xScale = 0.8
        image.yScale = 0.9
        label.fontColor = .black
        label.fontName = TypesFont.bold.rawValue
        label.fontSize = 80
        label.position = .init(x: -2, y: -20)
        addChild(label)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateResult(text: String) {
        if self.text.count == 3 {
            return
        }
        self.text += text
        label.text = self.text
    }
   
    func resetResult() {
        text = ""
        label.text = self.text
    }
    
    func erase(){
        _ = text.popLast()
        label.text = self.text
    }
    
    func getResult() -> Int {
        return Int(self.text) ?? -1
    }
}

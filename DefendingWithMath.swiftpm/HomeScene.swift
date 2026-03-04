//
//  HomeScene.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 19/02/25.
//

import SpriteKit

final class HomeScene: SKScene {
    let ground = Ground()
    let castle = Castle()
    let flag = Flag()
    var newScene: GameScene?
    let transition = SKTransition.fade(with: .black, duration: 2)
    let startLabel: SKLabelNode = {
        let label = SKLabelNode(text: "Touch to start")
        label.fontSize = 130
        label.fontName = TypesFont.bold.rawValue
        label.fontColor = .white
        label.position = .init(x: 0, y: -600)
        label.run(.repeatForever(.sequence([.fadeIn(withDuration: 1.5), .wait(forDuration: 2), .fadeOut(withDuration: 1.5)])))
        return label
    } ()
    
    let titleLabel: SKLabelNode = {
        let label = SKLabelNode(text: "Defending With Math")
        label.fontSize = 150
        label.fontName = TypesFont.bold.rawValue
        label.fontColor = .black
        label.position = .init(x: 0, y: 550)
        return label
    } ()
    
    let enemy1 = Enemy(operation: EnemiesOperation().generateAddOrSub(), image: "Flying_1", prefix: "Flying")
    let enemy2 = Enemy(operation: EnemiesOperation().generateAddOrSub(), image: "Flying_1", prefix: "Flying")
    
    static func create() -> SKScene {
        let scene = HomeScene(size: .init(width: 2360, height: 1640))
        scene.scaleMode = .aspectFill
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        return scene
    }
    
    override func sceneDidLoad(){
        backgroundColor = .white
//        self.anchorPoint = .init(x: 0.5, y: 0.5)
        newScene = GameScene(size: self.size)
        ground.position = .init(x: 0, y: -self.size.height/2 + ground.image.size.height/2)
        ground.zPosition = -1
        addChild(ground)
    
        castle.position = .init(x: 0, y: -75)
        addChild(castle)
        
        flag.position = .init(x: 60, y: 315)
        addChild(flag)
        
        enemy1.position = .init(x: 700, y: 300)
        addChild(enemy1)
        
        enemy2.position = .init(x: -700, y: 300)
        enemy2.xScale = -NodesTools.scale
        addChild(enemy2)
        
        addChild(startLabel)
        addChild(titleLabel)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let gameScene = SceneManager.shared.getScene(ofType: .game) {
            SceneManager.shared.present(gameScene)
        }
    }
    
    deinit {
        print("aqui foi amem")
    }
}

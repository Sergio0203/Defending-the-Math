//
//  SceneManager.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 20/02/25.
//

import SpriteKit

enum SceneType {
    case home, game
}

class SceneManager {
    
    public static let shared = SceneManager(currentScene: HomeScene.create())

    var currentScene: SKScene
    var transition = SKTransition.fade(with: .black, duration: 1.5)
    var library: [SceneType: SKScene] = [:]
    
    private init(currentScene: SKScene) {
        self.currentScene = currentScene
        library[.home] = currentScene
        library[.game] = GameScene.create()
    }
    
    func getScene(ofType type: SceneType) -> SKScene? {
        return library[type]
    }
    
    func present(_ scene: SKScene) {
        scene.isHidden = false
        currentScene.isHidden = true
        currentScene.view?.presentScene(scene, transition: transition)
        currentScene = scene
    }
    
}

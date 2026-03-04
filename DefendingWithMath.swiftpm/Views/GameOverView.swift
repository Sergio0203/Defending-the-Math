//
//  GameOverView.swift
//  Meu App
//
//  Created by Sérgio César Lira Júnior on 18/02/25.
//
import SpriteKit
final class GameOverView: SKNode {
    let backgroundLabel = SKSpriteNode(color: .white, size: .init(width: 2360, height: 1640))
    
    let gameOverLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: TypesFont.bold.rawValue)
        label.fontColor = .black
        label.fontSize = 200
        label.text = "Game Over"
        return label
    }()
    
    let restartButton: HUDButton
    let restartLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: TypesFont.regular.rawValue)
        label.fontColor = .black
        label.fontSize = 80
        label.text = "Play again"
        return label
    }()
    
    let menuButton: HUDButton
    
    let menuButtonLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: TypesFont.regular.rawValue)
        label.fontColor = .black
        label.fontSize = 80
        label.text = "Home"
        return label
    }()
    
    var scoreLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: TypesFont.regular.rawValue)
        label.fontColor = .black
        label.fontSize = 100
        return label
    }()
    
    var highScoreLabel: SKLabelNode = {
            let label = SKLabelNode(fontNamed: TypesFont.regular.rawValue)
            let highScore = UserDefaults.standard.integer(forKey: "highScore")
            label.fontColor = .black
            label.fontSize = 100
            label.text = "High Score: \(highScore)"
            return label
    }()
    
    init(restartAction: @escaping () -> Void, menuAction: @escaping () -> Void) {
        restartButton = HUDButton(name: "restartButton", action: restartAction)
        menuButton = HUDButton(name: "homeButton", action: menuAction)
        super.init()
        
        backgroundLabel.alpha = 0.9
        backgroundLabel.zPosition = 2
        self.addChild(backgroundLabel)
        
        menuButton.zPosition = 3
        menuButton.position = CGPoint(x: -300, y: -200)
        self.addChild(menuButton)
        
        menuButtonLabel.zPosition = 3
        menuButtonLabel.position = CGPoint(x: menuButton.position.x, y: menuButton.position.y - 200)
        self.addChild(menuButtonLabel)
        
        restartButton.zPosition = 3
        restartButton.position = CGPoint(x: 300, y: -200)
        self.addChild(restartButton)
        
        restartLabel.zPosition = 3
        restartLabel.position = CGPoint(x: restartButton.position.x, y: restartButton.position.y - 200)
        self.addChild(restartLabel)

        gameOverLabel.zPosition = 3
        gameOverLabel.position = CGPoint(x: 0, y: 400)
        self.addChild(gameOverLabel)
        
        scoreLabel.zPosition = 3
        scoreLabel.position = CGPoint(x: 0, y: 200)
        addChild(scoreLabel)
        
        highScoreLabel.zPosition = 3
        highScoreLabel.position = CGPoint(x: 0, y: 100)
        addChild(highScoreLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGameOver(score: Int, newHighScore: Bool = false){
        scoreLabel.text = "Score: \(score)"
        highScoreLabel.text = newHighScore ? "New High Score: \(UserDefaults.standard.integer(forKey: "highScore"))" : "High Score: \(UserDefaults.standard.integer(forKey: "highScore"))"
      
    }
    
    
}

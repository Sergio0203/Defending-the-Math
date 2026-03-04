//
//  GameScene.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 29/01/25.
//

import SpriteKit
import GameplayKit

enum EnemyType {
    case walking, flying
}

enum PhasesConstant {
    case phase1, phase2, phase3, phase4, phase5
    var timeToTower: TimeInterval {
        switch self {
        case .phase1: return 14
        case .phase2: return 12
        case .phase3: return 10
        case .phase4: return 8
        case .phase5: return 7
        }
    }
    
    var delayToSpawnEnemy: TimeInterval {
        switch self {
        case .phase1: return 5
        case .phase2: return 4
        case .phase3: return 3.5
        case .phase4: return 3
        case .phase5: return 2.5
        }
    }
        
    private static let phaseByMinScore: [(PhasesConstant, Int)] = [
        (.phase1, 0),
        (.phase2, 20),
        (.phase3, 40),
        (.phase4, 60),
        (.phase5, 80),
    ]
    
    static func create(fromScore score: Int) -> PhasesConstant {
        return PhasesConstant.phaseByMinScore.last(where: { score >= $0.1 })!.0
    }
}

final class GameScene: SKScene {
    
    var spawn = true
    var phase = PhasesConstant.phase1 {
        didSet {
            self.run(.sequence([
                .run {
                    self.removeAction(forKey: "spawnEnemys")
                }, .wait(forDuration: 3),
                .run {
                    self.spawnEnemy(phase: self.phase)
                }
            ]))
        }
    }
    var enemysOnScreen: [Enemy] = []
    let numbers = [1,2,3,4,5,6,7,8,9,0]
    let result = ResultLabel()
    let ground = Ground()
    let castle = Castle()
    let flag = Flag()
    var resultButton: ResultButton?
    var eraseButton: EraseButton?
    var gameOverView: GameOverView?
    private let ctasYPosition: CGFloat = -500
    /// Animating Letters
    var comboSetence: String? {
        didSet {
            guard let comboSetence else { return }
            comboLabel = comboSetence.map {
                let label = SKLabelNode(fontNamed: TypesFont.regular.rawValue)
                label.text = String($0)
                label.fontColor = .black
                label.fontSize = 100
                label.run(
                    .repeatForever(
                        .sequence(
                            [
                                .rotate(byAngle: -0.2, duration: 0.2),
                                .rotate(byAngle: 0.4, duration: 0.4),
                                .rotate(byAngle: -0.2, duration: 0.2)
                            ]
                        )
                    )
                )
                return label
            }
        }
    }
    let scoreLabel = SKLabelNode(fontNamed: TypesFont.bold.rawValue)
    var comboLabel: [SKLabelNode] = []
    var sequence = 0 {
        didSet {
            let aux = (sequence/4) + 1
            combo = aux > 4 ? 4 : aux
        }
    }
    
    /// Combo
    var combo = 1 {
        didSet {
            if combo > 1 {
                comboSetence = "Combo x\(combo)"
                for (indice, letter) in comboLabel.enumerated() {
                    letter.position = .init(x: -200 + CGFloat(indice) * 60, y: 475)
                    addChild(letter)
                }
            } else {
                for letter in comboLabel {
                    letter.removeFromParent()
                }
            }
        }
    }
    
    /// HighScore
    var newhighScore: Bool = false
    
    var highScoreLabel = SKLabelNode(fontNamed: TypesFont.bold.rawValue)
    
    var highScore: Int {
        get {
            UserDefaults.standard.integer(forKey: "highScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "highScore")
            highScoreLabel.text = "HIGH SCORE: \(highScore)"
            newhighScore = true
        }
    }
    /// Score and Phases
    var score: Int = 0 {
        didSet {
            if score > highScore {
                highScore = score
            }
            let newPhase = PhasesConstant.create(fromScore: score)
            
            if phase != newPhase {
                phase = newPhase
            } else if phase == .phase1 {
                
            }
            
            scoreLabel.text = "SCORE: \(score)"
            //dont remember why this is here, but if i remove, it doesn`t work anymore
            combo = 1
        }
    }
    
    let playSound = SKAction.playSoundFileNamed("kill.mp3", waitForCompletion: false)

    static func create() -> SKScene {
        let scene = GameScene(size: .init(width: 2360, height: 1640))
        scene.scaleMode = .aspectFill
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        return scene
    }
    
    override func sceneDidLoad() {
        backgroundColor = .white
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        phase = .phase1
        setUpScene()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func setUpScene() {
        result.resetResult()
        newhighScore = false
        combo = 1
        sequence = 0
        score = 0
        enemysOnScreen.removeAll()
        ground.position = .init(x: 0, y: self.frame.minY + ground.image.size.height/2)
        ground.zPosition = -1
        addChild(ground)
        
        castle.position = .init(x: 0, y: -75)
        addChild(castle)
        
        flag.position = .init(x: 60, y: 315)
        addChild(flag)
        
        result.position = .init(x: 0, y: ctasYPosition)
        addChild(result)
        
        highScoreLabel.text = "HIGH SCORE: \(highScore)"
        highScoreLabel.fontColor = .black
        highScoreLabel.fontSize = 70
        highScoreLabel.position = .init(x: -875, y: 700)
        addChild(highScoreLabel)
        
        scoreLabel.position = .init(x: 0, y: 650)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 80
        addChild(scoreLabel)
        
        //Solve enemies
        resultButton = ResultButton(){ [weak self] in
            guard let self = self else { return }
            var enemysEliminated = 0
            var enemysToRemove: [Enemy] = []
            for enemy in self.enemysOnScreen {
                if enemy.checkResult(result.getResult()) {
                    self.run(playSound)
                    enemy.removeFromParent()
                    enemy.removeAllActions()
                    enemysEliminated += 1
                    enemysToRemove.append(enemy)
                }
            }
            for enemy in enemysToRemove {
                enemysOnScreen.removeAll { $0 === enemy }
            }
            enemysToRemove.removeAll()
            score += enemysEliminated * combo
            if enemysEliminated > 0 {
                sequence += enemysEliminated
            } else {
                sequence = 0
                result.run(
                    .repeat(
                        .sequence(
                            [
                                .move(by: .init(dx: -5, dy: 0), duration: 0.05),
                                .move(by: .init(dx: 10, dy: 0), duration: 0.1),
                                .move(by: .init(dx: -5, dy: 0), duration: 0.05)
                            ]
                        ),
                        count: 4
                    )
                )
            }
            print(sequence)
            
            self.result.resetResult()
        }
        
        resultButton?.position = .init(x: 250, y: ctasYPosition)
        addChild(resultButton!)
        
        eraseButton = EraseButton(){ [weak self] in
            guard let self = self else { return }
            self.result.erase()
        }
        
        eraseButton?.position = .init(x: -255, y: ctasYPosition)
        addChild(eraseButton!)
        
        for x in numbers {
            let numberButton = NumberButtons(number: numbers[x]) { [weak self] in
                guard let self = self else { return }
                result.updateResult(text: "\(numbers[x])")
            }
            let sizeButton = numberButton.image.frame.width
            numberButton.position = CGPoint(x: self.frame.minX + sizeButton/2 + 22 + ((sizeButton + 10) * CGFloat(x)), y: -690)
            numberButton.zPosition = 1
            addChild(numberButton)
        }
        
    }
    
    func spawnEnemy(phase: PhasesConstant) {
        let spawnAction = SKAction.run { [weak self] in
            guard let self = self else { return }
            if self.spawn {
                var enemy: Enemy
                let typeEnemy = Int.random(in: 1...2) == 1 ? EnemyType.walking : EnemyType.flying
                
                switch typeEnemy {
                case .walking:
                    enemy = WalkingEnemy()
                    enemy.position = CGPoint(x: CGFloat([self.frame.maxX + 100, -(self.frame.maxX + 100)].randomElement()!), y: -315)
                    
                    enemy.run(.moveTo(x: flag.position.x, duration: phase.timeToTower))
                    
                case .flying:
                    enemy = FlyingEnemy()
                    enemy.position = CGPoint(x: CGFloat([self.frame.maxX + 100, -(self.frame.maxX + 100)].randomElement()!) , y: CGFloat((-190...500).randomElement()!))
                    
                    enemy.run(.move(to: .init(x: flag.position.x, y: flag.position.y - 150), duration: phase.timeToTower))
                }
                
                if enemy.position.x < 0 {
                    enemy.invertEnemy()
                }
                
                enemy.verifyWidth()
                self.addChild(enemy)
                self.enemysOnScreen.append(enemy)
            }
        }
        
        let waitAction = SKAction.wait(forDuration: phase.delayToSpawnEnemy)
        let sequenceAction = SKAction.sequence([spawnAction, waitAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        run(repeatAction, withKey: "spawnEnemys")
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if ((contact.bodyA.categoryBitMask == NodesTools.enemy) && (contact.bodyB.categoryBitMask == NodesTools.tower)) || (contact.bodyB.categoryBitMask == NodesTools.enemy) && (contact.bodyA.categoryBitMask == NodesTools.tower){
            enemyTouchedTower()
        }
    }
    
    private func enemyTouchedTower () {
        for enemy in enemysOnScreen {
            enemy.isPaused = true
            enemy.removeAllActions()
        }
        self.removeAllActions()
        gameOver()
    }
    
    private func gameOver () {
        
        if gameOverView == nil {
            gameOverView = GameOverView(restartAction: { [weak self] in
                guard let self else { return }
                self.removeAllChildren()
                if self.phase == .phase1 {
                    self.phase = .phase1
                }
                self.setUpScene()
                
            }, menuAction: { [weak self] in
                guard let self else { return }
                self.removeAllChildren()
                if self.phase == .phase1 {
                    self.phase = .phase1
                }
                self.setUpScene()
                
                if let homeScene =
                    SceneManager.shared.getScene(ofType: .home) {
                    SceneManager.shared.present(homeScene)
                }
            })
        }
        
        guard let gameOverView, gameOverView.parent == nil else { return }
        gameOverView.setGameOver(score: score, newHighScore: newhighScore)
        gameOverView.alpha = 0
        self.addChild(gameOverView)
        gameOverView.run(SKAction.fadeIn(withDuration: 0.5))
        
    }
}

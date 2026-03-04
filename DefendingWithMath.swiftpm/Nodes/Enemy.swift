
import SpriteKit

class Enemy: SKNode {
    var operation: (String, Int)?
    var image: SKSpriteNode?
    var animation: [SKTexture] = []
    var sign: SKSpriteNode?
    var label: SKLabelNode?
    init(operation: (String, Int), image: String, prefix: String) {
        self.operation = operation
        self.image = .init(imageNamed: image)
        super.init()
        addChild(self.image ?? .init(imageNamed: ""))
        setUpPhysics()
        animate(prefix)
        self.setScale(NodesTools.scale)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate(_ prefix: String){
        for i in 1...3 {
            let frame = SKTexture(imageNamed: "\(prefix)_\(i)")
            frame.filteringMode = .nearest
            animation.append(frame)
        }
        image!.run(.repeatForever(.animate(with: animation, timePerFrame: 0.2)))
    }
    
    func verifyWidth() {
        if self.xScale < 0 {
            sign?.xScale = -1
        }
    }
    
    func invertEnemy(){
        self.xScale = -NodesTools.scale
    }
    
    func checkResult(_ result: Int) -> Bool {
        guard let operation = self.operation else { return false }
        return operation.1 == result
    }
    
    func setUpPhysics() {
        guard let image = self.image else { return }
        self.physicsBody = SKPhysicsBody(texture: image.texture!, size: image.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = NodesTools.enemy
        self.physicsBody?.collisionBitMask = NodesTools.tower
        self.physicsBody?.contactTestBitMask = NodesTools.tower
    }
}

final class WalkingEnemy: Enemy {
    init() {
        super.init(operation: EnemiesOperation().generateAddOrSub(), image: "Walking_1", prefix: "Walking")
        sign = SKSpriteNode(imageNamed: "sign1")
        sign?.position = .init(x: -20, y: 200)
        addChild(sign!)
        
        label = SKLabelNode(text: operation?.0)
        label?.fontName = TypesFont.bold.rawValue
        label?.fontColor = .black
        label?.fontSize = 70
        label?.zPosition = 1
        sign?.addChild(label!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

final class FlyingEnemy: Enemy {
    init() {
        super.init(operation: EnemiesOperation().generateMultOrDiv(), image: "Flying_1", prefix: "Flying")
        sign = SKSpriteNode(imageNamed: "sign2")
        sign?.position = .init(x: -40, y: 150)
        addChild(sign!)
        
        label = SKLabelNode(text: operation?.0)
        label?.fontName = TypesFont.bold.rawValue
        label?.fontColor = .black
        label?.fontSize = 70
        label?.zPosition = 1
        label?.position = .init(x: 20, y: 40)
        sign?.addChild(label!)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

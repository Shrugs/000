//
//  CreateUniverseScene.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

let BIG_BANG_HOLD_TIME : NSTimeInterval = 8

class CreateUniverseScene: SKScene {

  // MARK: Properties

  var universeDelegate : CreateUniverseDelegate?

  let container = SKNode()

  lazy var tapAndHoldNode : SKLabelNode = { [unowned self] in
    return generalTextNode("tap and hold").setPos(to: self.textNodePosition) as! SKLabelNode
  }()

  lazy var keepHoldingNode : SKLabelNode = { [unowned self] in
    return generalTextNode("keep holding").setPos(to: self.textNodePosition) as! SKLabelNode
  }()

  var gravityField : SKFieldNode?
  var gravitySingularity : SKShapeNode?

  var bigBangOccurred = false
  var bigBangTimer : NSTimer?

  lazy var dustParticleTexture : SKTexture = { [unowned self] in
    let shape = SKShapeNode(rectOfSize: CGSize(width: 1, height: 1))
    shape.fillColor = Constant.Color.DustColor
    return self.view!.textureFromNode(shape)!
  }()

  lazy var blackHolePosition : CGPoint = { [unowned self] in
    return CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height * 0.2)
  }()

  lazy var textNodePosition : CGPoint = { [unowned self] in
    return CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height * 0.85)
  }()

  // MARK: Lifecycle Methods

  override func didMoveToView(view: SKView) {
    backgroundColor = Constant.Color.SpaceBackground
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)

    addChild(container)

    keepHoldingNode.alpha = 0
    container.addChild(keepHoldingNode)

    container.addChild(tapAndHoldNode)
    setTextState(.TapAndHold)
  }

  override func didSimulatePhysics() {

    container.enumerateChildNodesWithName(Constant.SpriteKeys.DustParticle, usingBlock: { (node, stop) in
      // if the particles are out of bounds, remove them
      if node.position.x < 0 || node.position.x > self.frame.size.width {
        node.removeFromParent()
      } else if node.position.y < 0 || node.position.y > self.frame.size.height {
        node.removeFromParent()
      } else if let g = self.gravitySingularity where g.containsPoint(node.position) {
        node.removeFromParent()
      }
    })
  }

  // MARK: Dust Stuff

  var dustTimer : NSTimer?

  func beginCreatingDust() {
    dustTimer = NSTimer.schedule(repeatInterval: 0.05) { timer in
      for _ in 1...10 {
        self.createDust()
      }
    }
  }

  func endCreatingDust() {
    dustTimer?.invalidate()

    // destroy all dust particles
    container.enumerateChildNodesWithName(Constant.SpriteKeys.DustParticle, usingBlock: { (node, stop) in
      node.runAction(SKAction.fadeOutWithDuration(0.5)) {
        node.removeFromParent()
      }
    })
  }

  func createDust() {

    // creates a singular dust particle

    let particleSize : CGFloat = 1.0

    let particle = SKSpriteNode(texture: dustParticleTexture)
    particle.name = Constant.SpriteKeys.DustParticle
    particle.alpha = CGFloat(randomDouble(0.3, to: 1.0))

    let randomX = randomDouble(-20.0, to: Double(frame.size.width) + 20.0)
    let randomY = randomDouble(-20.0, to: Double(frame.size.height) + 20.0)

    particle.position = CGPoint(x: randomX, y: randomY)
    particle.physicsBody = SKPhysicsBody(circleOfRadius: particleSize)
    container.addChild(particle)
  }

  // MARK: Singularity Stuff

  func createSingularity(at loc: CGPoint) {
    gravitySingularity = SKShapeNode(circleOfRadius: self.frame.size.width * 0.05)

    guard let gravitySingularity = gravitySingularity else { return }

    gravitySingularity.fillColor = .blackColor()
    gravitySingularity.strokeColor = .whiteColor()
    gravitySingularity.glowWidth = 1

    gravitySingularity.position = loc
    gravitySingularity.setScale(0.01)

    gravityField = self.createRadialGravityField()
    gravitySingularity.addChild(gravityField!)

    container.addChild(gravitySingularity)

    gravitySingularity.runAction(SKAction.scaleTo(1.0, duration: 5.0))
  }

  func removeSingularity() {
    gravitySingularity?.removeFromParent()
    gravitySingularity = nil

    self.gravityField?.removeFromParent()
    self.gravityField = nil
  }

  func createRadialGravityField() -> SKFieldNode {
    let gravityField = SKFieldNode.radialGravityField()
    gravityField.strength = 12
    gravityField.falloff = 0.1

    return gravityField
  }

  var previousState : Constant.StateKeys.CreateUniverse.TextState?

  func setTextState(state: Constant.StateKeys.CreateUniverse.TextState) {
    switch state {
    case .BigBanged:
      tapAndHoldNode.fadeOut(0.2) { self.tapAndHoldNode.removeFromParent() }
      keepHoldingNode.fadeOut(0.2) { self.keepHoldingNode.removeFromParent() }
    case .KeepHolding:
      // fade out tap and fade in keep Holding
      tapAndHoldNode.fadeOut(1.0)
      keepHoldingNode.fadeInAfter(2, duration: 1)
    case .TapAndHold: fallthrough
    default:
      if let _ = previousState {
        // by default
        keepHoldingNode.fadeOut(0.4)
        tapAndHoldNode.fadeInAfter(1.0, duration: 1.0)
      } else {
        // first run
        tapAndHoldNode.fadeInAfter(1.0, duration: 1.0)
      }
    }

    previousState = state
  }

  // MARK: Big Bang Stuff

  func triggerBigBang() {

    guard let gravitySingularity = gravitySingularity else { return }

    if !bigBangOccurred {
      bigBangOccurred = true

      // stop creating dust
      endCreatingDust()

      // fade out text
      tapAndHoldNode.fadeOut(0.2)  // just in case
      keepHoldingNode.fadeOut(0.2)

      // start big bang animations
      let bigBangParticleEmitter = SKEmitterNode(fileNamed: "BigBang.sks")!
      bigBangParticleEmitter.position = gravitySingularity.position
      container.addChild(bigBangParticleEmitter)

      removeSingularity()

      // shake the screen a bit
      container.runAction(SKAction.shake(0.8, amplitudeX: 100, amplitudeY: 100)) {
        let blackHole = BlackHole()
        blackHole.setScale(0.01)
        blackHole.position = self.lastTouch ?? CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        self.container.addChild(blackHole)
        let seq = SKAction.sequence([
          SKAction.waitForDuration(1.0),
          SKAction.scaleTo(1.0, duration: 1.0),
          SKAction.waitForDuration(1.0),
          SKAction.moveTo(self.blackHolePosition, duration: 3.0)
        ])
        blackHole.runAction(seq) {
          self.universeDelegate?.didFinishCreatingUniverse()
        }
      }
    }
  }


  // MARK: Touches State Machine

  var lastTouch : CGPoint?

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    guard let loc = touches.first?.locationInNode(container) else { return }

    if !bigBangOccurred {
      lastTouch = loc

      // create a strong radial gravitational field at the touch point
      createSingularity(at: loc)

      // begin spawning "dust" particles that are attracted to the radial field
      beginCreatingDust()

      // fade out the tapAndHoldNode, create the keepHoldingNode if not exists
      setTextState(.KeepHolding)

      // start the big bang timer
      bigBangTimer = NSTimer.schedule(delay: BIG_BANG_HOLD_TIME) {[unowned self] timer in
        self.triggerBigBang()
      }
    }
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    // enable this if I ever find a good way to stop the phone from lagging to death
    //    if let loc = touches.first?.locationInNode(self) {
    //      lastTouch = loc
    //      gravitySingularity?.position = loc
    //    }
  }

  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    // disable gravity
    removeSingularity()

    // turn off dust generation
    endCreatingDust()

    // stop big bang timer
    bigBangTimer?.invalidate()

    // fade out keep holding regardless
    setTextState(.TapAndHold)

    if bigBangOccurred {
      // if the big bang occured
      setTextState(.BigBanged)

    }
  }
}


protocol CreateUniverseDelegate {
  func didFinishCreatingUniverse()
}

































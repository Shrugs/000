//
//  BlackHole.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

let blackHoleRadius : CGFloat = 40
let singularityRadius : CGFloat = 15

class BlackHole: SKNode {

  let animatedTextureAtlas = SKTextureAtlas(named: "benny")
  var idleFrames = [SKTexture]()

  lazy var innerSingularity : SKSpriteNode = { [unowned self] in

    let innerSize = CGSize(width: singularityRadius * 2, height: singularityRadius * 2)

    let innerSingularity = SKSpriteNode(texture: SKTexture(imageNamed: "benny1"), color: UIColor.blackColor(), size: innerSize)
    innerSingularity.physicsBody = SKPhysicsBody(circleOfRadius: singularityRadius)
    innerSingularity.physicsBody?.affectedByGravity = false
    innerSingularity.physicsBody?.dynamic = false
    innerSingularity.physicsBody?.categoryBitMask = Constant.SpriteMasks.BlackHoleSingularity
    innerSingularity.physicsBody?.collisionBitMask = 0

    for texture in self.animatedTextureAtlas.textureNames {
      self.idleFrames.append(self.animatedTextureAtlas.textureNamed(texture))
    }

    innerSingularity.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self.idleFrames, timePerFrame: 0.5)))
    return innerSingularity
  }()

  lazy var eventHorizon : SKShapeNode = { [unowned self] in
    let eventHorizon = SKShapeNode(circleOfRadius: blackHoleRadius)
    eventHorizon.fillColor = .blackColor()
    eventHorizon.strokeColor = .whiteColor()
    eventHorizon.glowWidth = 0.5
    return eventHorizon
  }()

  var gravityField : SKFieldNode = {
    let gravityField = SKFieldNode.radialGravityField()
    gravityField.strength = 0.0
    gravityField.categoryBitMask = Constant.FieldMasks.BlackHoleField
    return gravityField
  }()

  override init() {
    super.init()

    name = Constant.SpriteKeys.BlackHole

    physicsBody = SKPhysicsBody(circleOfRadius: blackHoleRadius)
    physicsBody?.categoryBitMask = Constant.SpriteMasks.BlackHole
    physicsBody?.affectedByGravity = false
    physicsBody?.dynamic = false

    addChild(eventHorizon)
    addChild(innerSingularity)
    addChild(gravityField)
  }

  func startGravity() {
    gravityField.strength = 0.3
  }

  func endGravity() {
    gravityField.strength = 0.0
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}































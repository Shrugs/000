//
//  ShatterParticle.swift
//  #000
//
//  Created by Matt Condon on 4/30/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

let shatterSize = CGSize(width: 4, height: 4)

class ShatterPiece: SKSpriteNode {

  var centerOffset : CGPoint!
  var isShown = false

  convenience init(texture: SKTexture?, centerOffset: CGPoint) {
    self.init(texture: texture, color: UIColor.whiteColor(), size: shatterSize)

    self.centerOffset = centerOffset

    name = Constant.SpriteKeys.ShatterPiece

    position = centerOffset

    physicsBody = SKPhysicsBody(circleOfRadius: 4)
    physicsBody?.categoryBitMask = Constant.SpriteMasks.ShatterPiece
    physicsBody?.collisionBitMask = 0
    physicsBody?.contactTestBitMask = Constant.SpriteMasks.BlackHole | Constant.SpriteMasks.BlackHoleSingularity
    physicsBody?.fieldBitMask = Constant.FieldMasks.BlackHoleField
  }
}

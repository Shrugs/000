//
//  SKScene+StarField.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

extension SKScene {
  func newStarField(color color: SKColor, speed : CGFloat, starsPerSecond: CGFloat, scale: CGFloat, filled: Bool = true) -> SKEmitterNode {
    // Determine the time a star is visible on screen
    let lifetime = frame.size.height * UIScreen.mainScreen().scale / speed

    // Create the emitter node
    let emitterNode = SKEmitterNode()
    emitterNode.particleTexture = SKTexture(imageNamed: "star")
    emitterNode.particleBirthRate = starsPerSecond
    emitterNode.particleColor = color
    emitterNode.particleSpeed = speed * -1
    emitterNode.particleScale = scale
    emitterNode.particleColorBlendFactor = 1
    emitterNode.particleLifetime = lifetime

    // Position in the middle at top of the screen
    emitterNode.position = CGPoint(x: frame.size.width/2, y: frame.size.height)
    emitterNode.particlePositionRange = CGVector(dx: frame.size.width, dy: 0)

    if filled {
      // Fast forward the effect to start with a filled screen
      emitterNode.advanceSimulationTime(NSTimeInterval(lifetime))
    }

    return emitterNode
  }
}


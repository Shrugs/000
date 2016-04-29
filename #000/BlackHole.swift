//
//  BlackHole.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

class BlackHole: SKSpriteNode {

  let animatedTextureAtlas = SKTextureAtlas(named: "benny")
  var idleFrames = [SKTexture]()

  init() {
    let texture = SKTexture(imageNamed: "benny1")
    super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    for texture in animatedTextureAtlas.textureNames {
      idleFrames.append(animatedTextureAtlas.textureNamed(texture))
    }

    runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(idleFrames, timePerFrame: 0.5)))
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}


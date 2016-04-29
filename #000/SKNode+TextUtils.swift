//
//  SKNode+TextUtils.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

//
//  TextUtils.swift
//  spritekittest
//
//  Created by Matt Condon on 4/26/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

let FADE_IN = "fadeIn"
let FADE_OUT = "fadeOut"

func generalTextNode(text: String) -> SKLabelNode {
  let node = SKLabelNode(fontNamed: "AvenirNext-UltraLight")
  node.text = text
  node.fontSize = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 22 : 30
  node.fontColor = .whiteColor()
  node.verticalAlignmentMode = .Center
  node.horizontalAlignmentMode = .Center
  return node
}

extension SKNode {

  func setPos(to position: CGPoint) -> SKNode {
    self.position = position
    return self
  }

  // MARK: Fade In

  func fadeIn(duration: NSTimeInterval, completion: (() -> Void)?) -> SKNode {
    // remove all fadeIn and fadeOut actions
    if self.actionForKey(FADE_IN) != nil || self.actionForKey(FADE_OUT) != nil {
      self.removeActionForKey(FADE_IN)
      self.removeActionForKey(FADE_OUT)
    } else {
      self.alpha = 0
    }

    self.runAction(SKAction.fadeInWithDuration(duration), withKey: FADE_IN, completion: completion)

    return self
  }

  func fadeIn(duration: NSTimeInterval = 1) -> SKNode {
    return fadeIn(duration, completion: nil)
  }

  func fadeInAfter(after: NSTimeInterval = 1, duration: NSTimeInterval = 1) -> SKNode {
    self.alpha = 0
    self.removeActionForKey(FADE_IN)
    self.removeActionForKey(FADE_OUT)

    self.runAction(SKAction.sequence([
      SKAction.waitForDuration(after),
      SKAction.fadeInWithDuration(duration)
    ]), withKey: FADE_IN)
    return self
  }

  // MARK: Fade Out

  func fadeOut(duration: NSTimeInterval, completion: (() -> Void)?) -> SKNode {
    self.removeActionForKey(FADE_IN)
    self.removeActionForKey(FADE_OUT)

    self.runAction(SKAction.fadeOutWithDuration(duration), withKey: FADE_OUT, completion: completion)

    return self
  }

  func fadeOut(duration: NSTimeInterval = 1) -> SKNode {
    return self.fadeOut(duration, completion: nil)
  }

  // MARK: Utils

  func runAction(action: SKAction!, withKey: String!, completion: (() -> Void)?)
  {
    if let completion = completion {
      let completionAction = SKAction.runBlock(completion)
      let compositeAction = SKAction.sequence([action, completionAction])
      runAction(compositeAction, withKey: withKey)
    } else {
      runAction(action, withKey: withKey)
    }
  }

}
































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
  let node = SKLabelNode(fontNamed: Constant.GenericText.Font.Name)
  node.text = text
  node.fontSize = Constant.GenericText.Font.Size
  node.fontColor = Constant.GenericText.Font.Color
  node.verticalAlignmentMode = .Center
  node.horizontalAlignmentMode = .Center
  return node
}

func multipleLineText(labelInPut: SKLabelNode) -> SKNode {
  let subStrings:[String] = labelInPut.text!.componentsSeparatedByString("\n")
  let labelOutPut = SKNode()

  for (i, subString) in subStrings.enumerate() {
    let label = SKLabelNode(fontNamed: labelInPut.fontName)
    label.text = subString
    label.fontColor = labelInPut.fontColor
    label.fontSize = labelInPut.fontSize
    label.position = labelInPut.position
    label.horizontalAlignmentMode = labelInPut.horizontalAlignmentMode
    label.verticalAlignmentMode = labelInPut.verticalAlignmentMode

    let y = CGFloat(i) * labelInPut.fontSize // 0, 22, 44, 66
    label.position = CGPoint(x: 0, y: -y)
    labelOutPut.addChild(label)
  }

  return labelOutPut
}

extension SKLabelNode {
  func setFont(to fontName: String) -> SKLabelNode {
    self.fontName = fontName
    return self
  }

  func toMultilineNode() -> SKNode {
    return multipleLineText(self)
  }
}

extension SKNode {

  func setPos(to position: CGPoint) -> SKNode {
    self.position = position
    return self
  }

  func addTo(node: SKNode) -> SKNode {
    node.addChild(self)
    return self
  }

  // MARK: Fade In

  func fadeIn(duration: NSTimeInterval, completion: (() -> Void)?) -> SKNode {
    // remove all fadeIn and fadeOut actions
    if self.actionForKey(FADE_IN) != nil {
      self.removeActionForKey(FADE_IN)
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

    self.runAction(SKAction.sequence([
      SKAction.waitForDuration(after),
      SKAction.fadeInWithDuration(duration)
    ]), withKey: FADE_IN)
    return self
  }

  // MARK: Fade Out

  func fadeOut(duration: NSTimeInterval, completion: (() -> Void)?) -> SKNode {
    self.removeActionForKey(FADE_OUT)

    self.runAction(SKAction.fadeOutWithDuration(duration), withKey: FADE_OUT, completion: completion)

    return self
  }

  func fadeOut(duration: NSTimeInterval = 1) -> SKNode {
    return self.fadeOut(duration, completion: nil)
  }

  func fadeOutAfter(after: NSTimeInterval = 1, duration: NSTimeInterval = 1, completion: (() -> Void)? = nil) -> SKNode {
    self.removeActionForKey(FADE_OUT)

    self.runAction(SKAction.sequence([
      SKAction.waitForDuration(after),
      SKAction.fadeOutWithDuration(duration)
      ]), withKey: FADE_OUT, completion: completion)
    return self
  }

  func fadeOutAndRemoveAfter(after: NSTimeInterval = 1, duration: NSTimeInterval = 1, completion: (() -> Void)? = nil) -> SKNode {
    self.removeActionForKey(FADE_OUT)

    self.runAction(SKAction.sequence([
      SKAction.waitForDuration(after),
      SKAction.fadeOutWithDuration(duration),
      SKAction.removeFromParent()
      ]), withKey: FADE_OUT, completion: completion)
    return self
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
































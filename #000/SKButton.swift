//
//  SKButton.swift
//  #000
//
//  Created by Matt Condon on 5/1/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit

typealias OnTapHandler = (SKButton) -> Void

class SKButton : SKLabelNode {

  var onTap : OnTapHandler?

  init(text: String, onTap: OnTapHandler) {
    super.init()
    self.text = text
    self.onTap = onTap

    self.fontName = Constant.GenericText.Font.Name
    self.fontSize = Constant.GenericText.Font.Size
    self.fontColor = Constant.GenericText.Font.Color

    self.verticalAlignmentMode = .Center
    self.horizontalAlignmentMode = .Center

    self.userInteractionEnabled = true
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.onTap?(self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

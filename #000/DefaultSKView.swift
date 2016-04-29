//
//  DefaultSKView.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import SpriteKit

class DefaultSKView: SKView {

  convenience init() {
    self.init(frame: CGRect.null)

    #if DEBUG
      showsFPS = true
      showsNodeCount = true
      showsPhysics = true
    #endif
  }
  
}


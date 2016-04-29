//
//  Constants.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import HEXColor

struct Constant {
  struct Color {
    static var SpaceBackground = UIColor(rgba: "#262626")
    static var DustColor = UIColor.whiteColor()
  }
  struct SpriteKeys {
    static var DustParticle = "dust_particle"
  }
  struct StateKeys {
    struct CreateUniverse {
      enum TextState {
        case TapAndHold
        case KeepHolding
      }
    }
  }
}

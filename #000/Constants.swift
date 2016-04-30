//
//  Constants.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import HEXColor
import CoreGraphics

struct Constant {
  static var DefaultBlackHoleName = "Benji"

  struct GenericText {
    struct Font {
      static var Size : CGFloat = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 22 : 30
      static var Name = "AvenirNext-UltraLight"
      static var Color = UIColor.whiteColor()
    }
  }

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
        case BigBanged
      }
    }
  }

  struct MapGenerator {
    static var MapSize = CGSize(width: 256, height: 256)
    static var DefaultColorScheme = [
      Biome.Ocean: UIColor(rgba: "#0DC2FF")
    ]
  }

}

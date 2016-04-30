//
//  GeneralState.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import Foundation

class GeneralState {
  static var hasCreatedUniverse : Bool {
    get {
      return NSUserDefaults.standardUserDefaults().objectForKey("hasCreatedUniverse")?.boolValue ?? false
    }
    set {
      let defaults = NSUserDefaults.standardUserDefaults()
      defaults.setBool(newValue, forKey: "hasCreatedUniverse")
      defaults.synchronize()
    }
  }

  static var hasIntroducedBlackHole : Bool {
    get {
      return NSUserDefaults.standardUserDefaults().objectForKey("hasIntroducedBlackHole")?.boolValue ?? false
    }
    set {
      let defaults = NSUserDefaults.standardUserDefaults()
      defaults.setBool(newValue, forKey: "hasIntroducedBlackHole")
      defaults.synchronize()
    }
  }
}

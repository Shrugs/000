//
//  Debug.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import Foundation

struct Debug {
  static func reset() {
    let defaults = NSUserDefaults.standardUserDefaults()
    for key in defaults.dictionaryRepresentation().keys {
      defaults.removeObjectForKey(key)
    }
    defaults.synchronize()

    try! DefaultRealm.write {
      DefaultRealm.deleteAll()
    }
  }
}
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
    let url = DefaultRealm.configuration.fileURL!
    if NSFileManager.defaultManager().fileExistsAtPath(url.path!) {
      try! NSFileManager.defaultManager().removeItemAtURL(url)
    }
  }
}
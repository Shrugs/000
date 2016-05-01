//
//  DocumentsDirectory.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import Foundation

var DocumentsDirectory : NSString = {
  let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
  return paths.first!
}()

var BundleDirectory : NSBundle = {
  return NSBundle.mainBundle()
}()
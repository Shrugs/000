//
//  String+Random.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import Foundation

extension String {
  static func random(len : Int = 10) -> String {

    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    let randomString : NSMutableString = NSMutableString(capacity: len)

    for _ in 0 ..< len {
      let length = UInt32(letters.length)
      let rand = arc4random_uniform(length)
      randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString as String
  }
}
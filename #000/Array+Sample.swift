//
//  Array+Sample.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import Foundation

extension Array {
  func sample() -> Element {
    // select a single random instance
    return self[Int( arc4random_uniform(UInt32(count)) )]
  }
}
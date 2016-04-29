//
//  GlobalHelpers.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import Foundation

func randomDouble(from: Double, to: Double) -> Double {
  return from + Double(arc4random()) % (to - from);
}

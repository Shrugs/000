//
//  Map.swift
//  planetgentest
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import CoreGraphics

struct MapTile {
  var biome : Biome = .None

}

struct Map {
  var tiles : [MapTile?]
  var size : CGSize

  init(size: CGSize) {
    self.size = size
    self.tiles = [MapTile?](count: Int(size.width) * Int(size.height), repeatedValue: nil)
  }
}
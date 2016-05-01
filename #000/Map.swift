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
  var colorScheme : ColorScheme = ColorSchemes[Constant.MapGenerator.DefaultColorSchemeIndex]
  var tiles : [MapTile?]
  var size : CGSize

  init(size: CGSize) {
    self.size = size
    self.tiles = [MapTile?](count: Int(size.width) * Int(size.height), repeatedValue: nil)
  }

  func tileToPixelData(tile: MapTile) -> PixelData {
    // map from the biome to the correct color
    return colorScheme[tile.biome]!.pixelData
  }

  func toImage() -> UIImage {
    // convert MapTile to PixelData
    return PixelDrawer.imageFromARGB32Bitmap(tiles.map { tile in

      guard let tile = tile else { return PixelData(a: 0, r: 0, g: 0, b: 0) }

      return tileToPixelData(tile)

      }, width: Int(size.width), height: Int(size.height))
  }
}
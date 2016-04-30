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
  var colorScheme : ColorScheme = Constant.MapGenerator.DefaultColorScheme
  var tiles : [MapTile?]
  var size : CGSize

  init(size: CGSize) {
    self.size = size
    self.tiles = [MapTile?](count: Int(size.width) * Int(size.height), repeatedValue: nil)
  }

  func tileToPixelData(tile: MapTile) -> PixelData {
    // map from the biome to the correct color
    switch tile.biome {
    case .Ocean:
      return PixelData(a: 255, r: 0, g: 0, b: 255)
    case .Beach:
      return PixelData(a: 255, r: 214, g: 187, b: 150)
    case .Grassland:
      return PixelData(a: 255, r: 176, g: 250, b: 147)
    case .Forest: fallthrough
    case .RainForest:
      return PixelData(a: 255, r: 10, g: 209, b: 27)
    case .Jungle: fallthrough
    case .Savannah: fallthrough
    case .TemperateDesert: fallthrough
    case .Shrubland: fallthrough
    case .Scorched: fallthrough
    case .Bare:
      return PixelData(a: 255, r: 255, g: 0, b: 0)
    case .Taiga: fallthrough
    case .Tundra: fallthrough
    case .Snow:
      return PixelData(a: 255, r: 255, g: 255, b: 255)
    default:
      return PixelData(a: 0, r: 0, g: 0, b: 0)
    }
  }

  func toImage() -> UIImage {
    // convert MapTile to PixelData
    return PixelDrawer.imageFromARGB32Bitmap(tiles.map { tile in

      guard let tile = tile else { return PixelData(a: 0, r: 0, g: 0, b: 0) }

      return tileToPixelData(tile)

      }, width: Int(size.width), height: Int(size.height))
  }
}
//
//  PlanetGenerator.swift
//  planetgentest
//
//  Created by Matt Condon on 4/27/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import CoreGraphics


class MapGenerator {
  // size of the map
  let size: CGSize
  let perlinGenerator = PerlinGenerator()

  init(size: CGSize) {
    self.size = size
  }

  func computeMap(heightMap: Field) -> Map {
    // given a height map and a humidity map, create a Map with a set of MapTiles
    // indicating biomes

    let height = Int(heightMap.size.height)
    let width = Int(heightMap.size.width)

    var map = Map(size: heightMap.size)

    for i in 0 ..< height {
      for j in 0 ..< width {
        let index = i * width + j

        let elevation = heightMap.data[index]
        let humidity : Float = 1.0 // humidityMap.data[index]

        map.tiles[index] = tileFor(elevation: elevation, humidity: humidity)
      }
    }

    return map
  }

  func tileFor(elevation elevation: Float, humidity: Float) -> MapTile {
    return MapTile(biome: biomeFor(elevation: elevation, humidity: humidity))
  }

  func biomeFor(elevation elevation: Float, humidity: Float) -> Biome {
    if elevation < 0.2 { return .Ocean }
    if elevation < 0.22 { return .Beach }

    if elevation > 0.8 {
      switch humidity {
      case let h where h < 0.1:  return .Scorched
      case let h where h < 0.2:  return .Bare
      case let h where h < 0.5:  return .Tundra
      default:                   return .Snow
      }
    }

    if elevation > 0.6 {
      switch humidity {
      case let h where h < 0.33: return .TemperateDesert
      case let h where h < 0.66: return .Shrubland
      default:                   return .Taiga
      }
    }

    if elevation > 0.3 {
      switch humidity {
      case let h where h < 0.16:  return .TemperateDesert
      case let h where h < 0.50:  return .Grassland
      case let h where h < 0.83:  return .Forest
      default:                    return .RainForest
      }
    }

    // now elevation is between 0.22 and 0.3
    switch humidity {
    case let h where h < 0.16:    return .TemperateDesert
    case let h where h < 0.33:    return .Grassland
    case let h where h < 0.66:    return .Forest
    default:                      return .RainForest
    }
  }

}





























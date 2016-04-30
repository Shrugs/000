//
//  CivilizationGenerator.swift
//  planetgentest
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit

class CivilizationGenerator {

  let civType : Double
  let colorScheme : ColorScheme
  let zoom : Float
  let persistence : Float

  init(civType: Double, colorScheme: ColorScheme, zoom: Double, persistence: Double) {
    self.civType = civType
    self.colorScheme = colorScheme
    self.zoom = Float(zoom)
    self.persistence = Float(persistence)
  }

  func generate() -> Civilization {

    let civ = Civilization()
    civ.name = "Earth"
    civ.dominantSpecies = "Homo Sapien"
    civ.population = "7.125 Billion"
    civ.civilizationType = self.civType
    civ.mostRecentInvention = "Soylent"
    civ.almostInvented = "Sustainable Fusion Reactors; just 10 more years to go!"
    civ.size = randomDouble(25, to: 256)

    // now generate map and store URL

    // 1) Generate a HeightMap using the passed-in values
    let fieldGenerator = PerlinGenerator()
    fieldGenerator.octaves = 3
    fieldGenerator.zoom = self.zoom
    fieldGenerator.persistence = self.persistence

    let heightMap = fieldGenerator.field(ofSize: Constant.MapGenerator.MapSize)

    // 2) Generate a Map object
    let mapGenerator = MapGenerator(size: Constant.MapGenerator.MapSize)
    var map = mapGenerator.computeMap(heightMap)

    // 3) Assign Map a Color Scheme
    map.colorScheme = self.colorScheme

    // 4) Render Map to an UIImage using that ColorScheme
    let mapImg = map.toImage()

    // 5) Save that UIImage to Disk
    if let data = UIImagePNGRepresentation(mapImg) {
      let filename = DocumentsDirectory.stringByAppendingPathComponent(String.random(10))
      data.writeToFile(filename, atomically: true)
      civ.mapUrl = filename
    }

    // 6) Save that Civilization to Realm
//    try! DefaultRealm.write {
//      DefaultRealm.add(civ)
//    }

    return civ
  }
}
































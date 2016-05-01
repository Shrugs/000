//
//  CivilizationGenerator.swift
//  planetgentest
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit

class CivilizationGenerator {

  static func generateDefaultPlanets() {

    // generates all of the planets and saves them to a Realm database
    let earth = CivilizationGenerator(civType: 0.7125, colorSchemeIndex: 0, zoom: 2.0, persistence: 1.0)
      .generate(
        name: "Earth",
        species: "Humans",
        population: "7.125 Billion",
        mostRecentInvention: "invented the hoverboard. You saved them from themselves.",
        almostInvented: "invented sustainable fusion reactors. They were only 10 years away, nice!",
        size: 25
    )

//    let alderaan = CivilizationGenerator(civType: 1.25, colorSchemeIndex: 0, zoom: 3, persistence: 0.2)
//      .generate(
//        name: "Balderan",
//        species: "Humans",
//        population: "8.2 Billion",
//        mostRecentInvention: "discovered the concept of Socialism and free education. Good for them!",
//        almostInvented: "invented anti Death Star weapons systems.",
//        size: 45
//    )
//
//    let arrakis = CivilizationGenerator(civType: 0.3, colorSchemeIndex: 3, zoom: 7, persistence: 0.01)
//      .generate(
//        name: "Jarakis",
//        species: "Freemen",
//        population: "200,000",
//        mostRecentInvention: "discovered some sort of cayenne pepper equivalent. Sounds delicous.",
//        almostInvented: "perfected terraforming techology. Doesn't sound that terra-able.",
//        size: 30
//    )
//
//    let cybertron = CivilizationGenerator(civType: 0.3, colorSchemeIndex: 4, zoom: 1.0, persistence: 1.0)
//      .generate(
//        name: "Anoltron",
//        species: "Anoltronians",
//        population: "43.3 Billion",
//        mostRecentInvention: "created some badass dinosaur robots. Hell yeah.",
//        almostInvented: "guaranteed peace and happiness between worlds.",
//        size: 50
//    )
//
//    let lifeline = CivilizationGenerator(civType: 0.0, colorSchemeIndex: 3, zoom: 7, persistence: 0.01)
//      .generate(
//        name: "Unknown",
//        species: "Humans (?)",
//        population: "2 (?)",
//        mostRecentInvention: "invented a MacGyver'd compass to replace the one on Taylor's suit. Sounds pretty useful.",
//        almostInvented: "discovered a timeline where nobody's possessed by creepy green alien things.",
//        size: 20
//    )
//
//    let krypton = CivilizationGenerator(civType: 2.0, colorSchemeIndex: 1, zoom: 2.0, persistence: 1.0)
//      .generate(
//        name: "Xenon",
//        species: "Xenonites",
//        population: "12.8 Billion",
//        mostRecentInvention: "invented baby sized spaceships. Doesn't sound particularly useful, but what do we know?",
//        almostInvented: "figured out how to stop suns from going supernova. ¯\\_(ツ)_/¯",
//        size: 30
//    )
//
//    let aincrad = CivilizationGenerator(civType: 0.1, colorSchemeIndex: 5, zoom: 1.0, persistence: 0.1)
//      .generate(
//        name: "Incrad",
//        species: "Humans",
//        population: "10,000",
//        mostRecentInvention: "discovered the concept of holding two weapons at the same time.",
//        almostInvented: "figured out how to log out.",
//        size: 50
//    )
//
//    let gallifrey = CivilizationGenerator(civType: 0.1, colorSchemeIndex: 5, zoom: 1.0, persistence: 0.1)
//      .generate(
//        name: "Zallifreid",
//        species: "Zallifreidans",
//        population: "325 to 20 Billion",
//        mostRecentInvention: "invented time travel.",
//        almostInvented: "invented cataclysm preventative measures.",
//        size: 27
//    )
//
//    let disboard = CivilizationGenerator(civType: 0.1, colorSchemeIndex: 6, zoom: 3, persistence: 0.5)
//      .generate(
//        name: "Thizboard",
//        species: "The Exceed",
//        population: "750 Million",
//        mostRecentInvention: "have been having fun and playing together.",
//        almostInvented: "united all of the races.",
//        size: 27
//    )
//
//    let lv462 = CivilizationGenerator(civType: 0.5, colorSchemeIndex: 7, zoom: 1, persistence: 0.01)
//      .generate(
//        name: "KU 315",
//        species: "Humans (?)",
//        population: "18",
//        mostRecentInvention: "have been trying to get engineers to fix their problems.",
//        almostInvented: "figured out how to run slightly to the left.",
//        size: 27
//    )
//
//    let pandora = CivilizationGenerator(civType: 0.5, colorSchemeIndex: 1, zoom: 1, persistence: 0.01)
//      .generate(
//        name: "Mavdora",
//        species: "Mavi",
//        population: "300,000",
//        mostRecentInvention: "have been dealing with an invasive species impersonating their own.",
//        almostInvented: "obtained the unobtainable.",
//        size: 20
//    )

    // Tatooine from Star Wars
    // Hoth from Star Wars
    // Barsoom from John Carter of Barsoom


    try! DefaultRealm.write {
      DefaultRealm.deleteAll()
      [
        earth,
//        alderaan,
//        arrakis,
//        cybertron,
//        lifeline,
//        krypton,
//        aincrad,
//        gallifrey,
//        disboard,
//        lv462,
//        pandora
      ].forEach { civ in
        DefaultRealm.add(civ)
      }
    }


  }

  let civType : Double
  let colorSchemeIndex : Int
  let zoom : Float
  let persistence : Float

  init(civType: Double?, colorSchemeIndex: Int?, zoom: Double?, persistence: Double?) {
    self.civType = civType                   ?? randomDouble(0, to: 2.0)
    self.colorSchemeIndex = colorSchemeIndex ?? Int(arc4random_uniform(UInt32(ColorSchemes.count)))
    self.zoom = Float(zoom                   ?? randomDouble(1, to: 7))
    self.persistence = Float(persistence     ?? randomDouble(0.01, to: 1.0))
  }

  func generate(name name: String, species: String, population: String, mostRecentInvention: String, almostInvented: String, size: Double) -> Civilization {

    let civ = Civilization()
    civ.name = name
    civ.dominantSpecies = species
    civ.population = population
    civ.civilizationType = self.civType
    civ.mostRecentInvention = mostRecentInvention
    civ.almostInvented = almostInvented
    civ.size = 75 // [25 -> 50]
    civ.colorSchemeIndex = self.colorSchemeIndex

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
    map.colorScheme = ColorSchemes[self.colorSchemeIndex]

    // 4) Render Map to an UIImage using that ColorScheme
    let mapImg = map.toImage()

    // 5) Save that UIImage to Disk
    if let data = UIImagePNGRepresentation(mapImg) {
      let imgName = "\(civ.name).png"
      let filename = DocumentsDirectory.stringByAppendingPathComponent(imgName)
      data.writeToFile(filename, atomically: true)
      civ.mapUrl = imgName
    }

    return civ
  }
}
































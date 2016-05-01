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
        mostRecentInvention: "invented the hoverboard.",
        almostInvented: "invented sustainable\nfusion reactors.",
        size: 25
    )

    let alderaan = CivilizationGenerator(civType: 1.25, colorSchemeIndex: 0, zoom: 3, persistence: 0.2)
      .generate(
        name: "Balderan",
        species: "Humans",
        population: "8.2 Billion",
        mostRecentInvention: "discovered the concept\nof Socialism and\nfree education.",
        almostInvented: "invented anti Death Star\nweapons systems.",
        size: 45
    )

    let arrakis = CivilizationGenerator(civType: 0.3, colorSchemeIndex: 3, zoom: 3, persistence: 0.01)
      .generate(
        name: "Jarakis",
        species: "Freemen",
        population: "215,729",
        mostRecentInvention: "discovered some sort\nof cayenne pepper equivalent.\nSounds delicous.",
        almostInvented: "perfected terraforming techology.",
        size: 30
    )

    let cybertron = CivilizationGenerator(civType: 0.3, colorSchemeIndex: 4, zoom: 1.0, persistence: 1.0)
      .generate(
        name: "Anoltron",
        species: "Anoltronians",
        population: "43.3 Billion",
        mostRecentInvention: "created some dinosaur robots\nto ride into battle.",
        almostInvented: "guaranteed peace and\nhappiness between worlds.",
        size: 50
    )

    let lifeline = CivilizationGenerator(civType: 0.0, colorSchemeIndex: 3, zoom: 7, persistence: 0.01)
      .generate(
        name: "Unknown",
        species: "Humans (?)",
        population: "2 (?)",
        mostRecentInvention: "MacGyver'd a compass to\nreplace the one on\nTaylor's suit.",
        almostInvented: "discovered a timeline where\nnobody's possessed by creepy\ngreen alien things.",
        size: 20
    )

    let krypton = CivilizationGenerator(civType: 2.0, colorSchemeIndex: 1, zoom: 2.0, persistence: 1.0)
      .generate(
        name: "Xenon",
        species: "Xenonites",
        population: "12.8 Billion",
        mostRecentInvention: "invented baby-sized spaceships.\nDoesn't sound particularly useful,\nbut what do we know?",
        almostInvented: "figured out how to stop\nsuns from going supernova.\n¯\\_(ツ)_/¯",
        size: 30
    )

    let aincrad = CivilizationGenerator(civType: 0.1, colorSchemeIndex: 5, zoom: 5.0, persistence: 0.2)
      .generate(
        name: "Incrad",
        species: "Humans",
        population: "10,000",
        mostRecentInvention: "discovered the concept of\nholding two weapons\nat the same time.",
        almostInvented: "figured out how to log out.",
        size: 50
    )

    let gallifrey = CivilizationGenerator(civType: 0.1, colorSchemeIndex: 7, zoom: 1.0, persistence: 0.1)
      .generate(
        name: "Zallifreid",
        species: "Zallifreidans",
        population: "20.2 Billion",
        mostRecentInvention: "invented time travel.",
        almostInvented: "invented cataclysm\npreventative measures.",
        size: 27
    )

    let disboard = CivilizationGenerator(civType: 0.1, colorSchemeIndex: 6, zoom: 3, persistence: 0.5)
      .generate(
        name: "Thisboard",
        species: "Exceed",
        population: "750 Million",
        mostRecentInvention: "have been having fun\nand playing together.",
        almostInvented: "united all of the races.",
        size: 27
    )
//
    let lv462 = CivilizationGenerator(civType: 0.5, colorSchemeIndex: 7, zoom: 1, persistence: 0.01)
      .generate(
        name: "KU 315",
        species: "Humans (?)",
        population: "18",
        mostRecentInvention: "have been trying to\nget engineers to fix their problems.",
        almostInvented: "figured out how to\nrun slightly to the left.",
        size: 27
    )
//
    let pandora = CivilizationGenerator(civType: 0.5, colorSchemeIndex: 1, zoom: 1, persistence: 0.01)
      .generate(
        name: "Mavdora",
        species: "Mavi",
        population: "300,415",
        mostRecentInvention: "have been dealing with an\ninvasive species impersonating\ntheir own.",
        almostInvented: "obtained the unobtainable.",
        size: 20
    )

    // Tatooine from Star Wars
    // Hoth from Star Wars
    // Barsoom from John Carter of Barsoom


    try! DefaultRealm.write {
      DefaultRealm.deleteAll()
      [
        earth,
        alderaan,
        arrakis,
        cybertron,
        lifeline,
        krypton,
        aincrad,
        gallifrey,
        disboard,
        lv462,
        pandora
      ].forEach { civ in
        DefaultRealm.add(civ)
      }
    }

    try! DefaultRealm.writeCopyToURL(NSURL(fileURLWithPath: DocumentsDirectory.stringByAppendingPathComponent("copy.realm")))

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
































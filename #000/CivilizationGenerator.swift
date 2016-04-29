//
//  CivilizationGenerator.swift
//  planetgentest
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

class CivilizationGenerator {
  let technologyLevel : Double
  let colorScheme : ColorScheme
  let zoom : Double
  let persistence : Double

  init(technologyLevel: Double, colorScheme: ColorScheme, zoom: Double, persistence: Double) {
    self.technologyLevel = technologyLevel
    self.colorScheme = colorScheme
    self.zoom = zoom
    self.persistence = persistence
  }

  func generate() {
    // generates a fake name
    // generate a fake dominate species
    // generate civilization type based on technology level
    // generate accomplishments based on technology level
    // generate population based on technology level
    // generate map UIImage and save to disk

  }
}

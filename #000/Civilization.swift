//
//  Civilization.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

// stores info related to civilizations in Realm

import Foundation
import RealmSwift

class Civilization : Object {

  dynamic var name : String = ""
  dynamic var dominantSpecies : String = ""
  dynamic var population : String = ""
  dynamic var mapUrl : String = ""
  dynamic var technologyLevel : Double = 0
  dynamic var civilizationType : Double = 0
  dynamic var mostRecentInvention : String = ""
  dynamic var almostInvented : String = ""
  dynamic var size : Double = 0
  dynamic var colorSchemeIndex : Int = 0

  dynamic var consumedAt : NSDate? = nil

//  var energyConsumption : Double {
//    get {
//      // https://en.wikipedia.org/wiki/Kardashev_scale
//      return pow(10, 10 * civilizationType) + 6
//    }
//  }

  override static func primaryKey() -> String? {
    return "name"
  }

}

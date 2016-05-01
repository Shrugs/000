
//  DefaultRealm.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import RealmSwift

let DefaultRealm : Realm = {

  var config = Realm.Configuration()
  config.schemaVersion = 3
  config.migrationBlock = { migration, oldSchemaVersion in
  }

  Realm.Configuration.defaultConfiguration = config

  print("Realm resides at:")
  print(config.fileURL)
  print()

  return try! Realm()
}()

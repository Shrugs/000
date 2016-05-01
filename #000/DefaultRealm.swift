
//  DefaultRealm.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import RealmSwift
import Foundation

let DefaultRealm : Realm = {

  let realmPath = DocumentsDirectory.stringByAppendingPathComponent("default.realm")

  if !NSFileManager.defaultManager().fileExistsAtPath(realmPath) {
    let bundleRealm = BundleDirectory.pathForResource("default", ofType: "realm")!
    try! NSFileManager.defaultManager().copyItemAtPath(bundleRealm, toPath: realmPath)
  }

  var config = Realm.Configuration()
  config.fileURL = NSURL(fileURLWithPath: realmPath)
  config.schemaVersion = 3
  config.migrationBlock = { migration, oldSchemaVersion in
  }

  Realm.Configuration.defaultConfiguration = config

  print("Realm resides at:")
  print(config.fileURL)
  print()

  return try! Realm()
}()

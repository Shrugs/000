//
//  PlanetSprite.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

let MASS_OF_PLANET : CGFloat = 20

class PlanetSprite : SK3DNode {
  
  convenience init(withCiv civ: Civilization) {
    self.init(viewportSize: CGSize(width: civ.size, height: civ.size))

    let filename = ((civ.mapUrl as NSString).lastPathComponent as NSString).stringByDeletingPathExtension
    let imageLocation = BundleDirectory.pathForResource(filename, ofType: "png")!
    let planetScene = PlanetScene(withImage: UIImage(contentsOfFile: imageLocation)!)
    scnScene = planetScene
    
    let myCamera = SCNCamera()
    myCamera.xFov = 40
    myCamera.yFov = 40
    let myCameraNode = SCNNode()
    myCameraNode.camera = myCamera
    myCameraNode.position = SCNVector3(x: 0, y: 0, z: 1.5)
    myCameraNode.orientation = SCNQuaternion(x: 0, y: 0, z: 0.5, w: 1)
    pointOfView = myCameraNode

    autoenablesDefaultLighting = true

    physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(civ.size) / 2.0)
    physicsBody?.mass = MASS_OF_PLANET
    physicsBody?.affectedByGravity = false

    physicsBody?.categoryBitMask = Constant.SpriteMasks.Planet
    physicsBody?.collisionBitMask = 0
    physicsBody?.contactTestBitMask = Constant.SpriteMasks.BlackHole
    physicsBody?.fieldBitMask = 0

    zPosition = -2
  }
}

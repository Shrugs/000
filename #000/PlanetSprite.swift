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

class PlanetSprite : SK3DNode {
  convenience init(withCiv civ: Civilization) {
    self.init(viewportSize: CGSize(width: civ.size, height: civ.size))

    let planetScene = PlanetScene(withImage: UIImage(contentsOfFile: civ.mapUrl)!)
    scnScene = planetScene
    
    let myCamera = SCNCamera()
    myCamera.xFov = 40
    myCamera.yFov = 40
    let myCameraNode = SCNNode()
    myCameraNode.camera = myCamera
    myCameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
    myCameraNode.orientation = SCNQuaternion(x: 0, y: 0, z: 0.5, w: 1)
    pointOfView = myCameraNode

    autoenablesDefaultLighting = true
  }
}

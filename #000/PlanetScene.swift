//
//  PlanetScene.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SceneKit

class PlanetScene: SCNScene {

  // given a UIImage, build the rotating

  convenience init(withImage image : UIImage) {
    self.init()

    let ambientLight = SCNLight()
    let ambientLightNode = SCNNode()
    ambientLight.type = SCNLightTypeAmbient
    ambientLight.color = UIColor.whiteColor()
    ambientLightNode.light = ambientLight
    rootNode.addChildNode(ambientLightNode)

    let sphere = SCNSphere(radius: 0.5)
    let material = createWorldMaterial(withDiffuse: image)
    sphere.materials =  [material]

    let sphereNode = SCNNode(geometry: sphere)
    rootNode.addChildNode(sphereNode)

    // @TODO - add some variable rotation around whatever axis that is
    sphereNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: CGFloat(M_PI_2), z: 0, duration: 10)))

  }


  func createWorldMaterial(withDiffuse img: UIImage) -> SCNMaterial {

    CustomFiltersVendor.registerFilters()

    let material = SCNMaterial()
    let context = CIContext()

    let pixelSize = 8

    let newRect = CGRect(
      x: pixelSize,
      y: pixelSize,
      width: Int(img.size.width) - pixelSize * 2,
      height: Int(img.size.height) - pixelSize * 2
    )

    let pixelImg = CIImage(image: img)!
      .imageByApplyingFilter("CIPixellate", withInputParameters: ["inputScale": pixelSize])
      .imageByCroppingToRect(newRect)


    let normalImg = pixelImg
      .imageByApplyingFilter("NormalMap", withInputParameters: nil)
      .imageByApplyingFilter("CIColorControls", withInputParameters: ["inputContrast": 30])

    let cgdiffuseMap = context.createCGImage(pixelImg, fromRect: pixelImg.extent)
    let cgNormalMap = context.createCGImage(normalImg, fromRect: normalImg.extent)

    material.diffuse.contents = cgdiffuseMap
    material.normal.contents = cgNormalMap
    material.normal.intensity = 1.0

    return material
  }

}

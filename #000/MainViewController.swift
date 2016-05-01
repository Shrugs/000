//
//  ViewController.swift
//  #000
//
//  Created by Matt Condon on 4/29/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {

  var skView: SKView!

  let sceneTransition : SKTransition = {
    let transition = SKTransition()
    transition.pausesOutgoingScene = false
    return transition
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    becomeFirstResponder()

    view.backgroundColor = Constant.Color.SpaceBackground

    CivilizationGenerator.generateDefaultPlanets()

    // when the app is started, load the correct view
    self.skView = DefaultSKView()
    self.skView.frame = view.frame
    self.skView.backgroundColor = Constant.Color.SpaceBackground
    view.addSubview(skView)

    self.presentNextScene()

  }

  func presentNextScene() {
    var scene : SKScene?
    if GeneralState.hasCreatedUniverse {
      scene = TamagatchiScene(size: view.frame.size)
    } else {
      let uScene = CreateUniverseScene(size: view.frame.size)
      uScene.universeDelegate = self
      scene = uScene
    }

    if let scene = scene {
      scene.scaleMode = .ResizeFill
      skView.presentScene(scene, transition: sceneTransition)
    } else {
      fatalError("No scene to transition to.")
    }
  }

  override func viewWillDisappear(animated: Bool) {
    resignFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  override func canBecomeFirstResponder() -> Bool {
    return true
  }

  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if motion == .MotionShake {
      Debug.reset()
    }
  }

}


extension MainViewController : CreateUniverseDelegate {
  func didFinishCreatingUniverse() {
    GeneralState.hasCreatedUniverse = true
    self.presentNextScene()
  }
}































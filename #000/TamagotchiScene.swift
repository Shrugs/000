//
//  TomagatchiScene.swift
//  #000
//
//  Created by Matt Condon on 4/27/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import SpriteKit
import UIKit

class TamagatchiScene: SKScene {

  let container = SKNode()
  let blackHole = BlackHole()

  lazy var blackHolePosition : CGPoint = { [unowned self] in
    return CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height * 0.2)
  }()

  lazy var textNodePosition : CGPoint = { [unowned self] in
    return CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height * 0.85)
  }()

  lazy var introduceBlackHoleNode : SKLabelNode = { [unowned self] in
    return generalTextNode("a black hole has formed").setPos(to: self.textNodePosition) as! SKLabelNode
  }()

  lazy var iAmNode : SKLabelNode = { [unowned self] in
    return generalTextNode("i am").setPos(to: self.textNodePosition) as! SKLabelNode
  }()

  lazy var destroyerOfWorldsNode : SKLabelNode = { [unowned self] in
    return generalTextNode("destroyer of worlds")
  }()

  lazy var nameInput : UITextField = { [unowned self] in
    let nameInput = UITextField()
    nameInput.delegate = self
    nameInput.text = Constant.DefaultBlackHoleName
    nameInput.font = UIFont(name: "AvenirNext-Bold", size: Constant.GenericText.Font.Size)
    nameInput.textAlignment = .Center
    nameInput.textColor = Constant.GenericText.Font.Color
    nameInput.keyboardAppearance = .Dark

    return nameInput
  }()

  var nameInputFocusTimer : NSTimer?

  override func didMoveToView(view: SKView) {
    backgroundColor = Constant.Color.SpaceBackground

    // Subscribe to Keyboard Notifications
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TamagatchiScene.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TamagatchiScene.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)

    addChild(container)

    let isFirstRun = GeneralState.hasIntroducedBlackHole

    // Create Star Fields
    container.addChild(newStarField(color: SKColor.darkGrayColor(), speed: 15, starsPerSecond: 1, scale: 0.05, filled: !isFirstRun))
    container.addChild(newStarField(color: SKColor.grayColor(), speed: 20, starsPerSecond: 0.001, scale: 0.08, filled: !isFirstRun))

    blackHole.position = blackHolePosition
    container.addChild(blackHole)

    if isFirstRun {
      GeneralState.hasIntroducedBlackHole = true
      // if it's the first run, introduce the black hole
      self.introduceBlackHoleNode
        .fadeIn()
      self.container.addChild(self.introduceBlackHoleNode)


      self.introduceBlackHoleNode.fadeOutAfter(3.0, duration: 1.0) {
        self.iAmNode.fadeIn()
        self.container.addChild(self.iAmNode)

        self.nameInput.sizeToFit()
        self.nameInput.frame.size.width = view.frame.size.width * 0.7

        let skCenter = CGPointMake(view.frame.size.width/2.0, self.iAmNode.frame.origin.y - self.iAmNode.frame.size.height - 10)
        let vCenter = view.convertPoint(skCenter, toScene: self)

        self.nameInput.center = vCenter
        self.nameInput.alpha = 0

        UIView.animateWithDuration(1.0) {
          self.nameInput.alpha = 1.0
        }

        view.addSubview(self.nameInput)

        self.nameInputFocusTimer = NSTimer.schedule(delay: 3.0) { timer in
          self.nameInput.becomeFirstResponder()
        }
      }
    } else {
      // do some stuff normally

      let earth = CivilizationGenerator(civType: 0.7125, colorScheme: Constant.MapGenerator.DefaultColorScheme, zoom: 2.0, persistence: 1.0).generate()
      let earthNode = PlanetSprite(withCiv: earth)
      earthNode.position = CGPoint(x: view.frame.size.width/2.0, y: view.frame.size.height/2.0)
      container.addChild(earthNode)
    }
  }

  func doneEditingName(name: String) {
    self.nameInput.userInteractionEnabled = false

    let vLoc = CGPoint(x: self.frame.size.width/2.0, y: self.nameInput.center.y + self.nameInput.frame.size.height + 10)
    let skLoc = self.convertPoint(self.view!.convertPoint(vLoc, toScene: self), toNode: container)

    self.destroyerOfWorldsNode
      .setPos(to: skLoc)
      .fadeInAfter(1, duration: 1)
    container.addChild(self.destroyerOfWorldsNode)

    self.iAmNode.fadeOutAfter(3.0, duration: 1) {
      UIView.animateWithDuration(1.0, animations: {
        self.nameInput.alpha = 0.0
      }) { done in
        self.destroyerOfWorldsNode.fadeOut(1.0) {
          self.introduceEarth()
        }
      }
    }
  }

  func introduceEarth() {
    // Earth fuckin D I E S


  }

  func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size else {
      print("wat")
      return
    }

    // move the black hole up
    blackHole.runAction(SKAction.moveTo(CGPoint(x: self.frame.size.width / 2.0, y: keyboardSize.height + 50), duration: 0.15))
  }

  func keyboardWillHide(notification: NSNotification) {
    blackHole.runAction(SKAction.moveTo(blackHolePosition, duration: 0.3))
  }
}


extension TamagatchiScene : UITextFieldDelegate {

  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    nameInputFocusTimer?.invalidate()
    return true
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if let text = textField.text where text.characters.count >= 1 {
      self.nameInput.resignFirstResponder()
      doneEditingName(textField.text ?? Constant.DefaultBlackHoleName)
      return true
    }
    
    return false
  }
}




























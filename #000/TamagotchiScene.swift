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

  lazy var secondTextNodePosition : CGPoint = { [unowned self] in
    return CGPoint(x: self.frame.size.width/2.0, y: self.textNodePosition.y - 50)
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
    nameInput.text = GeneralState.blackHoleName
    nameInput.font = UIFont(name: Constant.GenericText.BoldFont.Name, size: Constant.GenericText.BoldFont.Size)
    nameInput.textAlignment = .Center
    nameInput.textColor = Constant.GenericText.Font.Color
    nameInput.keyboardAppearance = .Dark

    return nameInput
  }()

  var nameInputFocusTimer : NSTimer?

  override func didMoveToView(view: SKView) {
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
    backgroundColor = Constant.Color.SpaceBackground

    // Subscribe to Keyboard Notifications
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TamagatchiScene.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TamagatchiScene.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)

    addChild(container)

    let isFirstRun = !GeneralState.hasIntroducedBlackHole

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

      blackHole.introduceEventHorizon()
      
      introduceEarth()
    }
  }

  func doneEditingName(name: String) {
    GeneralState.blackHoleName = name
    self.nameInput.userInteractionEnabled = false

    let vLoc = CGPoint(x: self.frame.size.width/2.0, y: self.nameInput.center.y + self.nameInput.frame.size.height + 10)
    let skLoc = self.convertPoint(self.view!.convertPoint(vLoc, toScene: self), toNode: container)

    self.destroyerOfWorldsNode
      .setPos(to: skLoc)
      .fadeInAfter(1, duration: 1)
    container.addChild(self.destroyerOfWorldsNode)

    blackHole.introduceEventHorizon()

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

  func showCivilizationStats(civ: Civilization) {

    let config : [[String: String]] = [
      [
        "text": "\(GeneralState.blackHoleName) destroyed",
      ],
      [
        "text": civ.name,
        "font": Constant.GenericText.BoldFont.Name
      ],
      [
        "text": "\(civ.population) \(civ.dominantSpecies)",
      ],
      [
        "text": "They Recently",
        "font": Constant.GenericText.BoldFont.Name
      ],
      [
        "text": "... \(civ.mostRecentInvention)",
      ],
      [
        "text": "They Almost",
        "font": Constant.GenericText.BoldFont.Name
      ],
      [
        "text": "... \(civ.almostInvented)",
      ]
    ]

    let bottomPosition = CGPoint(
      x: self.frame.size.width / 2.0,
      y: (blackHole.position.y - blackHole.frame.size.height / 2.0) / 2.0 - 20
    )

    presentLabels(config) { labels in

      let doneButton = SKButton(text: "nice") { button in
        button.fadeOutAndRemoveAfter(1.0, duration: 0.2)
        self.fadeOutLabels(labels) {
          self.continueDriftingThroughSpace()
        }
      }

      doneButton
        .setPos(to: bottomPosition)
        .addTo(self.container)
        .fadeIn()

    }
    
  }

  func presentLabels(config : [[String: String]], done: (([SKNode]) -> Void)?) -> [SKNode] {
    var nodes = [SKNode]()
    var currentTime : Double = 0
    for (i, c) in config.enumerate() {

      let isTitle = c["font"] != nil

      currentTime = currentTime + (isTitle ? 4 : 2)

      let node = generalTextNode(c["text"]!)
        .setFont(to: c["font"] ?? Constant.GenericText.Font.Name)
        .toMultilineNode()
        .setPos(to: i == 0 ? textNodePosition : positionForNodeAfter(nodes[i-1], isTitle ? 30 : 0))
        .addTo(container)
        .fadeInAfter(currentTime, duration: 1.0)
      nodes.append(node)
    }

    NSTimer.schedule(delay: currentTime) { timer in
      done?(nodes)
    }

    return nodes
  }

  func fadeOutLabels(nodes: [SKNode], done: (() -> Void)?) {
    for (i, n) in nodes.enumerate() {
      n.fadeOutAfter(Double(i), duration: 0.5)
    }

    NSTimer.schedule(delay: Double(nodes.count)) { timer in
      done?()
    }
  }

  func positionForNodeAfter(node: SKNode, _ extraSpace: CGFloat = 0) -> CGPoint {
    let size = node.calculateAccumulatedFrame()
    return CGPoint(x: frame.size.width/2.0, y: node.position.y - size.height - 10 - extraSpace)
  }

  // MARK: Civilization Intros

  func introduceEarth() {
    // Earth fuckin D I E S
    introduceCivilizationByName("Balderan")
  }

  func introduceCivilizationByName( name: String) {
    let results = DefaultRealm.objects(Civilization).filter("name == '\(name)'")
    if results.count == 0 {
      print("No planet called \(name)")
      return
    }
    guard let civ = results.first else { return }
    introduceCivilization(civ)
  }

  func introduceRandomCivilization() {
    // get a random civ from realm
    // create if does not exist
    let allCivs = DefaultRealm.objects(Civilization).filter("consumedAt == nil")
    let totalCivs = allCivs.count
    if totalCivs > 0 {
      let i = Int(arc4random_uniform(UInt32(totalCivs)))
      introduceCivilization(allCivs[i])
    } else {
      displayEndGame()
    }
  }

  func displayEndGame() {
    let information = [
      [
        "text": "Congrats",
        "font": Constant.GenericText.BoldFont.Name
      ],
      [
        "text": "\(GeneralState.blackHoleName) has consumed all of the\nplanets in (this) universe."
      ]
    ]

    presentLabels(information) { labels in
      NSTimer.schedule(delay: 3.0) { timer in
        self.fadeOutLabels(labels) {
          self.continueDriftingThroughSpace()
        }
      }
    }
  }

  func continueDriftingThroughSpace() {
    generalTextNode("\(GeneralState.blackHoleName) continues drifting\nthrough space.")
      .toMultilineNode()
      .setPos(to: self.textNodePosition)
      .addTo(self.container)
      .fadeInAfter(1.0, duration: 1.0)
      .fadeOutAndRemoveAfter(5, duration: 3.0)
  }

  // MARK: Actually Introduce Sprites

  var civilization : Civilization?
  var planet : SKNode?

  enum ConsumptionState {
    case Initial
    case Introduction
    case Freefalling
    case DidComputeShatters
    case Consuming
    case Done
  }

  let thetaStep : Double = 0.2
  let totalTheta : Double = 2 * M_PI
  let radiusStep : Double = 3

  var shatters : [SKNode]?

  var consumptionState : ConsumptionState?
  var prevConsumptionState : ConsumptionState?
  var shakeTimer : NSTimer?

  func setConsumptionState(state: ConsumptionState) {

    if state == .Consuming {
      blackHole.beginConsuming()
      // start shaking until done
      shakeTimer = NSTimer.schedule(repeatInterval: 1.0) { timer in
        self.container.runAction(SKAction.shake(1.0))
      }
    }

    if state == .Done {
      blackHole.endConsuming()
      shakeTimer?.invalidate()
      // show the stats for the civilization
      // fade out any extra shatters
      container.enumerateChildNodesWithName(Constant.SpriteKeys.ShatterPiece, usingBlock: { node, stop in
        node.fadeOut(1) { node.removeFromParent() }
      })
      blackHole.endGravity()

      showCivilizationStats(civilization!)
    }

    prevConsumptionState = consumptionState
    consumptionState = state
  }

  func introduceCivilization(civ: Civilization) {
    civilization = civ
    planet = PlanetSprite(withCiv: civ)

    // 1) Position at top of screen, just out of sight.
    planet!.position = CGPoint(x: frame.size.width/2.0, y: frame.size.height + CGFloat(civ.size))
    container.addChild(planet!)

    setConsumptionState(.Initial)

  }

  override func didSimulatePhysics() {

    if let state = consumptionState {
      guard let planet = planet else { return }
      guard let civilization = civilization else { return }

      if state != .Done && state != .Consuming {

        // slow down when we're in freefall
        let velocity = state == .Freefalling ? -20 : -30

        planet.physicsBody?.velocity = CGVector(dx: 0, dy: velocity)
      }

      if state == .Consuming {
        // slow down while consuming
        planet.physicsBody?.velocity = CGVector(dx: 0, dy: -10)
      }

      // if the planet passes below the 80% threshold, introduce the civilization
      if state == .Initial && planet.position.y < frame.size.height * 0.75 {
        setConsumptionState(.Introduction)
        // Introduce Planet
        let youveEncounteredNode = generalTextNode("\(GeneralState.blackHoleName) encountered")
          .setPos(to: textNodePosition)
          .fadeIn(1)
        container.addChild(youveEncounteredNode)

        let planetNameNode = generalTextNode(civilization.name)
          .setFont(to: Constant.GenericText.BoldFont.Name)
          .setPos(to: secondTextNodePosition)
          .addTo(container)
          .fadeInAfter(2, duration: 1)

        let wait : Double = 5

        youveEncounteredNode.fadeOutAfter(wait, duration: 1.0) { youveEncounteredNode.removeFromParent() }
        planetNameNode.fadeOutAfter(wait + 1, duration: 1.0) {
          planetNameNode.removeFromParent()
        }

        // Then set to FreeFalling
        self.setConsumptionState(.Freefalling)
      }

      if state == .Freefalling {
        computeShatters()
        setConsumptionState(.DidComputeShatters)
      }

      if state == .Consuming {
        if planet.convertPoint(CGPoint(x: 0, y: 0), toNode: container).y < blackHole.convertPoint(CGPoint(x: 0, y: 0), toNode: container).y {
          // planet is obscured by black hole, remove
          planet.removeFromParent()
          setConsumptionState(.Done)
        }
      }
    }

    container.enumerateChildNodesWithName(Constant.SpriteKeys.ShatterPiece, usingBlock: { (node, stop) in
      // if the particles are out of bounds, remove them
      if node.position.x < 0 || node.position.x > self.frame.size.width {
        node.removeFromParent()
      } else if node.position.y < 0 || node.position.y > self.frame.size.height {
        node.removeFromParent()
      }
    })
  }

  func computeShatters() {
    guard let planet = planet else { return }
    guard let civilization = civilization else { return }

    shatters = [ShatterPiece]()

    let colorScheme = ColorSchemes[civilization.colorSchemeIndex]
    let allColors = colorScheme.values

    let shape = SKShapeNode(rectOfSize: shatterSize)

    let textures : [SKTexture] = allColors.map { c in
      shape.fillColor = c
      return self.view!.textureFromNode(shape)!
    }

    // initially place all of the points on the planet's node
    // but then move them to container as they become shows
//    let center = CGPoint(x: planet.frame.size.width / 2.0, y: planet.frame.size.height / 2.0)

    var count = 0

    var theta : Double = 0
    while theta < totalTheta {
      // for each theta
      var r : Double = 0
      while r < (civilization.size / 2.0) {
        // for each radius step

        // we now have r and theta
        // place a shatter piece at the x and y
        let x = CGFloat(Double(r) * cos(theta))
        let y = CGFloat(Double(r) * sin(theta))

        let shatter = ShatterPiece(
          texture: textures.sample(),
          centerOffset: CGPoint(x: x, y: y)
        )
        shatter.alpha = 0.0
        shatter.physicsBody?.affectedByGravity = false
        shatter.physicsBody?.pinned = true
        shatters!.append(shatter)
        planet.addChild(shatter)

        count = count + 1
        
        r = r + radiusStep
      }
      
      theta = theta + thetaStep
    }

  }

  func startConsuming() {
    // add gravity to the black hole
    blackHole.startGravity()
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
      doneEditingName(textField.text ?? GeneralState.blackHoleName)
      return true
    }
    
    return false
  }
}

extension TamagatchiScene : SKPhysicsContactDelegate {
  func didBeginContact(contact: SKPhysicsContact) {

    if let _ = testIf(Constant.SpriteMasks.Planet, and: Constant.SpriteMasks.BlackHole, didContactWithContact: contact)
      where (consumptionState == .DidComputeShatters) {

      // if we're freefalling and intersect with the black hole node,
      // trigger the consumption sequence
      startConsuming()
      setConsumptionState(.Consuming)
    }

    // if shatter -> event horizon
    // show shatter piece
    if let shatter = testIf(Constant.SpriteMasks.ShatterPiece, and: Constant.SpriteMasks.BlackHole, didContactWithContact: contact) {
      guard let planet = planet else {
        print("no planet in the scene???")
        return
      }

      guard !(shatter as! ShatterPiece).isShown else {
        return
      }

      let newPos = container.convertPoint(shatter.position, fromNode: planet)
      shatter.removeFromParent()
      shatter.position = newPos
      shatter.fadeIn(0.3)
      shatter.physicsBody?.pinned = false
      shatter.physicsBody?.affectedByGravity = true
      container.addChild(shatter)

      (shatter as! ShatterPiece).isShown = true
    }

    if let s = testIf(Constant.SpriteMasks.ShatterPiece, and: Constant.SpriteMasks.BlackHoleSingularity, didContactWithContact: contact) {
      s.removeFromParent()
    }
  }

  func testIf(categoryA: UInt32, and categoryB: UInt32?, didContactWithContact contact: SKPhysicsContact) -> SKNode? {
    // test if categoryA contacted categoryB and return the node corresponding to categoryA
    // only works if the categories for each thing are different
    if (contact.bodyA.categoryBitMask == categoryA && contact.bodyB.categoryBitMask == categoryB)
      || (contact.bodyA.categoryBitMask == categoryB && contact.bodyB.categoryBitMask == categoryA) {

      if contact.bodyA.categoryBitMask == categoryA { return contact.bodyA.node }
      if contact.bodyB.categoryBitMask == categoryA { return contact.bodyB.node }
    }

    return nil
  }

}


























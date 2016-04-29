//
//  Field.swift
//  planetgentest
//
//  Created by Matt Condon on 4/27/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import CoreGraphics

class Field {
  var data : [Float]
  var size : CGSize

  var edgeFalloffPercentage : CGFloat = 0.05

  lazy var leftEllipse : (CGPoint) -> CGFloat = { [unowned self] in
    return self.ellipse(
      h: 0,
      k: self.size.height/2.0,
      r_x: self.edgeFalloffPercentage * self.size.width,
      r_y: self.size.height/2.0
    )
    }()

  lazy var rightEllipse : (CGPoint) -> CGFloat = { [unowned self] in
    return self.ellipse(
      h: self.size.width,
      k: self.size.height/2.0,
      r_x: self.edgeFalloffPercentage * self.size.width,
      r_y: self.size.height/2.0
    )
    }()

  init(size : CGSize) {
    self.size = size
    self.data = [Float](count: Int(size.width) * Int(size.height), repeatedValue: 0.0)
  }

  func ellipseEdgeFalloff(x: CGFloat) -> CGFloat {
    // linear falloff for edges of ellipse
    // x is the output of the ellipse function (how close it is to the edge of the ellipse
    let xIntercept : CGFloat = 0.4
    let m = (1.0 / (1.0 - xIntercept))
    let lerp = m * x + (1 - m)
    return min(1.0, max(0.0, lerp))
  }

  func ellipseFalloff(point: CGPoint) -> CGFloat {
    // falloff for edges to guarantee water on the edge
    // returns value btween 1 and 0
    // if it's within an ellipse on the edge, return the ellipse value times the lerp value
    let leftEllipseValue = leftEllipse(point)
    let rightEllipseValue = rightEllipse(point)

    let minimumValue = min(leftEllipseValue, rightEllipseValue)

    if minimumValue <= 1 {
      // is within the ellipse, so return the falloff
      return ellipseEdgeFalloff(minimumValue)
    }

    return 1
  }

  func ellipse(h h: CGFloat, k: CGFloat, r_x: CGFloat, r_y: CGFloat) -> (CGPoint) -> CGFloat {
    func valueForPoint(point: CGPoint) -> CGFloat {
      let x = point.x
      let y = point.y

      let firstHalf =  ((x - h) * (x - h)) / (r_x * r_x)
      let secondHalf = ((y - k) * (y - k)) / (r_y * r_y)
      return firstHalf + secondHalf
    }
    return valueForPoint
  }
}


extension Field {
  func toImage() -> UIImage {
    let width = Int(self.size.width)
    let height = Int(self.size.height)

    let startTime = CFAbsoluteTimeGetCurrent();

    var pixelArray = [PixelData](count: width * height, repeatedValue: PixelData(a: 255, r:0, g: 0, b: 0))

    for i in 0 ..< height {
      for j in 0 ..< width {
        let index = i * width + j

        var val = self.data[index]
        if val > 1 { val = 1 }

        let u_I = UInt8(val * 255)
        pixelArray[index].r = u_I
        pixelArray[index].g = u_I
        pixelArray[index].b = u_I
      }
    }

    print(" R RENDER:" + String(format: "%.4f", CFAbsoluteTimeGetCurrent() - startTime));

    let outputImage = PixelDrawer.imageFromARGB32Bitmap(pixelArray, width: width, height: height)
    
    return outputImage
  }
}






























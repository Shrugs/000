//
//  PixelData.swift
//  planetgentest
//
//  Created by Matt Condon on 4/27/16.
//  Copyright © 2016 mattc. All rights reserved.
//

import UIKit
import CoreGraphics

// MARK: Image Generation

//
//  drawing images from pixel data
//      http://blog.human-friendly.com/drawing-images-from-pixel-data-in-swift
//


struct PixelData {
  var a:UInt8 = 255
  var r:UInt8
  var g:UInt8
  var b:UInt8
}

struct PixelDrawer {
  static let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
  static let bitmapInfo:CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)

  static func imageFromARGB32Bitmap(pixels:[PixelData], width:Int, height:Int)->UIImage {
    let bitsPerComponent:Int = 8
    let bitsPerPixel:Int = 32

    assert(pixels.count == Int(width * height))

    var data = pixels // Copy to mutable []
    let providerRef = CGDataProviderCreateWithCFData(NSData(bytes: &data, length: data.count * sizeof(PixelData)))

    let cgim = CGImageCreate(
      width,
      height,
      bitsPerComponent,
      bitsPerPixel,
      width * Int(sizeof(PixelData)),
      rgbColorSpace,
      bitmapInfo,
      providerRef,
      nil,
      false,
      CGColorRenderingIntent.RenderingIntentDefault
    )
    return UIImage(CGImage: cgim!)
  }

}

extension UIColor {
  var pixelData : PixelData {
    get {
      var red : CGFloat = 0
      var green : CGFloat = 0
      var blue : CGFloat = 0
      var alpha : CGFloat = 0

      getRed(&red, green: &green, blue: &blue, alpha: &alpha)

      return PixelData(
        a: UInt8(alpha * 255),
        r: UInt8(red * 255),
        g: UInt8(green * 255),
        b: UInt8(blue * 255)
      )
    }
  }
}
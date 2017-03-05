//
//  UIImage+Grayscaled.swift
//  Graygram
//
//  Created by Suyeol Jeon on 06/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

extension UIImage {

  func grayscaled() -> UIImage? {
    guard let context = CGContext(
      data: nil,
      width: Int(self.size.width),
      height: Int(self.size.height),
      bitsPerComponent: 8,
      bytesPerRow: 0,
      space: CGColorSpaceCreateDeviceGray(),
      bitmapInfo: .allZeros
    )
    else { return nil }

    guard let inputCGImage = self.cgImage else { return nil }
    let imageRect = CGRect(origin: .zero, size: self.size)
    context.draw(inputCGImage, in: imageRect)

    guard let outputCGImage = context.makeImage() else { return nil }
    return UIImage(cgImage: outputCGImage)
  }

}

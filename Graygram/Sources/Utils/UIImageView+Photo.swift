//
//  UIImageView+Photo.swift
//  Graygram
//
//  Created by Suyeol Jeon on 12/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

extension UIImageView {

  func setImage(with photoID: String?, placeholder: UIImage? = nil, size: PhotoSize) {
    guard let photoID = photoID else {
      self.image = placeholder
      return
    }
    let url = URL(string: "https://graygram.com/photos/\(photoID)/\(size.pixel)x\(size.pixel)")
    self.kf.setImage(with: url, placeholder: placeholder)
  }

}

//
//  PostEditorImageCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostEditorImageCell: UITableViewCell {

  // MARK: UI

  fileprivate let photoView = UIImageView()


  // MARK: Initializing

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(self.photoView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Configuring

  func configure(image: UIImage) {
    self.photoView.image = image
  }


  // MARK: Size

  class func height(width: CGFloat) -> CGFloat {
    return width // 정사각형
  }


  // MARK: Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    self.photoView.frame = self.contentView.bounds
  }

}

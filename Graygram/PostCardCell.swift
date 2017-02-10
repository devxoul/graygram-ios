//
//  PostCardCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostCardCell: UICollectionViewCell {

  fileprivate let messageLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.messageLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(post: Post) {
    self.backgroundColor = .lightGray
    self.messageLabel.text = post.message
  }

}

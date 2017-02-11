//
//  PostCardCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit
import Kingfisher
import ManualLayout

final class PostCardCell: UICollectionViewCell {

  fileprivate let photoView = UIImageView()
  fileprivate let messageLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.photoView.backgroundColor = .gray
    self.messageLabel.numberOfLines = 3
    self.messageLabel.font = UIFont.systemFont(ofSize: 14)

    self.contentView.addSubview(self.photoView)
    self.contentView.addSubview(self.messageLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(post: Post) {
    self.backgroundColor = .lightGray

    if let id = post.photoID, let url = URL(string: "https://graygram.com/photos/\(id)/640x640") {
      self.photoView.kf.setImage(with: url)
    }

    self.messageLabel.text = post.message
    self.setNeedsLayout()
  }

  class func size(width: CGFloat, post: Post) -> CGSize {
    var height: CGFloat = 0
    height += width // photoView height

    if let message = post.message, !message.isEmpty {
      let font = UIFont.systemFont(ofSize: 14)
      let constraintSize = CGSize(width: width - 20, height: font.lineHeight * 3)
      let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
      let attributes: [String: Any] = [NSFontAttributeName: font]
      let boundingRect = message.boundingRect(
        with: constraintSize,
        options: options,
        attributes: attributes,
        context: nil
      )
      height += 10 // messageLabel top
      height += ceil(boundingRect.height) // messageLabel height
      height += 10 // messageLabel bottom
    }
    return CGSize(width: width, height: height)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.photoView.width = self.contentView.width
    self.photoView.height = self.photoView.width

    self.messageLabel.top = self.photoView.bottom + 10
    self.messageLabel.left = 10
    self.messageLabel.width = self.contentView.width - 20
    self.messageLabel.sizeToFit()
  }

}

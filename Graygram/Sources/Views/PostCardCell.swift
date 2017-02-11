//
//  PostCardCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostCardCell: UICollectionViewCell {

  // MARK: Constants

  fileprivate struct Constant {
    static let messageLabelNumberOfLines = 3
  }

  fileprivate struct Metric {
    static let userPhotoViewLeft = 10.f
    static let userPhotoViewSize = 30.f

    static let usernameLabelLeft = 8.f
    static let usernameLabelRight = 10.f

    static let photoViewTop = 10.f

    static let messageLabelTop = 10.f
    static let messageLabelLeft = 10.f
    static let messageLabelRight = 10.f
    static let messageLabelBottom = 10.f
  }

  fileprivate struct Font {
    static let usernameLabel = UIFont.boldSystemFont(ofSize: 13)
    static let messageLabel = UIFont.systemFont(ofSize: 14)
  }


  // MARK: UI

  fileprivate let userPhotoView = UIImageView().then {
    $0.backgroundColor = .gray
    $0.layer.cornerRadius = Metric.userPhotoViewSize / 2
    $0.clipsToBounds = true
  }
  fileprivate let usernameLabel = UILabel().then {
    $0.font = Font.usernameLabel
  }
  fileprivate let photoView = UIImageView().then {
    $0.backgroundColor = .gray
  }
  fileprivate let messageLabel = UILabel().then {
    $0.numberOfLines = Constant.messageLabelNumberOfLines
    $0.font = Font.messageLabel
  }


  // MARK: Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.userPhotoView)
    self.contentView.addSubview(self.usernameLabel)
    self.contentView.addSubview(self.photoView)
    self.contentView.addSubview(self.messageLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Configuring

  func configure(post: Post) {
    self.backgroundColor = .lightGray
    self.userPhotoView.setImage(with: post.user.photoID, size: .tiny)
    self.usernameLabel.text = post.user.username
    self.photoView.setImage(with: post.photoID, size: .hd)
    self.messageLabel.text = post.message
    self.setNeedsLayout()
  }


  // MARK: Size

  class func size(width: CGFloat, post: Post) -> CGSize {
    var height: CGFloat = 0
    height += Metric.userPhotoViewSize
    height += Metric.photoViewTop
    height += width // photoView height

    if let message = post.message, !message.isEmpty {
      let messageLabelSize = message.size(
        width: width - Metric.messageLabelLeft - Metric.messageLabelRight,
        font: Font.messageLabel,
        numberOfLines: Constant.messageLabelNumberOfLines
      )
      height += Metric.messageLabelTop
      height += messageLabelSize.height // messageLabel height
      height += Metric.messageLabelBottom
    }
    return CGSize(width: width, height: height)
  }


  // MARK: Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    self.userPhotoView.left = Metric.userPhotoViewLeft
    self.userPhotoView.width = Metric.userPhotoViewSize
    self.userPhotoView.height = Metric.userPhotoViewSize

    self.usernameLabel.sizeToFit()
    self.usernameLabel.left = self.userPhotoView.right + Metric.usernameLabelLeft
    self.usernameLabel.width = min(
      self.usernameLabel.width,
      self.contentView.width - self.usernameLabel.left - Metric.usernameLabelRight
    )
    self.usernameLabel.centerY = self.userPhotoView.centerY

    self.photoView.top = self.userPhotoView.bottom + Metric.photoViewTop
    self.photoView.width = self.contentView.width
    self.photoView.height = self.photoView.width

    self.messageLabel.top = self.photoView.bottom + Metric.messageLabelTop
    self.messageLabel.left = Metric.messageLabelLeft
    self.messageLabel.width = self.contentView.width - Metric.messageLabelLeft - Metric.messageLabelRight
    self.messageLabel.sizeToFit()
  }

}

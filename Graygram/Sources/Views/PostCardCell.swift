//
//  PostCardCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import Alamofire

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

    static let likeButtonTop = 10.f
    static let likeButtonLeft = 10.f
    static let likeButtonSize = 20.f

    static let likeCountLabelLeft = 6.f

    static let messageLabelTop = 10.f
    static let messageLabelLeft = 10.f
    static let messageLabelRight = 10.f
  }

  fileprivate struct Font {
    static let usernameLabel = UIFont.boldSystemFont(ofSize: 13)
    static let likeCountLabel = UIFont.boldSystemFont(ofSize: 12)
    static let messageLabel = UIFont.systemFont(ofSize: 13)
  }


  // MARK: Properties

  fileprivate var post: Post?


  // MARK: UI

  fileprivate let userPhotoView = UIImageView().then {
    $0.layer.cornerRadius = Metric.userPhotoViewSize / 2
    $0.clipsToBounds = true
  }
  fileprivate let usernameLabel = UILabel().then {
    $0.font = Font.usernameLabel
  }
  fileprivate let photoView = UIImageView().then {
    $0.backgroundColor = .lightGray
  }

  fileprivate let likeButton = UIButton().then {
    $0.setBackgroundImage(#imageLiteral(resourceName: "icon_like"), for: .normal)
    $0.setBackgroundImage(#imageLiteral(resourceName: "icon_like_selected"), for: .selected)
  }
  fileprivate let likeCountLabel = UILabel().then {
    $0.font = Font.likeCountLabel
  }

  fileprivate let messageLabel = UILabel().then {
    $0.numberOfLines = Constant.messageLabelNumberOfLines
    $0.font = Font.messageLabel
  }


  // MARK: Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)

    self.contentView.addSubview(self.userPhotoView)
    self.contentView.addSubview(self.usernameLabel)
    self.contentView.addSubview(self.photoView)
    self.contentView.addSubview(self.likeButton)
    self.contentView.addSubview(self.likeCountLabel)
    self.contentView.addSubview(self.messageLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Configuring

  func configure(post: Post) {
    self.post = post
    self.userPhotoView.setImage(with: post.user.photoID, size: .tiny)
    self.usernameLabel.text = post.user.username
    self.photoView.setImage(with: post.photoID, size: .hd)
    self.likeButton.isSelected = post.isLiked
    self.configureLikeCountLabel()
    self.messageLabel.text = post.message
    self.messageLabel.isHidden = post.message?.isEmpty != false
    self.setNeedsLayout()
  }

  fileprivate func configureLikeCountLabel() {
    guard let likeCount = self.post?.likeCount else { return }
    if likeCount > 0 {
      self.likeCountLabel.text = "\(likeCount)명이 좋아합니다."
    } else {
      self.likeCountLabel.text = "가장 먼저 좋아요를 눌러보세요."
    }
  }


  // MARK: Size

  class func size(width: CGFloat, post: Post) -> CGSize {
    var height: CGFloat = 0
    height += Metric.userPhotoViewSize
    height += Metric.photoViewTop
    height += width // photoView height

    height += Metric.likeButtonTop
    height += Metric.likeButtonSize

    if let message = post.message, !message.isEmpty {
      let messageLabelSize = message.size(
        width: width - Metric.messageLabelLeft - Metric.messageLabelRight,
        font: Font.messageLabel,
        numberOfLines: Constant.messageLabelNumberOfLines
      )
      height += Metric.messageLabelTop
      height += messageLabelSize.height // messageLabel height
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

    self.likeButton.top = self.photoView.bottom + Metric.likeButtonTop
    self.likeButton.left = Metric.likeButtonLeft
    self.likeButton.width = Metric.likeButtonSize
    self.likeButton.height = Metric.likeButtonSize

    self.likeCountLabel.sizeToFit()
    self.likeCountLabel.left = self.likeButton.right + Metric.likeCountLabelLeft
    self.likeCountLabel.centerY = self.likeButton.centerY

    if !self.messageLabel.isHidden {
      self.messageLabel.top = self.likeButton.bottom + Metric.messageLabelTop
      self.messageLabel.left = Metric.messageLabelLeft
      self.messageLabel.width = self.contentView.width - Metric.messageLabelLeft - Metric.messageLabelRight
      self.messageLabel.sizeToFit()
    }
  }


  // MARK: Networking

  func like() {
    guard let post = self.post, let postID = post.id else { return }
    self.likeButton.isSelected = true
    self.post?.likeCount = post.likeCount + 1
    self.configureLikeCountLabel()

    let urlString = "https://api.graygram.com/posts/\(postID)"
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    Alamofire.request(urlString, method: .post, headers: headers).responseData { response in
      switch response.result {
      case .success,
           .failure where response.response?.statusCode != 409:
        print("post-\(postID) 좋아요 성공!")

      case .failure:
        print("post-\(postID) 좋아요 실패 ㅠㅠ")
        self.likeButton.isSelected = false
        self.post?.likeCount = post.likeCount
        self.configureLikeCountLabel()
      }
    }
  }

  func unlike() {
    guard let post = self.post, let postID = post.id else { return }
    self.likeButton.isSelected = false
    self.post?.likeCount = max(0, post.likeCount - 1)
    self.configureLikeCountLabel()

    let urlString = "https://api.graygram.com/posts/\(postID)"
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    Alamofire.request(urlString, method: .post, headers: headers).responseData { response in
      switch response.result {
      case .success,
           .failure where response.response?.statusCode != 409:
        print("post-\(postID) 좋아요 취소 성공!")

      case .failure:
        print("post-\(postID) 좋아요 취소 실패 ㅠㅠ")
        self.likeButton.isSelected = true
        self.post?.likeCount = post.likeCount
        self.configureLikeCountLabel()
      }
    }
  }


  // MARK: Actions

  func likeButtonDidTap() {
    self.like()
  }

}

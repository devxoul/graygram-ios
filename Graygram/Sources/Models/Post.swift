//
//  Post.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import ObjectMapper

struct Post: Mappable {

  var id: Int!
  var user: User!
  var photoID: String!
  var message: String?
  var createdAt: Date!
  var isLiked: Bool!
  var likeCount: Int!

  init?(map: Map) {
  }

  mutating func mapping(map: Map) {
    self.id <- map["id"]
    self.user <- map["user"]
    self.photoID <- map["photo.id"]
    self.message <- map["message"]
    self.createdAt <- (map["created_at"], ISO8601DateTransform())
    self.isLiked <- map["is_liked"]
    self.likeCount <- map["like_count"]
  }

}


extension Notification.Name {
  /// 좋아요를 할 경우 발생하는 노티피케이션입니다. `userInfo`에 `postID`가 전달됩니다.
  static var postDidLike: Notification.Name { return .init("postDidLike") }

  /// 좋아요를 취소할 경우 발생하는 노티피케이션입니다. `userInfo`에 `postID`가 전달됩니다.
  static var postDidUnlike: Notification.Name { return .init("postDidUnlike") }

  /// 새로운 `Post`가 생성되었을 경우 발생하는 노티피케이션입니다. `userInfo`에 `post: Post`가 전달됩니다.
  static var postDidCreate: Notification.Name { return .init("postDidCreate") }
}

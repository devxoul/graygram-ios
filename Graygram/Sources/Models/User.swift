//
//  User.swift
//  Graygram
//
//  Created by Suyeol Jeon on 12/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import ObjectMapper

struct User: Mappable {

  var id: Int!
  var username: String!
  var photoID: String?

  init?(map: Map) {
  }

  mutating func mapping(map: Map) {
    self.id <- map["id"]
    self.username <- map["username"]
    self.photoID <- map["photo.id"]
  }

}

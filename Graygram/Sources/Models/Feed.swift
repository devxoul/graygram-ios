//
//  Feed.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import ObjectMapper

struct Feed: Mappable {

  var posts: [Post]?
  var nextURLString: String?

  init?(map: Map) {
  }

  mutating func mapping(map: Map) {
    self.posts <- map["data"]
    self.nextURLString <- map["paging.next"]
  }

}

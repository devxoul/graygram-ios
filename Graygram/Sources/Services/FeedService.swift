//
//  FeedService.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire
import ObjectMapper

struct FeedService {

  static func feeds(
    more: Bool,
    nextURLString: String?,
    completion: (DataResponse<Void>) -> Void
  ) {
    let urlString: String
    if !more {
      urlString = "https://api.graygram.com/feed?limit=10"
    } else if let nextURLString = nextURLString {
      urlString = nextURLString
    } else {
      return
    }

    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        // completion에 전달해야 할 정보:
        // 1. feeds: [Feed]
        // 2. nextURLString: String?
      }
  }

}

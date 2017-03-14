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

  static func feed(paging: Paging, completion: (DataResponse<Feed>) -> Void) {
    let urlString: String
    switch paging {
    case .refresh:
      urlString = "https://api.graygram.com/feed?limit=10"
    case .next(let nextURLString):
      urlString = nextURLString
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

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

  static func feed(paging: Paging, completion: @escaping (DataResponse<Feed>) -> Void) {
    let urlString: String
    switch paging {
    case .refresh:
      urlString = "https://api.graygram.com/feed"
    case .next(let nextURLString):
      urlString = nextURLString
    }

    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let response: DataResponse<Feed> = response.flatMap { json in
          if let feed = Mapper<Feed>().map(JSONObject: json) {
            return .success(feed)
          } else {
            return .failure(MappingError(from: json, to: Feed.self))
          }
        }
        completion(response)
      }
  }

}

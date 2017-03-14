//
//  UserService.swift
//  Graygram
//
//  Created by Suyeol Jeon on 14/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire
import ObjectMapper

struct UserService {

  static func me(_ completion: @escaping (DataResponse<User>) -> Void) {
    let urlString = "https://api.graygram.com/me"
    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        switch response.result {
        case .success(let json):
          if let user = Mapper<User>().map(JSONObject: json) {
            // 성공
          } else {
            // 실패
          }

        case .failure(let error):
          // 실패
          break
        }
      }
  }

}

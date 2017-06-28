//
//  UserService.swift
//  Graygram
//
//  Created by Suyeol Jeon on 14/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire
import ObjectMapper

struct UserService: APIServiceType {

  static func me(_ completion: @escaping (DataResponse<User>) -> Void) {
    let urlString = self.url("/me")
    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let response: DataResponse<User> = response.flatMap { json in
          if let user = Mapper<User>().map(JSONObject: json) {
            return .success(user)
          } else {
            let error = MappingError(from: json, to: User.self)
            return .failure(error)
          }
        }
        completion(response)
      }
  }

}

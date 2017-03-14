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
        let response: DataResponse<User> = response.map { result in
          switch result {
          case .success(let json):
            if let user = Mapper<User>().map(JSONObject: json) {
              return .success(user)
            } else {
              let error = MappingError(from: json, to: User.self)
              return .failure(error)
            }

          case .failure(let error):
            return .failure(error)
          }
        }
        completion(response)
      }
  }

}

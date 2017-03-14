//
//  AuthService.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire

struct AuthService {

  static func login(
    username: String,
    password: String,
    completion: @escaping (DataResponse<Void>) -> Void
  ) {
    let urlString = "https://api.graygram.com/login/username"
    let parameters: [String: Any] = [
      "username": username,
      "password": password,
    ]
    let headers: HTTPHeaders = [
      "Accept": "application/json",
    ]
    Alamofire
      .request(urlString, method: .post, parameters: parameters, headers: headers)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let response: DataResponse<Void> = response.map { result in
          switch result {
          case .success:
            return .success(Void())
          case .failure(let error):
            return .failure(error)
          }
        }
        completion(response)
      }
  }

}

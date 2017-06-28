//
//  PostService.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire
import ObjectMapper

struct PostService: APIServiceType {

  static func create(
    image: UIImage,
    message: String?,
    progress: @escaping (Progress) -> Void,
    completion: @escaping (DataResponse<Post>) -> Void
  ) {
    let urlString = self.url("/posts")
    let headers: HTTPHeaders = [
      "Accept": "application/json",
    ]
    Alamofire.upload(
      multipartFormData: { formData in
        if let imageData = UIImageJPEGRepresentation(image, 1) {
          formData.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
        }
        if let messageData = message?.data(using: .utf8) {
          formData.append(messageData, withName: "message")
        }
      },
      to: urlString,
      headers: headers,
      encodingCompletion: { result in
        switch result {
        case .success(let request, _, _): // Request 인코딩 성공
          request // 실제 HTTP 요청
            .validate(statusCode: 200..<400)
            .responseJSON { response in
              let response: DataResponse<Post> = response.flatMapResult { json in
                if let post = Mapper<Post>().map(JSONObject: json) {
                  return .success(post)
                } else {
                  return .failure(MappingError(from: json, to: Post.self))
                }
              }
              completion(response)
            }

        case .failure(let error): // Request 인코딩 실패
          let response = DataResponse<Post>(
            request: nil,
            response: nil,
            data: nil,
            result: .failure(error)
          )
          completion(response)
        }
      }
    )
  }

  static func post(id: Int, completion: @escaping (DataResponse<Post>) -> Void) {
    let urlString = self.url("/posts/\(id)")
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    Alamofire.request(urlString, method: .get, headers: headers)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let response: DataResponse<Post> = response.flatMapResult { json in
          if let post = Mapper<Post>().map(JSONObject: json) {
            return .success(post)
          } else {
            return .failure(MappingError(from: json, to: Post.self))
          }
        }
        completion(response)
      }
  }

  static func like(postID: Int, completion: @escaping (DataResponse<Void>) -> Void) {
    NotificationCenter.default.post(
      name: .postDidLike,
      object: self,
      userInfo: ["postID": postID]
    )
    let urlString = self.url("/\(postID)/likes")
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    Alamofire.request(urlString, method: .post, headers: headers)
      .validate(statusCode: 200..<400)
      .responseData { response in
        if case .failure = response.result, response.response?.statusCode != 409 {
          NotificationCenter.default.post(
            name: .postDidUnlike,
            object: self,
            userInfo: ["postID": postID]
          )
        }
        let response: DataResponse<Void> = response.mapResult { _ in }
        completion(response)
      }
  }

  static func unlike(postID: Int, completion: @escaping (DataResponse<Void>) -> Void) {
    NotificationCenter.default.post(
      name: .postDidLike,
      object: self,
      userInfo: ["postID": postID]
    )
    let urlString = self.url("/\(postID)/likes")
    let headers: HTTPHeaders = [
      "Accept": "application/json"
    ]
    Alamofire.request(urlString, method: .delete, headers: headers)
      .validate(statusCode: 200..<400)
      .responseData { response in
        if case .failure = response.result, response.response?.statusCode != 409 {
          NotificationCenter.default.post(
            name: .postDidLike,
            object: self,
            userInfo: ["postID": postID]
          )
        }
        let response: DataResponse<Void> = response.mapResult { _ in }
        completion(response)
      }
  }

}

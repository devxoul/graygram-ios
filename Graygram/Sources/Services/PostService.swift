//
//  PostService.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire
import ObjectMapper

struct PostService {

  static func create(
    image: UIImage,
    message: String?,
    progress: @escaping (Progress) -> Void,
    completion: @escaping (DataResponse<Post>) -> Void
  ) {

  }

}

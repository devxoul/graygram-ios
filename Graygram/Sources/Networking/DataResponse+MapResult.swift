//
//  DataResponse+MapResult.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Alamofire

extension DataResponse {

  /// `DataResponse`에 새로운 `Result`를 맵핑하여 반환합니다.
  func map<T>(_ transform: (Result<Value>) -> Result<T>) -> DataResponse<T> {
    return DataResponse<T>(
      request: self.request,
      response: self.response,
      data: self.data,
      result: transform(self.result),
      timeline: self.timeline
    )
  }

}

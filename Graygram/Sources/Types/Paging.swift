//
//  Paging.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

enum Paging {
  /// 첫 요청이나 새로고침 요청을 나타냅니다.
  case refresh

  /// 다음 페이지 요청을 나타냅니다. 요청할 URL 문자열을 값으로 가집니다.
  case next(String)
}

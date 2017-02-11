//
//  PhotoSize.swift
//  Graygram
//
//  Created by Suyeol Jeon on 12/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

enum PhotoSize {
  /// 640px
  case hd

  /// 320px (화면 가로 길이의 약 1/2)
  case large

  /// 200px (화면 가로 길이의 약 2/3)
  case medium

  /// 128px (화면 가로 길이의 약 1/3)
  case thumbnail

  /// 64px
  case small

  /// 40px
  case tiny


  /// 개발에 사용되는 포인트 크기
  var point: Int {
    switch self {
    case .hd: return 640
    case .large: return 320
    case .medium: return 200
    case .thumbnail: return 128
    case .small: return 64
    case .tiny: return 40
    }
  }

  /// 렌더링에 사용되는 픽셀 크기 (`pointSize`에 화면의 `scale`을 곱한 값)
  var pixel: Int {
    return self.point * Int(UIScreen.main.scale)
  }

}

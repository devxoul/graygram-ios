//
//  APIServiceType.swift
//  Graygram
//
//  Created by Suyeol Jeon on 28/06/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

protocol APIServiceType {
}

extension APIServiceType {
  static func url(_ path: String) -> String {
    return "https://api.graygram.com" + path
  }
}

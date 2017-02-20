//
//  SplashViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 21/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import Alamofire

final class SplashViewController: UIViewController {

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let urlString = "https://api.graygram.com/me"
    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          print("내 프로필 정보 받아오기 성공!", value)
          AppDelegate.instance?.presentMainSreen()

        case .failure(let error):
          print("내 프로필 정보 받아오기 실패 ㅠㅠ", error)
          AppDelegate.instance?.presentLoginSreen()
        }
      }
  }

}

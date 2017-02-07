//
//  FeedViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 05/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetchPosts()
  }

  // MARK: Networking

  fileprivate func fetchPosts() {
    Alamofire.request("https://api.graygram.com/feed").responseJSON { response in
      switch response.result {
      case .success(let value):
        print(value)

      case .failure(let error):
        print(error)
      }
    }
  }

}

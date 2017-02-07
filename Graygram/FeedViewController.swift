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

  var posts: [Post] = []

  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.frame = self.view.bounds
    self.view.addSubview(self.collectionView)
    self.fetchPosts()
  }

  // MARK: Networking

  fileprivate func fetchPosts() {
    Alamofire.request("https://api.graygram.com/feed").responseJSON { response in
      switch response.result {
      case .success(let value):
        guard let json = value as? [String: Any] else { return }
        let postsJSONArray = json["data"] as? [[String: Any]] ?? []
        self.posts = [Post](JSONArray: postsJSONArray) ?? []

      case .failure(let error):
        print(error)
      }
    }
  }

}

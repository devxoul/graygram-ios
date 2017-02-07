//
//  FeedViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 05/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController, UICollectionViewDataSource {

  var posts: [Post] = []

  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.backgroundColor = .white
    self.collectionView.frame = self.view.bounds
    self.collectionView.dataSource = self
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cardCell")
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
        self.collectionView.reloadData()

      case .failure(let error):
        print(error)
      }
    }
  }

  // MARK: UICollectionViewDataSource

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.posts.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath)
    cell.backgroundColor = .lightGray
    return cell
  }

}

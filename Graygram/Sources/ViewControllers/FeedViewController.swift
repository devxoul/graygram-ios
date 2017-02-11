//
//  FeedViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 05/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit
import Alamofire

final class FeedViewController: UIViewController {

  // MARK: Properties

  fileprivate var posts: [Post] = []


  // MARK: UI

  fileprivate let refreshControl = UIRefreshControl()
  fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .white
    $0.register(PostCardCell.self, forCellWithReuseIdentifier: "cardCell")
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.frame = self.view.bounds
    self.collectionView.dataSource = self
    self.collectionView.delegate = self

    self.refreshControl.addTarget(self, action: #selector(self.refreshControlDidChangeValue), for: .valueChanged)

    self.collectionView.addSubview(self.refreshControl)
    self.view.addSubview(self.collectionView)
    self.fetchPosts()
  }

  // MARK: Networking

  fileprivate func fetchPosts() {
    Alamofire.request("https://api.graygram.com/feed").responseJSON { response in
      self.refreshControl.endRefreshing()

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


  // MARK: Actions

  fileprivate dynamic func refreshControlDidChangeValue() {
    self.fetchPosts()
  }

}


// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.posts.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PostCardCell
    cell.configure(post: self.posts[indexPath.item])
    return cell
  }

}


// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = collectionView.frame.width
    return PostCardCell.size(width: cellWidth, post: self.posts[indexPath.item])
  }

}

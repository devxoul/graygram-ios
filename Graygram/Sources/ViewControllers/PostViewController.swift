//
//  PostViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 15/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {

  // MARK: Properties

  fileprivate let postID: Int
  fileprivate var post: Post?


  // MARK: UI

  fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  fileprivate let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = .clear
    $0.alwaysBounceVertical = true
    $0.register(PostCardCell.self, forCellWithReuseIdentifier: "cardCell")
  }
  fileprivate let errorMessageLabel = UILabel()
  fileprivate let refreshButton = UIButton(type: .system).then {
    $0.setTitle("새로고침", for: .normal)
  }


  // MARK: Initializing

  init(postID: Int, post: Post? = nil) {
    self.postID = postID
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white

    self.collectionView.dataSource = self
    self.collectionView.delegate = self

    self.refreshButton.addTarget(self, action: #selector(fetchPost), for: .touchUpInside)

    self.view.addSubview(self.activityIndicatorView)
    self.view.addSubview(self.collectionView)
    self.view.addSubview(self.errorMessageLabel)
    self.view.addSubview(self.refreshButton)

    self.activityIndicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.errorMessageLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-10)
    }
    self.refreshButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(10)
    }

    NotificationCenter.default.addObserver(self, selector: #selector(postDidLike), name: .postDidLike, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(postDidUnlike), name: .postDidUnlike, object: nil)

    self.fetchPost()
  }


  // MARK: Networking

  func fetchPost() {
    self.setErrorViewHidden(true)
    self.activityIndicatorView.startAnimating()
    self.collectionView.isHidden = true

    PostService.post(id: self.postID) { [weak self] response in
      guard let `self` = self else { return }
      switch response.result {
      case .success(let post):
        print("Post 요청 성공! \(post)")
        self.post = post
        self.activityIndicatorView.stopAnimating()
        self.collectionView.isHidden = false
        self.collectionView.reloadData()

      case .failure(let error):
        print("Post 요청 실패 ㅠㅠ \(error)")
        self.errorMessageLabel.text = error.localizedDescription
        self.activityIndicatorView.stopAnimating()
        self.setErrorViewHidden(false)
      }
    }
  }


  // MARK: Utils

  fileprivate func setErrorViewHidden(_ hidden: Bool) {
    self.errorMessageLabel.isHidden = hidden
    self.refreshButton.isHidden = hidden
  }


  // MARK: Notification

  func postDidLike(_ notification: Notification) {
    guard var post = self.post else { return }
    post.likeCount! += 1
    post.isLiked = true
    self.post = post
    self.collectionView.reloadData()
  }

  func postDidUnlike(_ notification: Notification) {
    guard var post = self.post else { return }
    post.likeCount! -= 1
    post.isLiked = false
    self.post = post
    self.collectionView.reloadData()
  }

}

extension PostViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if self.post == nil {
      return 0
    } else {
      return 1
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PostCardCell
    if let post = self.post {
      cell.configure(post: post)
    }
    return cell
  }

}

extension PostViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let post = self.post else { return .zero }
    return PostCardCell.size(width: collectionView.width, post: post)
  }

}

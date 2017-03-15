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
  }

}

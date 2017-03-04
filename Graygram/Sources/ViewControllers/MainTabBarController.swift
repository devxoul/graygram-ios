//
//  MainTabBarController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 05/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

  let feedViewController = FeedViewController()

  init() {
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = [
      UINavigationController(rootViewController: self.feedViewController),
    ]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

//
//  SettingsViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 20/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Settings"
    self.tabBarItem.title = "Settings"
    self.tabBarItem.image = UIImage(named: "tab-settings")
    self.tabBarItem.selectedImage = UIImage(named: "tab-settings-selected")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}

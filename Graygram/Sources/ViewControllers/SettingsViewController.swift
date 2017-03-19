//
//  SettingsViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 20/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

  fileprivate struct Section {
    let items: [SectionItem]
  }

  fileprivate enum SectionItem {
    case version
    case logout
  }

  fileprivate let tableView = UITableView(frame: .zero, style: .grouped)

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

    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints { make in
      make.edges.equalTo(0)
    }
  }

}

extension SettingsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }

}


extension SettingsViewController: UITableViewDelegate {



}

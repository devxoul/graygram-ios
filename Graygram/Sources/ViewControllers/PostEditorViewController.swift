//
//  PostEditorViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostEditorViewController: UIViewController {

  // MARK: Properties

  fileprivate let image: UIImage


  // MARK: UI

  fileprivate let tableView = UITableView(frame: .zero, style: .grouped)


  // MARK: Initializing

  init(image: UIImage) {
    self.image = image
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

}

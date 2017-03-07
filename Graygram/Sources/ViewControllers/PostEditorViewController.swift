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
  fileprivate var message: String?


  // MARK: UI

  fileprivate let tableView = UITableView(frame: .zero, style: .grouped)


  // MARK: Initializing

  init(image: UIImage) {
    self.image = image
    super.init(nibName: nil, bundle: nil)
    self.title = "New Post"
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(PostEditorImageCell.self, forCellReuseIdentifier: "imageCell")
    self.tableView.register(PostEditorMessageCell.self, forCellReuseIdentifier: "messageCell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.view.addSubview(self.tableView)

    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillChangeFrame),
      name: .UIKeyboardWillChangeFrame,
      object: nil
    )
  }


  // MARK: Notification

  func keyboardWillChangeFrame(notification: Notification) {
    guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
      let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
    else { return }
    let keyboardVisibleHeight = UIScreen.main.bounds.height - keyboardFrame.origin.y
    UIView.animate(withDuration: duration) {
      self.tableView.contentInset.bottom = keyboardVisibleHeight
      self.tableView.scrollIndicatorInsets.bottom = keyboardVisibleHeight

      // 키보드가 보여지는 경우 메시지 셀로 스크롤
      if keyboardVisibleHeight > 0 {
        let indexPath = IndexPath(row: 1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
      }
    }
  }

}

extension PostEditorViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! PostEditorImageCell
      cell.configure(image: self.image)
      return cell

    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! PostEditorMessageCell
      cell.configure(message: self.message)
      cell.textDidChange = { [weak self] message in
        guard let `self` = self else { return }
        self.message = message
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
      }
      return cell

    default:
      return UITableViewCell()
    }
  }

}

extension PostEditorViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return PostEditorImageCell.height(width: tableView.width)

    case 1:
      return PostEditorMessageCell.height(width: tableView.width, message: self.message)

    default:
      return 0
    }
  }

}

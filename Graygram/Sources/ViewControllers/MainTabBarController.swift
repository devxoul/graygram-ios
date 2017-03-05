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

  /// 업로드 버튼을 할 가짜 뷰 컨트롤러. 실제로 선택되지는 않습니다.
  let fakeUploadViewController = UIViewController().then {
    $0.tabBarItem.image = UIImage(named: "tab-upload")
    $0.tabBarItem.imageInsets.top = 5
    $0.tabBarItem.imageInsets.bottom = -5
  }

  init() {
    super.init(nibName: nil, bundle: nil)
    self.delegate = self

    self.viewControllers = [
      UINavigationController(rootViewController: self.feedViewController),
      self.fakeUploadViewController,
    ]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Presenting

  fileprivate func presentImagePickerController() {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    self.present(pickerController, animated: true, completion: nil)
  }

}


// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    // `fakeUploadViewController` 탭을 선택하면 실제로 탭을 선택하는 대신 `PostEditorViewController`를 띄웁니다.
    if viewController === self.fakeUploadViewController {
      self.presentImagePickerController()
      return false
    }
    return true
  }

}


// MARK: - UIImagePickerControllerDelegate

extension MainTabBarController: UIImagePickerControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    print("이미지 선택: \(info)")
  }

}


// MARK: - UINavigationControllerDelegate

extension MainTabBarController: UINavigationControllerDelegate {
}

//
//  LoginViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 18/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

  // MARK: UI

  fileprivate let usernameTextField = UITextField().then {
    $0.borderStyle = .roundedRect
    $0.placeholder = "Username"
    $0.font = UIFont.systemFont(ofSize: 14)
  }
  fileprivate let passwordTextField = UITextField().then {
    $0.borderStyle = .roundedRect
    $0.placeholder = "Password"
    $0.font = UIFont.systemFont(ofSize: 14)
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Login"

    self.view.addSubview(self.usernameTextField)
    self.view.addSubview(self.passwordTextField)

    self.usernameTextField.snp.makeConstraints { make in
      make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(30)
    }

    self.passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(self.usernameTextField.snp.bottom).offset(15)
      make.left.right.height.equalTo(self.usernameTextField)
    }
  }

}

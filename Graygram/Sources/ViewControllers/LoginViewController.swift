//
//  LoginViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 18/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import Alamofire

final class LoginViewController: UIViewController {

  // MARK: UI

  fileprivate let usernameTextField = UITextField().then {
    $0.borderStyle = .roundedRect
    $0.placeholder = "Username"
    $0.autocorrectionType = .no
    $0.autocapitalizationType = .none
    $0.font = UIFont.systemFont(ofSize: 14)
  }
  fileprivate let passwordTextField = UITextField().then {
    $0.borderStyle = .roundedRect
    $0.placeholder = "Password"
    $0.isSecureTextEntry = true
    $0.font = UIFont.systemFont(ofSize: 14)
  }
  fileprivate let loginButton = UIButton().then {
    $0.backgroundColor = $0.tintColor
    $0.layer.cornerRadius = 5
    $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    $0.setTitle("Login", for: .normal)
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Login"

    self.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)

    self.view.addSubview(self.usernameTextField)
    self.view.addSubview(self.passwordTextField)
    self.view.addSubview(self.loginButton)

    self.usernameTextField.snp.makeConstraints { make in
      make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(15)
      make.left.equalTo(30)
      make.right.equalTo(-30)
      make.height.equalTo(35)
    }

    self.passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(self.usernameTextField.snp.bottom).offset(10)
      make.left.right.height.equalTo(self.usernameTextField)
    }

    self.loginButton.snp.makeConstraints { make in
      make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
      make.left.right.equalTo(self.usernameTextField)
      make.height.equalTo(40)
    }
  }


  // MARK: Actions

  func loginButtonDidTap() {
    guard let username = self.usernameTextField.text, !username.isEmpty else { return }
    guard let password = self.passwordTextField.text, !password.isEmpty else { return }

    self.usernameTextField.isEnabled = false
    self.passwordTextField.isEnabled = false
    self.loginButton.isEnabled = false
    self.loginButton.alpha = 0.4

    let urlString = "https://api.graygram.com/login/username"
    let parameters: [String: Any] = [
      "username": username,
      "password": password,
    ]
    let headers: HTTPHeaders = [
      "Accept": "application/json",
    ]
    Alamofire
      .request(urlString, method: .post, parameters: parameters, headers: headers)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          print("로그인 성공!", value)

        case .failure(let error):
          print("로그인 실패 ㅠㅠ", error)

          self.usernameTextField.isEnabled = true
          self.passwordTextField.isEnabled = true
          self.loginButton.isEnabled = true
          self.loginButton.alpha = 1

          switch response.errorInfo()?.field {
          case .some("username"):
            self.usernameTextField.becomeFirstResponder()
            self.usernameTextField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
          case .some("password"):
            self.passwordTextField.becomeFirstResponder()
            self.passwordTextField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
          default:
            break
          }
        }
      }
  }

}

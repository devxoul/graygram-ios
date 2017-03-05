//
//  ImageCropViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 06/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

/// 이미지를 정사각형으로 크롭하는 뷰 컨트롤러
final class ImageCropViewController: UIViewController {

  // MARK: Properties

  fileprivate let originalImage: UIImage


  // MARK: UI

  fileprivate let scrollView = UIScrollView()
  fileprivate let imageView = UIImageView()

  fileprivate let cropAreaView = UIView().then {
    $0.isUserInteractionEnabled = false
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.layer.borderWidth = 1 / UIScreen.main.scale
  }
  fileprivate let cropAreaTopCoverView = UIView().then {
    $0.isUserInteractionEnabled = false
    $0.backgroundColor = .white
    $0.alpha = 0.9
  }
  fileprivate let cropAreaBottomCoverView = UIView().then {
    $0.isUserInteractionEnabled = false
    $0.backgroundColor = .white
    $0.alpha = 0.9
  }


  // MARK: Initializing

  init(image: UIImage) {
    self.originalImage = image
    super.init(nibName: nil, bundle: nil)
    self.imageView.image = image
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.scrollView.addSubview(self.imageView)
    self.view.addSubview(self.scrollView)
    self.view.addSubview(self.cropAreaTopCoverView)
    self.view.addSubview(self.cropAreaBottomCoverView)
    self.view.addSubview(self.cropAreaView)

    self.scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    self.cropAreaView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.height.equalTo(self.cropAreaView.snp.width)
      make.centerY.equalToSuperview()
    }
    self.cropAreaTopCoverView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.bottom.equalTo(self.cropAreaView.snp.top)
    }
    self.cropAreaBottomCoverView.snp.makeConstraints { make in
      make.top.equalTo(self.cropAreaView.snp.bottom)
      make.bottom.left.right.equalToSuperview()
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if self.imageView.size == .zero {
      self.imageView.size = self.scrollView.size
    }
  }

}

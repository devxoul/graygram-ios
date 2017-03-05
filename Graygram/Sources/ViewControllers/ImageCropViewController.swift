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


  // MARK: Initializing

  init(image: UIImage) {
    self.originalImage = image
    super.init(nibName: nil, bundle: nil)
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

    self.scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  }

}

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

  // MARK: UI

  fileprivate let scrollView = UIScrollView().then {
    $0.alwaysBounceHorizontal = true
    $0.alwaysBounceVertical = true
    $0.showsHorizontalScrollIndicator = false
    $0.showsVerticalScrollIndicator = false
    $0.maximumZoomScale = 3
  }
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
    super.init(nibName: nil, bundle: nil)
    self.title = "Crop"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(cancelButtonDidTap)
    )
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneButtonDidTap)
    )

    self.automaticallyAdjustsScrollViewInsets = false
    self.imageView.image = image
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.scrollView.delegate = self
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
    self.initializeContentSizeIfNeeded()
  }


  // MARK: Scroll View Utils

  /// 이미지 뷰 크기와 스크롤 뷰 컨텐츠 크기를 초기화합니다.
  func initializeContentSizeIfNeeded() {
    guard self.imageView.size == .zero, let image = self.imageView.image else { return }

    let imageWidth = image.size.width
    let imageHeight = image.size.height

    if imageWidth > imageHeight {
      self.imageView.height = self.cropAreaView.height
      self.imageView.width = self.cropAreaView.height * imageWidth / imageHeight
    } else if imageWidth < imageHeight {
      self.imageView.width = self.cropAreaView.width
      self.imageView.height = self.cropAreaView.width * imageHeight / imageWidth
    } else {
      self.imageView.size = self.cropAreaView.size
    }

    let contentInsetTopBottom = (self.scrollView.height - self.cropAreaView.height) / 2
    self.scrollView.contentInset.top = contentInsetTopBottom
    self.scrollView.contentInset.bottom = contentInsetTopBottom
    self.scrollView.contentSize = self.imageView.size
    self.centerScrollView(animated: false)
  }

  func centerScrollView(animated: Bool) {
    let targetContentOffset = CGPoint(
      x: (self.scrollView.contentSize.width - self.scrollView.width) / 2,
      y: (self.scrollView.contentSize.height - self.scrollView.height) / 2
    )
    self.scrollView.setContentOffset(targetContentOffset, animated: animated)
  }


  // MARK: Actions

  func cancelButtonDidTap() {
    _ = self.navigationController?.popViewController(animated: true)
  }

  func doneButtonDidTap() {
    print("이미지 편집 완료")
    guard let image = self.imageView.image else { return }
    var rect = self.scrollView.convert(self.cropAreaView.frame, from: self.cropAreaView.superview)
    rect.origin.x *= image.size.width / self.imageView.width
    rect.origin.y *= image.size.height / self.imageView.height
    rect.size.width *= image.size.width / self.imageView.width
    rect.size.height *= image.size.height / self.imageView.height

    if let croppedCGImage = image.cgImage?.cropping(to: rect) {
      let croppedImage = UIImage(cgImage: croppedCGImage)
      print(croppedImage)
    }
  }

}


// MARK: - UIScrollViewDelegate

extension ImageCropViewController: UIScrollViewDelegate {

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.imageView
  }

}

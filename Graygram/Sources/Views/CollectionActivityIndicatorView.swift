//
//  CollectionActivityIndicatorView.swift
//  Graygram
//
//  Created by Suyeol Jeon on 17/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class CollectionActivityIndicatorView: UICollectionReusableView {

  fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.activityIndicatorView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

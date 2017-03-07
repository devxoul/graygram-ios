//
//  PostEditorMessageCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostEditorMessageCell: UITableViewCell {

  // MARK: UI

  fileprivate let textView = UITextView()


  // MARK: Initializing

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    self.contentView.addSubview(self.textView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

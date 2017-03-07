//
//  PostEditorMessageCell.swift
//  Graygram
//
//  Created by Suyeol Jeon on 08/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

final class PostEditorMessageCell: UITableViewCell {

  // MARK: Constants

  struct Font {
    static let textView = UIFont.systemFont(ofSize: 14)
  }


  // MARK: UI

  fileprivate let textView = UITextView()


  // MARK: Initializing

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    self.textView.font = Font.textView
    self.contentView.addSubview(self.textView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Configuring

  func configure(message: String) {
    self.textView.text = message
    self.setNeedsLayout()
  }


  // MARK: Size

  class func height(width: CGFloat, message: String) -> CGFloat {
    let messageHeight = message.size(width: width, font: Font.textView).height
    let minimumHeight = ceil(Font.textView.lineHeight * 3)
    return max(messageHeight, minimumHeight)
  }


  // MARK: Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    self.textView.frame = self.contentView.bounds
  }

}

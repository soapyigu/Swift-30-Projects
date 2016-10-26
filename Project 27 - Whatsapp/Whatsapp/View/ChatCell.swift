//
//  ChatCell.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
  
  lazy var nameLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
    $0.textColor = UIColor.gray
  }
  
  let messageLabel = UILabel()
  
  lazy var dateLabel = UILabel().then {
    $0.textColor = UIColor.gray
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

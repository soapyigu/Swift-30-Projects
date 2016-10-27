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
    
    setupLayouts()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayouts() {
    let nameLabelConstraints = [
      nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
    ]
    let messageLabelConstraints = [
      messageLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
    ]
    let dateLabelConstraints = [
      dateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      dateLabel.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor)
    ]
    
    Helper.setupContraints(view: nameLabel, superView: contentView, constraints: nameLabelConstraints)
    Helper.setupContraints(view: messageLabel, superView: contentView, constraints: messageLabelConstraints)
    Helper.setupContraints(view: dateLabel, superView: contentView, constraints: dateLabelConstraints)
  }
}

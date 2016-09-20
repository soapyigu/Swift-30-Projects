//
//  ChatCell.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

  let messageLabel = UILabel()
  private let bubbleImageView = UIImageView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupMessageLabel()
    setupBubbleImageView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupMessageLabel() {
    let messageLabelConstraints = [
      messageLabel.centerXAnchor.constraint(equalTo: bubbleImageView.centerXAnchor),
      messageLabel.centerYAnchor.constraint(equalTo: bubbleImageView.centerYAnchor)
    ]
    
    Helper.setupContraints(view: messageLabel, superView: bubbleImageView, constraints: messageLabelConstraints)
    
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 0
  }
  
  private func setupBubbleImageView() {
    let bubbleImageViewContraints = [
      bubbleImageView.widthAnchor.constraint(equalTo: messageLabel.widthAnchor),
      bubbleImageView.widthAnchor.constraint(equalToConstant: 50.0),
      bubbleImageView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor),
      bubbleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      bubbleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ]
    
    Helper.setupContraints(view: bubbleImageView, superView: contentView, constraints: bubbleImageViewContraints)
    
    bubbleImageView.tintColor = UIColor.blue
    bubbleImageView.image = UIImage(named: "MessageBubble")?.withRenderingMode(.alwaysTemplate)
  }
  
}

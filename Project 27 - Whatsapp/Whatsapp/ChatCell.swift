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
  
  private var outgoingConstraint: NSLayoutConstraint!
  private var incomingConstraint: NSLayoutConstraint!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupMessageLabel()
    setupBubbleImageView()
    setupLayouts()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - set up message label layouts and bubble imageView layouts
  private func setupMessageLabel() {
    let messageLabelConstraints = [
      messageLabel.centerXAnchor.constraint(equalTo: bubbleImageView.centerXAnchor),
      messageLabel.centerYAnchor.constraint(equalTo: bubbleImageView.centerYAnchor),
    ]
    
    Helper.setupContraints(view: messageLabel, superView: bubbleImageView, constraints: messageLabelConstraints)
    
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 1
  }
  
  private func setupBubbleImageView() {
    let bubbleImageViewContraints = [
      bubbleImageView.widthAnchor.constraint(equalTo: messageLabel.widthAnchor, multiplier: 1.0, constant: 50.0),
      bubbleImageView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor),
      bubbleImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
    ]
    
    Helper.setupContraints(view: bubbleImageView, superView: contentView, constraints: bubbleImageViewContraints)
    
    bubbleImageView.image = UIImage(named: "MessageBubble")!
}
  
  private func setupLayouts() {
    outgoingConstraint = bubbleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    incomingConstraint = bubbleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
  }
  
  // MARK: - set properties based on incoming or not
  public func incoming(incoming: Bool) {
    if incoming {
      incomingConstraint.isActive = true
      outgoingConstraint.isActive = false
    } else {
      incomingConstraint.isActive = false
      outgoingConstraint.isActive = true
    }
    
    setupImageView(incoming: incoming)
  }
  
  private func setupImageView(incoming: Bool) {
    let image = UIImage(named: "MessageBubble")!.withRenderingMode(.alwaysTemplate)
    let incomingInsets = UIEdgeInsets(top: 17, left: 26.5, bottom: 17.5, right: 21)
    let outgoingInsets = UIEdgeInsets(top: 17, left: 21, bottom: 17.5, right: 26.5)
    
    if incoming {
      bubbleImageView.tintColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
      bubbleImageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: UIImageOrientation.upMirrored).withRenderingMode(.alwaysTemplate).resizableImage(withCapInsets: incomingInsets)
    } else {
      bubbleImageView.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
      bubbleImageView.image = image.resizableImage(withCapInsets: outgoingInsets)
    }
  }
}


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
  
  private var outgoingConstraints: [NSLayoutConstraint]!
  private var incomingConstraints: [NSLayoutConstraint]!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.clear
    
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
    messageLabel.numberOfLines = 0
  }
  
  private func setupBubbleImageView() {
    let bubbleImageViewContraints = [
      bubbleImageView.widthAnchor.constraint(equalTo: messageLabel.widthAnchor, constant: 50.0),
      bubbleImageView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor, constant: 20.0),
      bubbleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
      bubbleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
    ]
    
    Helper.setupContraints(view: bubbleImageView, superView: contentView, constraints: bubbleImageViewContraints)
    
    bubbleImageView.image = UIImage(named: "MessageBubble")!
}
  
  private func setupLayouts() {
    outgoingConstraints = [
      bubbleImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: 5.0),
      bubbleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0)
    ]
    incomingConstraints = [
      bubbleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
      bubbleImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor, constant: -5.0)
    ]
  }
  
  // MARK: - set properties based on incoming or not
  public func incoming(incoming: Bool) {
    if incoming {
      NSLayoutConstraint.activate(incomingConstraints)
      NSLayoutConstraint.deactivate(outgoingConstraints)
    } else {
      NSLayoutConstraint.activate(outgoingConstraints)
      NSLayoutConstraint.deactivate(incomingConstraints)
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

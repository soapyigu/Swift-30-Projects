//
//  NewMessageView.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

final public class NewMessageView: UIView {
  // MARK: - UI Components
  lazy var inputTextView = UITextView().then {
    $0.isScrollEnabled = false
    $0.layer.cornerRadius = 5.0
  }
  
  lazy var sendButton = UIButton().then {
    $0.setTitle("Send", for: .normal)
    $0.setContentHuggingPriority(251, for: .horizontal)
    $0.setContentCompressionResistancePriority(751, for: .horizontal)
  }
  
  override public func didMoveToSuperview() {
    setupUI(superview: superview)
  }
  
  private func setupUI(superview: UIView?) {
    guard let superview = superview else {
      return
    }
    
    // set up layout
    translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      heightAnchor.constraint(equalToConstant: 50.0)
    ]
    
    NSLayoutConstraint.activate(constraints)
    
    
    // set up properties
    backgroundColor = UIColor.lightGray
    
    // set up components layouts
    let inputTextViewConstraints = [
      inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
      inputTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
      inputTextView.heightAnchor.constraint(equalTo: heightAnchor, constant: -20.0)
    ]
    Helper.setupContraints(view: inputTextView, superView: self, constraints: inputTextViewConstraints)
    
    let sendButtonConstraints = [
      sendButton.leadingAnchor.constraint(equalTo: inputTextView.trailingAnchor, constant: 10.0),
      sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
      sendButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      ]
    Helper.setupContraints(view: sendButton, superView: self, constraints: sendButtonConstraints)
  }
}

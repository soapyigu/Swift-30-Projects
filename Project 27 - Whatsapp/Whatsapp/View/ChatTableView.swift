//
//  ChatTableView.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

final public class ChatTableView: UITableView, Scroll {
  
  override public func didMoveToSuperview() {
    estimatedRowHeight = 56.0
    separatorStyle = .none
    backgroundView = UIImageView.init(image: UIImage.init(named: "wp_132"))
    
    setupUI(superview: superview)
  }
  
  private func setupUI(superview: UIView?) {
    guard let superview = superview else {
      return
    }
    
    let constraints = [
      topAnchor.constraint(equalTo: superview.topAnchor),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor)
    ]
    
    Helper.setupContraints(view: self, superView: superview, constraints: constraints)
  }
}

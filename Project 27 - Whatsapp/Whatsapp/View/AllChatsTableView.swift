//
//  AllChatsTableView.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

final public class AllChatsTableView: UITableView {
  public override func didMoveToWindow() {
    setupLayout(superview: superview)
  }
  
  private func setupLayout(superview: UIView?) {
    guard let superview = superview else {
      return
    }
    
    let constraints = [
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
    ]
    
    Helper.setupContraints(view: self, superView: superview, constraints: constraints)
  }
}

//
//  messageDatePaddingView.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

final class MessageDatePaddingView: UIView {
  
  // MARK: UI Components
  private var dateLabel = UILabel().then {
    $0.textAlignment = .center
  }
  
  public func setupDate(date: Date) {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MMM dd, YYYY"
    dateLabel.text = dateFormat.string(from: date)
  }
  
  override public func didMoveToSuperview() {
    setupUI(superview: superview)
  }
  
  private func setupUI(superview: UIView?) {
    guard let superview = superview else {
      return
    }
  
    layer.cornerRadius = 10.0
    layer.masksToBounds = true
    backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
    
    // set up layout
    translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      topAnchor.constraint(equalTo: superview.topAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    ]
    Helper.setupContraints(view: self, superView: superview, constraints: constraints)
    
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    let labelConstraints = [
      dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ]
    Helper.setupContraints(view: dateLabel, superView: self, constraints: labelConstraints)
    
    backgroundColor = UIColor.clear
  }
}

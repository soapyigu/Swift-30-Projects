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
    backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
    
    // set up layout
    translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      centerXAnchor.constraint(equalTo: superview.centerXAnchor),
      centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: -8)
    ]
    Helper.setupContraints(view: self, superView: superview, constraints: constraints)
    
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    let labelConstraints = [
      dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      dateLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -5),
      dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10)
    ]
    Helper.setupContraints(view: dateLabel, superView: self, constraints: labelConstraints)
  }
}

//
//  Helper.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import Foundation
import UIKit

public class Helper {
  public static func setupContraints(view: UIView, superView: UIView, constraints: [NSLayoutConstraint]) {
    view.translatesAutoresizingMaskIntoConstraints = false
    
    superView.addSubview(view)
    
    NSLayoutConstraint.activate(constraints)
  }
}

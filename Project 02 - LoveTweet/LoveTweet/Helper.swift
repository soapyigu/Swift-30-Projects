//
//  Helper.swift
//  LoveTweet
//
//  Copyright © 2017 YiGu. All rights reserved.
//

import UIKit
import Social

enum Gender: Int {
  case Male = 0, Female
}

extension Selector {
  static let endEditing = #selector(UIView.endEditing(_:))
}

extension UIViewController {
  func showAlert(title: String, message: String, buttonTitle: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

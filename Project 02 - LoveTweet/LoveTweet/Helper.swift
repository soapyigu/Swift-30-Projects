//
//  Helper.swift
//  LoveTweet
//
//  Copyright © 2017 YiGu. All rights reserved.
//

import UIKit
import Social

enum InterestedGender: String {
  case MEN = "Men"
  case WOMEN = "Women"
}

enum Gender: Int {
  case Male = 0, Female
}

extension Selector {
  static let endEditing = #selector(UIView.endEditing(_:))
}

extension UIViewController {
  func tweet(messenge m: String) {
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
      let twitterController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      twitterController.setInitialText(m)
      present(twitterController, animated: true, completion: nil)
    } else {
      showAlert(title: "Twitter Unavailable",
                message: "Please configure your twitter account on device",
                buttonTitle: "Ok")
    }
  }
  
  func showAlert(title: String, message: String, buttonTitle: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
}

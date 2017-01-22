//
//  Helper.swift
//  Birthdays
//
//  Copyright © 2017 Appcoda. All rights reserved.
//

import UIKit

class Helper {
  
  static func showMessage(message: String) {
    let alertController = UIAlertController(title: "Birthdays", message: message, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(dismissAction)
    
    let pushedViewControllers = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).viewControllers
    let presentedViewController = pushedViewControllers.last
    
    presentedViewController?.present(alertController, animated: true, completion: nil)
  }
}

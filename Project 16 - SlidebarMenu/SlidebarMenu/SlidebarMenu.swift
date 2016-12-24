//
//  SlidebarMenu.swift
//  SlidebarMenu
//
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation
import UIKit

extension Selector {
  static let toMenu = #selector(SWRevealViewController.revealToggle(_:))
  static let toExtra = #selector(SWRevealViewController.rightRevealToggle(_:))
}

extension UIViewController {
  func addSideBarMenu(leftMenuButton: UIBarButtonItem?, rightMenuButton: UIBarButtonItem? = nil) {
    if let revealVC = revealViewController() {
      if let menuButton = leftMenuButton {
        menuButton.target = revealVC
        menuButton.action = Selector.toMenu
      }
      
      if let extraButton = rightMenuButton {
        revealVC.rightViewRevealWidth = 150
        extraButton.target = revealVC
        extraButton.action = Selector.toExtra
      }
      
      view.addGestureRecognizer(revealVC.panGestureRecognizer())
    }
    
  }
}

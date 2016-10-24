//
//  Scroll.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import Foundation
import UIKit

protocol Scroll {
  func scrollToBottom()
}

extension Scroll where Self: UITableView {
  func scrollToBottom() {
    let lastSection = numberOfSections - 1
    guard lastSection >= 0 else {
      return
    }
    
    let lastRow = numberOfRows(inSection: lastSection) - 1
    guard lastRow >= 0 else {
      return
    }
    
    let indexPath = IndexPath.init(row: lastRow, section: lastSection)
    scrollToRow(at: indexPath, at: .bottom, animated: true)
  }
}

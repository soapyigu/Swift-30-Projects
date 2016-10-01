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
    let indexPath = IndexPath.init(row: self.numberOfRows(inSection: 0) - 1, section: 0)
    self.scrollToRow(at: indexPath, at: .bottom, animated: true)
  }
}

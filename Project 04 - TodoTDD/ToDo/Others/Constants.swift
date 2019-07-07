//
//  File.swift
//  ToDo
//
//  Created by gu, yi on 9/21/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import Foundation

struct Constants {
  static let MainBundleIdentifer = "Main"
  static let ItemListViewControllerIdentifier = "ItemListViewController"
  static let DetailViewControllerIdentifier = "DetailViewController"
  static let InputViewControllerIndentifier = "InputViewController"
  
  static let ItemCellIdentifier = "ItemCell"

  static let userName = "Crystal"
  static let password = "1234"
}

extension Notification {
  static let ItemSelectedNotification = Notification.Name("ItemSelectedNotification")
}

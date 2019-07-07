//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by gu, yi on 9/18/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import UIKit

enum Section: Int {
  case toDo
  case done
}

class ItemListDataProvider: NSObject {
  var itemManager: ToDoItemManager?
}

extension ItemListDataProvider: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let itemManager = itemManager else {
      return 0
    }
    guard let itemSection = Section(rawValue: section) else {
      fatalError()
    }
    
    let numberOfRows: Int
    
    switch itemSection {
    case .toDo:
      numberOfRows = itemManager.toDoCount
    case .done:
      numberOfRows = itemManager.doneCount
    }
    
    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ItemCellIdentifier, for: indexPath) as! ItemCell
    
    guard let itemManager = itemManager else {
      fatalError()
    }
    guard let itemSection = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    let item: ToDoItem
    
    switch itemSection {
    case .toDo:
      item = itemManager.item(at: indexPath.row)
    case .done:
      item = itemManager.doneItem(at: indexPath.row)
    }
    
    cell.configCell(with: item)
    
    return cell
  }
}

extension ItemListDataProvider: UITableViewDelegate {
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    
    guard let itemSection = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    let deleteTitle: String
    
    switch itemSection {
    case .toDo:
      deleteTitle = "Check"
    case .done:
      deleteTitle = "Uncheck"
    }
    
    return deleteTitle
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    guard let itemSection = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    switch itemSection {
    case .toDo:
      itemManager?.checkItem(at: indexPath.row)
    case .done:
      itemManager?.uncheckItem(at: indexPath.row)
    }
    
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let itemSection = Section(rawValue: indexPath.section) else {
      fatalError()
    }
    
    switch itemSection {
    case .toDo:
      NotificationCenter.default.post(
        name: Notification.ItemSelectedNotification,
        object: self,
        userInfo: ["index": indexPath.row])
    case .done:
      break
    }
  }
}

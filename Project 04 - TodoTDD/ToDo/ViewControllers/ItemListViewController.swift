//
//  ItemListViewController.swift
//  ToDo
//
//  Created by gu, yi on 9/18/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
  @IBOutlet var tableView: UITableView!
  @IBOutlet var dataProvider: ItemListDataProvider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
    
    dataProvider.itemManager = ToDoItemManager()
    
    NotificationCenter.default.addObserver(self, selector: #selector(showDetails(_:)), name: Notification.ItemSelectedNotification,
      object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  @objc func showDetails(_ sender: Notification) {
    guard let index = sender.userInfo?["index"] as? Int else {
      fatalError()
    }
    
    if let nextViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailViewControllerIdentifier) as? DetailViewController,
      let itemManager = dataProvider.itemManager {
      
      guard index < itemManager.toDoCount else {
        return
      }
      
      nextViewController.item = itemManager.item(at: index)
        
      navigationController?.pushViewController(nextViewController, animated: true)
    }
  }
    
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    guard let inputViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController else {
      return
    }
    inputViewController.itemManager = dataProvider.itemManager
    
    present(inputViewController, animated: true, completion: nil)
  }
}

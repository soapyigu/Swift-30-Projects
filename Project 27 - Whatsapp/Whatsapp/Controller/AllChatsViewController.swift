//
//  AllChatsViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit
import RealmSwift

class AllChatsViewController: UIViewController {
  
  private let tableView = UITableView(frame: CGRect.zero, style: .plain)
  private let cellIdentifier = "MessageCell"
  private let realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    title = "Chats"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "PenOS7"), style: .plain, target: self, action: "newChat")
  }
}

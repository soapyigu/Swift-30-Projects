//
//  AllChatsViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit
import RealmSwift

class AllChatsViewController: UIViewController {
  
  private let tableView = AllChatsTableView(frame: CGRect.zero, style: .plain)
  let cellIdentifier = "MessageCell"
  private let realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupTableView()
  }
  
  private func setupUI() {
    title = "Chats"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "PenOS7"), style: .plain, target: self, action: "newChat")
  }
  
  private func setupTableView() {
    // set up delegate
//    tableView.delegate = self
    tableView.dataSource = self
    
    // set up cell
    tableView.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
    
    // set up UI
    let tableViewContraints = [
      tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
    ]
    Helper.setupContraints(view: tableView, superView: view, constraints: tableViewContraints)
  }
  
  func loadChats() -> Array<Chat> {
    return Array(realm.objects(Chat.self).sorted(byProperty: "lastMessage", ascending: true))
  }
}

extension AllChatsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return loadChats().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatCell
    
    return cell
  }
}

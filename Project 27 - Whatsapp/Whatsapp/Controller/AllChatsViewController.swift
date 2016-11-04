//
//  AllChatsViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit
import RealmSwift

class AllChatsViewController: UIViewController {
  
  let cellIdentifier = "MessageCell"
  private let tableView = AllChatsTableView(frame: CGRect.zero, style: .plain)
  private let realm = try! Realm()
  
  var chats = [Chat]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupData()
    setupUI()
    setupTableView()
  }
  
  private func setupUI() {
    title = "Chats"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "PenOS7"), style: .plain, target: self, action: "newChat")
  }
  
  private func setupTableView() {
    // set up delegate
    tableView.delegate = self
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
  
  private func setupData() {
    chats = loadChats()
  }
  
  private func loadChats() -> Array<Chat> {
    return Array(realm.objects(Chat.self).sorted(byProperty: "lastMessage", ascending: true))
  }
}

extension AllChatsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chats.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatCell
    
    let chat = chats[indexPath.row]
    cell.messageLabel.text = chat.lastMessage?.text
    cell.dateLabel.text = Helper.dateToStr(date: chat.lastMessage?.date)
    
    return cell
  }
}

extension AllChatsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard chats.count > 0 else {
      return
    }
  }
}

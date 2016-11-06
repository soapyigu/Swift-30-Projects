//
//  AllChatsViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit
import RealmSwift

class AllChatsViewController: UIViewController {
  
  var chats: [Chat]?
  let cellIdentifier = "MessageCell"
  private let tableView = AllChatsTableView(frame: CGRect.zero, style: .plain)
  private let realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupData()
    setupUI()
    setupTableView()
  }
  
  private func setupUI() {
    title = "Chats"
    navigationController?.navigationBar.barTintColor = UIColor.white
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: "edit")
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
//    chats = loadChats()
  }
  
  private func loadChats() -> Array<Chat> {
    return Array(realm.objects(Chat.self).sorted(byProperty: "lastMessage", ascending: true))
  }
}

extension AllChatsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let _ = chats else {
      let label = UILabel.init(frame: CGRect(x: 10, y: 0, width: view.bounds.size.width - 20, height: view.bounds.size.height))
      
      // draw the result in a label
      label.attributedText = Helper.insertImageToWords(startWords: "To begin a new chat, simple tap on the ",
                                                       endWords: " icon in the top right corner.",
                                                       imageName: "PenOS7.png")
      
      label.sizeToFit()
      label.numberOfLines = 0
      label.font = UIFont(name: label.font.fontName, size: 20)
      label.textAlignment = .center
      tableView.backgroundView = label
      tableView.separatorStyle = .none
      
      return 0
    }
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let chats = chats else {
      return 0
    }
    return chats.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatCell
    
    if let chats = chats {
      let chat = chats[indexPath.row]
      cell.messageLabel.text = chat.lastMessage?.text
      cell.dateLabel.text = Helper.dateToStr(date: chat.lastMessage?.date)
    }
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
    guard let chats = chats else {
      return
    }
  }
}

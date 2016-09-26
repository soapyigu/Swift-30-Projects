//
//  ViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
  
  private let tableView = UITableView()
  private let newMessageView = NewMessageView()
  
  let cellIdentifier = "Cell"
  var messages = [Message]()
  
  var incoming: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNewMessageView()
    setupTableView()
    setupMessages()
  }
  
  private func setupTableView() {
    // set up delegate
    tableView.delegate = self
    tableView.dataSource = self
    
    // set up cell
    tableView.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
    
    // set up UI
    let tableViewContraints = [
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: newMessageView.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
    Helper.setupContraints(view: tableView, superView: view, constraints: tableViewContraints)
    
    tableView.separatorStyle = .none
  }
  
  private func setupMessages() {
    for _ in 0 ... 10 {
      let message = Message(text: "Hello, this is the longer message")
      message.incoming = incoming
      incoming = !incoming

      messages.append(message)
    }
  }
  
  private func setupNewMessageView() {
    view.addSubview(newMessageView)
  }
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatCell
    
    let message = messages[indexPath.row]
    cell.messageLabel.text = message.text
    cell.incoming(incoming: message.incoming)
    return cell
  }
}

extension ChatViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
}


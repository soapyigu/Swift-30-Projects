//
//  ViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
  
  private let tableView = UITableView()
  let cellIdentifier = "Cell"
  var messages = [Message]()
  
  var incoming: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    setupMessages()
  }
  
  private func setupTableView() {
    setupTableViewUI()
    setupTableViewDelegate()
  }
  
  private func setupTableViewUI() {
    let tableViewContraints = [
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
    
    Helper.setupContraints(view: tableView, superView: view, constraints: tableViewContraints)
  }
  
  private func setupTableViewDelegate() {
    tableView.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
    
    tableView.dataSource = self
  }
  
  private func setupMessages() {
    for i in 0 ... 10 {
      let message = Message(text: String(i))
      message.incoming = incoming
      incoming = !incoming

      messages.append(message)
    }
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


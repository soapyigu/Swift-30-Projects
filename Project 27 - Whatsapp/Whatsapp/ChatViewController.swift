//
//  ViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChatViewController: UIViewController {
  
  private let tableView = UITableView()
  private let newMessageView = NewMessageView()
  
  let cellIdentifier = "Cell"
  var messages = [Message]()
  
  var incoming: Bool = false
  private let disposeBag = DisposeBag()
  
  private var newMessageViewBottomConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNewMessageView()
    setupTableView()
    setupMessages()
    setupEvents()
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
    
    newMessageViewBottomConstraint = newMessageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    newMessageViewBottomConstraint.isActive = true
  }
  
  private func setupEvents() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
    view.addGestureRecognizer(tapGesture)
    
    // keyboard show up animation
    NotificationCenter.default
      .rx.notification(NSNotification.Name.UIKeyboardWillShow)
      .subscribe(
        onNext: {[unowned self] notification in
          guard let userInfo = notification.userInfo else {
            return
          }

          let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
          let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
          
          let frame = self.view.convert(keyboardFrame, from: (UIApplication.shared.delegate?.window)!)
          self.newMessageViewBottomConstraint.constant = frame.origin.y - self.view.frame.height
          UIView.animate(withDuration: animationDuration, animations: {
            self.view.layoutIfNeeded()
          })
      })
    .addDisposableTo(disposeBag)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
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


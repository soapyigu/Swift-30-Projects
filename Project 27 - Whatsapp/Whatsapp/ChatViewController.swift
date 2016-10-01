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
  // MARK: - Variables
  let cellIdentifier = "Cell"
  
  var messages = [Message]()
  var incoming: Bool = false
  
  private let tableView = UITableView()
  private let newMessageView = NewMessageView()
  private var newMessageViewBottomConstraint: NSLayoutConstraint!
  
  private let disposeBag = DisposeBag()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNewMessageView()
    setupTableView()
    setupMessages()
    setupEvents()
  }
  
  private func setupTableView() {
    tableView.estimatedRowHeight = 56.0
    
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
    // tap to dismiss keyboard
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
    view.addGestureRecognizer(tapGesture)
    
    // keyboard show up animation
    NotificationCenter.default
      .rx.notification(NSNotification.Name.UIKeyboardWillShow)
      .subscribe(
        onNext: { [unowned self] notification in
          self.updateBottomConstraint(forNotication: notification as NSNotification)
        }).addDisposableTo(disposeBag)
    
    // keyboard dismiss animation
    NotificationCenter.default
      .rx.notification(NSNotification.Name.UIKeyboardWillHide)
      .subscribe(
        onNext: { [unowned self] notification in
          self.updateBottomConstraint(forNotication: notification as NSNotification)
        }).addDisposableTo(disposeBag)
    
    // tap to send a new message
    let inputTextValidation = newMessageView.inputTextView
      .rx.text.map { !$0.isEmpty }
      .shareReplay(1)
    
    inputTextValidation
      .bindTo(newMessageView.sendButton.rx.enabled)
      .addDisposableTo(disposeBag)
    
    newMessageView.sendButton
      .rx.tap.subscribe(
        onNext: { [unowned self] _ in
          let message = Message(text: self.newMessageView.inputTextView.text)
          message.incoming = false
          self.messages.append(message)
          
          self.tableView.reloadData()
          self.scrollToBottom()
        }).addDisposableTo(disposeBag)

  }
  
  private func updateBottomConstraint(forNotication notification: NSNotification) {
    guard let userInfo = notification.userInfo else {
      return
    }
    
    switch notification.name {
    case NSNotification.Name.UIKeyboardWillShow:
      let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
      let frame = self.view.convert(keyboardFrame, from: (UIApplication.shared.delegate?.window)!)
      newMessageViewBottomConstraint.constant = frame.origin.y - view.frame.height
      break
      
    case NSNotification.Name.UIKeyboardWillHide:
      newMessageViewBottomConstraint.constant = 0.0
      break
      
    default:
      break
    }
    
    let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
    UIView.animate(withDuration: animationDuration, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  func scrollToBottom() {
    let indexPath = IndexPath.init(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
  }
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
}


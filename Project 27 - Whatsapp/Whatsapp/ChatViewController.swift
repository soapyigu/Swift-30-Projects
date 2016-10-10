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
  
  var incoming: Bool = false
  
  var messageSections = [Date: [Message]]()
  var dates = [Date]()
  
  private let tableView = ChatTableView()
  private let newMessageView = NewMessageView()
  private var newMessageViewBottomConstraint: NSLayoutConstraint!
  
  let date = Date.init(timeIntervalSince1970: 1100000000)
  
  private let disposeBag = DisposeBag()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNewMessageView()
    setupTableView()
    setupMessages()
    setupEvents()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.scrollToBottom()
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
  }
  
  private func setupMessages() {
    for i in 0 ... 10 {
      let message = Message(text: "Hello, this is the longer message", date: date)
      message.incoming = incoming
      incoming = !incoming
      
      if i % 2 == 0 {
        message.date = Date.init(timeInterval: 60 * 60 * 24, since: date)
      }

      addMessage(message: message)
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
          self.tableView.scrollToBottom()
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
          let message = Message(text: self.newMessageView.inputTextView.text, date: self.date)
          message.incoming = false
          self.addMessage(message: message)
          
          self.newMessageView.inputTextView.text = ""
          self.dismissKeyboard()
          
          self.tableView.reloadData()
          self.tableView.scrollToBottom()
        })
      .addDisposableTo(disposeBag)
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
  
  private func addMessage(message: Message) {
    guard let messageDate = message.date else {
      return
    }
    
    let startDay = NSCalendar.current.startOfDay(for: messageDate)
    
    if let _ = messageSections[startDay] {
      messageSections[startDay]!.append(message)
    } else {
      dates.append(startDay)
      messageSections[startDay] = [message]
    }
  }
  
  // MARK: - general helpful functions
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
  func getMessages(section: Int) -> [Message] {
    let date = dates[section]
    
    guard let messages = messageSections[date] else {
      return [Message]()
    }
    
    return messages
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return dates.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return getMessages(section: section).count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatCell
    
    let messages = getMessages(section: indexPath.section)
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

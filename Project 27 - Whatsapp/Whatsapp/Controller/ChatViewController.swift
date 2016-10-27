//
//  ViewController.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class ChatViewController: UIViewController {
  // MARK: - Variables
  var incoming: Bool = false
  var messageSections = [Date: [Message]]()
  var dates = [Date]()
  let cellIdentifier = "ChatCell"
  
  private let realm = try! Realm()
  private let disposeBag = DisposeBag()

  private let tableView = ChatTableView(frame: CGRect.zero, style: .grouped)
  private let newMessageView = NewMessageView()
  private var newMessageViewBottomConstraint: NSLayoutConstraint!
    
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNewMessageView()
    setupTableView()
    setupEvents()
    setupMessages()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.scrollToBottom()
  }
  
  private func setupTableView() {
    // set up delegate
    tableView.delegate = self
    tableView.dataSource = self
    
    // set up cell
    tableView.register(MessageCell.self, forCellReuseIdentifier: cellIdentifier)
    
    // set up UI
    let tableViewContraints = [
      tableView.bottomAnchor.constraint(equalTo: newMessageView.topAnchor)
    ]
    Helper.setupContraints(view: tableView, superView: view, constraints: tableViewContraints)
  }
  
  private func setupNewMessageView() {
    newMessageViewBottomConstraint = newMessageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    
    Helper.setupContraints(view: newMessageView, superView: view, constraints: [newMessageViewBottomConstraint])
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
          self.didSendButtonTap()
        })
      .addDisposableTo(disposeBag)
  }
  
  private func setupMessages() {
    // query all messages from realm
    let messages = realm.objects(Message.self).sorted(byProperty: "date", ascending: true)
    
    for message in messages {
      addMessage(message: message)
    }
  }
  
  private func didSendButtonTap() {
    let message = Message()
    message.text = newMessageView.inputTextView.text
    message.date = Date()
    message.incoming = false
    
    addMessage(message: message)
    
    // store message
    try! self.realm.write {
      self.realm.add(message)
    }
    
    newMessageView.inputTextView.text = ""
    dismissKeyboard()
    
    tableView.reloadData()
    tableView.scrollToBottom()
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
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessageCell
    
    let messages = getMessages(section: indexPath.section)
    let message = messages[indexPath.row]
    cell.messageLabel.text = message.text
    cell.incoming(incoming: message.incoming)
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clear
    
    let messageDateView = MessageDatePaddingView()
    messageDateView.setupDate(date: dates[section])
    
    headerView.addSubview(messageDateView)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
}

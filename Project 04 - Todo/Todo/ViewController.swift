//
//  ViewController.swift
//  Todo
//
//  Created by Yi Gu on 2/29/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

var todos: [ToDoItem] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

  @IBOutlet weak var todoTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    todos = [ToDoItem(id: "1", image: "child-selected", title: "Go to Disney", date: dateFromString("2014-10-20")!),
      ToDoItem(id: "2", image: "shopping-cart-selected", title: "Cicso Shopping", date: dateFromString("2014-10-28")!),
      ToDoItem(id: "3", image: "phone-selected", title: "Phone to Jobs", date: dateFromString("2014-10-30")!),
      ToDoItem(id: "4", image: "travel-selected", title: "Plan to Europe", date: dateFromString("2014-10-31")!)]
    
    todoTableView.delegate = self
    todoTableView.dataSource = self
  }
  
  // MARK: tableViewDataSource required
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (todos.count != 0) {
      return todos.count
    } else {
      let messageLabel: UILabel = UILabel()
      
      setMessageLabel(messageLabel, frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), text: "No data is currently available.", textColor: UIColor.blackColor(), numberOfLines: 0, textAlignment: NSTextAlignment.Center, font: UIFont(name:"Palatino-Italic", size: 20)!)
      
      self.todoTableView.backgroundView = messageLabel
      self.todoTableView.separatorStyle = UITableViewCellSeparatorStyle.None
      
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier: String = "todoCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    setCellWithTodoItem(cell, todo: todos[indexPath.row])
    
    return cell
  }
  
  // MARK: helper func
  func setMessageLabel(messageLabel: UILabel, frame: CGRect, text: String, textColor: UIColor, numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont) {
    messageLabel.frame = frame
    messageLabel.text = text
    messageLabel.textColor = textColor
    messageLabel.numberOfLines = numberOfLines
    messageLabel.textAlignment = textAlignment
    messageLabel.font = font
    messageLabel.sizeToFit()
  }
  
  func setCellWithTodoItem(cell: UITableViewCell, todo: ToDoItem) {
    let imageView: UIImageView = cell.viewWithTag(11) as! UIImageView
    let titleLabel: UILabel = cell.viewWithTag(12) as! UILabel
    let dateLabel: UILabel = cell.viewWithTag(13) as! UILabel
    
    imageView.image = UIImage(named: todo.image)
    titleLabel.text = todo.title
    dateLabel.text = stringFromDate(todo.date)
  }

}


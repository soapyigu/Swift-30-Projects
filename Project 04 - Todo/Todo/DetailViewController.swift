//
//  DetailViewController.swift
//  Todo
//
//  Created by Yi Gu on 3/1/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var childButton: UIButton!
  @IBOutlet weak var phoneButton: UIButton!
  @IBOutlet weak var shoppingCartButton: UIButton!
  @IBOutlet weak var travelButton: UIButton!
  @IBOutlet weak var todoTitleLabel: UITextField!
  @IBOutlet weak var todoDatePicker: UIDatePicker!
  
  var todo: ToDoItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if todo == nil {
      self.title = "New Todo"
      childButton.selected = true
    } else {
      self.title = "Edit Todo"
      if todo?.image == "child-selected"{
        childButton.selected = true
      }
      else if todo?.image == "phone-selected"{
        phoneButton.selected = true
      }
      else if todo?.image == "shopping-cart-selected"{
        shoppingCartButton.selected = true
      }
      else if todo?.image == "travel-selected"{
        travelButton.selected = true
      }
      
      todoTitleLabel.text = todo?.title
      todoDatePicker.setDate((todo?.date)!, animated: false)
    }
  }
  
  // MARK: type select
  @IBAction func selectChild(sender: AnyObject) {
    resetButtons()
    childButton.selected = true
  }
  
  @IBAction func selectPhone(sender: AnyObject) {
    resetButtons()
    phoneButton.selected = true
  }
  
  @IBAction func selectShoppingCart(sender: AnyObject) {
    resetButtons()
    shoppingCartButton.selected = true
  }
  
  @IBAction func selectTravel(sender: AnyObject) {
    resetButtons()
    travelButton.selected = true
  }
  
  func resetButtons() {
    childButton.selected = false
    phoneButton.selected = false
    shoppingCartButton.selected = false
    travelButton.selected = false
  }
  
  // MARK: create or edit a new todo
  @IBAction func tapDone(sender: AnyObject) {
    var image = ""
    if childButton.selected {
      image = "child-selected"
    }
    else if phoneButton.selected {
      image = "phone-selected"
    }
    else if shoppingCartButton.selected {
      image = "shopping-cart-selected"
    }
    else if travelButton.selected {
      image = "travel-selected"
    }
    
    if todo == nil {
      let uuid = NSUUID().UUIDString
      todo = ToDoItem(id: uuid, image: image, title: todoTitleLabel.text!, date: todoDatePicker.date)
      todos.append(todo!)
    } else {
      todo?.image = image
      todo?.title = todoTitleLabel.text!
      todo?.date = todoDatePicker.date
    }
  }
}

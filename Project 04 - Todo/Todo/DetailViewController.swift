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
      childButton.isSelected = true
    } else {
      self.title = "Edit Todo"
      if todo?.image == "child-selected"{
        childButton.isSelected = true
      }
      else if todo?.image == "phone-selected"{
        phoneButton.isSelected = true
      }
      else if todo?.image == "shopping-cart-selected"{
        shoppingCartButton.isSelected = true
      }
      else if todo?.image == "travel-selected"{
        travelButton.isSelected = true
      }
      
      todoTitleLabel.text = todo?.title
      todoDatePicker.setDate((todo?.date)! as Date, animated: false)
    }
  }
  
  // MARK: type select
  @IBAction func selectChild(_ sender: AnyObject) {
    resetButtons()
    childButton.isSelected = true
  }
  
  @IBAction func selectPhone(_ sender: AnyObject) {
    resetButtons()
    phoneButton.isSelected = true
  }
  
  @IBAction func selectShoppingCart(_ sender: AnyObject) {
    resetButtons()
    shoppingCartButton.isSelected = true
  }
  
  @IBAction func selectTravel(_ sender: AnyObject) {
    resetButtons()
    travelButton.isSelected = true
  }
  
  func resetButtons() {
    childButton.isSelected = false
    phoneButton.isSelected = false
    shoppingCartButton.isSelected = false
    travelButton.isSelected = false
  }
  
  // MARK: create or edit a new todo
  @IBAction func tapDone(_ sender: AnyObject) {
    var image = ""
    if childButton.isSelected {
      image = "child-selected"
    }
    else if phoneButton.isSelected {
      image = "phone-selected"
    }
    else if shoppingCartButton.isSelected {
      image = "shopping-cart-selected"
    }
    else if travelButton.isSelected {
      image = "travel-selected"
    }
    
    if todo == nil {
      let uuid = UUID().uuidString
      todo = ToDoItem(id: uuid, image: image, title: todoTitleLabel.text!, date: todoDatePicker.date)
      todos.append(todo!)
    } else {
      todo?.image = image
      todo?.title = todoTitleLabel.text!
      todo?.date = todoDatePicker.date
    }
    
    self.navigationController?.popToRootViewController(animated: true)
  }
}

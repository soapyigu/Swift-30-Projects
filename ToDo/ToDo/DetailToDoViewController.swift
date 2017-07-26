//
//  DetailToDoViewController.swift
//  ToDo
//
//  Created by Song Zixin on 7/26/17.
//  Copyright © 2017 Silk Song. All rights reserved.
//

import UIKit

protocol DetailToDoViewControllerDelegate: class {
    func detailToDoViewController(_ controller: DetailToDoViewController, addNewTodo todo: Todo)
    func detailToDoViewController(_ controller: DetailToDoViewController, editTodo todo: Todo)
}

class DetailToDoViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: DetailToDoViewControllerDelegate?
    var editTodo: Todo?
    
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var chartButton: UIButton!
    
    @IBAction func tapChildButton(_ sender: Any) {
        resetButton()
        childButton.isSelected = true
    }
    
    @IBAction func tapPhoneButton(_ sender: Any) {
        resetButton()
        phoneButton.isSelected = true
    }
    
    @IBAction func tapChartButton(_ sender: Any) {
        resetButton()
        chartButton.isSelected = true
    }
    
    @IBAction func tapTravelButton(_ sender: Any) {
        resetButton()
        travelButton.isSelected = true
    }
    
    func resetButton() {
        childButton.isSelected = false
        phoneButton.isSelected = false
        chartButton.isSelected = false
        travelButton.isSelected = false
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        
        if todoTitle.text == "" {
            let alertController = UIAlertController(title: "Reminder", message: "Please fill in Todo Title", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            var imageName: String
            
            if childButton.isSelected {
                imageName = "child-selected"
            } else if phoneButton.isSelected {
                imageName = "phone-selected"
            } else if chartButton.isSelected {
                imageName = "shopping-cart-selected"
            } else {
                imageName = "travel-selected"
            }
            
            if let editTodo = editTodo {
                editTodo.title = todoTitle.text!
                editTodo.date = todoDate.date
                editTodo.imageName = imageName
                delegate?.detailToDoViewController(self, editTodo: editTodo)
            } else {
                
                let newTodo = Todo(title: todoTitle.text!, date: todoDate.date, imageName: imageName)
                delegate?.detailToDoViewController(self, addNewTodo: newTodo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        if let editTodo = editTodo {
            todoTitle.text = editTodo.title
            todoDate.setDate(editTodo.date, animated: true)
            navigationItem.title = "Edit Todo"
            
            switch editTodo.imageName {
            case "child-selected":
                resetButton()
                childButton.isSelected = true
            case "phone-selected":
                resetButton()
                phoneButton.isSelected = true
            case "shopping-cart-selected":
                resetButton()
                chartButton.isSelected = true
            case "travel-selected":
                resetButton()
                travelButton.isSelected = true
            default:
                return
            }
            
        } else {
            childButton.isSelected = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        todoTitle.resignFirstResponder()
        return true
    }

    
    

}

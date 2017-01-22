//
//  CreateContactViewController.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import Contacts

class CreateContactViewController: UIViewController {
  
  @IBOutlet weak var txtFirstname: UITextField!
  @IBOutlet weak var txtLastname: UITextField!
  @IBOutlet weak var txtHomeEmail: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    txtFirstname.delegate = self
    txtLastname.delegate = self
    txtHomeEmail.delegate = self
    
    let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(CreateContactViewController.createContact))
    navigationItem.rightBarButtonItem = saveBarButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: Custom functions
  
  func createContact() {
    
  }
}

// MARK: UITextFieldDelegate functions
extension CreateContactViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

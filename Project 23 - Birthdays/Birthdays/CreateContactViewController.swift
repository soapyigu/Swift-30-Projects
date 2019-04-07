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
    
    let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(CreateContactViewController.createContact))
    navigationItem.rightBarButtonItem = saveBarButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: Custom functions
  
  @objc func createContact() {
    let newContact = CNMutableContact()
    
    newContact.givenName = txtFirstname.text!
    newContact.familyName = txtLastname.text!
    
    if let homeEmail = txtHomeEmail.text {
      let homeEmail = CNLabeledValue(label: CNLabelHome, value: homeEmail as NSString)
      newContact.emailAddresses = [homeEmail]
    }
    
    let birthdayComponents = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: datePicker.date)
    newContact.birthday = birthdayComponents
    
    do {
      let saveRequest = CNSaveRequest()
      saveRequest.add(newContact, toContainerWithIdentifier: nil)
      try AppDelegate.appDelegate.contactStore.execute(saveRequest)
      
      navigationController?.popViewController(animated: true)
    } catch {
      Helper.show(message: "Unable to save the new contact.")
    }
  }
}

// MARK: UITextFieldDelegate functions
extension CreateContactViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

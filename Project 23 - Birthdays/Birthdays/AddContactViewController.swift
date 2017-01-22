//
//  AddContactViewController.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import Contacts

class AddContactViewController: UIViewController {
  
  @IBOutlet weak var txtLastName: UITextField!
  @IBOutlet weak var pickerMonth: UIPickerView!
  
  let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  
  var currentlySelectedMonthIndex = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pickerMonth.delegate = self
    txtLastName.delegate = self
    
    let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(AddContactViewController.performDoneItemTap))
    navigationItem.rightBarButtonItem = doneBarButtonItem
  }
  
  // MARK: IBAction functions
  
  @IBAction func showContacts(_ sender: AnyObject) {
    
  }
}
  
// MARK: UIPickerView Delegate and Datasource functions
extension AddContactViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return months.count
  }
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return months[row]
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    currentlySelectedMonthIndex = row + 1
  }
}

// MARK: UITextFieldDelegate functions
extension AddContactViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    AppDelegate.appDelegate.requestForAccess { (accessGranted) -> Void in
      if accessGranted {
        let predicate = CNContact.predicateForContacts(matchingName: self.txtLastName.text!)
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey]
        var contacts = [CNContact]()
        var message: String!
      }
    }
    
    return true
  }
  
  // MARK: Custom functions
  
  func performDoneItemTap() {
    
  }
}

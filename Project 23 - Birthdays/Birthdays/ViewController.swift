//
//  ViewController.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
  
  @IBOutlet weak var tblContacts: UITableView!
  
  var contacts = [CNContact]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.tintColor = UIColor(red: 241.0/255.0, green: 107.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    
    configureTableView()
  }
  
  // MARK: IBAction functions
  @IBAction func addContact(_ sender: AnyObject) {
    performSegue(withIdentifier: "idSegueAddContact", sender: self)
  }
  
  // MARK: Custom functions
  func configureTableView() {
    tblContacts.delegate = self
    tblContacts.dataSource = self
    tblContacts.register(UINib(nibName: "ContactBirthdayCell", bundle: nil), forCellReuseIdentifier: "idCellContactBirthday")
  }
  
  
  /// Set ViewController class as the delegate of the AddContactViewControllerDelegate protocol
  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      if identifier == "idSegueAddContact" {
        let addContactViewController = segue.destination as! AddContactViewController
        addContactViewController.delegate = self
      }
    }
  }
}

// MARK: UITableView Delegate and Datasource functions
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "idCellContactBirthday") as! ContactBirthdayCell
    
    let currentContact = contacts[indexPath.row]
    
    cell.lblFullname.text = "\(currentContact.givenName) \(currentContact.familyName)"
    
    // Set the birthday info.
    if let birthday = currentContact.birthday {
      cell.lblBirthday.text = "\(birthday.year)-\(birthday.month)-\(birthday.day)"
    }
    else {
      cell.lblBirthday.text = "Not available birthday data"
    }
    
    // Set the contact image.
    if let imageData = currentContact.imageData {
      cell.imgContactImage.image = UIImage(data: imageData)
    }
    
    // Set the contact's home email address.
    var homeEmailAddress: String!
    for emailAddress in currentContact.emailAddresses {
      if emailAddress.label == CNLabelHome {
        homeEmailAddress = emailAddress.value as String
        break
      }
    }
    if let homeEmailAddress = homeEmailAddress {
      cell.lblEmail.text = homeEmailAddress
    } else {
      cell.lblEmail.text = "Not available home email"
    }
    
    return cell
    
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
}

extension ViewController: AddContactViewControllerDelegate {
  func didFetchContacts(_ contacts: [CNContact]) {
    for contact in contacts {
      self.contacts.append(contact)
    }
    
    tblContacts.reloadData()
  }
}


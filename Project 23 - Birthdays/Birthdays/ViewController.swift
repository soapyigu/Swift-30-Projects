//
//  ViewController.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

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
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    
    cell.lblFullname.text = CNContactFormatter.string(from: currentContact, style: .fullName)
    
    if !currentContact.isKeyAvailable(CNContactBirthdayKey) || !currentContact.isKeyAvailable(CNContactImageDataKey) ||  !currentContact.isKeyAvailable(CNContactEmailAddressesKey) {
      refetch(contact: currentContact, atIndexPath: indexPath)
    } else {
      // Set the birthday info.
      if let birthday = currentContact.birthday {
        cell.lblBirthday.text = birthday.asString
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
    }
    
    return cell
    
  }
  
  fileprivate func refetch(contact: CNContact, atIndexPath indexPath: IndexPath) {
    AppDelegate.appDelegate.requestForAccess { (accessGranted) -> Void in
      if accessGranted {
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName), CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey] as [Any]
        
        do {
          let contactRefetched = try AppDelegate.appDelegate.contactStore.unifiedContact(withIdentifier: contact.identifier, keysToFetch: keys as! [CNKeyDescriptor])
          self.contacts[indexPath.row] = contactRefetched
          
          DispatchQueue.main.async {
            self.tblContacts.reloadRows(at: [indexPath], with: .automatic)
          }
        }
        catch {
          print("Unable to refetch the contact: \(contact)", separator: "", terminator: "\n")
        }
      }
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      contacts.remove(at: indexPath.row)
      tblContacts.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedContact = contacts[indexPath.row]
    
    let keys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName), CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey] as [Any]
    
    if selectedContact.areKeysAvailable([CNContactViewController.descriptorForRequiredKeys()]) {
      let contactViewController = CNContactViewController(for: selectedContact)
      contactViewController.contactStore = AppDelegate.appDelegate.contactStore
      contactViewController.displayedPropertyKeys = keys
      navigationController?.pushViewController(contactViewController, animated: true)
    }
    else {
      AppDelegate.appDelegate.requestForAccess(completionHandler: { (accessGranted) -> Void in
        if accessGranted {
          do {
            let contactRefetched = try AppDelegate.appDelegate.contactStore.unifiedContact(withIdentifier: selectedContact.identifier, keysToFetch: [CNContactViewController.descriptorForRequiredKeys()])
            
            DispatchQueue.main.async {
              let contactViewController = CNContactViewController(for: contactRefetched)
              contactViewController.contactStore = AppDelegate.appDelegate.contactStore
              contactViewController.displayedPropertyKeys = keys
              self.navigationController?.pushViewController(contactViewController, animated: true)
            }
          }
          catch {
            print("Unable to refetch the selected contact.", separator: "", terminator: "\n")
          }
        }
      })
    }
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


//
//  ViewController.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tblContacts: UITableView!
  
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
}
  
// MARK: UITableView Delegate and Datasource functions
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    return cell
    
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
}


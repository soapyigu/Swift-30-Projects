//
//  ViewController.swift
//  HitList
//
//  Created by Yi Gu on 3/8/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var names: [String] = []
  
  // MARK - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "The List"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK - UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier: String = "cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    
    cell.textLabel!.text = names[indexPath.row]
    
    return cell
  }
  
  // MARK - IBActions
  @IBAction func addName(sender: AnyObject) {
    let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {(action: UIAlertAction) -> Void in
      let textField = alert.textFields!.first
      self.names.append(textField!.text!)
      self.tableView.reloadData()
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(action: UIAlertAction) -> Void in
    })
    
    alert.addTextFieldWithConfigurationHandler {
      (textField: UITextField) -> Void in
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    presentViewController(alert, animated: true, completion: nil)
  }

}


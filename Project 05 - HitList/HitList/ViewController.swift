//
//  ViewController.swift
//  HitList
//
//  Created by Yi Gu on 3/8/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var people: [NSManagedObject] = []
  
  // MARK - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigationTitle()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    self.fetchCoreData(managedContext)
  }

  func setupNavigationTitle() {
    title = "The List"
  }
  
  func fetchCoreData(managedContext: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest(entityName: "Person")
    
    do {
      let results =
      try managedContext.executeFetchRequest(fetchRequest)
      people = results as! [NSManagedObject]
    } catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }

  }
  
  // MARK - UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier: String = "cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    
    let person = people[indexPath.row]
    cell.textLabel!.text = person.valueForKey("name") as? String
    
    return cell
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    switch editingStyle {
    case .Delete:
      // remove the deleted item from the model
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      let managedContext = appDelegate.managedObjectContext
      managedContext.deleteObject(people[indexPath.row] as NSManagedObject)
      do {
        try managedContext.save()
        people.removeAtIndex(indexPath.row)
      } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
      }
      
      //tableView.reloadData()
      // remove the deleted item from the `UITableView`
      self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    default:
      return
      
    }
  }
  
  // MARK - IBActions
  @IBAction func addName(sender: AnyObject) {
    let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {(action: UIAlertAction) -> Void in
      let textField = alert.textFields!.first
      self.saveName(textField!.text!)
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
  
  // MARK - CoreData func
  func saveName(name: String) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let entity =  NSEntityDescription.entityForName("Person",
      inManagedObjectContext:managedContext)
    let person = NSManagedObject(entity: entity!,
      insertIntoManagedObjectContext: managedContext)
    
    person.setValue(name, forKey: "name")
    
    do {
      try managedContext.save()
      people.append(person)
    } catch let error as NSError  {
      print("Could not save \(error), \(error.userInfo)")
    }
  }

}


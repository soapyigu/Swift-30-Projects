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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    self.fetchCoreData(managedContext)
  }

  func setupNavigationTitle() {
    title = "The List"
  }
  
  func fetchCoreData(_ managedContext: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    
    do {
      let results =
      try managedContext.fetch(fetchRequest)
      people = results as! [NSManagedObject]
    } catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }

  }
  
  // MARK - UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier: String = "cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
    let person = people[indexPath.row]
    cell.textLabel!.text = person.value(forKey: "name") as? String
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      // remove the deleted item from the model
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedContext = appDelegate.managedObjectContext
      managedContext.delete(people[indexPath.row] as NSManagedObject)
      do {
        try managedContext.save()
        people.remove(at: indexPath.row)
      } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
      }
      
      //tableView.reloadData()
      // remove the deleted item from the `UITableView`
      self.tableView.deleteRows(at: [indexPath], with: .fade)
    default:
      return
      
    }
  }
  
  // MARK - IBActions
  @IBAction func addName(_ sender: AnyObject) {
    let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action: UIAlertAction) -> Void in
      let textField = alert.textFields!.first
      self.saveName(textField!.text!)
      self.tableView.reloadData()
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction) -> Void in
    })
    
    alert.addTextField {
      (textField: UITextField) -> Void in
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  // MARK - CoreData func
  func saveName(_ name: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let entity =  NSEntityDescription.entity(forEntityName: "Person",
      in:managedContext)
    let person = NSManagedObject(entity: entity!,
      insertInto: managedContext)
    
    person.setValue(name, forKey: "name")
    
    do {
      try managedContext.save()
      people.append(person)
    } catch let error as NSError  {
      print("Could not save \(error), \(error.userInfo)")
    }
  }

}


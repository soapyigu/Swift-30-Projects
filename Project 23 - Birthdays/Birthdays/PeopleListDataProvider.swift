//
//  PeopleListDataProvider.swift
//  Birthdays
//
//  Created by dasdom on 27.03.15.
//  Copyright (c) 2015 Dominik Hauser. All rights reserved.
//

import UIKit
import CoreData

public class PeopleListDataProvider: NSObject, PeopleListDataProviderProtocol {
  
  public var managedObjectContext: NSManagedObjectContext?
  weak public var tableView: UITableView!
  var _fetchedResultsController: NSFetchedResultsController? = nil
  
  let dateFormatter: NSDateFormatter
  
  override public init() {
    dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .LongStyle
    dateFormatter.timeStyle = .NoStyle
    
    super.init()
  }
  
  public func addPerson(personInfo: PersonInfo) {
    let context = self.fetchedResultsController.managedObjectContext
    let entity = self.fetchedResultsController.fetchRequest.entity!
    let person = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Person
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    person.firstName = personInfo.firstName
    person.lastName = personInfo.lastName
    person.birthday = personInfo.birthday
    
    // Save the context.
    var error: NSError? = nil
    do {
      try context.save()
    } catch let error1 as NSError {
      error = error1
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      print("Unresolved error \(error), \(error!.userInfo)")
      abort()
    }
  }
  
  func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
    let person = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
    cell.textLabel!.text = person.fullname
    cell.detailTextLabel!.text = dateFormatter.stringFromDate(person.birthday)
  }
  
//  public func personForIndexPath(indexPath: NSIndexPath) -> Person? {
//    return fetchedResultsController.objectAtIndexPath(indexPath) as? Person
//  }
//  
  public func fetch() {
    let sortKey = NSUserDefaults.standardUserDefaults().integerForKey("sort") == 0 ? "lastName" : "firstName"
    
    let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: true)
    let sortDescriptors = [sortDescriptor]
    
    fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
    var error: NSError? = nil
    do {
      try fetchedResultsController.performFetch()
    } catch let error1 as NSError {
      error = error1
      print("error: \(error)")
    }
    tableView.reloadData()
  }
}

// MARK: UITableViewDataSource
extension PeopleListDataProvider: UITableViewDataSource {
  
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.fetchedResultsController.sections?.count ?? 0
  }
  
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionInfo = self.fetchedResultsController.sections![section] 
    return sectionInfo.numberOfObjects
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
    self.configureCell(cell, atIndexPath: indexPath)
    return cell
  }
  
  public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      let context = self.fetchedResultsController.managedObjectContext
      context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
      
      var error: NSError? = nil
      do {
        try context.save()
      } catch let error1 as NSError {
        error = error1
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //println("Unresolved error \(error), \(error.userInfo)")
        abort()
      }
    }
  }
  
}

// MARK: NSFetchedResultsControllerDelegate
extension PeopleListDataProvider: NSFetchedResultsControllerDelegate {
  
  var fetchedResultsController: NSFetchedResultsController {
    if _fetchedResultsController != nil {
      return _fetchedResultsController!
    }
    
    let fetchRequest = NSFetchRequest()
    // Edit the entity name as appropriate.
    let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.managedObjectContext!)
    fetchRequest.entity = entity
    
    // Set the batch size to a suitable number.
    fetchRequest.fetchBatchSize = 20
    
    // Edit the sort key as appropriate.
    let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
    let sortDescriptors = [sortDescriptor]
    
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
    aFetchedResultsController.delegate = self
    _fetchedResultsController = aFetchedResultsController
    
    var error: NSError? = nil
    do {
      try _fetchedResultsController!.performFetch()
    } catch let error1 as NSError {
      error = error1
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      //println("Unresolved error \(error), \(error.userInfo)")
      abort()
    }
    
    return _fetchedResultsController!
  }
  
  public func controllerWillChangeContent(controller: NSFetchedResultsController) {
    self.tableView.beginUpdates()
  }
  
  public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    switch type {
    case .Insert:
      self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
    case .Delete:
      self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
    default:
      return
    }
  }
  
  public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    case .Delete:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    case .Update:
      self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
    case .Move:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    default:
      return
    }
  }
  
  public func controllerDidChangeContent(controller: NSFetchedResultsController) {
    self.tableView.endUpdates()
  }

}

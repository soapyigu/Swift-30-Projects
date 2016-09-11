//
//  PeopleListDataProviderProtocol.swift
//  Birthdays
//
//  Created by dasdom on 27.03.15.
//  Copyright (c) 2015 Dominik Hauser. All rights reserved.
//

import UIKit
import CoreData
import AddressBookUI

public protocol PeopleListDataProviderProtocol: UITableViewDataSource {
  var managedObjectContext: NSManagedObjectContext? { get }
  weak var tableView: UITableView! { get set }
  
  func addPerson(personInfo: PersonInfo)
  func fetch()
}

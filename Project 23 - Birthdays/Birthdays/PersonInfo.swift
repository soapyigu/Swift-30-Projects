//
//  PersonInfo.swift
//  Birthdays
//
//  Created by dasdom on 28.03.15.
//  Copyright (c) 2015 Dominik Hauser. All rights reserved.
//

import Foundation
import AddressBookUI

public struct PersonInfo {
  let firstName: String
  let lastName: String
  let birthday: NSDate
  
  public init(firstName: String, lastName: String, birthday: NSDate) {
    self.firstName = firstName
    self.lastName = lastName
    self.birthday = birthday
  }
  
  init(abRecord: ABRecord) {
    self.firstName = ABRecordCopyValue(abRecord, kABPersonFirstNameProperty).takeRetainedValue() as! String
    self.lastName = ABRecordCopyValue(abRecord, kABPersonLastNameProperty).takeRetainedValue() as! String
    self.birthday = ABRecordCopyValue(abRecord, kABPersonBirthdayProperty).takeRetainedValue() as! NSDate
  }
}
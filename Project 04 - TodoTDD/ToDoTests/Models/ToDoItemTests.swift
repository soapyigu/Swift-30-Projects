//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by gu, yi on 9/6/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
  
  let timestamp = 0.0
  let locationName = "Location"
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_init_givenTitle_setsTitle() {
    let toDoItem = ToDoItem(title: Foo)
    
    XCTAssertEqual(toDoItem.title, Foo, "should set title")
  }
  
  func test_init_givenItemDescription_setsItemDescription() {
    let toDoItem = ToDoItem(title: Foo, itemDescription: Bar)
    
    XCTAssertEqual(toDoItem.title, Foo, "should set title")
    XCTAssertEqual(toDoItem.itemDescription, Bar, "should set itemDescription")
  }
  
  func test_init_givenTimeStamp_setsTimeStamp() {
    let toDoItem = ToDoItem(title: Foo, timeStamp: timestamp)
    
    XCTAssertEqual(toDoItem.timestamp, timestamp, "should set timeStamp")
  }
  
  func test_init_givenLocation_setsLocation() {
    
    let location = Location(name: locationName)
    let toDoItem = ToDoItem(title: Foo, location: Location(name: locationName))
    
    XCTAssertEqual(toDoItem.location, location, "should set location")
  }
  
  func test_init_hasPlistDictionaryProperty() {
    let toDoItem = ToDoItem(title: "First")
    let dictionary = toDoItem.plistDict
    
    XCTAssertNotNil(dictionary)
  }
  
  func test_canBeCreatedFromPlistDictionary() {
    let location = Location(name: "Bar")
    let toDoItem = ToDoItem(title: "Foo", itemDescription: "Baz", timeStamp: 1.0, location: location)
    
    let dict = toDoItem.plistDict
    let recreatedItem = ToDoItem(dict: dict)
    
    XCTAssertEqual(recreatedItem, toDoItem)
  }
  
}

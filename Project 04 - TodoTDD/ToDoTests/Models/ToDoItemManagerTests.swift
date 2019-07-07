//
//  ToDoItemManagerTests.swift
//  ToDoTests
//
//  Created by gu, yi on 9/6/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemManagerTests: XCTestCase {
  
  var itemManager: ToDoItemManager!
  let titleForFirstToAdd = "first"
  let titleForSecondToAdd = "second"
  
  override func setUp() {
    super.setUp()
    
    itemManager = ToDoItemManager()
  }
  
  override func tearDown() {
    itemManager.removeAll()
    itemManager = nil
    
    super.tearDown()
  }
  
  func test_init_toDoCountIsZero() {
    XCTAssertEqual(itemManager.toDoCount, 0, "toDoCount should be 0")
  }
  
  func test_init_doneCountIsZero() {
    XCTAssertEqual(itemManager.doneCount, 0, "toDoCount should be 0")
  }
  
  func test_addItem_increaseToDoCountByOne() {
    let expectToDoCount = itemManager.toDoCount + 1
    itemManager.add(ToDoItem(title: ""))
    
    XCTAssertEqual(itemManager.toDoCount, expectToDoCount, "toDoCount should increase by 1")
  }
  
  func test_itemAt_givenLastIndex_returnsAddedItem() {
    let item = ToDoItem(title: titleForFirstToAdd)
    itemManager.add(item)
    
    XCTAssertEqual(itemManager.item(at: itemManager.toDoCount - 1), item, "should return added item")
  }
  
  func test_checkItemAt_givenFirstIndex_removesFromToDoItems() {
    let firstItem = ToDoItem(title: titleForFirstToAdd)
    let secondItem = ToDoItem(title: titleForSecondToAdd)
    
    itemManager.add(firstItem)
    itemManager.add(secondItem)
    
    XCTAssertEqual(itemManager.item(at: 0), firstItem, "first item should be added")
    
    let expectToDoCount = itemManager.toDoCount - 1
    
    itemManager.checkItem(at: 0)
    
    XCTAssertEqual(itemManager.item(at: 0), secondItem, "first item should be removed")
    XCTAssertEqual(itemManager.toDoCount, expectToDoCount, "toDoCount should decrease by 1")
  }
  
  func test_checkItemAt_givenFirstIndex_addsToDoneItems() {
    let firstItem = ToDoItem(title: titleForFirstToAdd)
    let secondItem = ToDoItem(title: titleForSecondToAdd)
    
    itemManager.add(firstItem)
    itemManager.add(secondItem)
    
    XCTAssertEqual(itemManager.doneCount, 0, "done items should be empty")
    
    let expectDoneCount = itemManager.doneCount + 1
    
    itemManager.checkItem(at: 0)
    
    XCTAssertEqual(itemManager.doneItem(at: 0), firstItem, "first item should be removed")
    XCTAssertEqual(itemManager.doneCount, expectDoneCount, "doneCount should increase by 1")
  }
  
  func test_removeAll_clearsItems() {
    let firstItem = ToDoItem(title: titleForFirstToAdd)
    let secondItem = ToDoItem(title: titleForSecondToAdd)
    
    itemManager.add(firstItem)
    itemManager.add(secondItem)
    
    itemManager.removeAll()
    
    XCTAssertEqual(itemManager.toDoCount, 0, "toDoCount should be 0")
    XCTAssertEqual(itemManager.doneCount, 0, "doneCount should be 0")
  }
  
  func test_ToDoItemsGetSerialized() {
    let firstItem = ToDoItem(title: "First")
    itemManager.add(firstItem)
    
    let secondItem = ToDoItem(title: "Second")
    itemManager.add(secondItem)
    
    NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
  
    XCTAssertEqual(itemManager?.toDoCount, 2)
    XCTAssertEqual(itemManager?.item(at: 0), firstItem)
    XCTAssertEqual(itemManager?.item(at: 1), secondItem)
  }
}

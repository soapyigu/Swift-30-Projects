//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by gu, yi on 9/20/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
  
  // MARK: - Variables
  var tableView: UITableView!
  var dataProvider: ItemListDataProvider!
  var itemManager: ToDoItemManager!
  
  // MARK: - Life Cycle
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: Constants.MainBundleIdentifer, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: Constants.ItemListViewControllerIdentifier) as! ItemListViewController
    controller.loadViewIfNeeded()
    tableView = controller.tableView
    
    dataProvider = ItemListDataProvider()
    itemManager = ToDoItemManager()
    
    dataProvider.itemManager = itemManager
    tableView.dataSource = dataProvider
  }
  
  override func tearDown() {
    itemManager.removeAll()
    
    super.tearDown()
  }
  
  // MARK: - NumberOfSections
  func test_numberOfSections_init_isTwo() {
    XCTAssertEqual(tableView.numberOfSections, 2, "number of sections should be 2")
  }
  
  // MARK: - NumberOfRows
  func test_numberOfRowsOfToDoSection_init_isToDoCount() {
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0, "number of rows in toDo section should be 0 at first")
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), itemManager.toDoCount, "number of rows in toDo section should be equal to toDoCount of itemManager")
  }
  
  func test_numberOfRowsOfToDoSection_addToDoItem_isToDoCount() {
    itemManager.add(ToDoItem(title: Foo))
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1, "number of rows in toDo section increase to be 1 after adding a new item")
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), itemManager.toDoCount, "number of rows in toDo section should be equal to toDoCount of itemManager")
  }
  
  func test_numberOfRowsOfToDoSection_checkToDoItem_isToDoCount() {
    itemManager.add(ToDoItem(title: Foo))
    itemManager.checkItem(at: 0)
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0, "number of rows in toDo section should be 0 after all items checked")
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), itemManager.toDoCount, "number of rows in toDo section should be equal to toDoCount of itemManager")
  }
  
  func test_numberOfRowsOfToDoSection_removeAllItems_isToDoCount() {
    itemManager.add(ToDoItem(title: Foo))
    itemManager.removeAll()
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0, "number of rows in toDo section should be 0 after all items removed")
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), itemManager.toDoCount, "number of rows in toDo section should be equal to toDoCount of itemManager")
  }
  
  func test_numberOfRowsOfDoneSection_init_isDoneCount() {
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0, "number of rows in done section should be 0 at first")
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), itemManager.doneCount, "number of rows in done section should be equal to doneCount of itemManager")
  }
  
  func test_numberOfRowsOfDoneSection_addDoneItem_isDoneCount() {
    itemManager.add(ToDoItem(title: Foo))
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0, "number of rows in done section should keep to be 0 after adding a new item")
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), itemManager.doneCount, "number of rows in done section should be equal to doneCount of itemManager")
  }
  
  func test_numberOfRowsOfDoneSection_checkToDoItem_isDoneCount() {
    itemManager.add(ToDoItem(title: Foo))
    itemManager.checkItem(at: 0)
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1, "number of rows in done section should be 1 after one item checked")
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), itemManager.doneCount, "number of rows in done section should be equal to doneCount of itemManager")
  }
  
  func test_numberOfRowsOfDoneSection_removeAllItems_isDoneCount() {
    itemManager.add(ToDoItem(title: Foo))
    itemManager.removeAll()
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0, "number of rows in done section should be 0 after all items removed")
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), itemManager.doneCount, "number of rows in done section should be equal to doneCount of itemManager")
  }
  
  // MARK: - CellForRow
  func test_cellForRow_init_isItemCell() {
    itemManager.add(ToDoItem(title: Foo))
    tableView.reloadData()
    
    // if tableView is not init from storyboard, it cannot configure cell to ItemCell as it cannot find the right identifier
    let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
    
    XCTAssertTrue(cell is ItemCell, "should be ItemCell")
  }
  
  func test_cellForRow_givenToDoItem_callsCellDequeue() {
    let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)
    
    itemManager.add(ToDoItem(title: Foo))
    mockTableView.reloadData()
    
    _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
    XCTAssertTrue(mockTableView.dequeueCellGotCalled, "cell should be dequeued")
  }
  
  func test_cellForRow_givenToDoItem_callsConfigCell() {
    let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)
    
    let item = ToDoItem(title: Foo)
    itemManager.add(item)
    mockTableView.reloadData()
    
    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
    XCTAssertTrue(cell.configCellGotCalled, "cell should be dequeued")
    XCTAssertEqual(cell.cachedItem, item, "config item should be the one added")
  }
  
  func test_cellForRow_givenDoneItem_callsConfigCell() {
    let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)
    
    let item = ToDoItem(title: Foo)
    itemManager.add(item)
    itemManager.checkItem(at: 0)
    mockTableView.reloadData()
    
    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
    XCTAssertTrue(cell.configCellGotCalled, "cell should be dequeued")
    XCTAssertEqual(cell.cachedItem, item, "config item should be the one added")
  }
  
  // MARK: - UITableViewDelegate
  func test_deleteButton_inToDoSection_showsTitleCheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(
      tableView,
      titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                          section: 0))
    
    XCTAssertEqual(deleteButtonTitle, "Check")
  }
  
  func test_deleteButton_inDoneSection_showsTitleCheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
    
    XCTAssertEqual(deleteButtonTitle, "Uncheck")
  }
  
  func test_checkAnItem_inToDoSection_changesItemsNum() {
    itemManager.add(ToDoItem(title: Foo))
    
    tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
    
    XCTAssertEqual(itemManager.toDoCount, 0, "should remove toDo item")
    XCTAssertEqual(itemManager.doneCount, 1, "should add done item")
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0, "toDo item number should be 0")
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1, "done item number should be 1")
  }
  
  func test_checkAnItem_inDoneSection_changesItemsNum() {
    itemManager.add(ToDoItem(title: Foo))
    itemManager.checkItem(at: 0)
    tableView.reloadData()
    
    tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
    
    XCTAssertEqual(itemManager.toDoCount, 1, "should add toDo item")
    XCTAssertEqual(itemManager.doneCount, 0, "should remove done item")
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1, "toDo item number should be 1")
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0, "done item number should be 0")
  }
  
}

extension ItemListDataProviderTests {
  // Mock a table view to ensure the dequeCell function is called.
  class MockTableView: UITableView {
    var dequeueCellGotCalled = false
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      
      dequeueCellGotCalled = true
      
      return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
      let mockTableView = MockTableView()
      
      mockTableView.dataSource = dataSource
      mockTableView.register(MockItemCell.self, forCellReuseIdentifier: Constants.ItemCellIdentifier)
      
      return mockTableView
    }
  }
  
  class MockItemCell: ItemCell {
    var configCellGotCalled = false
    var cachedItem: ToDoItem?
    
    override func configCell(with item: ToDoItem, isChecked: Bool = false) {
      
      configCellGotCalled = true
      cachedItem = item
    }
  }
}

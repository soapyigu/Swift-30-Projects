//
//  ItemListViewControllerTests.swift
//  ToDoTests
//
//  Created by gu, yi on 9/18/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {
  
  var itemListViewController: ItemListViewController!
  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    itemListViewController = (storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController)
    
    itemListViewController.loadViewIfNeeded()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_init_hasTableView() {
    
    XCTAssertTrue(itemListViewController.tableView.isDescendant(of: itemListViewController.view))
  }
  
  func test_init_givenDataProvider_setsTableViewDataSource() {
    
    XCTAssertTrue(itemListViewController.tableView.dataSource is ItemListDataProvider, "dataProvider should be the dataSource to tableView")
  }
  
  func test_init_givenDataProvider_setsTableViewDelegate() {
  
    XCTAssertTrue(itemListViewController.tableView.delegate is ItemListDataProvider, "dataProvider should be the dataSource to tableView")
  }
  
  func test_init_givenDataProvider_dataSourceEqualsDelegate() {
    
    XCTAssertEqual(itemListViewController.tableView.dataSource as? ItemListDataProvider,
                   itemListViewController.tableView.delegate as? ItemListDataProvider, "dataSource and delegate should be the same")
  }
  
  func test_init_itemListViewController_hasAddBarButtonWithSelfAsTarget() {
    
    let target = itemListViewController.navigationItem.rightBarButtonItem?.target
    XCTAssertEqual(target as? UIViewController, itemListViewController)
  }
  
  func test_addItem_inputViewController_shouldPresent() {
    
    XCTAssertNil(itemListViewController.presentedViewController)
    
    _test_performAddItem()
    
    XCTAssertNotNil(itemListViewController.presentedViewController)
    XCTAssertTrue(itemListViewController.presentedViewController is InputViewController)
  }
  
  func test_addItem_inputViewController_sharesItemManagerWithItemListViewController() {
    _test_performAddItem()
    
    guard let inputViewController = itemListViewController.presentedViewController as? InputViewController else {
      XCTFail()
      return
    }
    guard let inputItemManager = inputViewController.itemManager else {
      XCTFail()
      return
    }
    
    guard let itemManager = itemListViewController.dataProvider.itemManager else {
      XCTFail()
      return
    }
    
    XCTAssert(itemManager === inputItemManager)
  }
  
  func test_addItem_givenSave_shouldHaveNewItem() {
    _test_performAddItem()
    
    XCTAssertEqual(itemListViewController.tableView.numberOfRows(inSection: Section.toDo.rawValue), 0)
    
    guard let inputViewController = itemListViewController.presentedViewController as? InputViewController else {
      XCTFail()
      return
    }
    
    inputViewController.titleTextField = UITextField()
    inputViewController.titleTextField.text = "Foo"
    inputViewController.save()

    // trigger view will appear
    itemListViewController.viewWillAppear(true)
    
    XCTAssertEqual(itemListViewController.tableView.numberOfRows(inSection: Section.toDo.rawValue), 1)
  }
  
  private func _test_performAddItem() {
    guard let addItemButton = itemListViewController.navigationItem.rightBarButtonItem else {
      return XCTFail()
    }
    guard let action = addItemButton.action else {
      return XCTFail()
    }
    
    // set item list view controller as root so that it is visible in view hierachy
    UIApplication.shared.keyWindow?.rootViewController = itemListViewController
    
    itemListViewController.performSelector(onMainThread: action,
                                           with: addItemButton,
                                           waitUntilDone: true)
  }
  
  func test_selectToDoItemCell_shouldPresentDetailViewController() {
    let mockNavigationController = MockNavigationController(rootViewController: itemListViewController)
    
    UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
    
    let testItem = ToDoItem(title: "foo")
    itemListViewController.dataProvider.itemManager = ToDoItemManager()
    itemListViewController.dataProvider.itemManager?.add(testItem)
    
    // reload data to make sure tableview gets updated
    itemListViewController.tableView.reloadData()
    
    // select row 0
    NotificationCenter.default.post(
      name: Notification.ItemSelectedNotification,
      object: self,
      userInfo: ["index": 0])
    
    guard let detailViewController = mockNavigationController.lastPushedViewController as? DetailViewController else {
        return XCTFail()
    }
    
    guard let detailItem = detailViewController.item else {
      return XCTFail()
    }
    
    detailViewController.loadViewIfNeeded()
    
    XCTAssertEqual(detailItem, testItem)
  }
}

extension ItemListViewControllerTests {
  class MockNavigationController : UINavigationController {
    
    var lastPushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      lastPushedViewController = viewController
      super.pushViewController(viewController, animated: animated)
    }
  }
}


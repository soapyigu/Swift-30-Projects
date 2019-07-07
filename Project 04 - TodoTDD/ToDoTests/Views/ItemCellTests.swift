//
//  ItemCellTests.swift
//  ToDoTests
//
//  Created by gu, yi on 9/26/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTests: XCTestCase {
    
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: Constants.MainBundleIdentifer, bundle: nil)
        let itemListViewController = storyboard.instantiateViewController(withIdentifier: Constants.ItemListViewControllerIdentifier) as! ItemListViewController
        itemListViewController.loadViewIfNeeded()
        
        let tableView = itemListViewController.tableView
        let fakeDataSource = FakeDataSource()
        tableView?.dataSource = fakeDataSource
        
      cell = (tableView?.dequeueReusableCell(withIdentifier: Constants.ItemCellIdentifier, for: IndexPath(row: 0, section: 0)) as! ItemCell)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - init
    func test_init_givenTableViewDataSource_hasNameLabel() {
        // make sure it is not nil is not enough, we have to make sure it is in the content view
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func test_init_givenTableViewDataSource_hasLocationLabel() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_init_givenTableViewDataSource_hasDateLabel() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    // MARK: - configCell
    func test_configCell_givenTitle_setsTitle() {
        let toDoItem = ToDoItem(title: Foo)
        
        cell.configCell(with: toDoItem)
        
        XCTAssertEqual(cell.titleLabel.text, toDoItem.title)
    }
    
    func test_configCell_givenLocation_setsLocation() {
        let location = Location(name: Bar)
        let toDoItem = ToDoItem(title: Foo, location: location)
        
        cell.configCell(with: toDoItem)
        
        XCTAssertEqual(cell.locationLabel.text, Bar)
    }
    
    func test_configCell_givenDate_setsDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: testDate)
        let timeStamp = date?.timeIntervalSince1970
        
        let toDoItem = ToDoItem(title: Foo, timeStamp: timeStamp)
        
        cell.configCell(with: toDoItem)
        
        XCTAssertEqual(cell.dateLabel.text, testDate)
    }
    
    func test_configCell_itemIsChecked_titleIsStrokeThrough() {
        let location = Location(name: Bar)
        let toDoItem = ToDoItem(title: Foo, timeStamp: 1456150025, location: location)
        
        cell.configCell(with: toDoItem, isChecked: true)
        
        let attributedString = NSAttributedString(
            string: Foo,
            attributes: [NSAttributedString.Key.strikethroughStyle:
                NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}

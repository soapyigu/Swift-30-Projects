//
//  ToDoUITests.swift
//  ToDoUITests
//
//  Created by Yi Gu on 7/6/19.
//  Copyright © 2019 gu, yi. All rights reserved.
//

import XCTest

class ToDoUITests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    
  }
  
  // make sure 'Hardware -> Keyboard -> Connect hardware keyboard' is off.
  func testAddToDo() {
    
    let app = XCUIApplication()
    app.navigationBars["ToDo.ItemListView"].buttons["Add"].tap()
    
    let titleTextField = app.textFields["Title"]
    titleTextField.tap()
    titleTextField.typeText("Meeting")
    
    let addressTextField = app.textFields["Address"]
    addressTextField.tap()
    addressTextField.typeText("650 Castro St, Mountain View")
    
    let descriptionTextField = app.textFields["Description"]
    descriptionTextField.tap()
    descriptionTextField.typeText("Quora")

    // Please change the value of pickerWheels to today to make the test work
    let datePickersQuery = app.datePickers
    datePickersQuery.pickerWheels["2019"].adjust(toPickerWheelValue: "2019")
    datePickersQuery.pickerWheels["July"].adjust(toPickerWheelValue: "April")
    datePickersQuery.pickerWheels["7"].adjust(toPickerWheelValue: "1")
    
    // tap anywhere to dismiss keyboard
    app.keyboards.buttons["return"].tap()
    
    // go back to previous page
    app.buttons["Save"].tap()
    
    XCTAssertTrue(app.tables.staticTexts["Meeting"].exists)
    XCTAssertTrue(app.tables.staticTexts["04/01/2019"].exists)
    XCTAssertTrue(app.tables.staticTexts["650 Castro St, Mountain View"].exists)
  }
}

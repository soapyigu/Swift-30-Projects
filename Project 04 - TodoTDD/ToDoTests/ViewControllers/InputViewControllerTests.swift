//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by Yi Gu on 5/4/19.
//  Copyright © 2019 gu, yi. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class InputViewControllerTests: XCTestCase {
  
  var inputViewController: InputViewController!
  var placemark: MockPlacemark!
  
  override func setUp() {
    super.setUp()
    
    let storyboard = UIStoryboard(name: Constants.MainBundleIdentifer, bundle: nil)
    inputViewController = (storyboard.instantiateViewController(withIdentifier: Constants.InputViewControllerIndentifier) as! InputViewController)
    
    inputViewController.loadViewIfNeeded()
  }
  
  override func tearDown() {
    inputViewController.itemManager?.removeAll()
    
    super.tearDown()
  }
  
  func test_init_hasTitleTextField() {
    XCTAssertTrue(inputViewController.titleTextField.isDescendant(of: inputViewController.view))
  }
  
  func test_init_hasLocationTextField() {
    XCTAssertTrue(inputViewController.locationTextField.isDescendant(of: inputViewController.view))
  }
  
  func test_init_hasDescriptionTextField() {
    XCTAssertTrue(inputViewController.descriptionTextField.isDescendant(of: inputViewController.view))
  }
  
  func test_init_hasDatePicker() {
    XCTAssertTrue(inputViewController.datePicker.isDescendant(of: inputViewController.view))
  }
  
  func test_init_hasCanelButton() {
    XCTAssertTrue(inputViewController.cancelButton.isDescendant(of: inputViewController.view))
  }
  
  func test_init_hasSaveButton() {
    XCTAssertTrue(inputViewController.saveButton.isDescendant(of: inputViewController.view))
  }
  
  func test_init_hasSaveAction() {
    let saveButton = inputViewController.saveButton
    
    guard let actions = saveButton?.actions(forTarget: inputViewController, forControlEvent: .touchUpInside) else {
      XCTFail()
      return
    }
    
    XCTAssertTrue(actions.contains("save"))
  }
  
  func test_save_usesGeocoderToGetCoordinateFromAddress() {
    let mockInputViewController = MockInputViewController()
    mockInputViewController.titleTextField = UITextField()
    mockInputViewController.datePicker = UIDatePicker()
    mockInputViewController.descriptionTextField = UITextField()
    mockInputViewController.locationTextField = UITextField()
    
    mockInputViewController.titleTextField.text = "Foo"
    
    // input a new item and save
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let timestamp = 1456095600.0
    let date = Date(timeIntervalSince1970: timestamp)
    mockInputViewController.datePicker.date = date
    
    mockInputViewController.descriptionTextField.text = "Bar"
    mockInputViewController.locationTextField.text = "Infinite Loop 1, Cupertino"
    
    let mockGeocoder = MockGeocoder()
    mockInputViewController.geocoder = mockGeocoder
    
    mockInputViewController.itemManager = ToDoItemManager()
    
    let dismissExpectation = expectation(description: "Dismiss")
    
    mockInputViewController.completionHandler = {
      dismissExpectation.fulfill()
    }
    
    mockInputViewController.save()
    
    placemark = MockPlacemark()
    let coordinate = CLLocationCoordinate2DMake(37.3316851,
                                                -122.0300674)
    placemark.mockCoordinate = coordinate
    mockGeocoder.completionHandler?([placemark], nil)
    
    waitForExpectations(timeout: 3, handler: nil)
    
    // create the expected item
    let testItem = ToDoItem(title: "Foo",
                            itemDescription: "Bar",
                            timeStamp: timestamp,
                            location: Location(name: "Infinite Loop 1, Cupertino",
                                               coordinate: coordinate))
    
    let item = mockInputViewController.itemManager?.item(at: 0)
    XCTAssertEqual(item, testItem)
    
    mockInputViewController.itemManager?.removeAll()
  }
  
  func test_save_dismissSelf() {
    let mockInputViewController = MockInputViewController()
    
    mockInputViewController.titleTextField = UITextField()
    mockInputViewController.titleTextField.text = "Foo"
   
    mockInputViewController.save()
  
    XCTAssertTrue(mockInputViewController.dismissGotCalled)
    
    mockInputViewController.itemManager?.removeAll()
  }
  
  func test_cancel_dismissSelf() {
    let mockInputViewController = MockInputViewController()
    
    mockInputViewController.cancel()
    
    XCTAssertTrue(mockInputViewController.dismissGotCalled)
    
    mockInputViewController.itemManager?.removeAll()
  }
  
  func test_Geocoder_FetchesCoordinates() {
    let geocoderAnswered = expectation(description: "Geocoder")
    
    let address = "Infinite Loop 1, Cupertino"
    
    CLGeocoder().geocodeAddressString(address) { placemarks, error -> Void in
      let coordinate = placemarks?.first?.location?.coordinate
      
      guard let latitude = coordinate?.latitude else {
        XCTFail()
        return
      }
      guard let longitude = coordinate?.longitude else {
        XCTFail()
        return
      }
      
      XCTAssertEqual(latitude, 37.3316, accuracy: 0.001)
      XCTAssertEqual(longitude, -122.0301, accuracy: 0.001)
      
      geocoderAnswered.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
}

extension InputViewControllerTests {
  class MockGeocoder: CLGeocoder {
    
    var completionHandler: CLGeocodeCompletionHandler?
    
    override func geocodeAddressString(
      _ addressString: String,
      completionHandler: @escaping CLGeocodeCompletionHandler) {
      
      self.completionHandler = completionHandler
    }
  }
  
  class MockPlacemark : CLPlacemark {
    
    var mockCoordinate: CLLocationCoordinate2D?
    
    override var location: CLLocation? {
      guard let coordinate = mockCoordinate else {
        return CLLocation()
      }
      
      return CLLocation(latitude: coordinate.latitude,
                        longitude: coordinate.longitude)
    }
  }
  
  class MockInputViewController : InputViewController {
    
    var dismissGotCalled = false
    var completionHandler: (() -> Void)?
    
    override func dismiss(animated flag: Bool,
                          completion: (() -> Void)? = nil) {
      
      dismissGotCalled = true
      completionHandler?()
    }
  }
}

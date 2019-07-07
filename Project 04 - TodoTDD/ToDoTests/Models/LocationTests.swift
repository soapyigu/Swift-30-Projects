//
//  LocationTests.swift
//  ToDoTests
//
//  Created by gu, yi on 9/6/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class LocationTests: XCTestCase {
  
  let locationName = "LocationName"
  let latitude = 1.0
  let longitude = 2.0
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_init_givenName_setsName() {
    let location = Location(name: locationName)
    
    XCTAssertEqual(location.name, locationName, "should set name")
  }
  
  func test_init_givenCoordinate_setsCoordinate() {
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let location = Location(name: "", coordinate: coordinate)
    
    XCTAssertEqual(location.coordinate?.latitude, latitude, "should set latitude")
    XCTAssertEqual(location.coordinate?.longitude, longitude, "should set longitude")
  }
  
  func test_init_hasPlistDictionaryProperty() {
    let location = Location(name: "Home")
    let dictionary = location.plistDict
    
    XCTAssertNotNil(dictionary)
  }
  
  func test_canBeSerializedAndDeserialized() {
    let location = Location(
      name: "Home",
      coordinate: CLLocationCoordinate2DMake(50.0, 6.0))
    
    let dict = location.plistDict
    let recreatedLocation = Location(dict: dict)
    
    XCTAssertEqual(recreatedLocation, location)
    
  }
}

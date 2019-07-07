//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Yi Gu on 5/11/19.
//  Copyright © 2019 gu, yi. All rights reserved.
//

import XCTest
@testable import ToDo

class APIClientTests: XCTestCase {
  
  var apiClient: APIClient!
  var urlSession: MockURLSession!
  
  override func setUp() {
    apiClient = APIClient()
    urlSession = MockURLSession()
    
    apiClient.session = urlSession
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_login_usesExpectedHost() {
    
    let completion = { (token: Token?, error: Error?) in }
    apiClient.loginUser(with: Constants.userName, password: Constants.password, completion: completion)
    
    guard let _ = urlSession.url else {
      XCTFail();
      return
    }
    
    XCTAssertEqual(urlSession.urlComponents?.host, "awesometodos.com")
  }
  
  func test_login_usesExpectedPath() {
    let completion = { (token: Token?, error: Error?) in }
    apiClient.loginUser(with: Constants.userName, password: Constants.password, completion: completion)
    
    guard let _ = urlSession.url else {
      XCTFail();
      return
    }
    
    XCTAssertEqual(urlSession.urlComponents?.path, "/login")
  }
  
  func test_login_usesExpectedQuery() {
    let completion = { (token: Token?, error: Error?) in }
    apiClient.loginUser(with: Constants.userName, password: Constants.password, completion: completion)
    
    guard let _ = urlSession.url else {
      XCTFail();
      return
    }
    
    XCTAssertEqual(urlSession.urlComponents?.query, "username=\(Constants.userName)&password=\(Constants.password)")
  }
  
  func test_login_givenSuccessResponse_createsToken() {
    
    let jsonData = "{\"token\": \"1234567890\"}".data(using: .utf8)
    let mockURLSession = MockURLSession(data: jsonData)
    apiClient.session = mockURLSession
    
    let tokenExpectation = expectation(description: "Token")
    
    var caughtToken: Token?
    apiClient.loginUser(with: Constants.userName, password: Constants.password) { (token, _) in
      caughtToken = token
      tokenExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { _ in
      XCTAssertEqual(caughtToken?.id, "1234567890")
    }
  }
  
  func test_login_givenJSONIsInvalid_returnsError() {
    
    let mockURLSession = MockURLSession(data: Data())
    apiClient.session = mockURLSession
    
    let errorExpectation = expectation(description: "Error")
    
    var catchedError: Error?
    apiClient.loginUser(with: Constants.userName, password: Constants.password) { (_, error) in
      catchedError = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { _ in
      XCTAssertNotNil(catchedError)
    }
  }
  
  func test_login_givenJSONIsNil_returnsError() {
    
    let mockURLSession = MockURLSession()
    apiClient.session = mockURLSession
    
    let errorExpectation = expectation(description: "Error")
    
    var catchedError: Error?
    apiClient.loginUser(with: Constants.userName, password: Constants.password) { (_, error) in
      catchedError = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { _ in
      XCTAssertNotNil(catchedError)
    }
  }
  
  func test_login_givenFailResponse_returnsError() {
    
    let jsonData = "{\"token\": \"1234567890\"}".data(using: .utf8)
    let error = NSError(domain: "SomeError", code: 1234, userInfo: nil)
    let mockURLSession = MockURLSession(data: jsonData, error: error)
    apiClient.session = mockURLSession
    
    let errorExpectation = expectation(description: "Error")
    
    var catchedError: Error?
    apiClient.loginUser(with: Constants.userName, password: Constants.password) { (_, error) in
      catchedError = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { _ in
      XCTAssertNotNil(catchedError)
    }
  }
}

extension APIClientTests {
  class MockURLSession: Sessionable {
    
    var url: URL?
    var urlComponents: URLComponents? {
      guard let url = url else {
        return nil
      }
      return URLComponents(url: url, resolvingAgainstBaseURL: true)
    }
    
    private let dataTask: MockTask
    
    init(data: Data? = nil, urlResponse: URLResponse? = nil, error: Error? = nil) {
      dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
      
      self.url = url
      dataTask.completionHandler = completionHandler
      
      return dataTask
    }
  }
  
  class MockTask: URLSessionDataTask {
    
    private let data: Data?
    private let urlResponse: URLResponse?
    private let responseError: Error?
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
  
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
      self.data = data
      self.urlResponse = urlResponse
      self.responseError = error
    }
    
    override func resume() {
      DispatchQueue.main.async() {
        self.completionHandler?(self.data,
                                self.urlResponse,
                                self.responseError)
      }
    }
  }
}

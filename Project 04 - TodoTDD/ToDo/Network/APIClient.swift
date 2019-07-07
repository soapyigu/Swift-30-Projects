//
//  APIClient.swift
//  ToDo
//
//  Created by Yi Gu on 5/11/19.
//  Copyright © 2019 gu, yi. All rights reserved.
//

import Foundation

enum NetworkError : Error {
  case DataEmptyError
}

class APIClient {
  
  lazy var session: Sessionable = URLSession.shared

  func loginUser(with name:String , password: String, completion: @escaping (Token?, Error?) -> Void) {
    
    let query = "username=\(Constants.userName)&password=\(Constants.password)"
    guard let url = URL(string: "https://awesometodos.com/login?\(query)") else {
      fatalError()
    }
    
    session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(nil, error)
        return
      }
      
      guard let data = data else {
        completion(nil, NetworkError.DataEmptyError)
        return
      }
      
      do {
        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
        
        var token: Token? = nil
       
        if let tokenString = dict?["token"] {
          token = Token(id: tokenString)
        }
        completion(token, nil)
      } catch {
        completion(nil, error)
      }
    }.resume()
  }
}

extension URLSession: Sessionable { }

protocol Sessionable {
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

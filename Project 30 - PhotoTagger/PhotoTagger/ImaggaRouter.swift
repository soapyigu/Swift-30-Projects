//
//  ImaggaRouter.swift
//  PhotoTagger
//
//  Created by Yi Gu on 8/4/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import Alamofire

public enum ImaggaRouter: URLRequestConvertible {
  static let baseURLPath = "http://api.imagga.com/v1"
  static let authenticationToken = "Basic YWNjXzM5MWRkMjU2NjE4ZWU0Mzo2NWFjODVmMzNhNWE1YmQ3YTMzZGJkNzFjNTlmYTM5Yw=="
  
  case content
  case tags(String)
  case colors(String)
  
  var method: HTTPMethod {
    switch self {
    case .content:
      return .post
    case .tags, .colors:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .content:
      return "/content"
    case .tags:
      return "/tagging"
    case .colors:
      return "/colors"
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let parameters: [String: Any] = {
      switch self {
      case .tags(let contentID):
        return ["content": contentID]
      case .colors(let contentID):
        return ["content": contentID, "extract_object_colors": 0]
      default:
        return [:]
      }
    }()
    
    let url = try ImaggaRouter.baseURLPath.asURL()
    
    var request = URLRequest(url: url.appendingPathComponent(path))
    request.httpMethod = method.rawValue
    request.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
    request.timeoutInterval = TimeInterval(10 * 1000)
    
    return try URLEncoding.default.encode(request, with: parameters)
  }
}

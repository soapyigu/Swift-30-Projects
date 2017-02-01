/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// Inspired by https://github.com/lingoer/SwiftyJSON

import Foundation

enum JSONValue {
  
  case jsonObject([String:JSONValue])
  case jsonArray([JSONValue])
  case jsonString(String)
  case jsonNumber(NSNumber)
  case jsonBool(Bool)
  case jsonNull

  var object: [String:JSONValue]? {
    switch self {
    case .jsonObject(let value):
      return value
    default:
      return nil
    }
  }
  
  var array: [JSONValue]? {
    switch self {
    case .jsonArray(let value):
      return value
    default:
      return nil
    }
  }
  
  var string: String? {
    switch self {
    case .jsonString(let value):
      return value
    default:
      return nil
    }
  }
  
  var integer: Int? {
    switch self {
    case .jsonNumber(let value):
      return value.intValue
    default:
      return nil
    }
  }
  
  var double: Double? {
    switch self {
    case .jsonNumber(let value):
      return value.doubleValue
    default:
      return nil
    }
  }
  
  var bool: Bool? {
    switch self {
    case .jsonBool(let value):
      return value
    case .jsonNumber(let value):
      return value.boolValue
    default:
      return nil
    }
  }
  
  subscript(i: Int) -> JSONValue? {
    get {
      switch self {
      case .jsonArray(let value):
        return value[i]
      default:
        return nil
      }
    }
  }
  
  subscript(key: String) -> JSONValue? {
    get {
      switch self {
      case .jsonObject(let value):
        return value[key]
      default:
        return nil
      }
    }
  }
  
  static func fromObject(_ object: Any) -> JSONValue? {
    switch object {
    case let value as NSString:
      return JSONValue.jsonString(value as String)
    case let value as NSNumber:
      return JSONValue.jsonNumber(value)
    case _ as NSNull:
      return JSONValue.jsonNull
    case let value as NSDictionary:
      var jsonObject: [String:JSONValue] = [:]
      for (k, v) in value {
        if let k = k as? NSString {
          if let v = JSONValue.fromObject(v as Any) {
            jsonObject[k as String] = v
          } else {
            return nil
          }
        }
      }
      return JSONValue.jsonObject(jsonObject)
    case let value as NSArray:
      var jsonArray: [JSONValue] = []
      for v in value {
        if let v = JSONValue.fromObject(v as Any) {
          jsonArray.append(v)
        } else {
          return nil
        }
      }
      return JSONValue.jsonArray(jsonArray)
    default:
      return nil
    }
  }
  
}

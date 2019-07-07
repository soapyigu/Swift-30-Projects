//
//  ToDOItem.swift
//  ToDo
//
//  Created by gu, yi on 9/6/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import Foundation

struct ToDoItem {
  let title: String
  let itemDescription: String?
  let timestamp: Double?
  let location: Location?
  
  // plist related
  private let titleKey = "titleKey"
  private let itemDescriptionKey = "itemDescriptionKey"
  private let timestampKey = "timestampKey"
  private let locationKey = "locationKey"
  
  var plistDict: [String:Any] {
    var dict = [String:Any]()
    
    dict[titleKey] = title
    if let itemDescription = itemDescription {
      dict[itemDescriptionKey] = itemDescription
    }
    if let timestamp = timestamp {
      dict[timestampKey] = timestamp
    }
    if let location = location {
      let locationDict = location.plistDict
      dict[locationKey] = locationDict
    }
    return dict
  }
  
  init(title: String, itemDescription: String? = nil, timeStamp: Double? = nil, location: Location? = nil) {
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timeStamp
    self.location = location
  }
  
  init?(dict: [String: Any]) {
    guard let title = dict[titleKey] as? String else {
      return nil
    }
    
    self.title = title
    self.itemDescription = dict[itemDescriptionKey] as? String
    self.timestamp = dict[timestampKey] as? Double
    if let locationDict = dict[locationKey] as? [String: Any] {
      self.location = Location(dict: locationDict)
    } else {
      self.location = nil
    }
  }
}

extension ToDoItem: Equatable {
  static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    return lhs.title == rhs.title && lhs.location?.name == rhs.location?.name
  }
}

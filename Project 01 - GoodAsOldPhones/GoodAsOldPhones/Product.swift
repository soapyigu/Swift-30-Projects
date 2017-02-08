//
//  Product.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import Foundation

class Product {
  var name: String?
  var cellImageName: String?
  var fullscreenImageName: String?
  
  init(name: String, cellImageName: String, fullscreenImageName: String) {
    self.name = name
    self.cellImageName = cellImageName
    self.fullscreenImageName = fullscreenImageName
  }
}

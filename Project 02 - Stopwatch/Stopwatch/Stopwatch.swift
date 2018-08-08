//
//  Stopwatch.swift
//  Stopwatch
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
  var counter: Double
  var timer: Timer
  
  override init() {
    counter = 0.0
    timer = Timer()
  }
}

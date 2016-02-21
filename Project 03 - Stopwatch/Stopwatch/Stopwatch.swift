//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Yi Gu on 2/20/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
  var counter: Double
  var timer: NSTimer
  
  override init() {
    self.counter = 0.0
    self.timer = NSTimer()
  }
}

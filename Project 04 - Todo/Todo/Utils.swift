//
//  Utils.swift
//  Todo
//
//  Created by Yi Gu on 2/29/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation

func dateFromString(date: String) -> NSDate? {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter.dateFromString(date)
}

func stringFromDate(date: NSDate) -> String {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter.stringFromDate(date)
}


//
//  Message.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import Foundation

class Message {
  var text: String?
  var incoming: Bool!
  var date: Date?
  
  public init(text: String, date: Date) {
    self.text = text
    self.date = date
  }
}

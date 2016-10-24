//
//  Message.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
  dynamic var text: String?
  dynamic var date: Date?
  dynamic var incoming: Bool = false
}

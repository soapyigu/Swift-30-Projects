//
//  Chat.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import Foundation
import RealmSwift

class Chat: Object {
  dynamic var lastMessage: Message? {
    return realm?.objects(Message.self).sorted(byProperty: "date").last
  }
}

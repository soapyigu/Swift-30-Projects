//
//  ChatTableView.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

final class ChatTableView: UITableView, Scroll {
  
  override public func didMoveToSuperview() {
    self.estimatedRowHeight = 56.0    
    self.separatorStyle = .none
  }
}

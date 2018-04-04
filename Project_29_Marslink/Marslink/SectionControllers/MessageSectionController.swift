//
//  MessageSectionController.swift
//  Marslink
//
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class MessageSectionController: IGListSectionController {
  
  fileprivate let solFormatter = SolFormatter()
  fileprivate var message: Message!
  
  override init() {
    super.init()
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
  }
}

extension MessageSectionController: IGListSectionType {
  func numberOfItems() -> Int {
    return 1
  }
  
  func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext, let message = message else {
      return .zero
    }
    
    let width = context.containerSize.width
    
    return MessageCell.cellSize(width: width, text: message.text)
  }
  
  func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: MessageCell.self, for: self, at: index) as! MessageCell
    
    cell.titleLabel.text = message.user.name.uppercased()
    cell.messageLabel.text = message.text
    
    return cell
  }
  
  func didUpdate(to object: Any) {
    message = object as? Message
  }
  
  func didSelectItem(at index: Int) {}
}


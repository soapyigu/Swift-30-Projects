//
//  JournalSectionController.swift
//  Marslink
//
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import IGListKit

class JournalSectionController: IGListSectionController {
  
  fileprivate let solFormatter = SolFormatter()
  fileprivate var entry: JournalEntry!
  
  override init() {
    super.init()
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
  }
}

extension JournalSectionController: IGListSectionType {
  func numberOfItems() -> Int {
    return 2
  }
  
  func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext, let entry = entry else {
      return .zero
    }
    
    let width = context.containerSize.width
    
    if index == 0 {
      return CGSize(width: width, height: 30)
    } else {
      return JournalEntryCell.cellSize(width: width, text: entry.text)
    }
  }
  
  func cellForItem(at index: Int) -> UICollectionViewCell {
    let cellClass: AnyClass = index == 0 ? JournalEntryDateCell.self : JournalEntryCell.self
    
    let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
    
    if let cell = cell as? JournalEntryDateCell {
      cell.label.text = "SOL \(solFormatter.sols(fromDate: entry.date))"
    } else if let cell = cell as? JournalEntryCell {
      cell.label.text = entry.text
    }
    
    return cell
  }
  
  func didUpdate(to object: Any) {
    entry = object as? JournalEntry
  }
  
  func didSelectItem(at index: Int) {}
}

//
//  FBMeBaseCell.swift
//  FacebookMe
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import UIKit

class FBMeBaseCell: UITableViewCell {
  static let identifier = "FBMeBaseCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = Specs.color.white
    textLabel?.textColor = Specs.color.black
    textLabel?.font = Specs.font.large
    
    detailTextLabel?.font = Specs.font.small
    detailTextLabel?.textColor = Specs.color.gray
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

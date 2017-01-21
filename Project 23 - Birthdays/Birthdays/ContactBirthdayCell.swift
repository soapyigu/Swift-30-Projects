//
//  ContactBirthdayCell.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit

class ContactBirthdayCell: UITableViewCell {
  
  @IBOutlet weak var lblFullname: UILabel!
  @IBOutlet weak var lblBirthday: UILabel!
  @IBOutlet weak var imgContactImage: UIImageView!
  @IBOutlet weak var lblEmail: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    imgContactImage.layer.cornerRadius = 25.0
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

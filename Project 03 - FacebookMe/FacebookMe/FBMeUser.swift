//
//  FBMeUser.swift
//  FacebookMe
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import UIKit

class FBMeUser {
  var name: String
  var avatarName: String
  var education: String
  
  init(name: String, avatarName: String = "bayMax", education: String) {
    self.name = name
    self.avatarName = avatarName
    self.education = education
  }
}

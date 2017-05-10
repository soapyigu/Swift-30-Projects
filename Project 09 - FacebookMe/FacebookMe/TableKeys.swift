//
//  TableKeys.swift
//  FacebookMe
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import Foundation

public struct TableKeys {
  static let Section = "section"
  static let Rows = "rows"
  static let ImageName = "imageName"
  static let Title = "title"
  static let SubTitle = "subTitle"
  static let seeMore = "See More..."
  static let addFavorites = "Add Favorites..."
  static let logout = "Log Out"
  
  static func populate(withUser user: FBMeUser) -> [[String: Any]] {
    return [
      [
        TableKeys.Rows: [
          [TableKeys.ImageName: user.avatarName, TableKeys.Title: user.name, TableKeys.SubTitle: "View your profile"]
        ]
      ],
      [
        TableKeys.Rows: [
          [TableKeys.ImageName: Specs.imageName.friends, TableKeys.Title: "Friends"],
          [TableKeys.ImageName: Specs.imageName.events, TableKeys.Title: "Events"],
          [TableKeys.ImageName: Specs.imageName.groups, TableKeys.Title: "Groups"],
          [TableKeys.ImageName: Specs.imageName.education, TableKeys.Title: user.education],
          [TableKeys.ImageName: Specs.imageName.townHall, TableKeys.Title: "Town Hall"],
          [TableKeys.ImageName: Specs.imageName.instantGames, TableKeys.Title: "Instant Games"],
          [TableKeys.Title: TableKeys.seeMore]
        ]
      ],
      [
        TableKeys.Section: "FAVORITES",
        TableKeys.Rows: [
          [TableKeys.Title: TableKeys.addFavorites]
        ]
      ],
      [
        TableKeys.Rows: [
          [TableKeys.ImageName: Specs.imageName.settings, TableKeys.Title: "Settings"],
          [TableKeys.ImageName: Specs.imageName.privacyShortcuts, TableKeys.Title: "Privacy Shortcuts"],
          [TableKeys.ImageName: Specs.imageName.helpSupport, TableKeys.Title: "Help and Support"]
        ]
      ],
      [
        TableKeys.Rows: [
          [TableKeys.Title: TableKeys.logout]
        ]
      ]
    ]
  }
}



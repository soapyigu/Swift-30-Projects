//
//  Specs.swift
//  FacebookMe
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import UIKit

public struct Specs {
  public struct Color {
    public let tint = UIColor(hex: 0x3b5998)
    public let red = UIColor.red
    public let white = UIColor.white
    public let black = UIColor.black
    public let gray = UIColor.lightGray
  }
  
  public struct FontSize {
    public let tiny: CGFloat = 10
    public let small: CGFloat = 12
    public let regular: CGFloat = 14
    public let large: CGFloat = 16
  }
  
  public struct Font {
    private static let regularName = "Helvetica Neue"
    private static let boldName = "Helvetica Neue Bold"
    public let tiny = UIFont(name: regularName, size: Specs.fontSize.tiny)
    public let small = UIFont(name: regularName, size: Specs.fontSize.small)
    public let regular = UIFont(name: regularName, size: Specs.fontSize.regular)
    public let large = UIFont(name: regularName, size: Specs.fontSize.large)
    public let smallBold = UIFont(name: boldName, size: Specs.fontSize.small)
    public let regularBold = UIFont(name: boldName, size: Specs.fontSize.regular)
    public let largeBold = UIFont(name: boldName, size: Specs.fontSize.large)
  }
  
  public struct ImageName {
    public let friends = "fb_friends"
    public let events = "fb_events"
    public let groups = "fb_groups"
    public let education = "fb_education"
    public let townHall = "fb_town_hall"
    public let instantGames = "fb_games"
    public let settings = "fb_settings"
    public let privacyShortcuts = "fb_privacy_shortcuts"
    public let helpSupport = "fb_help_and_support"
    public let placeholder = "fb_placeholder"
  }
  
  public static var color: Color {
    return Color()
  }
  
  public static var fontSize: FontSize {
    return FontSize()
  }
  
  public static var font: Font {
    return Font()
  }
  
  public static var imageName: ImageName {
    return ImageName()
  }
}

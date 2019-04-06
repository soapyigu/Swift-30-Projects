//
//  AppDelegate.swift
//  FlickerSearch
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

let themeColor = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window?.tintColor = themeColor
    
    return true
  }
}


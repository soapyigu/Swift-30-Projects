//
//  AppDelegate.swift
//  FacebookMe
//
//  Copyright © 2017 Yi Gu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: FBMeViewController())
    window?.makeKeyAndVisible()
    
    return true
  }
}


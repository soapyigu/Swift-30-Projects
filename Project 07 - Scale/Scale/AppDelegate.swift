//
//  AppDelegate.swift
//  Scale
//
//  Created by Yi Gu on 04/22/15.
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

enum Shortcut: String {
  case openBlue = "OpenBlue"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions:
    [NSObject: AnyObject]?) -> Bool {
    
    print("didFinishLaunchingWithOptions called")
    var isLaunchedFromQuickAction = false
    
    if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
      isLaunchedFromQuickAction = true
      handleQuickAction(shortcutItem)
    } else {
      self.window?.backgroundColor = UIColor.whiteColor()
    }
    
    return !isLaunchedFromQuickAction
  }
  
  func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
    
    // Handle quick actions
    completionHandler(handleQuickAction(shortcutItem))
    
  }
  
  func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
    var quickActionHandled = false
    let type = shortcutItem.type.componentsSeparatedByString(".").last!
    
    if let shortcutType = Shortcut.init(rawValue: type) {
      switch shortcutType {
      case .openBlue:
        self.window?.backgroundColor = UIColor(red: 151.0/255.0, green: 187.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        quickActionHandled = true
      }
    }
    
    return quickActionHandled
  }
}


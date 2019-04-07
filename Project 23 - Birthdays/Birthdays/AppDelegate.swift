//
//  AppDelegate.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  static var appDelegate: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
  
  var window: UIWindow?
  var contactStore = CNContactStore()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
    let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    
    switch authorizationStatus {
    case .authorized:
      completionHandler(true)
      
    case .denied, .notDetermined:
      self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
        if access {
          completionHandler(access)
        } else {
          if authorizationStatus == CNAuthorizationStatus.denied {
            DispatchQueue.main.async {
              let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
              Helper.show(message: message)
            }
          }
        }
      })
      
    default:
      completionHandler(false)
    }
  }
}

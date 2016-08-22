//
//  AppDelegate.swift
//  TwitterBird
//
//  Created by Yi Gu on 8/12/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var mask: CALayer?
  var imageView: UIImageView?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    if let window = window {
      // add background imageView
      imageView = UIImageView(frame: window.frame)
      imageView!.image = UIImage(named: "twitterScreen")
      window.addSubview(imageView!)
      
      // set up mask
      mask = CALayer()
      mask?.contents = UIImage(named: "twitterBird")?.CGImage
      mask?.position = window.center
      mask?.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
      imageView!.layer.mask = mask
      
      animateMask()
      
      // make window visible
      window.rootViewController = UIViewController()
      window.backgroundColor = UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1)
      window.makeKeyAndVisible()
    }
    
    // hide the status bar
    UIApplication.sharedApplication().statusBarHidden = true
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the uer interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func animateMask() {
    // init key frame animation
    let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
    keyFrameAnimation.delegate = self
    keyFrameAnimation.duration = 1
    keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
    
    // animate zoom in and then zoom out
    let initalBounds = NSValue(CGRect: mask!.bounds)
    let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 80, height: 64))
    let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
    keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
    
    // set up time interals
    keyFrameAnimation.keyTimes = [0, 0.3, 1]
    
    // add animation to current view
    keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
    mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
  }
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    // remove mask
    imageView?.layer.mask = nil
  }
}


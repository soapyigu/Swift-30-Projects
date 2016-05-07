//
//  MasterViewController.swift
//  SpotifySignIn
//
//  Created by Yi Gu on 4/28/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class MasterViewController: VideoSplashViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupVideoBackground()
  }
  
  func setupVideoBackground() {
    let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("moments", ofType: "mp4")!)
    
    // setup layout
    videoFrame = view.frame
    fillMode = .ResizeAspectFill
    alwaysRepeat = true
    sound = true
    startTime = 2.0
    alpha = 0.8
    
    contentURL = url
    view.userInteractionEnabled = false
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}

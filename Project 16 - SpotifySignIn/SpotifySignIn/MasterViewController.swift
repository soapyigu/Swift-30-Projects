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
    let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
    
    // setup layout
    videoFrame = view.frame
    fillMode = .resizeAspectFill
    alwaysRepeat = true
    sound = true
    startTime = 2.0
    alpha = 0.8
    
    contentURL = url
    view.isUserInteractionEnabled = false
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
}

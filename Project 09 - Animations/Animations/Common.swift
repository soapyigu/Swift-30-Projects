//
//  Common.swift
//  Animations
//
//  Created by Yi Gu on 5/1/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation
import UIKit

func drawRectView() -> UIView {
  let screenRect = UIScreen.mainScreen().bounds
  let rect = CGRectMake(0, 0, CGRectGetWidth(screenRect) / 2.0, CGRectGetHeight(screenRect) / 4.0)
  
  let view = UIView(frame: rect)
  view.center = CGPointMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect) - 50)
  view.backgroundColor = UIColor.redColor()
  
  return view
}

func makeAlert(title: String, message: String, actionTitle: String) -> UIAlertController {
  let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
  alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: nil))
  
  return alert
}

//
//  Common.swift
//  Animations
//
//  Created by Yi Gu on 5/1/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation
import UIKit

let screenRect = UIScreen.mainScreen().bounds
let generalFrame = CGRectMake(0, 0, CGRectGetWidth(screenRect) / 2.0, CGRectGetHeight(screenRect) / 4.0)
let generalCenter = CGPointMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect) - 50)

func drawRectView(color: UIColor, frame: CGRect, center: CGPoint) -> UIView {
  let view = UIView(frame: frame)
  view.center = center
  view.backgroundColor = color
  return view
}

func drawCircleView() -> UIView {
  let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: CGRectGetMidY(screenRect) - 50), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
  
  let shapeLayer = CAShapeLayer()
  shapeLayer.path = circlePath.CGPath
  
  shapeLayer.fillColor = UIColor.redColor().CGColor
  shapeLayer.strokeColor = UIColor.redColor().CGColor
  shapeLayer.lineWidth = 3.0
  
  let view = UIView()
  view.layer.addSublayer(shapeLayer)
  
  return view
}

func makeAlert(title: String, message: String, actionTitle: String) -> UIAlertController {
  let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
  alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: nil))
  
  return alert
}

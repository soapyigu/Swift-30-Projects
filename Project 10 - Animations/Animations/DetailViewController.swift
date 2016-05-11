//
//  DetailViewController.swift
//  Animations
//
//  Created by Yi Gu on 5/1/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  // MARK: - Variables
  var barTitle = ""
  var animateView: UIView!
  private let duration = 2.0
  private let delay = 0.2
  private let scale = 1.2
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRect()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.topItem?.title = barTitle
  }
  
  private func setupRect() {
    if barTitle == "BezierCurve Position" {
      animateView = drawCircleView()
      
    } else if barTitle == "View Fade In" {
      animateView = UIImageView(image: UIImage(named: "whatsapp"))
      animateView.frame = generalFrame
      animateView.center = generalCenter
    } else {
      animateView = drawRectView(UIColor.redColor(), frame: generalFrame, center: generalCenter)
    }
    view.addSubview(animateView)
  }
  
  // MARK: - IBAction
  @IBAction func didTapAnimate(sender: AnyObject) {
    switch barTitle {
    case "2-Color":
      changeColor(UIColor.greenColor())
      
    case "Simple 2D Rotation":
      rotateView(M_PI)
      
    case "Multicolor":
      multiColor(UIColor.greenColor(), UIColor.blueColor())
      
    case "Multi Point Position":
      multiPosition(CGPoint(x: animateView.frame.origin.x, y: 100), CGPoint(x: animateView.frame.origin.x, y: 350))
      
    case "BezierCurve Position":
      var controlPoint1 = self.animateView.center
      controlPoint1.y -= 125.0
      var controlPoint2 = controlPoint1
      controlPoint2.x += 40.0
      controlPoint2.y -= 125.0;
      var endPoint = self.animateView.center;
      endPoint.x += 75.0
      curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
  
      
    case "Color and Frame Change":
      let currentFrame = self.animateView.frame
      let firstFrame = CGRectInset(currentFrame, -30, -50)
      let secondFrame = CGRectInset(firstFrame, 10, 15)
      let thirdFrame = CGRectInset(secondFrame, -15, -20)
      colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.orangeColor(), UIColor.yellowColor(), UIColor.greenColor())
      
    case "View Fade In":
      viewFadeIn()
      
    case "Pop":
      Pop()
      
    default:
      let alert = makeAlert("Alert", message: "The animation not implemented yet", actionTitle: "OK")
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  // MARK: - Private Methods for Animations
  private func changeColor(color: UIColor) {
    UIView.animateWithDuration(self.duration, animations: {
      self.animateView.backgroundColor = color
      }, completion: nil)
  }
  
  private func multiColor(firstColor: UIColor, _ secondColor: UIColor) {
    UIView.animateWithDuration(duration, animations: {
      self.animateView.backgroundColor = firstColor
      }, completion: { finished in
        self.changeColor(secondColor)
    })
  }
  
  private func simplePosition(pos: CGPoint) {
    UIView.animateWithDuration(self.duration, animations: {
      self.animateView.frame.origin = pos
      }, completion: nil)
  }
  
  private func multiPosition(firstPos: CGPoint, _ secondPos: CGPoint) {
    UIView.animateWithDuration(self.duration, animations: {
      self.animateView.frame.origin = firstPos
      }, completion: { finished in
        self.simplePosition(secondPos)
    })
  }
  
  private func rotateView(angel: Double) {
    UIView.animateWithDuration(duration, delay: delay, options: [.Repeat], animations: {
      self.animateView.transform = CGAffineTransformMakeRotation(CGFloat(angel))
      }, completion: nil)
  }
  
  private func colorFrameChange(firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect,
                                _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
    UIView.animateWithDuration(self.duration, animations: {
      self.animateView.backgroundColor = firstColor
      self.animateView.frame = firstFrame
      }, completion: { finished in
        UIView.animateWithDuration(self.duration, animations: {
          self.animateView.backgroundColor = secondColor
          self.animateView.frame = secondFrame
          }, completion: { finished in
            UIView.animateWithDuration(self.duration, animations: {
              self.animateView.backgroundColor = thirdColor
              self.animateView.frame = thirdFrame
              }, completion: nil)
        })
    })
  }
  
  private func curvePath(endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
    let path = UIBezierPath()
    path.moveToPoint(self.animateView.center)
    
    path.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)

    // create a new CAKeyframeAnimation that animates the objects position
    let anim = CAKeyframeAnimation(keyPath: "position")
    
    // set the animations path to our bezier curve
    anim.path = path.CGPath
    
    // set some more parameters for the animation
    anim.duration = self.duration
    
    // add the animation to the squares 'layer' property
    self.animateView.layer.addAnimation(anim, forKey: "animate position along path")
    self.animateView.center = endPoint
  }
  
  private func viewFadeIn() {
    let secondView = UIImageView(image: UIImage(named: "facebook"))
    secondView.frame = self.animateView.frame
    secondView.alpha = 0.0
    
    view.insertSubview(secondView, aboveSubview: self.animateView)
    
    UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseOut, animations: {
      secondView.alpha = 1.0
      self.animateView.alpha = 0.0
      }, completion: nil)
  }
  
  private func Pop() {
    UIView.animateWithDuration(duration / 4,
      animations: {
      self.animateView.transform = CGAffineTransformMakeScale(CGFloat(self.scale), CGFloat(self.scale))
      }, completion: { finished in
        UIView.animateWithDuration(self.duration / 4, animations: {
          self.animateView.transform = CGAffineTransformIdentity
        })
    })
  }
}

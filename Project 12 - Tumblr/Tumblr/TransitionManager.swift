//
//  TransitionManager.swift
//  Tumblr
//
//  Created by Yi Gu on 7/11/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
  private var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView()
    
    // create a tuple of our screens
    let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
    
    // assign references to our menu view controller and the 'bottom' view controller from the tuple
    // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
    let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
    let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
    
    let menuView = menuViewController.view
    let bottomView = bottomViewController.view
    
    // prepare the menu
    if (self.presenting){
      // prepare menu to fade in
      offStageMenuController(menuViewController)
    }
    
    // add the both views to our view controller
    container!.addSubview(bottomView)
    container!.addSubview(menuView)
    
    let duration = self.transitionDuration(transitionContext)
    
    UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
      
      if (self.presenting){
        self.onStageMenuController(menuViewController) // onstage items: slide in
      }
      else {
        self.offStageMenuController(menuViewController) // offstage items: slide out
      }
      
      }, completion: { finished in
        transitionContext.completeTransition(true)
        UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
        
    })
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.5
  }
  
  func offStage(amount: CGFloat) -> CGAffineTransform {
    return CGAffineTransformMakeTranslation(amount, 0)
  }
  
  func offStageMenuController(menuViewController: MenuViewController){
    
    menuViewController.view.alpha = 0
    
    // setup paramaters for 2D transitions for animations
    let topRowOffset  :CGFloat = 300
    let middleRowOffset :CGFloat = 150
    let bottomRowOffset  :CGFloat = 50
    
    menuViewController.textPostIcon.transform = self.offStage(-topRowOffset)
    menuViewController.textPostLabel.transform = self.offStage(-topRowOffset)
    
    menuViewController.quotePostIcon.transform = self.offStage(-middleRowOffset)
    menuViewController.quotePostLabel.transform = self.offStage(-middleRowOffset)
    
    menuViewController.chatPostIcon.transform = self.offStage(-bottomRowOffset)
    menuViewController.chatPostLabel.transform = self.offStage(-bottomRowOffset)
    
    menuViewController.photoPostIcon.transform = self.offStage(topRowOffset)
    menuViewController.photoPostLabel.transform = self.offStage(topRowOffset)
    
    menuViewController.linkPostIcon.transform = self.offStage(middleRowOffset)
    menuViewController.linkPostLabel.transform = self.offStage(middleRowOffset)
    
    menuViewController.audioPostIcon.transform = self.offStage(bottomRowOffset)
    menuViewController.audioPostLabel.transform = self.offStage(bottomRowOffset)
    
    
    
  }
  
  func onStageMenuController(menuViewController: MenuViewController){
    
    // prepare menu to fade in
    menuViewController.view.alpha = 1
    
    menuViewController.textPostIcon.transform = CGAffineTransformIdentity
    menuViewController.textPostLabel.transform = CGAffineTransformIdentity
    
    menuViewController.quotePostIcon.transform = CGAffineTransformIdentity
    menuViewController.quotePostLabel.transform = CGAffineTransformIdentity
    
    menuViewController.chatPostIcon.transform = CGAffineTransformIdentity
    menuViewController.chatPostLabel.transform = CGAffineTransformIdentity
    
    menuViewController.photoPostIcon.transform = CGAffineTransformIdentity
    menuViewController.photoPostLabel.transform = CGAffineTransformIdentity
    
    menuViewController.linkPostIcon.transform = CGAffineTransformIdentity
    menuViewController.linkPostLabel.transform = CGAffineTransformIdentity
    
    menuViewController.audioPostIcon.transform = CGAffineTransformIdentity
    menuViewController.audioPostLabel.transform = CGAffineTransformIdentity
    
  }

}

extension TransitionManager: UIViewControllerTransitioningDelegate {
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = true
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = false
    return self
  }
}

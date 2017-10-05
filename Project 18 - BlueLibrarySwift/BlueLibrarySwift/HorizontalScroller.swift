//
//  HorizontalScroller.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/8/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

// Use Delegate and Protocol to implement Adapter Pattern
@objc protocol HorizontalScrollerDelegate {
  // num of views to present inside the horizontal scroller
  func numberOfViewsForHorizontalScroller(_ scroller: HorizontalScroller) -> Int
  
  // return the view that should appear at <index>
  func horizontalScrollerViewAtIndex(_ scroller: HorizontalScroller, index:Int) -> UIView
  
  // inform the delegate what the view at <index> has been clicked
  func horizontalScrollerClickedViewAtIndex(_ scroller: HorizontalScroller, index:Int)
  
  // return the index of the initial view to display. this method is optional
  // and defaults to 0 if it's not implemented by the delegate
  @objc optional func initialViewIndex(_ scroller: HorizontalScroller) -> Int
}

class HorizontalScroller: UIView {
  weak var delegate: HorizontalScrollerDelegate?
  
  // MARK: - Variables
  fileprivate let VIEW_PADDING = 10
  fileprivate let VIEW_DIMENSIONS = 100
  fileprivate let VIEWS_OFFSET = 100
  
  fileprivate var scroller : UIScrollView!
  
  var viewArray = [UIView]()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    initializeScrollView()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initializeScrollView()
  }
  
  func initializeScrollView() {
    scroller = UIScrollView()
    scroller.delegate = self
    addSubview(scroller)
    
    scroller.translatesAutoresizingMaskIntoConstraints = false
    
    // apply constraints
    self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    
    // add tap recognizer
    let tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(HorizontalScroller.scrollerTapped(_:)))
    scroller.addGestureRecognizer(tapRecognizer)
  }
  
  // call reload when added to another view
  override func didMoveToSuperview() {
    reload()
  }
  
  // MARK: - Public Functions
  @objc func scrollerTapped(_ gesture: UITapGestureRecognizer) {
    let location = gesture.location(in: gesture.view)
    
    guard let delegate = delegate else {
      return
    }
    
    for index in 0 ..< delegate.numberOfViewsForHorizontalScroller(self) {
      let view = scroller.subviews[index] 
      
      if view.frame.contains(location) {
        delegate.horizontalScrollerClickedViewAtIndex(self, index: index)
        
        // center the tapped view in the scroll view
        scroller.setContentOffset(CGPoint(x: view.frame.origin.x - self.frame.size.width / 2 + view.frame.size.width / 2, y: 0), animated:true)
        
        break
      }
    }
  }
  
  func viewAtIndex(_ index :Int) -> UIView {
    return viewArray[index]
  }
  
  func reload() {
    // check if there is a delegate, if not there is nothing to load.
    if let delegate = delegate {
      // reset viewArray
      viewArray = []
      
      // remove all subviews
      let views: NSArray = scroller.subviews as NSArray
      for view in views {
        (view as AnyObject).removeFromSuperview()
      }
      
      // xValue is the starting point of the views inside the scroller
      var xValue = VIEWS_OFFSET
      for index in 0 ..< delegate.numberOfViewsForHorizontalScroller(self) {
        // add a view at the right position
        xValue += VIEW_PADDING
        let view = delegate.horizontalScrollerViewAtIndex(self, index: index)
        view.frame = CGRect(x: CGFloat(xValue), y: CGFloat(VIEW_PADDING), width: CGFloat(VIEW_DIMENSIONS), height: CGFloat(VIEW_DIMENSIONS))
        scroller.addSubview(view)
        xValue += VIEW_DIMENSIONS + VIEW_PADDING
        
        // store the view to viewArray
        viewArray.append(view)
      }
      
      scroller.contentSize = CGSize(width: CGFloat(xValue + VIEWS_OFFSET), height: frame.size.height)
      
      // if an initial view is defined, center the scroller on it
      if let initialView = delegate.initialViewIndex?(self) {
        scroller.setContentOffset(CGPoint(x: CGFloat(initialView) * CGFloat((VIEW_DIMENSIONS + (2 * VIEW_PADDING))), y: 0), animated: true)
      }
    }
  }
  
  func centerCurrentView() {
    var xFinal = Int(scroller.contentOffset.x) + (VIEWS_OFFSET / 2) + VIEW_PADDING
    let viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING))
    xFinal = viewIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING))
    scroller.setContentOffset(CGPoint(x: xFinal, y: 0), animated: true)
    if let delegate = delegate {
      delegate.horizontalScrollerClickedViewAtIndex(self, index: Int(viewIndex))
    }
  }
}

extension HorizontalScroller: UIScrollViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      centerCurrentView()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    centerCurrentView()
  }
}

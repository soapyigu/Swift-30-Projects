//
//  HorizontalScroller.swift
//  BlueLibrarySwift
//
//  Created by Yi Gu on 5/8/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

// MARK: - DataSource
protocol HorizontalScrollerDataSource: class {
  // number of views to present inside the horizontal scroller
  func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int
  
  // the view that should appear at index
  func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView
}

extension HorizontalScrollerDataSource {
  func initialViewIndex(_ scroller: HorizontalScrollerView) -> Int {
    return 0
  }
}

// MARK: - Delegate
protocol HorizontalScrollerDelegate: class {
  
  // inform the delegate what the view at <index> has been clicked
  func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int)
}

// MARK: - HorizontalScroller
class HorizontalScrollerView: UIView {
  weak var delegate: HorizontalScrollerDelegate?
  weak var dataSource: HorizontalScrollerDataSource?
  
  // MARK: - Variables
  fileprivate enum ViewConstants {
    static let Padding: CGFloat = 10
    static let Dimensions: CGFloat = 100
    static let Offset: CGFloat = 100
  }
  
  fileprivate var scroller = UIScrollView()
  
  fileprivate var contentViews = [UIView]()
  
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
    addSubview(scroller)
    
    scroller.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      scroller.topAnchor.constraint(equalTo: self.topAnchor),
      scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector.scrollerDidTap)
    scroller.addGestureRecognizer(tapRecognizer)
  }
  
  // call reload when added to another view
  override func didMoveToSuperview() {
    reload()
  }
  
  func scrollToView(at index: Int, animated: Bool = true) {
    guard index < contentViews.count else {
      return
    }
    let centralView = contentViews[index]
    let targetCenter = centralView.center
    let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
    scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: animated)
  }
  
  @objc func scrollerDidTap(_ gesture: UITapGestureRecognizer) {
    let location = gesture.location(in: gesture.view)
    
    guard let index = contentViews.firstIndex(where: { $0.frame.contains(location) })
      else {
        return
    }
    
    delegate?.horizontalScrollerView(self, didSelectViewAt: index)
    scrollToView(at: index)
  }
  
  func viewAtIndex(_ index :Int) -> UIView {
    return contentViews[index]
  }
  
  func reload() {
    guard let dataSource = dataSource else {
      return
    }
    
    // Remove the old content views
    contentViews.forEach { $0.removeFromSuperview() }
    
    // xValue is the starting point of each view inside the scroller
    var xValue = ViewConstants.Offset
    
    // Fetch and add the new views
    contentViews = (0..<dataSource.numberOfViews(in: self)).map {
      index in
      // 5 - add a view at the right position
      xValue += ViewConstants.Padding
      let view = dataSource.horizontalScrollerView(self, viewAt: index)
      view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.Padding, width: ViewConstants.Dimensions, height: ViewConstants.Dimensions)
      scroller.addSubview(view)
      xValue += ViewConstants.Dimensions + ViewConstants.Padding
      return view
    }
    
    scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.Offset), height: frame.size.height)
  }
  
  func centerCurrentView() {
    let centerRect = CGRect(
      origin: CGPoint(x: scroller.bounds.midX - ViewConstants.Padding, y: 0),
      size: CGSize(width: ViewConstants.Padding, height: bounds.height)
    )
    
    guard let selectedIndex = contentViews.firstIndex(where: { $0.frame.intersects(centerRect) })
      else { return }
    let centralView = contentViews[selectedIndex]
    let targetCenter = centralView.center
    let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
    
    scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
  }
}

extension HorizontalScrollerView: UIScrollViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      centerCurrentView()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    centerCurrentView()
  }
}

fileprivate extension Selector {
  static let scrollerDidTap = #selector(HorizontalScrollerView.scrollerDidTap(_:))
}

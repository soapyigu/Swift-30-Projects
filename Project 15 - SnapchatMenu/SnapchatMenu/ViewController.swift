//
//  ViewController.swift
//  SnapchatMenu
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  enum vcName: String {
    case chat = "ChatViewController"
    case stories = "StoriesViewController"
    case discover = "DiscoverViewController"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let chatVC = UIViewController(nibName: vcName.chat.rawValue, bundle: nil)
    let storiesVC = UIViewController(nibName: vcName.stories.rawValue, bundle: nil)
    let discoverVC = UIViewController(nibName: vcName.discover.rawValue, bundle: nil)
    
    add(childViewController: chatVC, toParentViewController: self)
    add(childViewController: storiesVC, toParentViewController: self)
    add(childViewController: discoverVC, toParentViewController: self)
    
    var storiesFrame = storiesVC.view.frame
    storiesFrame.origin.x = view.frame.width
    storiesVC.view.frame = storiesFrame
    
    var discoverFrame = discoverVC.view.frame
    discoverFrame.origin.x = view.frame.width * 2
    discoverVC.view.frame = discoverFrame
    
    scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  fileprivate func add(childViewController: UIViewController, toParentViewController parentViewController: UIViewController) {
    addChildViewController(childViewController)
    scrollView.addSubview(childViewController.view)
    childViewController.didMove(toParentViewController: parentViewController)
  }
}


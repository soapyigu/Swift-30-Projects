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
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let chatVC = UIViewController(nibName: vcName.chat.rawValue, bundle: nil)
    let storiesVC = UIViewController(nibName: vcName.stories.rawValue, bundle: nil)
    
    add(childViewController: chatVC, toParentViewController: self)
    add(childViewController: storiesVC, toParentViewController: self)
    
    var storiesFrame = storiesVC.view.frame
    storiesFrame.origin.x = view.frame.width
    storiesVC.view.frame = storiesFrame
    
    scrollView.contentSize = CGSize(width: view.frame.width * 2, height: view.frame.height)
  }
  
  fileprivate func add(childViewController: UIViewController, toParentViewController parentViewController: UIViewController) {
    addChildViewController(childViewController)
    scrollView.addSubview(childViewController.view)
    childViewController.didMove(toParentViewController: parentViewController)
  }
}


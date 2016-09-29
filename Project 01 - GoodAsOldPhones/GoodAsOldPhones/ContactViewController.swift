//
//  ContactViewController.swift
//  GoodAsOldPhones
//
//  Created by Yi Gu on 2/9/16.
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(scrollView)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    scrollView.contentSize = CGSize(width: 375, height: 800)
  }
  
  
}

//
//  MainViewController.swift
//  Tumblr
//
//  Created by Yi Gu on 6/4/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // remove hairline
    navigationController?.toolbar.clipsToBounds = true
  }
  
  @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
    dismissViewControllerAnimated(true, completion: nil)
  }
}
